// Very large limits just in case, feel free to make these more sensible
#pragma pattern_limit 5000000
#pragma array_limit 200000
#include <std/sys.pat>
#include <std/mem.pat>
#include <std/io.pat>
#include <misc/types.pat>
#include <misc/s32p.pat>

//#define __DECOMPILE 1

str __header_fail_msg = "File header does not match expected mhfpac header";
u32 header1 @ 0x0 [[comment("Must equal 1A 63 61 70")]];
u32 header2 @ 0x4 [[comment("Must equal 00 00 00 0A")]];

std::assert_warn(header1 == 0x1A636170, __header_fail_msg);
std::assert_warn(header2 == 0x0000000A, __header_fail_msg);

ptr soStringSkillPt @ 0xA20;
ptr eoStringSkillPt @ 0xA1C;

ptr soStringSkillActivate @ 0xA1C;
ptr eoStringSkillActivate @ 0xBC0;

ptr soStringZSkill @ 0xFBC;
ptr eoStringZSkill @ 0xFB0;

ptr soStringSkillDesc @ 0xB8;
ptr eoStringSkillDesc @ 0xC0;

s32p skills[(eoStringSkillPt - soStringSkillPt)/4] @ soStringSkillPt;
s32p skillActive[(eoStringSkillActivate - soStringSkillActivate)/4] @ soStringSkillActivate;
s32p zskills[(eoStringZSkill - soStringZSkill)/4] @ soStringZSkill;
s32p skillDesc[(eoStringSkillDesc - soStringSkillDesc)/4] @ soStringSkillDesc;


struct Header {
    u64 unk0;
    u32 unk2;
    u32 pointerUnk; // end of header?
    u32 pointerEndOfText;
    Headers headerChunk[4] [[optimize(false)]];
    local int i;
    // Seek to the start of npcData then read
};


#ifdef __DECOMPILE
#include <mhfpac/decompile.hexpat>
#endif
