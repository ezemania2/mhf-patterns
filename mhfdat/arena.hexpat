#pragma once
#include <mhfdat/utils/index.pat>

// ***** Arena Equipment Block ***** //

struct DefBlock {
    u16 weaponClass;
    u16 weaponId;
    u16;
    u16 head;
    u16 chest;
    u16 arms;
    u16 waist;
    u16 legs;
    u16 setIdx;
    u16 multi;
};

struct ArenaEquips {
    DefBlock def[4];
} [[inline]];

ptVar<ArenaEquips> ArenaEquipment[17] @ header.ptrs.arenaEquipment;

// ***** Arena Item Block ***** //

using ItemBlock;
fn itemBlockFmt (ItemBlock n) {
    return std::format("{:02}x {}", n.quantity, getItemName(n.id));
};

struct ItemBlock {
    u16 quantity;
    u16 id;
} [[sealed, format("itemBlockFmt")]];

struct ItemTable {
    ItemBlock items[while(std::mem::read_signed($, 2) != -1)];
} [[inline]];

ptVar<ItemTable> ArenaItems[68] @ header.ptrs.arenaItems;

ptVar<ItemTable> unkPointers[23] @ header.ptrs.arenaAmmo
[[comment("Maybe items to add as ammo for ranged weapons?")]];

/* I have no idea what these are, they're just referenced in a pattern
    Doriel sent to me */
u16 stageIDChunk0[28] @ header.ptrs.arenaStageIDC0;
u16 stageIDChunk1[34] @ header.ptrs.arenaStageIDC1;

/* I have no idea what these are either, again referenced in a pattern
    sent to me by Doriel */

struct unkChunk {
    u16 unkVals[10];
} [[inline]];

ptVar<unkChunk> moreMysteryPointers[23] @ header.ptrs.hd_dll_af5261;
