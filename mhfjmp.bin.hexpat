#pragma pattern_limit 1000000
#pragma array_limit 20000
#include <std/mem.pat>
#include <std/io.pat>
#include <misc/s32p.pat>

// Pointeurs principaux
u32 hd_dll_1cbc3f @ 0x00 [[name("Menu Entries")]];
u32 hd_dll_1cbc5b @ 0x04 [[name("pAreas")]];
u32 hd_dll_1cbc66 @ 0x08 [[name("LenArea")]];
u32 Unk_C @ 0x0C [[name("PStrings")]];
u32 Unk_10 @ 0x10 [[name("LenStrings")]];

// Définition des structures
struct menu_entry {
    u32 JumpID;
    u32 unk0C [[comment("always FF FF FF FF")]];
    u16 AreaID;
    u16 AreaID2;
    u16 AreaID3;
    u16 AreaID4;
    float PlayerPosX;
    float PlayerPosY;
    float PlayerPosZ;
    u32 PlayerRotation;
    float CameraPosX;
    float CameraPosY;
    float CameraPosZ;
    u32 CameraRotation;
    s32p title [[encoding("shift-jis")]];
    s32p description [[encoding("shift-jis")]];
};

struct AREAENTRY {
    u16 index;
    u16 flags;
};

struct Area {
    u32 pEntryData;
    u32 lenEntryData;
    u32 pStageIds;

    AREAENTRY entry[lenEntryData] @ pEntryData;
    u16 stageIds[] @ pStageIds;
};

struct Strings {
    s32p strings;
};

// Utilisation des structures
menu_entry hd_dll_1cbc46[0x18] @ (hd_dll_1cbc3f) [[name("Menu Entries")]];
Area areas[hd_dll_1cbc66] @ (hd_dll_1cbc5b) [[name("Areas")]];
Strings strings[Unk_10] @ (Unk_C) [[name("Strings")]];