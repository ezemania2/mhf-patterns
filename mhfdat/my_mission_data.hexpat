#pragma once

#include <misc/types.pat>

struct MyMissionObjective{
    u8 unk00;
    u8 mission_nb;
    u16 target;
    u16 unk04;
    u16 unk06;
    u16 unk08;
    u16 unk0A;
    u16 HR_GR;
    u8 amount;
    u8 is_HC;
    u16 unk10;
    u8 Tickets;
    u8 is_GR;
};

/// My Mission Data Structure
struct MyMissionData {
    u16 is_GR [[comment("G-Rank flag"), name("is GR")]];
    u16 sr_requirement [[comment("SR requirement"), name("SR Requirement")]];
    u8 mission_nb [[comment("Mission number"), name("Mission Number")]];
    u8 buff_id [[comment("Buff ID"), name("Buff ID")]];
};

MyMissionObjective myMissionObjective[250] @ header.ptrs.my_mission_objective [[name("My Mission Objective")]];
MyMissionData myMissionData[251] @ header.ptrs.my_mission_data [[name("My Mission Data")]];
