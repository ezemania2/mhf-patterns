#pragma once

#include <mhfdat/utils/index.pat>
#include <misc/s32p.pat>

fn meleeName (u16 n) {
    return rIPPS(header.ptrs.meleeWeaponNames, n);
};


fn rangedName (u16 n) {
    return rIPPS(header.ptrs.rangedWeaponNames, n);
};

fn getEquipType(u8 n) {
    str ret = "!!Unknown!!";
    match (n) {
        (0x00): ret = "Legs";
        (0x02): ret = "Head";
        (0x03): ret = "Chest";
        (0x04): ret = "Arms";
        (0x05): ret = "Waist";
        (0x06): ret = "Melee";
        (0x07): ret = "Ranged";
    }
	return ret;
};

fn getEquipName(u32 n) {
    u8 equipType = u8 (n);
    u16 equipID = u16 (n>>16);
    
    str equipName = std::format("{:04X}", equipID);
         if (equipType == 0) 
        equipName = rIPPS(header.ptrs.legArmorNames, equipID);
    else if (equipType == 2) 
        equipName = rIPPS(header.ptrs.headArmorNames, equipID);
    else if (equipType == 3)
        equipName = rIPPS(header.ptrs.bodyArmorNames, equipID);
    else if (equipType == 4)
        equipName = rIPPS(header.ptrs.armArmorNames, equipID);
    else if (equipType == 5)
        equipName = rIPPS(header.ptrs.waistArmorNames, equipID);
    else if (equipType == 6) 
        equipName = rIPPS(header.ptrs.meleeWeaponNames, equipID);
    else if (equipType == 7) 
        equipName = rIPPS(header.ptrs.rangedWeaponNames, equipID);

    return std::format("{} | {}", getEquipType(equipType), equipName);
};

fn mUpgradeName (auto n) {
    //                  sizeof(WUpgradePath) = 36 
    //                                         \/
	return rIPPS(header.ptrs.meleeWeaponNames, 
    ( ($-header.ptrs.meleeWeaponUpgradePath) / 36));
};

fn rUpgradeName (auto n) {
    //                   sizeof(WUpgradePath) = 36 
    //                                          \/
	return rIPPS(header.ptrs.rangedWeaponNames, 
    ( ($-header.ptrs.rangedWeaponUpgradePath) / 36));
};

struct RegWUpgrade {
    u16 weaponID [[format("meleeName")]];
    padding[10];
    u16 upgradeMaterial1 [[format("getItemName")]];
    u8 numMaterial1;
    padding[5];
    u16 upgradeMaterial2 [[format("getItemName")]];
    u8 numMaterial2;
    padding[5];
    u16 upgradeMaterial3 [[format("getItemName")]];
    u8 numMaterial3;
    padding[5];
} [[comment("On using the materials listed, the weapon will upgrade to the listed weaponID, if it exists")]];

struct MWUpgradePath {
    u16 upgradeMaterial1 [[format("getItemName"), color("8888FF")]];
    u16 numMaterial1 [[color("FF8888")]];
    padding[4];
    u16 upgradeMaterial2 [[format("getItemName"), color("8888FF")]];
    u16 numMaterial2 [[color("FF8888")]];
    padding[4];
    u16 upgradeMaterial3 [[format("getItemName"), color("8888FF")]];
    u16 numMaterial3 [[color("FF8888")]];
    padding[4];
    u16 upgradesTo1 [[format("meleeName")]];
    u16 upgradesTo2 [[format("meleeName")]];
    u16 upgradesTo3 [[format("meleeName")]];
    u16 upgradesTo4 [[format("meleeName")]];
    padding[4];
} [[format("mUpgradeName"), color("88FF88")]];

struct RWUpgradePath {
    u16 upgradeMaterial1 [[format("getItemName"), color("8888FF")]];
    u16 numMaterial1 [[color("FF8888")]];
    padding[4];
    u16 upgradeMaterial2 [[format("getItemName"), color("8888FF")]];
    u16 numMaterial2 [[color("FF8888")]];
    padding[4];
    u16 upgradeMaterial3 [[format("getItemName"), color("8888FF")]];
    u16 numMaterial3 [[color("FF8888")]];
    padding[4];
    u16 upgradesTo1 [[format("rangedName")]];
    u16 upgradesTo2 [[format("rangedName")]];
    u16 upgradesTo3 [[format("rangedName")]];
    u16 upgradesTo4 [[format("rangedName")]];
    padding[4];
} [[format("rUpgradeName"), color("88FF88")]];

struct g50WUpgrade {
    u16 weaponId [[format("meleeName")]];
    u16 level1;
    u16 level2;
    u16 fullSuccRate;
    u32 zennyCost;
    u16 upgradeMaterial1 [[format("getItemName")]];
    u8 numMaterial1;
    padding[5];
    u16 upgradeMaterial2 [[format("getItemName")]];
    u8 numMaterial2;
    padding[5];
    u16 upgradeMaterial3 [[format("getItemName")]];
    u8 numMaterial3;
    padding[9];
};

struct RegAUpgradeRow {
    u16 itemID [[format("getItemName")]];
    u16 lv1Upgrade;
    u16 lv2Upgrade;
    u16 lv3Upgrade;
    u16 lv4Upgrade;
    u16 lv5Upgrade;
    u16 lv6Upgrade;
    u16 lv7Upgrade;
};

struct GenericAUpgrade {
    RegAUpgradeRow itemsForUpgrade [ while (std::mem::read_unsigned($, 0x10)) ];
};

struct SigilTowerTable {
    u16 ItemID [[format("getItemName")]];
    u16 ReceiptCategory;
    u16 ItemCraft1 [[format("getItemName")]];
    u8 ItemQty1;
    u8 ItemUnlockFlag1;
    u16 ItemCraft2 [[format("getItemName")]];
    u8 ItemQty2;
    u8 ItemUnlockFlag2;
    u16 ItemCraft3 [[format("getItemName")]];
    u8 ItemQty3;
    u8 ItemUnlockFlag3;
    u16 ItemCraft4 [[format("getItemName")]];
    u8 ItemQty4;
    u8 ItemUnlockFlag4;
};

struct CraftMatReq {
    u32 equipID [[color("0088FF"), format("getEquipName")]];
    bool purchaseable @ $-0x03;
	u16 materialID1 [[color("22FF22"), format("getItemName"), comment("Item ID")]];
	u16 materialAmnt1 [[color("FFFF22")]];
	padding[4];
	u16 materialID2 [[color("22FF22"), format("getItemName"), comment("Item ID")]];
	u16 materialAmnt2 [[color("FFFF22")]];
	padding[4];
	u16 materialID3 [[color("22FF22"), format("getItemName"), comment("Item ID")]];
	u16 materialAmnt3 [[color("FFFF22")]];
	padding[4];
    u16 materialID4 [[color("22FF22"), format("getItemName"), comment("Item ID")]];
	u16 materialAmnt4 [[color("FFFF22")]];
    padding[4];
	u16 unk24 [[comment("Some kind of flag?")]];
	padding[2];
	u16 HRreq;
	u16 unk2A [[comment("Some kind of flag?")]];
	bool previewAble;
	padding[3];
	u8 footer [[color("8888FF"), comment("0F")]];
	padding[3];
    u8 unk34 [[comment("W02=exotic, A01=Festi?, A02=Diva?, A03=SP?, A04=hiden, A05=exotic")]];
    padding[3];
} [[color("660066")]];

struct CraftMatTable {
    CraftMatReq entry [ while (std::mem::read_signed($, 1) != -1)] [[inline]];
};

MWUpgradePath mwUpgradePath[numMeleeW] @ header.ptrs.meleeWeaponUpgradePath;
RWUpgradePath rwUpgradePath[numRangedW] @ header.ptrs.rangedWeaponUpgradePath;

#pragma array_limit 81914
// Start of Selection
g50WUpgrade g50WeaponUpgrades[81914] @ header.ptrs.weaponG50Forging;

// [mhfo-hd.dll + 0xaf47ed]
ptVar<GenericAUpgrade> armorUpgrades[while(std::mem::read_unsigned($,4))] 
    @ header.ptrs.armorUpgradeMats;

SigilTowerTable sigilTowerTable[while(std::mem::read_unsigned($, 4))] @ header.ptrs.SigilTowerForging
    [[name("Sigil Tower Forging Data")]];
CraftMatTable towerArmorCraftingTable @ header.ptrs.armorTowerForging
    [[name("Tower Armor Forging Data")]];
CraftMatTable towerWeaponCraftingTable @ header.ptrs.weaponTowerForging
    [[name("Tower Weapon ForgWfing Data")]];
CraftMatTable specialWeaponCraftingTable @ header.ptrs.weaponSpecialForging //length = 56
    [[name("Special Weapon Forging Data??")]];
CraftMatTable armorGCraftingTable @ header.ptrs.armorGRForging
    [[name("G-Rank Armor Forging Data")]];
CraftMatTable weaponGCraftingTable @ header.ptrs.weaponGRForging
    [[name("G-Rank Weapon Forging Data")]];
CraftMatTable transmogCraftingTable2 @ header.ptrs.transmogForging2
    [[name("Second Transmog Forging Data")]];


CraftMatTable transmogCraftingTable @ header.ptrs.transmogForging
    [[name("Transmog Forging Data")]];
CraftMatTable zenithWeaponCraftingTable @ header.ptrs.zenithWeaponForging
    [[name("Zenith Weapon Forging Data")]];
CraftMatTable armorPremiumCraftingTable @ header.ptrs.armorPremiumForging
    [[name("Armor Premium Forging Data")]];
CraftMatTable zArmorCraftingTable @ header.ptrs.armorZenithForging
    [[name("Zenith Armor Forging Data")]];
CraftMatTable armorCraftingTable @ header.ptrs.armorForging
    [[name("Armor Forging Data")]];
CraftMatTable miscCrafting5 @ header.ptrs.otherWeaponForging
    [[name("Other Weapon Forging Data")]];


/* TODO: This section is weird
    Reena discovered the array names were wrong, and that
    evoUpgradeSub contains data for the weapon. 
    Rework these structs when more info is available
 */

struct evoUpgradeSub {
    u16 dmg;
    u16 unkSub2;
    u16 eleDamage;
    padding[2];
    u16 unkSub8;
    padding[2];
} [[single_color]];

struct evoUpgrade {
    u32 gCost;
    u16 unk04;
    u16 level;
    evoUpgradeSub sub[11];
    u16 unk8C [[comment("Increments with level from 650 to 850")]]; 
    u8 unk8E; padding[1];
    u16 unk90; padding[2];
    float unk94 [[comment("Always 0.70??")]]; 
    float unk98 [[comment("Always 1.00??")]];
    float unk9C [[comment("Always 1.20??")]];
    float unkA0 [[comment("Always 2.50??")]];
    float unkA4 [[comment("Always 1.43??")]]; 
    u16 unkA8 [[comment("Increments")]];
    u16 unkAA [[comment("Increments")]];
    u8 unkAC [[comment("Increments with level. 32 32, 33 33, ... in HR")]];
    u8 unkAD [[comment("Increments with level")]];
    padding[2];
};

evoUpgrade evoUpgradesClear[100] @ header.ptrs.evoUpgrades;
evoUpgrade evoUpgradesGlory[100] @ $;
evoUpgrade evoUpgradesShine[100] @ $;
evoUpgrade evoUpgradesFlash[100] @ $;

struct DecoShop {
    u16 decoItemID [[format("getItemName")]];
    u16 ReceiptCategory;
    u16 ItemID1 [[format("getItemName")]];
    u8 ItemQty1;
    u8 ItemUnlockFlag1;
    u16 ItemID2 [[format("getItemName")]];
    u8 ItemQty2;
    u8 ItemUnlockFlag2;
    u16 ItemID3 [[format("getItemName")]];
    u8 ItemQty3;
    u8 ItemUnlockFlag3;
    u16 ItemID4 [[format("getItemName")]];
    u8 ItemQty4;
    u8 ItemUnlockFlag4;
} [[single_color]];

DecoShop decoShop[while(std::mem::read_unsigned($, 4))] @ header.ptrs.DecoShop;
DecoShop grankDecoShop[while(std::mem::read_unsigned($, 4))] @ header.ptrs.GrankDecoShop;
DecoShop cuffCrafting[while(std::mem::read_unsigned($, 4))] @ header.ptrs.CuffCrafting;
DecoShop grankCuffCrafting[while(std::mem::read_unsigned($, 4))] @ header.ptrs.GrankCuffCrafting;