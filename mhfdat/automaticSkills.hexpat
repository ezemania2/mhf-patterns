#pragma once

#include <misc/s32p.pat>
#include <misc/automaticskills.hexpat>
#include <std/mem.pat>

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

fn getEquipNameFromID(u16 id, u8 equipType) {
    str equipName = std::format("{:04X}", id);
         if (equipType == 0) 
        equipName = rIPPS(header.ptrs.legArmorNames, id);
    else if (equipType == 2) 
        equipName = rIPPS(header.ptrs.headArmorNames, id);
    else if (equipType == 3)
        equipName = rIPPS(header.ptrs.bodyArmorNames, id);
    else if (equipType == 4)
        equipName = rIPPS(header.ptrs.armArmorNames, id);
    else if (equipType == 5)
        equipName = rIPPS(header.ptrs.waistArmorNames, id);
    else if (equipType == 6) 
        equipName = rIPPS(header.ptrs.meleeWeaponNames, id);
    else if (equipType == 7) 
        equipName = rIPPS(header.ptrs.rangedWeaponNames, id);
    
    return equipName;
};

using autoskills;
fn autoskillsFmt(autoskills entry) {
    return std::format("{} | {} | {}", 
        getEquipType(entry.eqType),
        getEquipNameFromID(entry.equipID, entry.eqType),
        entry.skill_id);
};

struct autoskills{
    u8 unk00;
    u8 eqType [[format("getEquipType")]];
    u16 equipID [[comment("getEquipNameFromID(equipID, eqType)")]];
    autoSkillList skill_id;
    padding[2];
} [[format("autoskillsFmt")]];

// Function to dynamically determine the table size
fn get_autoskills_count(ptr start_addr) {
    u32 count = 0;
    ptr current_addr = start_addr;
    
    // Each autoskills entry is 8 bytes
    while (count < 5000) {
        // Check file boundaries
        if (current_addr + sizeof(autoskills) > std::mem::size()) break;
        
        // Read the first byte (unk00) and equipment type
        u8 unk00 = std::mem::read_unsigned(current_addr, 1);
        u8 eqType = std::mem::read_unsigned(current_addr + 1, 1);
        u16 equipID = std::mem::read_unsigned(current_addr + 2, 2);
        u16 skill_id = std::mem::read_unsigned(current_addr + 4, 2);
        
        // Stop conditions
        // If we hit all zeros, we've reached padding/end
        if (unk00 == 0 && eqType == 0 && equipID == 0 && skill_id == 0) break;
        
        // If we hit 0xFFFF pattern
        if (equipID == 0xFFFF) break;
        
        // Valid equipment types are 0, 2-7
        if (eqType > 7 && eqType != 0) break;
        if (eqType == 1) break;
        
        count = count + 1;
        current_addr = current_addr + sizeof(autoskills);
    }
    
    // Ensure we return at least 1 to avoid empty arrays
    if (count == 0) count = 1;
    
    return count;
};

// TODO: If the exact offset in important_nums is known, replace the dynamic count with:
// num numAutomaticSkills @ (header.ptrs.important_nums + 0xXX) [[name("Number of Automatic Skills")]];
// And use: autoskills automaticSkills[numAutomaticSkills] @ header.ptrs.AutomaticSkillsTable [[name("Automatic Skills")]];

autoskills automaticSkills[get_autoskills_count(header.ptrs.AutomaticSkillsTable)] 
    @ header.ptrs.AutomaticSkillsTable 
    [[name("Automatic Skills Table")]];
