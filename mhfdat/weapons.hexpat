#pragma once

#include <misc/s32p.pat>

#ifndef __ITEM_DATA
// Define plusone if it wasn't defined in itemdata.hexpat
// Add 1 to n (Used for pattern formatting)
fn plusone (u8 n) {
	return n+1;
};
#endif

// Multiply n by 10 (Used for pattern formatting)
fn timesten (u8 n) {
	return n*10;
};

// 0x34 is the size of MeleeWeaponEntry
fn meleeNameWE (auto n) {
	u16 weapon_id = (($-header.ptrs.meleeWeapons) / 0x34);
	str weapon_name = rIPPS(header.ptrs.meleeWeaponNames, weapon_id);
	return std::format("{:04X} | {}", weapon_id, weapon_name);
};

// 0x3C is the size of RangedWeaponEntry
fn rangedNameWE (auto n) {
	u16 weapon_id = (($-header.ptrs.rangedWeapons) / 0x3C);
	str weapon_name = rIPPS(header.ptrs.rangedWeaponNames, weapon_id);
	return std::format("{:04X} | {}", weapon_id, weapon_name);
};
	
// TODO: Maybe replace these functions with enums?
// It won't look as pretty but it'd make a bit more sense
fn className (u8 n) {
	str ret = "!!Unknown!!";

	match (n) {
		(0x00): ret = "Great Sword";
		(0x01): ret = "Heavy Bowgun";
		(0x02): ret = "Hammer";
		(0x03): ret = "Lance";
		(0x04): ret = "Sword and Shield";
		(0x05): ret = "Light Bowgun";
		(0x06): ret = "Dual Blades";
		(0x07): ret = "Long Sword";
		(0x08): ret = "Hunting Horn";
		(0x09): ret = "Gunlance";
		(0x0A): ret = "Bow";
		(0x0B): ret = "Tonfa";
		(0x0C): ret = "Switch Axe F";
		(0x0D): ret = "Magnet Spike";
	}

	return ret;
};
	
fn elementName (u8 n) {
	str ret = "!!Unknown!!";

	match (n) {
		(0x00): ret = "None";
		(0x01): ret = "Fire";
		(0x02): ret = "Water";
		(0x03): ret = "Thunder";
		(0x04): ret = "Dragon";
		(0x05): ret = "Ice";
		(0x06): ret = "Flame";
		(0x07): ret = "Light";
		(0x08): ret = "Thunder Pole";
		(0x09): ret = "Tenshou";
		(0x0A): ret = "Okiko";
		(0x0B): ret = "Black Flame";
		(0x0C): ret = "Kanade";
		(0x0D): ret = "Darkness";
		(0x0E): ret = "Crimson Demon";
		(0x0F): ret = "Wind";
		(0x10): ret = "Sound";
		(0x11): ret = "Burning Zero";
		(0x12): ret = "Emperor's Roar";
	}
	
	return ret;
};
	
fn ailmentName (u8 n) {
	str ret = "!!Unknown!!";

	match (n) {
		(0x00): ret = "None";
		(0x01): ret = "Poison";
		(0x02): ret = "Paralysis";
		(0x03): ret = "Sleep";
		(0x04): ret = "Blast";
	}

	return ret;
};
	
fn eqType (u8 n) {
	str ret = "!!Unknown!!";

	match (n) {
		(0x00): ret = "General";
		(0x01): ret = "SP";
		(0x02): ret = "Gou";
		(0x04): ret = "Evolution";
		(0x08): ret = "HC";
		(0x12): ret = "Random Weapon";
		(0x24): ret = "Ravi";
		(0x40): ret = "G50";
	}
	
	return ret;
};

fn weaponType (u32 n) {
	str ret = "!!Unknown!!";

	match (n) {
		(0x00000000): ret = "General";
		(0x00000800): ret = "Prayer LR";
		(0x00000808): ret = "Prayer GR";
		(0x00000200): ret = "Exotique";
		(0x00001000): ret = "Zenith";
		(0x00000002): ret = "Gou HR1";
		(0x00000004): ret = "Gou HR2";
		(0x00000010): ret = "Gou GR1";
		(0x00000020): ret = "Gou GR2";
		(0x00000100): ret = "Gou GR3";
		(0x00000008): ret = "GR Gunner";
		(0x08000000): ret = "GR Simple upgrade";
		(0x00000041): ret = "Finess weapon";
		(0x00004000): ret = "Ravi GR+";
		(0x00000080): ret = "Tower";
	}

	return ret;
};

fn zenithSkill (u16 n){
	str ret = "!!Unknown!!";

	match (n){
		(0x0000): ret = "None";
		(0x0001): ret = "Skill Slot UP +1"; //1
		(0x0002): ret = "Skill Slot UP +2"; //2
		(0x0003): ret = "Skill Slot UP +3"; //3
		(0x0004): ret = "Skill Slot UP +4"; //4
		(0x0005): ret = "Skill Slot UP +5"; //5
		(0x0006): ret = "Skill Slot UP +6"; //6
		(0x0007): ret = "Skill Slot UP +7"; //7
		(0x0008): ret = "Crit Conv UP +1"; //8
		(0x0009): ret = "Crit Conv UP +2"; //9
		(0x000A): ret = "Stylish Assault UP +1"; //10
		(0x000B): ret = "Stylish Assault UP +2"; //11
		(0x000C): ret = "Disolver UP"; //12
		(0x000D): ret = "ThunderClad UP +1"; //13
		(0x000E): ret = "ThunderClad UP +2"; //14
		(0x000F): ret = "Ice Age UP"; //15
		(0x0011): ret = "Earplug UP +1"; //16
		(0x0012): ret = "Earplug UP +2"; //17
		(0x0013): ret = "Earplug UP +3"; //18
		(0x0014): ret = "Wind Res UP +1"; //19
		(0x0015): ret = "Wind Res UP +2"; //20
		(0x0016): ret = "Wind Res UP +3"; //21
		(0x0017): ret = "Wind Res UP +4"; //22
		(0x0018): ret = "Quake Res UP +1"; //23
		(0x0019): ret = "Quake Res UP +2"; //24
		(0x001A): ret = "Poison Res UP +1"; //25
		(0x001B): ret = "Poison Res UP +2"; //26
		(0x001C): ret = "Para Res UP +1"; //27
		(0x001D): ret = "Para Res UP +2"; //28
		(0x001E): ret = "Sleep Res UP +1"; //29
		(0x001F): ret = "Sleep Res UP +2"; //30
		(0x0020): ret = "Vampirism UP +1"; //31
		(0x0021): ret = "Vampirism UP +2"; //32
		(0x0022): ret = "DrugKnowledge UP"; //33
		(0x0023): ret = "Assistance UP"; //34
		(0x0024): ret = "Bullet Shaver UP +1"; //35
		(0x0025): ret = "Bullet Shaver UP +2"; //36
		(0x0026): ret = "Guard UP +1"; //37
		(0x0027): ret = "Guard UP +2"; //38
		(0x0028): ret = "Adaptation UP +1"; //39
		(0x0029): ret = "Adapdation UP +2"; //40
		(0x002A): ret = "Encourage UP +1"; //41
		(0x002B): ret = "Encourage UP +2"; //42
		(0x002C): ret = "Reflect UP +1"; //43
		(0x002D): ret = "Reflect UP +2"; //44
		(0x002E): ret = "Reflect UP +3"; //45
		(0x002F): ret = "Stylish UP"; //46
		(0x0030): ret = "Vigorous UP"; //47
		(0x0031): ret = "Obscurity UP"; //48
		(0x0032): ret = "Soul UP"; //49
		(0x0033): ret = "Ceaseless UP"; //50
		(0x0034): ret = "Rush UP"; //51

	}
	return ret;
};
	
struct MeleeItem {
	u16 modelId [[color("0088FF")]];
	u8 rarity [[format("plusone"), color("22FF22")]];
	u8 classId [[format("className"), color("0088FF")]];
	
	u32 zennyCost [[
		comment("Seems to be twice what Ferias reports"), 
		color("22FF22")
	]];

	u8 sharpnessId  [[color("FFFF00")]];
	u8 sharpnessMax [[color("FFF000")]];

	u16 rawDamage [[
		comment("In-game attack is raw damage * some multiplier."), 
		color("22FF22")
	]]; 

	u16 defense [[color("22FF22")]];
	s8 affinity [[color("22FF22")]];

	u8 elementId [[format("elementName"), color("00FF00")]];
	u8 eleDamage [[format("timesten"), color("00FF00")]];

	u8 ailmentId [[format("ailmentName"), color("00FF00")]];
	u8 ailDamage [[format("timesten"), color("00FF00")]];

	u8 slots [[color("00FF00")]];

	u8 Weapon_attribute [[
		name("Weapon Attribute"),
		comment("Could be secondary weapon attribute, such as Swaxe Phial type?"),
		color("FF0000")
	]]; 
	
	u8 Unk15 [[
		color("FF0000")
	]];

	u16 upgradePath [[
		comment("Maybe what weapon it upgrades from, how many indecies to look back. 0xFF for none?"), 
		color("FF0000")
	]]; 

	u16 otherModel [[
		comment("Often the same or similar to modelId. Maybe drawn modelId?"), 
		color("FF0000")
	]]; 

	u8 Equip_Type [[
		name("Equip Type"),
		format("eqType"), 
		color("FFFF00")
	]]; 

	u8 unk1B;
	u32 Length;
	u32 Weapon_type [[
		name("Weapon Type"),
		format("weaponType"),
		comment("it define if its zenith, prayer, grank, exotic, gou, etc..."), 
		color("FF0000")
		]];
	
	u16 Visual_effects [[
		comment("Seems to be related to weapon visual effects"),
		color("FF0000")
	]]; 
	
	u16 Tower_G50_Param_ID[[
		name("Tower/G50 Param ID")
	]];
	u8 G_rank [[name("G Rank"), color("FF0000")]]; 
	u8 unk29; 
	u8 unk2A; 
	u8 zeroF [[comment("Always 0F?"), color("FF0000")]];
	u32 Unk2C [[comment("Free Params?"), color("FF0000")]]; 
	u16 zenithSkill[[
		name("Zenith Skills"),
		format("zenithSkill")
	]];
	padding[2];
};

fn reload (u8 n) {
	str ret = "!!Unknown!!";

	match (n) {
		(0x00): ret = "Very Slow";
		(0x01): ret = "Slow";
		(0x02): ret = "Normal";
		(0x03): ret = "Fast";
		(0x04): ret = "Very Fast";
	}
	return ret;
};

fn recoil (u8 n) {
	str ret = "!!Unknown!!";

	match (n) {
		(0x00): ret = "Very High";
		(0x01): ret = "High";
		(0x02): ret = "Normal";
		(0x03): ret = "Low";
		(0x04): ret = "Very Low";
	}
	return ret;
};
	
struct RangedItem {
	u16 modelId;
	u8 rarity [[format("plusone")]];
	u8 maxSlotsMaybe;
	u8 classId [[format("className")]];
	u8 unk05;
	u8 eq [[
		name("Equip Type"),
		format("eqType"), 
		color("FFFF00")]];
	u8 unk07;
	u8 unk08;
	u8 unk09;
	u8 unk11;
	u8 unk12;
	u32 Weapon_type[[
		name("Weapon Type"),
		format("weaponType"),
		comment("it define if its zenith, prayer, grank, exotic, gou, etc...")
	]]; 
	u32 unk10;
	u32 zennyCost;
	u16 rawDamage;
	u16 defense;
	u8 recoil[[format("recoil")]];
	u8 slots;
	s8 affinity;
	u8 sortOrderMaybe;
	u8 Weapon_attribute [[comment("define gunners shot?")]];
	u8 elementId [[format("elementName")]];
	u8 eleDamage [[format("timesten")]];
	u8 reload[[format("reload")]];
	u16 unk24;
	u16 unk26;
	u32 bullet; 
	u16 Tower_G50_Param_ID[[
		name("Tower/G50 Param ID?")
	]];
	u16 unk2E;
	u8 G_rank [[name("G Rank"), color("FF0000")]];
	u8 unk32;
	u8 unk34;
	u8 zeroF;
	u16 unk38;
	u16 zenithSkill[[
		name("Zenith Skills"),
		format("zenithSkill")
	]];
	u32 unk42[[hidden]];
};

struct WeaponName {
	s32p name;
};

struct WeaponDescription {
	s32p description_1;
	s32p description_2;
	s32p description_3;
	s32p mhfy;
};

struct TableWeapons {
	MeleeItem  meleeEntries  [ while (std::mem::read_signed($, 2) != -1) ] @ header.ptrs.meleeWeapons [[name("Melee")]];
	RangedItem rangedEntries [ while (std::mem::read_signed($, 2) != -1) ] @ header.ptrs.rangedWeapons [[name("Ranged")]];
};

TableWeapons tableWeapons;

u32 MeleeLength    = sizeof(MeleeItem);
u32 RangedLength   = sizeof(RangedItem);
u32 MeleeQuantity  = (sizeof(tableWeapons.meleeEntries)/MeleeLength);
u32 RangedQuantity = (sizeof(tableWeapons.rangedEntries)/RangedLength);

struct WeaponMelee {
 	MeleeItem         data         [MeleeQuantity] @ header.ptrs.meleeWeapons       [[name("Data")]];
  WeaponName        names        [MeleeQuantity] @ header.ptrs.meleeWeaponNames   [[name("Names")]];
  WeaponDescription descriptions [MeleeQuantity] @ header.ptrs.meleeWeaponDesc    [[name("Descriptions")]];
};

struct WeaponRanged {
 	RangedItem        data         [RangedQuantity] @ header.ptrs.rangedWeapons     [[name("Data")]];
  WeaponName        names        [RangedQuantity] @ header.ptrs.rangedWeaponNames [[name("Names")]];
  WeaponDescription descriptions [RangedQuantity] @ header.ptrs.rangedWeaponDesc  [[name("Descriptions")]];
};

struct Weapons {
  WeaponMelee  melee  @ header.ptrs.meleeWeapons  [[name("Melee")]];
  WeaponRanged ranged @ header.ptrs.rangedWeapons [[name("Ranged")]];
};

Weapons weapons @ header.ptrs.meleeWeapons [[name("Weapons")]];