#pragma once

#include <std/mem.pat>

struct QuestPointers {
	u32 oneStar;
	u32 twoStars;
	u32 threeStars;
	u32 fourStars;
	u32 fiveStars;
	u32 sixStars;
};

struct QuestItem {
	u16 questId;
	u16 questNumber;
	u8 keyQuest;
	u8 urgentQuest;
	u16 unknown;
};

struct Quest {
	QuestItem oneStar    [35] @ 0x013C1EE0 [[name("*")]];
	QuestItem twoStars   [34] @ 0x013C1DC0 [[name("**")]];
	QuestItem threeStars [53] @ 0x013C1C00 [[name("***")]];
	QuestItem fourStars  [28] @ 0x013C1B00 [[name("****")]];
	QuestItem fiveStars  [93] @ 0x013C1800 [[name("*****")]];
	QuestItem sixStars   [12] @ 0x013C1780 [[name("******")]];
};

struct Quests {
	QuestPointers questPointers @ 0x013C1760 [[name("Pointers")]];
	Quest         data          @ 0x013C1760 [[name("Data")]];
};

Quests quests @ header.ptrs.questList [[name("Quests")]];
