#pragma once

#include <std/mem.pat>

struct QuestItem {
	u16 questId;
	u16 questNumber;
	u8 keyQuest;
	u8 urgentQuest;
	u16 unknown;
};

// Fonction pour déterminer dynamiquement la fin d'une section avec debug
fn get_dynamic_count(ptr start_addr) {
	u32 count = 0;
	ptr current_addr = start_addr;
	
	while (count < 300) {
		// Vérifier les limites du fichier d'abord
		if (current_addr + sizeof(QuestItem) > std::mem::size()) break;
		
		// Lire les données
		u16 questId = std::mem::read_unsigned(current_addr, 2);
		u16 questNumber = std::mem::read_unsigned(current_addr + 2, 2);
		u8 keyQuest = std::mem::read_unsigned(current_addr + 4, 1);
		u8 urgentQuest = std::mem::read_unsigned(current_addr + 5, 1);
		
		// Conditions d'arrêt plus permissives - on cherche de vrais patterns de fin
		// Arrêter si on trouve plusieurs zéros consécutifs
		if (questId == 0x0000 && questNumber == 0x0000) break;
		
		// Arrêter si questId semble invalide (mais être plus permissif)
		if (questId > 0x8000) break;
		
		// Pattern de fin Monster Hunter typique
		if (questId == 0xFFFF) break;
		
		count = count + 1;
		current_addr = current_addr + sizeof(QuestItem);
	}
	
	// S'assurer qu'on retourne au moins 1 pour éviter des arrays vides
	if (count == 0) count = 1;
	
	return count;
};

// Fonction helper pour les quêtes normales (pointers consécutifs)
fn get_quest_count_safe(ptr start_addr, ptr end_addr) {
	if (end_addr <= start_addr) {
		return get_dynamic_count(start_addr);
	}
	
	u32 calculated_count = (end_addr - start_addr) / sizeof(QuestItem);
	
	// Si le calcul semble raisonnable, l'utiliser
	if (calculated_count > 0 && calculated_count <= 500) {
		return calculated_count;
	}
	
	// Sinon, utiliser la détection dynamique
	return get_dynamic_count(start_addr);
};

// Fonction spéciale pour G-Rank qui détecte automatiquement la fin
// Elle doit compter TOUTES les quêtes valides jusqu'au padding
fn get_grank_count(ptr start_addr) {
	u32 count = 0;
	ptr current_addr = start_addr;
	
	while (count < 300) {
		// Vérifier les limites du fichier
		if (current_addr + sizeof(QuestItem) > std::mem::size()) break;
		
		// Lire les données
		u16 questId = std::mem::read_unsigned(current_addr, 2);
		u16 questNumber = std::mem::read_unsigned(current_addr + 2, 2);
		
		// Conditions d'arrêt pour G-Rank - seulement si les données semblent vraiment invalides
		if (questId == 0x0000 && questNumber == 0x0000) {
			// Vérifier si c'est vraiment la fin ou juste une quête avec des zéros
			// Si les 8 bytes suivants sont tous à zéro, c'est probablement le padding
			ptr check_addr = current_addr;
			u32 zero_count = 0;
			u32 check_idx = 0;
			while (check_idx < 8) {
				if (check_addr + check_idx < std::mem::size()) {
					if (std::mem::read_unsigned(check_addr + check_idx, 1) == 0x00) {
						zero_count = zero_count + 1;
					}
				}
				check_idx = check_idx + 1;
			}
			if (zero_count >= 6) break; // Si au moins 6 des 8 bytes sont zéro, c'est le padding
		}
		
		// Arrêter si questId semble vraiment invalide
		if (questId > 0x8000) break;
		if (questId == 0xFFFF) break;
		
		count = count + 1;
		current_addr = current_addr + sizeof(QuestItem);
	}
	
	// S'assurer qu'on retourne au moins 1
	if (count == 0) count = 1;
	
	return count;
};

// Structure pour les pointeurs des quêtes normales
struct QuestPointers {
	ptr oneStar;
	ptr twoStars;
	ptr threeStars;
	ptr fourStars;
	ptr fiveStars;
	ptr sixStars;
};

// Structure pour les quêtes normales
struct NormalQuests {
	QuestPointers questPointers @ addressof(this) [[name("Quest Pointers")]];
	
	// Pour les quêtes normales, les pointers sont consécutifs
	QuestItem oneStar[get_quest_count_safe(questPointers.oneStar, questPointers.twoStars)] 
		@ questPointers.oneStar [[name("HR1")]];
	QuestItem twoStars[get_quest_count_safe(questPointers.twoStars, questPointers.threeStars)] 
		@ questPointers.twoStars [[name("HR2")]];
	QuestItem threeStars[get_quest_count_safe(questPointers.threeStars, questPointers.fourStars)] 
		@ questPointers.threeStars [[name("HR3")]];
	QuestItem fourStars[get_quest_count_safe(questPointers.fourStars, questPointers.fiveStars)] 
		@ questPointers.fourStars [[name("HR4")]];
	QuestItem fiveStars[get_quest_count_safe(questPointers.fiveStars, questPointers.sixStars)] 
		@ questPointers.fiveStars [[name("HR5")]];
	QuestItem sixStars[get_dynamic_count(questPointers.sixStars)] 
		@ questPointers.sixStars [[name("HR6")]];
};

// Structure pour les pointeurs G-Rank
struct GRankPointers {
	ptr G7Pointer @ addressof(this) [[name("G7 Pointer")]];
	ptr G6Pointer @ (G7Pointer + (get_grank_count(G7Pointer) * sizeof(QuestItem)) + 8) [[name("G6 Pointer")]];
	ptr G5Pointer @ (G6Pointer + (get_grank_count(G6Pointer) * sizeof(QuestItem)) + 8) [[name("G5 Pointer")]];
	ptr G4Pointer @ (G5Pointer + (get_grank_count(G5Pointer) * sizeof(QuestItem)) + 8) [[name("G4 Pointer")]];
	ptr G3Pointer @ (G4Pointer + (get_grank_count(G4Pointer) * sizeof(QuestItem)) + 8) [[name("G3 Pointer")]];
	ptr G2Pointer @ (G3Pointer + (get_grank_count(G3Pointer) * sizeof(QuestItem)) + 8) [[name("G2 Pointer")]];
	ptr G1Pointer @ (G2Pointer + (get_grank_count(G2Pointer) * sizeof(QuestItem)) + 8) [[name("G1 Pointer")]];
};

// Structure pour les quêtes G-Rank avec le vrai pattern
// Pattern: Pointer G7 → Données G7 → 8 bytes padding → Pointer G6 → Données G6 → 8 bytes padding → ...
struct GRankQuests {
	GRankPointers pointers @ addressof(this) [[name("G-Rank Pointers")]];
	
	// Données G-Rank (référence les pointers de la structure ci-dessus)
	QuestItem g7[get_grank_count(pointers.G7Pointer)] @ pointers.G7Pointer [[name("G7 Quests")]];
	QuestItem g6[get_grank_count(pointers.G6Pointer)] @ pointers.G6Pointer [[name("G6 Quests")]];
	QuestItem g5[get_grank_count(pointers.G5Pointer)] @ pointers.G5Pointer [[name("G5 Quests")]];
	QuestItem g4[get_grank_count(pointers.G4Pointer)] @ pointers.G4Pointer [[name("G4 Quests")]];
	QuestItem g3[get_grank_count(pointers.G3Pointer)] @ pointers.G3Pointer [[name("G3 Quests")]];
	QuestItem g2[get_grank_count(pointers.G2Pointer)] @ pointers.G2Pointer [[name("G2 Quests")]];
	QuestItem g1[get_grank_count(pointers.G1Pointer)] @ pointers.G1Pointer [[name("G1 Quests")]];
};

// Instanciation des deux structures séparées
NormalQuests normalQuests @ header.ptrs.questList [[name("Normal Quests (1-6 Stars)")]];
GRankQuests gRankQuests @ header.ptrs.GRankQuestList [[name("G-Rank Quests")]];