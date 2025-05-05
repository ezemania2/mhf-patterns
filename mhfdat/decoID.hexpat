#pragma once

#include <misc/types.pat>

struct DecoID {
u8 slot_nb;
u16 flags;
u32 price;
padding[1];
u8 skillID1[[
    format("SkillName"),
    name("Skill ID 1")
]];
s8 skillPts1;
u8 skillID2[[
    format("SkillName"),
    name("Skill ID 2")
]];
s8 skillPts2;
u8 skillID3[[
    format("SkillName"),
    name("Skill ID 3")
]];
s8 skillPts3;
u8 skillID4[[
    format("SkillName"),
    name("Skill ID 4")
]];
s8 skillPts4;
u16 specialFlags;
u16 zenithSkill[[
    format("zenithSkills"),
    name("Zenith Skill")
]];
};

fn SkillName (u8 n){
    str ret = "!!Unknown!!";

    match (n) {
        (0x00): ret = "None";
        (0x01): ret = "Passive";
        (0x02): ret = "Fate";
        (0x03): ret = "Backpacking";
        (0x04): ret = "Auto-Guard";
        (0x05): ret = "Guard";
        (0x06): ret = "Recover";
        (0x07): ret = "Recover Speed";
        (0x08): ret = "Clust S.Add";
        (0x09): ret = "Protection";
        (0x0A): ret = "Thunder Res";
        (0x0B): ret = "Pierce S.Up";
        (0x0C): ret = "Pierce S.Add";
        (0x0D): ret = "Stun";
        (0x0E): ret = "Whim";
        (0x0F): ret = "Sharpness";
        (0x10): ret = "Gluttony";
        (0x11): ret = "Stealth";
        (0x12): ret = "Expert";
        (0x13): ret = "Wide-Area Recovery";
        (0x14): ret = "Wide-Area Antidote";
        (0x15): ret = "Attack";
        (0x16): ret = "Gather";
        (0x17): ret = "Pellet S.Up";
        (0x18): ret = "Pellet S.Add";
        (0x19): ret = "Sleep";
        (0x1A): ret = "All Res Up";
        (0x1B): ret = "Psychic";
        (0x1C): ret = "Reload";
        (0x1D): ret = "Cold Res";
        (0x1E): ret = "Heat Res";
        (0x1F): ret = "Health";
        (0x20): ret = "Artisan";
        (0x21): ret = "Wide-Area Seeds";
        (0x22): ret = "Ammo Combiner";
        (0x23): ret = "Map";
        (0x24): ret = "Hearing";
        (0x25): ret = "Combining";
        (0x26): ret = "Normal S.Up";
        (0x27): ret = "Normal S.Add";
        (0x28): ret = "Fish";
        (0x29): ret = "------";
        (0x2A): ret = "------";
        (0x2B): ret = "------";
        (0x2C): ret = "Throwing";
        (0x2D): ret = "Sharpening";
        (0x2E): ret = "Poison";
        (0x2F): ret = "Status Attack";
        (0x30): ret = "Meat";
        (0x31): ret = "Anti-Theft";
        (0x32): ret = "Bomb Boost";
        (0x33): ret = "Hunger";
        (0x34): ret = "Recoil";
        (0x35): ret = "Fire Res";
        (0x36): ret = "Wind Pressure";
        (0x37): ret = "Horn";
        (0x38): ret = "Defense";
        (0x39): ret = "Paralysis";
        (0x3A): ret = "Water Res";
        (0x3B): ret = "Dragon Res";
        (0x3C): ret = "Crag S.Add";
        (0x3D): ret = "Alchemy";
        (0x3E): ret = "Auto-Reload";
        (0x3F): ret = "Gather Speed";
        (0x40): ret = "Evasion";
        (0x41): ret = "Adrenaline";
        (0x42): ret = "Everlasting";
        (0x43): ret = "Stamina";
        (0x44): ret = "Loading";
        (0x45): ret = "Precision";
        (0x46): ret = "Monster";
        (0x47): ret = "Eating";
        (0x48): ret = "Carving";
        (0x49): ret = "Terrain";
        (0x4A): ret = "Deoderant";
        (0x4B): ret = "Snowball Res";
        (0x4C): ret = "Ice Res";
        (0x4D): ret = "Quake Res";
        (0x4E): ret = "Wide-Area";
        (0x4F): ret = "Vocal Chords";
        (0x50): ret = "Cooking";
        (0x51): ret = "Gunnery";
        (0x52): ret = "------";
        (0x53): ret = "------";
        (0x54): ret = "------";
        (0x55): ret = "Flute Expert";
        (0x56): ret = "------";
        (0x57): ret = "------";
        (0x58): ret = "------";
        (0x59): ret = "------";
        (0x5A): ret = "Breakout";
        (0x5B): ret = "Taijutsu";
        (0x5C): ret = "Strong Arm";
        (0x5D): ret = "------";
        (0x5E): ret = "Inspiration";
        (0x5F): ret = "Passive";
        (0x60): ret = "------";
        (0x61): ret = "------";
        (0x62): ret = "------";
        (0x63): ret = "------";
        (0x64): ret = "Bond";
        (0x65): ret = "------";
        (0x66): ret = "Guts";
        (0x67): ret = "------";
        (0x68): ret = "Pressure";
        (0x69): ret = "Capture Pro.";
        (0x6A): ret = "------";
        (0x6B): ret = "------";
        (0x6C): ret = "Poison C.Add";
        (0x6D): ret = "Para C.Add";
        (0x6E): ret = "Sleep C.Add";
        (0x6F): ret = "Fire Attack";
        (0x70): ret = "Water Attack";
        (0x71): ret = "Thunder Attack";
        (0x72): ret = "Ice Attack";
        (0x73): ret = "Dragon Attack";
        (0x74): ret = "Fasting";
        (0x75): ret = "----";
        (0x76): ret = "Bomb Sword";
        (0x77): ret = "Strong Attack Sword";
        (0x78): ret = "Poison Sword";
        (0x79): ret = "Para Sword";
        (0x7A): ret = "Sleep Sword";
        (0x7B): ret = "Fire Sword";
        (0x7C): ret = "Water Sword";
        (0x7D): ret = "Thunder Sword";
        (0x7E): ret = "Ice Sword";
        (0x7F): ret = "Dragon Sword";
        (0x80): ret = "Focus";
        (0x81): ret = "SnS Tech";
        (0x82): ret = "DS Tech";
        (0x83): ret = "GS Tech";
        (0x84): ret = "LS Tech";
        (0x85): ret = "Hammer Tech";
        (0x86): ret = "HH Tech";
        (0x87): ret = "Lance Tech";
        (0x88): ret = "GL Tech";
        (0x89): ret = "HBG Tech";
        (0x8A): ret = "LBG Tech";
        (0x8B): ret = "Bow Tech";
        (0x8C): ret = "Speed Setup";
        (0x8D): ret = "Wpn Handling";
        (0x8E): ret = "Element Attack";
        (0x8F): ret = "Stamina Recov";
        (0x90): ret = "Knife Throwing";
        (0x91): ret = "Caring";
        (0x92): ret = "Def Lock";
        (0x93): ret = "Fencing";
        (0x94): ret = "Status Res";
        (0x95): ret = "Sobriety";
        (0x96): ret = "Crystal Res";
        (0x97): ret = "Magnetic Res";
        (0x98): ret = "Light Tread";
        (0x99): ret = "Relief";
        (0x9A): ret = "Shiriagari";
        (0x9B): ret = "Lone Wolf";
        (0x9C): ret = "Three Worlds";
        (0x9D): ret = "Reflect";
        (0x9E): ret = "Compensation";
        (0x9F): ret = "Edgemaster";
        (0xA0): ret = "Rapid Fire";
        (0xA1): ret = "Strong Attack";
        (0xA2): ret = "Encourage";
        (0xA3): ret = "Grace";
        (0xA4): ret = "Vitality";
        (0xA5): ret = "Rage";
        (0xA6): ret = "Iron Arm";
        (0xA7): ret = "Breeder";
        (0xA8): ret = "Mutual Strike";
        (0xA9): ret = "Issen";
        (0xAA): ret = "Survivor";
        (0xAB): ret = "Steady Hand";
        (0xAC): ret = "Mounting";
        (0xAD): ret = "Tenderizer";
        (0xAE): ret = "Combo Expert";
        (0xAF): ret = "Hunter";
        (0xB0): ret = "Critical Shot";
        (0xB1): ret = "Continuous Strike (Deleted)";
        (0xB2): ret = "Evade Distance";
        (0xB3): ret = "Charge Atk Up";
        (0xB4): ret = "Bullet Saver";
        (0xB5): ret = "Movement Speed";
        (0xB6): ret = "Reinforcement";
        (0xB7): ret = "Vampirism";
        (0xB8): ret = "Adaptation";
        (0xB9): ret = "Dark Pulse";
        (0xBA): ret = "Herbal Science";
        (0xBB): ret = "Tonfa Tech";
        (0xBC): ret = "Incitement";
        (0xBD): ret = "Blazing Grace";
        (0xBE): ret = "Drug Knowledge";
        (0xBF): ret = "Absolute Def.";
        (0xC0): ret = "Mindfulness";
        (0xC1): ret = "Gathering Mastery";
        (0xC2): ret = "Stylish";
        (0xC3): ret = "Assistance";
        (0xC4): ret = "Gentle Shot";
        (0xC5): ret = "Dissolver";
        (0xC6): ret = "Combat Supremacy";
        (0xC7): ret = "Vigorous";
        (0xC8): ret = "Sword God";
        (0xC9): ret = "Thunder Clad";
        (0xCA): ret = "Status Assault";
        (0xCB): ret = "Drawing Arts";
        (0xCC): ret = "Blast Res";
        (0xCD): ret = "Crit Conversion";
        (0xCE): ret = "Determination";
        (0xCF): ret = "Stylish Assault";
        (0xD0): ret = "Freeze Res";
        (0xD1): ret = "Ice Age";
        (0xD2): ret = "Lavish Attack";
        (0xD3): ret = "AS F Tech";
        (0xD4): ret = "Fortification";
        (0xD5): ret = "Sniper";
        (0xD6): ret = "Obscurity";
        (0xD7): ret = "Evasion Boost";
        (0xD8): ret = "Rush";
        (0xD9): ret = "Skilled";
        (0xDA): ret = "Ceaseless";
        (0xDB): ret = "Breaking Point";
        (0xDC): ret = "Abnormality";
        (0xDD): ret = "Spacing";
        (0xDE): ret = "Trained";
        (0xDF): ret = "Furious";
        (0xE0): ret = "MS Tech";
    }
    return ret;
};

fn zenithSkills (u16 n){
	str ret = "!!Unknown!!";

	match (n){
    (0x0000): ret = "None";
	(0x0001): ret = "Skill Slot UP +1";
	(0x0002): ret = "Skill Slot UP +2";
	(0x0003): ret = "Skill Slot UP +3";
	(0x0004): ret = "Skill Slot UP +4";
	(0x0005): ret = "Skill Slot UP +5";
	(0x0006): ret = "Skill Slot UP +6";
	(0x0007): ret = "Skill Slot UP +7";
	(0x0008): ret = "Crit Conv UP +1";
	(0x0009): ret = "Crit Conv UP +2";
	(0x000A): ret = "Stylish Assault UP +1";
	(0x000B): ret = "Stylish Assault UP +2";
	(0x000C): ret = "Disolver UP";
	(0x000D): ret = "ThunderClad UP +1";
	(0x000E): ret = "ThunderClad UP +2";
	(0x000F): ret = "Ice Age UP";
	(0x0011): ret = "Earplug UP +1";
	(0x0012): ret = "Earplug UP +2";
	(0x0013): ret = "Earplug UP +3";
	(0x0014): ret = "Wind Res UP +1";
	(0x0015): ret = "Wind Res UP +2";
	(0x0016): ret = "Wind Res UP +3";
	(0x0017): ret = "Wind Res UP +4";
	(0x0018): ret = "Quake Res UP +1";
	(0x0019): ret = "Quake Res UP +2";
	(0x001A): ret = "Poison Res UP +1";
	(0x001B): ret = "Poison Res UP +2";
	(0x001C): ret = "Para Res UP +1";
	(0x001D): ret = "Para Res UP +2";
	(0x001E): ret = "Sleep Res UP +1";
	(0x001F): ret = "Sleep Res UP +2";
	(0x0020): ret = "Vampirism UP +1";
	(0x0021): ret = "Vampirism UP +2";
	(0x0022): ret = "DrugKnowledge UP";
	(0x0023): ret = "Assistance UP";
	(0x0024): ret = "Bullet Shaver UP +1";
	(0x0025): ret = "Bullet Shaver UP +2";
	(0x0026): ret = "Guard UP +1";
	(0x0027): ret = "Guard UP +2";
	(0x0028): ret = "Adaptation UP +1";
	(0x0029): ret = "Adapdation UP +2";
	(0x002A): ret = "Encourage UP +1";
	(0x002B): ret = "Encourage UP +2";
	(0x002C): ret = "Reflect UP +1";
	(0x002D): ret = "Reflect UP +2";
	(0x002E): ret = "Reflect UP +3";
	(0x002F): ret = "Stylish UP";
	(0x0030): ret = "Vigorous UP";
	(0x0031): ret = "Obscurity UP";
	(0x0032): ret = "Soul UP";
	(0x0033): ret = "Ceaseless UP";
	(0x0034): ret = "Rush UP";

	}
	return ret;
};

DecoID decoIDTable[6547] @ header.ptrs.Deco_ID [[name("Deco ID Table")]];

