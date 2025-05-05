#pragma once

struct SharpnessPointers {
  u32 great_sword;
  u32 heavy_bowgun;
  u32 hammer;
  u32 lance;
  u32 sword_and_shield;
  u32 light_bowgun;
  u32 dual_blades;
  u32 long_sword;
  u32 hunting_horn;
  u32 gunlance;
  u32 bow;
  u32 tonfa;
  u32 switch_axe;
  u32 magnet_spike;
};

struct SharpnessItem {
  u16 Red     [[color("FF0000")]];
  u16 Orange  [[color("FFA500")]];
  u16 Yellow  [[color("FFFF00")]];
  u16 Green   [[color("00FF00")]];
  u16 Blue    [[color("0000FF")]];
  u16 White   [[color("FFFFFF")]];
  u16 Purple  [[color("800080")]];
  u16 SkyBlue [[color("87CEEB")]];
};

struct Sharpness {
  SharpnessItem GreatSword     [128] @ 0x01902D00 [[name("Great Sword")]];
  SharpnessItem HeavyBowgun    [128] @ 0x01902D00 [[name("Heavy Bowgun")]];
  SharpnessItem Hammer         [128] @ 0x01902500 [[name("Hammer")]];
  SharpnessItem Lance          [128] @ 0x01901D00 [[name("Lance")]];
  SharpnessItem SwordAndShield [128] @ 0x01901500 [[name("Sword And Shield")]];
  SharpnessItem LightBowgun    [128] @ 0x01902D00 [[name("Light Bowgun")]];
  SharpnessItem DualBlades     [128] @ 0x01900D00 [[name("Dual Blades")]];
  SharpnessItem LongSword      [128] @ 0x01902D00 [[name("Long Sword")]];
  SharpnessItem HuntingHorn    [128] @ 0x01902500 [[name("Hunting Horn")]];
  SharpnessItem Gunlance       [128] @ 0x01901D00 [[name("Gunlance")]];
  SharpnessItem Bow            [128] @ 0x01902D00 [[name("Bow")]];
  SharpnessItem Tonfa          [128] @ 0x01900500 [[name("Tonfa")]];
  SharpnessItem SwitchAxe      [128] @ 0x018FFD00 [[name("Switch Axe")]];
  SharpnessItem MagnetSpike    [128] @ 0x018FF500 [[name("Magnet Spike")]];
};

struct Sharpnesses {
	SharpnessPointers sharpnessPointers @ 0x018FF4C0 [[name("Pointers")]];
	Sharpness         data              @ 0x018FF4C0 [[name("Data")]];
};

Sharpnesses sharpnesses @ 0x01900000 [[name("Sharpnesses")]];