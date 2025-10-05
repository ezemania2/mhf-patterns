#pragma once

#include <std/sys.pat>
#include <std/core.pat>
#include <std/io.pat>
#pragma endian little

// ----------------------------------------------------
// EM (Monster) IDs → Names (full list)
// ----------------------------------------------------
enum MONSTER_ID : u16 {
    None = 0,
    Rathian = 1,
    Fatalis = 2,
    Kelbi = 3,
    Mosswine = 4,
    Bullfango = 5,
    Yian_Kut_Ku = 6,
    Lao_Shan_Lung = 7,
    Cephadrome = 8,
    Felyne = 9,
    Veggie_Elder = 10,
    Rathalos = 11,
    Aptonoth = 12,
    Genprey = 13,
    Diablos = 14,
    Khezu = 15,
    Velociprey = 16,
    Gravios = 17,
    Felyne_Q = 18,
    Vespoid = 19,
    Gypceros = 20,
    Plesioth = 21,
    Basarios = 22,
    Melynx = 23,
    Hornetaur = 24,
    Apceros = 25,
    Monoblos = 26,
    Velocidrome = 27,
    Gendrome = 28,
    Rocks = 29,
    Ioprey = 30,
    Iodrome = 31,
    Pugis = 32,
    Kirin = 33,
    Cephalos = 34,
    Giaprey_Giadrome = 35,
    Crimson_Fatalis = 36,
    Pink_Rathian = 37,
    Blue_Yian_Kut_Ku = 38,
    Purple_Gypceros = 39,
    Yian_Garuga = 40,
    Silver_Rathalos = 41,
    Gold_Rathian = 42,
    Black_Diablos = 43,
    White_Monoblos = 44,
    Red_Khezu = 45,
    Green_Plesioth = 46,
    Black_Gravios = 47,
    Daimyo_Hermitaur = 48,
    Azure_Rathalos = 49,
    Ashen_Lao_Shan_Lung = 50,
    Blangonga = 51,
    Congalala = 52,
    Rajang = 53,
    Kushala_Daora = 54,
    Shen_Gaoren = 55,
    Great_Thunderbug = 56,
    Shakalaka = 57,
    Yama_Tsukami = 58,
    Chameleos = 59,
    Rusted_Kushala_Daora = 60,
    Blango = 61,
    Conga = 62,
    Remobra = 63,
    Lunastra = 64,
    Teostra = 65,
    Hermitaur = 66,
    Shogun_Ceanataur = 67,
    Bulldrome = 68,
    Anteka = 69,
    Popo = 70,
    White_Fatalis = 71,
    Yama_Tsukami_2 = 72,
    Ceanataur = 73,
    Hypnocatrice = 74,
    Lavasioth = 75,
    Tigrex = 76,
    Akantor = 77,
    Bright_Hypnoc = 78,
    Lavasioth_Subspecies = 79,
    Espinas = 80,
    Orange_Espinas = 81,
    White_Hypnoc = 82,
    Akura_Vashimu = 83,
    Akura_Jebia = 84,
    Berukyurosu = 85,
    Cactus = 86,
    Gorge_Objects = 87,
    Gorge_Rocks = 88,
    Pariapuria = 89,
    White_Espinas = 90,
    Kamu_Orugaron = 91,
    Nono_Orugaron = 92,
    Raviente = 93,
    Dyuragaua = 94,
    Doragyurosu = 95,
    Gurenzeburu = 96,
    Burukku = 97,
    Erupe = 98,
    Rukodiora = 99,
    Unknown_100 = 100,
    Gogomoa = 101,
    Kokomoa = 102,
    Taikun_Zamuza = 103,
    Abiorugu = 104,
    Kuarusepusu = 105,
    Odibatorasu = 106,
    Disufiroa = 107,
    Rebidiora = 108,
    Anorupatisu = 109,
    Hyujikiki = 110,
    Midogaron = 111,
    Giaorugu = 112,
    Mi_Ru = 113,
    Farunokku = 114,
    Pokaradon = 115,
    Shantien = 116,
    Pokara = 117,
    Dummy_118 = 118,
    Goruganosu = 119,
    Aruganosu = 120,
    Baruragaru = 121,
    Zerureusu = 122,
    Gougarf = 123,
    Uruki = 124,
    Forokururu = 125,
    Meraginasu = 126,
    Diorekkusu = 127,
    Garuba_Daora = 128,
    Inagami = 129,
    Varusaburosu = 130,
    Poborubarumu = 131,
    Duremudira = 132,
    UNK_133 = 133,
    Felyne_134 = 134,
    Blue_NPC = 135,
    UNK_136 = 136,
    Cactus_137 = 137,
    Veggie_Elders = 138,
    Gureadomosu = 139,
    Harudomerugu = 140,
    Toridcless = 141,
    Gasurabazura = 142,
    Kusubami = 143,
    Yama_Kurai = 144,
    Dure_3rd_Phase = 145,
    Zinogre = 146,
    Deviljho = 147,
    Brachydios = 148,
    Berserk_Laviente = 149,
    Toa_Tesukatora = 150,
    Barioth = 151,
    Uragaan = 152,
    Stygian_Zinogre = 153,
    Guanzorumu = 154,
    Starving_Deviljho = 155,
    UNK_156 = 156,
    Egyurasu = 157,
    Voljang = 158,
    Nargacuga = 159,
    Keoaruboru = 160,
    Zenaserisu = 161,
    Gore_Magala = 162,
    Blinking_Nargacuga = 163,
    Shagaru_Magala = 164,
    Amatsu = 165,
    Eruzerion = 166,
    Musou_Dure = 167,
    Rocks_168 = 168,
    Seregios = 169,
    Bogabadorumu = 170,
    Unknown_Blue_Barrel = 171,
    Musou_Bogabadorumu = 172,
    Costumed_Uruki = 173,
    Musou_Zerureusu = 174,
    PSO2_Rappy = 175,
    King_Shakalaka = 176
};


// ----------------------------------------------------
// Monster entry (16 bytes) — pure struct; break on bad ID
// ----------------------------------------------------
struct MonsterData {
    MONSTER_ID monster_id;  // 0x00
    u16 monster_flag;       // 0x02
    u16 base_points;        // 0x04
    u16 level1_points;      // 0x06
    u16 level2_points;      // 0x08
    u16 level3_points;      // 0x0A
    u16 level4_points;      // 0x0C
    u16 level5_points;      // 0x0E

    // Early-stop signal to the outer array:
    if (monster_id == 0 || monster_id > 176) { break; }

    
} [[name("Monster Data Entry")]];

// ----------------------------------------------------
// Pointer & dynamic block
// ----------------------------------------------------
const u32 MONSTER_BLOCK_SIZE = 4096;  // enlarged window

u32 monsterDataPointer @ 0xB20
[[name("Monster Data Pointer"),
  comment("Start of Monster Data block")]];

// Read rows while inside window; 'break;' inside struct stops immediately.
MonsterData monster_entries[while($ < monsterDataPointer + MONSTER_BLOCK_SIZE)]
    @ monsterDataPointer
[[name("Monster Data Table")]];

u32 RoadCatShopPointer @ 0xB10
[[name("Road Cat Shop Pointer"),
    comment("Start of Road Cat Shop Block")]];

enum ITEM_ID : u16 {
    None = 0
};

struct CatShop {
    u16 ItemId;  // 0x00
    u32 unk1;       // 0x02
    u16 pad1;
    u16 ItemId2;
    u32 Unk2;
    u16 pad2;  
    
    // Early-stop signal to the outer array:
    if (unk1 != 0xFFFFFFFF) { break; }

} [[name("Cat Shop Entry")]];


// Read rows while inside window; 'break;' inside struct stops immediately.
CatShop shop_entries[while($ < RoadCatShopPointer < MONSTER_BLOCK_SIZE)]
    @ RoadCatShopPointer
[[name("Cat Shop Table")]];


//data counters information
struct DataCounters {
  u16 unk1;
  u16 unk2;
  u16 CatShopItemCounter;
  u16 unk4;
  u16 RoadEntries;
} [[name("Data Counters")]];

DataCounters counters;  // assume this is already filled somewhere
u16 data1 = counters.CatShopItemCounter;


const u32 counter_size = 1;  // enlarged window
u32 CounterPointer @ 0xB04;


DataCounters data[while($ < CounterPointer + counter_size)]
    @CounterPointer
[[name("Data Counters")]];

u32 TowerMedalShop @ 0x948
[[name("Tower Medal Shop Pointer"),
    comment("Start of Tower Medal Shop Block")]];
    
struct TowerMedals {
    u16 Item;
    u16 randomValue;
    u8 Quantity;
    u8 pad;
    u8 pad2;
    u8 pad3;
    u16 Price;
    u16 pad4;
    
    // Early-stop signal to the outer array:
    if (Item == 0) { break; }

} [[name("Medal Shop Entry")]];

TowerMedals tower_medals[while($ < TowerMedalShop < MONSTER_BLOCK_SIZE)]
    @ TowerMedalShop
[[name("Tower Medal Shop Entries")]];


u32 ExtraCounters @ 0x910
[[name("Extra Counters"),
    comment("Start of Extra Counter Table")]];
    
struct ExtraCounters2 {
u16 counter1;
u16 counter2;
u16 counter3;
u16 counter4;
u16 counter5;
u16 counter6;
u16 counter7;
u16 MedalShopEntries;
u16 counter9;
u16 counter10;
u16 counter11;

if (counter11 == 0) {break;}
};

ExtraCounters2 extra_counters[while($ < ExtraCounters < MONSTER_BLOCK_SIZE)]
    @ ExtraCounters
[[name("Tower Medal Shop Entries")]];