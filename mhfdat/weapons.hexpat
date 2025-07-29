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
// Weapon class enum
enum WeaponClass : u8 {
	GreatSword = 0x00,
	HeavyBowgun = 0x01,
	Hammer = 0x02,
	Lance = 0x03,
	SwordAndShield = 0x04,
	LightBowgun = 0x05,
	DualBlades = 0x06,
	LongSword = 0x07,
	HuntingHorn = 0x08,
	Gunlance = 0x09,
	Bow = 0x0A,
	Tonfa = 0x0B,
	SwitchAxeF = 0x0C,
	MagnetSpike = 0x0D
};
	
// Element type enum
enum ElementType : u8 {
	None = 0x00,
	Fire = 0x01,
	Water = 0x02,
	Thunder = 0x03,
	Dragon = 0x04,
	Ice = 0x05,
	Flame = 0x06,
	Light = 0x07,
	ThunderPole = 0x08,
	Tenshou = 0x09,
	Okiko = 0x0A,
	BlackFlame = 0x0B,
	Kanade = 0x0C,
	Darkness = 0x0D,
	CrimsonDemon = 0x0E,
	Wind = 0x0F,
	Sound = 0x10,
	BurningZero = 0x11,
	EmperorsRoar = 0x12
};
	
// Ailment type enum
enum AilmentType : u8 {
	None = 0x00,
	Poison = 0x01,
	Paralysis = 0x02,
	Sleep = 0x03,
	Blast = 0x04
};
	
// Equipment type enum
enum EquipType : u8 {
	General = 0x00,
	SP = 0x01,
	Gou = 0x02,
	Evolution = 0x04,
	HC = 0x08,
	RandomWeapon = 0x12,
	Ravi = 0x24,
	G50 = 0x40
};

// Bitfield structure for WeaponType analysis
bitfield WeaponType {
    finess_base : 1;        // bit 0
    gou_hr1 : 1;           // bit 1
    gou_hr2 : 1;           // bit 2
    gr_gunner : 1;         // bit 3
    gou_gr1 : 1;           // bit 4
    gou_gr2 : 1;           // bit 5
    finess_ext : 1;        // bit 6
    tower : 1;             // bit 7
    gou_gr3 : 1;           // bit 8
    exotique : 1;          // bit 9
    ravi_z : 1;            // bit 10
    prayer_base : 1;       // bit 11
    zenith : 1;            // bit 12
    reserved_13 : 1 [[hidden]];       // bit 13
    ravi_gr_plus : 1;      // bit 14
    reserved_15_26 : 12 [[hidden]];   // bits 15-26
    gr_simple_upgrade : 1; // bit 27
    reserved_28_31 : 4 [[hidden]];    // bits 28-31
};

fn weaponTypeDecoder(WeaponType wt) {
    str result = "";
    bool first = true;
    
    // Gestion spéciale pour Prayer GR (combinaison de bits 11 + 3)
    if (wt.prayer_lr && wt.gr_gunner) {
        result += "Prayer GR";
        first = false;
    } else {
        // Traitement individuel si pas Prayer GR
        if (wt.prayer_lr) {
            if (!first) result += " | ";
            result += "Prayer LR";
            first = false;
        }
        if (wt.gr_gunner) {
            if (!first) result += " | ";
            result += "GR Gunner";
            first = false;
        }
    }
    
    if (wt.gou_hr1) {
        if (!first) result += " | ";
        result += "Gou HR1";
        first = false;
    }
    if (wt.gou_hr2) {
        if (!first) result += " | ";
        result += "Gou HR2";
        first = false;
    }
    if (wt.gou_gr1) {
        if (!first) result += " | ";
        result += "Gou GR1";
        first = false;
    }
    if (wt.gou_gr2) {
        if (!first) result += " | ";
        result += "Gou GR2";
        first = false;
    }
    if (wt.finess_weapon) {
        if (!first) result += " | ";
        result += "Finess weapon";
        first = false;
    }
    if (wt.tower) {
        if (!first) result += " | ";
        result += "Tower";
        first = false;
    }
    if (wt.gou_gr3) {
        if (!first) result += " | ";
        result += "Gou GR3";
        first = false;
    }
    if (wt.exotique) {
        if (!first) result += " | ";
        result += "Exotique";
        first = false;
    }
    if (wt.zenith) {
        if (!first) result += " | ";
        result += "Zenith";
        first = false;
    }
    if (wt.ravi_gr_plus) {
        if (!first) result += " | ";
        result += "Ravi GR+";
        first = false;
    }
    if (wt.gr_simple_upgrade) {
        if (!first) result += " | ";
        result += "GR Simple upgrade";
        first = false;
    }
    
    if (result == "") {
        result = "General";
    }
    
    return result;
};

// Fonction utilitaire pour détecter Prayer GR
fn isPrayerGR(WeaponType wt) {
    return (wt.prayer_lr && wt.gr_gunner);
};


enum Length : u32 {
	Medium = 0x00000000,
	Short = 0x00000001,
	VeryShort = 0x00000002,
	Long = 0x00000003,
	VeryLong = 0x00000004
};

// Zenith skill enum
enum ZenithSkill : u16 {
	None = 0x0000,
	SkillSlotUP1 = 0x0001,
	SkillSlotUP2 = 0x0002,
	SkillSlotUP3 = 0x0003,
	SkillSlotUP4 = 0x0004,
	SkillSlotUP5 = 0x0005,
	SkillSlotUP6 = 0x0006,
	SkillSlotUP7 = 0x0007,
	CritConvUP1 = 0x0008,
	CritConvUP2 = 0x0009,
	StylishAssaultUP1 = 0x000A,
	StylishAssaultUP2 = 0x000B,
	DisolverUP = 0x000C,
	ThunderCladUP1 = 0x000D,
	ThunderCladUP2 = 0x000E,
	IceAgeUP = 0x000F,
	EarplugUP1 = 0x0011,
	EarplugUP2 = 0x0012,
	EarplugUP3 = 0x0013,
	WindResUP1 = 0x0014,
	WindResUP2 = 0x0015,
	WindResUP3 = 0x0016,
	WindResUP4 = 0x0017,
	QuakeResUP1 = 0x0018,
	QuakeResUP2 = 0x0019,
	PoisonResUP1 = 0x001A,
	PoisonResUP2 = 0x001B,
	ParaResUP1 = 0x001C,
	ParaResUP2 = 0x001D,
	SleepResUP1 = 0x001E,
	SleepResUP2 = 0x001F,
	VampirismUP1 = 0x0020,
	VampirismUP2 = 0x0021,
	DrugKnowledgeUP = 0x0022,
	AssistanceUP = 0x0023,
	BulletShaverUP1 = 0x0024,
	BulletShaverUP2 = 0x0025,
	GuardUP1 = 0x0026,
	GuardUP2 = 0x0027,
	AdaptationUP1 = 0x0028,
	AdaptationUP2 = 0x0029,
	EncourageUP1 = 0x002A,
	EncourageUP2 = 0x002B,
	ReflectUP1 = 0x002C,
	ReflectUP2 = 0x002D,
	ReflectUP3 = 0x002E,
	StylishUP = 0x002F,
	VigorousUP = 0x0030,
	ObscurityUP = 0x0031,
	SoulUP = 0x0032,
	CeaselessUP = 0x0033,
	RushUP = 0x0034
};

struct MeleeItem {
	u16 modelId [[color("0088FF")]];
	u8 rarity [[format("plusone"), color("22FF22")]];
	WeaponClass classId [[color("0088FF")]];
	
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

	ElementType elementId [[color("00FF00")]];
	u8 eleDamage [[format("timesten"), color("00FF00")]];

	AilmentType ailmentId [[color("00FF00")]];
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

	EquipType Equip_Type [[
		name("Equip Type"),
		color("FFFF00")
	]]; 

	u8 unk1B;
	Length Length;
    WeaponType weapon_type [[
        name("Weapon Type"),
        comment("Bitfield defining weapon categories: zenith, prayer, grank, exotic, gou, etc..."), 
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
	ZenithSkill zenithSkill[[
		name("Zenith Skills")
	]];
	padding[2];
};


// Reload speed enum
enum ReloadSpeed : u8 {
	VerySlow = 0x00,
	Slow = 0x01,
	Normal = 0x02,
	Fast = 0x03,
	VeryFast = 0x04
};

// Recoil level enum
enum RecoilLevel : u8 {
	VeryHigh = 0x00,
	High = 0x01,
	Normal = 0x02,
	Low = 0x03,
	VeryLow = 0x04
};

bitfield BulletTypes {
    normal_lv1    : 1;   // Bit 0  - LV1 通常弾 (Normal Lv1)
    normal_lv2    : 1;   // Bit 1  - LV2 通常弾 (Normal Lv2)
    normal_lv3    : 1;   // Bit 2  - LV3 通常弾 (Normal Lv3)
    pierce_lv1    : 1;   // Bit 3  - LV1 貫通弾 (Pierce Lv1)
    pierce_lv2    : 1;   // Bit 4  - LV2 貫通弾 (Pierce Lv2)
    pierce_lv3    : 1;   // Bit 5  - LV3 貫通弾 (Pierce Lv3)
    spread_lv1    : 1;   // Bit 6  - LV1 散弾 (Spread Lv1)
    spread_lv2    : 1;   // Bit 7  - LV2 散弾 (Spread Lv2)
    spread_lv3    : 1;   // Bit 8  - LV3 散弾 (Spread Lv3)
    crag_lv1      : 1;   // Bit 9  - LV1 徹甲榴弾 (Crag Lv1)
    crag_lv2      : 1;   // Bit 10 - LV2 徹甲榴弾 (Crag Lv2)
    crag_lv3      : 1;   // Bit 11 - LV3 徹甲榴弾 (Crag Lv3)
    cluster_lv1   : 1;   // Bit 12 - LV1 拡散弾 (Cluster Lv1)
    cluster_lv2   : 1;   // Bit 13 - LV2 拡散弾 (Cluster Lv2)
    cluster_lv3   : 1;   // Bit 14 - LV3 拡散弾 (Cluster Lv3)
    fire          : 1;   // Bit 15 - 火炎弾 (Fire Shot)
    water         : 1;   // Bit 16 - 水冷弾 (Water Shot)
    thunder       : 1;   // Bit 17 - 電撃弾 (Thunder Shot)
    ice           : 1;   // Bit 18 - 氷結弾 (Ice Shot)
    dragon        : 1;   // Bit 19 - 滅龍弾 (Dragon Shot)
    recovery_lv1  : 1;   // Bit 20 - LV1 回復弾 (Recovery Lv1)
    recovery_lv2  : 1;   // Bit 21 - LV2 回復弾 (Recovery Lv2)
    poison_lv1    : 1;   // Bit 22 - LV1 毒弾 (Poison Lv1)
    poison_lv2    : 1;   // Bit 23 - LV2 毒弾 (Poison Lv2)
    paralysis_lv1 : 1;   // Bit 24 - LV1 麻痺弾 (Paralysis Lv1)
    paralysis_lv2 : 1;   // Bit 25 - LV2 麻痺弾 (Paralysis Lv2)
    sleep_lv1     : 1;   // Bit 26 - LV1 睡眠弾 (Sleep Lv1)
    sleep_lv2     : 1;   // Bit 27 - LV2 睡眠弾 (Sleep Lv2)
    tranquilizer  : 1;   // Bit 28 - 捕獲用麻酔弾 (Tranquilizer Shot)
    paint         : 1;   // Bit 29 - ペイント弾 (Paint Shot)
    demon         : 1;   // Bit 30 - 鬼人弾 (Demon Shot)
    armor         : 1;   // Bit 31 - 硬化弾 (Armor Shot)
};

bitfield AmmoQuantity {
    normal_lv1_qty    : 1;   // Bit 0  - LV1 通常弾 (Normal Lv1)
    normal_lv2_qty    : 1;   // Bit 1  - LV2 通常弾 (Normal Lv2)
    normal_lv3_qty    : 1;   // Bit 2  - LV3 通常弾 (Normal Lv3)
    pierce_lv1_qty    : 1;   // Bit 3  - LV1 貫通弾 (Pierce Lv1)
    pierce_lv2_qty    : 1;   // Bit 4  - LV2 貫通弾 (Pierce Lv2)
    pierce_lv3_qty    : 1;   // Bit 5  - LV3 貫通弾 (Pierce Lv3)
    spread_lv1_qty    : 1;   // Bit 6  - LV1 散弾 (Spread Lv1)
    spread_lv2_qty    : 1;   // Bit 7  - LV2 散弾 (Spread Lv2)
    spread_lv3_qty    : 1;   // Bit 8  - LV3 散弾 (Spread Lv3)
    crag_lv1_qty      : 1;   // Bit 9  - LV1 徹甲榴弾 (Crag Lv1)
    crag_lv2_qty      : 1;   // Bit 10 - LV2 徹甲榴弾 (Crag Lv2)
    crag_lv3_qty      : 1;   // Bit 11 - LV3 徹甲榴弾 (Crag Lv3)
    cluster_lv1_qty   : 1;   // Bit 12 - LV1 拡散弾 (Cluster Lv1)
    cluster_lv2_qty   : 1;   // Bit 13 - LV2 拡散弾 (Cluster Lv2)
    cluster_lv3_qty   : 1;   // Bit 14 - LV3 拡散弾 (Cluster Lv3)
    fire_qty          : 1;   // Bit 15 - 火炎弾 (Fire Shot)
    water_qty         : 1;   // Bit 16 - 水冷弾 (Water Shot)
    thunder_qty       : 1;   // Bit 17 - 電撃弾 (Thunder Shot)
    ice_qty           : 1;   // Bit 18 - 氷結弾 (Ice Shot)
    dragon_qty        : 1;   // Bit 19 - 滅龍弾 (Dragon Shot)
    recovery_lv1_qty  : 1;   // Bit 20 - LV1 回復弾 (Recovery Lv1)
    recovery_lv2_qty  : 1;   // Bit 21 - LV2 回復弾 (Recovery Lv2)
    poison_lv1_qty    : 1;   // Bit 22 - LV1 毒弾 (Poison Lv1)
    poison_lv2_qty    : 1;   // Bit 23 - LV2 毒弾 (Poison Lv2)
    paralysis_lv1_qty : 1;   // Bit 24 - LV1 麻痺弾 (Paralysis Lv1)
    paralysis_lv2_qty : 1;   // Bit 25 - LV2 麻痺弾 (Paralysis Lv2)
    sleep_lv1_qty     : 1;   // Bit 26 - LV1 睡眠弾 (Sleep Lv1)
    sleep_lv2_qty     : 1;   // Bit 27 - LV2 睡眠弾 (Sleep Lv2)
    tranquilizer_qty  : 1;   // Bit 28 - 捕獲用麻酔弾 (Tranquilizer Shot)
    paint_qty         : 1;   // Bit 29 - ペイント弾 (Paint Shot)
    demon_qty         : 1;   // Bit 30 - 鬼人弾 (Demon Shot)
    armor_qty         : 1;   // Bit 31 - 硬化弾 (Armor Shot)
} [[color("FF8080")]];
	
struct RangedItem {
	u16 modelId;
	u8 rarity [[format("plusone")]];
	u8 maxSlotsMaybe;
	WeaponClass classId;
	u8 unk05;
	EquipType eq [[
		name("Equip Type"),
		color("FFFF00")]];
	u8 unk07;
	u8 unk08;
	u8 unk09;
	u8 unk11;
	u8 unk12;
	WeaponType Weapon_type[[
		name("Weapon Type"),
		comment("it define if its zenith, prayer, grank, exotic, gou, etc...")
	]]; 
	u32 unk10;
	u32 zennyCost;
	u16 rawDamage;
	u16 defense;
	RecoilLevel recoil;
	u8 slots;
	s8 affinity;
	u8 sortOrderMaybe;
	u8 Weapon_attribute [[comment("define gunners shot?")]];
	ElementType elementId;
	u8 eleDamage [[format("timesten")]];
	ReloadSpeed reload;
	u32 unk24;
	BulletTypes bullet [[
        name("Bullet Types Supported"),
        comment("Bitfield indicating which ammunition types this bowgun can use")
    ]];
	u16 Tower_G50_Param_ID[[
		name("Tower/G50 Param ID?")
	]];
	u16 unk2E;
	u8 G_rank [[name("G Rank"), color("FF0000")]];
	u8 unk32;
	u8 unk34;
	u8 zeroF;
	u16 unk38;
	ZenithSkill zenithSkill[[
		name("Zenith Skills")
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
