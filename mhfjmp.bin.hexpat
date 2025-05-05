// Adjusted limits to prevent runtime errors
#pragma pattern_limit 1000000
#pragma array_limit 20000
#include <std/mem.pat>
#include <std/io.pat>
#include <misc/s32p.pat>

u32 hd_dll_1cbc3f @ 0x00;

struct menu_entry {

    u32 JumpID;
    u32 unk0C[[comment("always FF FF FF FF")]];
    u16 AreaID;
    u16 AreaID2;
    u16 AreaID3;
    u16 AreaID4;
    float PosX [[comment("Seems linked with PosX1")]];
    float PosY [[comment("Seems linked with PosY1")]];
    float PosZ [[comment("Seems linked with PosZ1")]];
    u8 unk28 [[comment("Seems linked with unk 38")]];
    u8 unk29;
    u16 unk30;
    float PosX1;
    float PosY1;
    float PosZ1;
    u8 unk38;
    u8 unk39;
    u16 unk40;
    s32p title;
    s32p description;


};

// Increased array size to allow more entries
menu_entry hd_dll_1cbc46[0x18] @ (hd_dll_1cbc3f + 0x00);

u32 hd_dll_1cbc5b @ 0x04;
u32 hd_dll_1cbc66 @0x08;
u32 Unk_C @0x0C;
u32 Unk_10 @0x10;