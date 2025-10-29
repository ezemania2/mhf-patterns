#pragma once
#include <mhfdat/utils/index.pat>

// Shop seems to be pointed to by a list of pointers,
// pointed to by hd_dll_af4c11.sub[2]

u32 shopInventory; 
shopInventory = std::mem::find_sequence(0, 0x0F, 01, 01, 00, 00, 00, 00, 00, 03, 01, 01, 00, 00, 00, 00, 00);
//shopInventory = 0x00C78C40;

u128 shopHeader @ shopInventory;

//u32 shopPointer @ 0x00C78C28;

struct ItemOut {
	u16 id [[format("getItemName")]];
	padding[6];
};

struct SpecialShopHeader {
	ptr ptRoadShop;
	ptr ptFestiShop;
	ptr ptNCafe;
	ptr ptSpecialItemShop;
	ptr ptSpecialItemShopSR1;
	ptr ptGCPExchange;
	ptr ptDojoGeneral;
	ptr ptDojoHR5;
	ptr ptDojoDoneComps;
	ptr unk[3] 
	[[comment("Same contents as previous dojo shops, unknown purpose")]];
};

struct ComboShop{
	u16 Itemid [[format("getItemName")]];
	u16 Combo_fee;
	u16 Recipe_No;
	u8 Recipe1_min1 [[
		name("Recipe 1 Min")
		]];
	u8 Recipe1_max2 [[
		name("Recipe 1 Max")
	]];
	u16 Recipe1_Itemid1 [[
		format("getItemName"),
		name("Recipe 1 Item ID 1")
	]];
	u16 Recipe1_Itemid_Qty1 [[name("Recipe 1 Item Id Qty 1")]];

	u16 Recipe1_Itemid2 [[
		format("getItemName"),
		name("Recipe 1 Item ID 2")
	]];
	u16 Recipe1_Itemid_Qty2 [[name("Recipe 1 Item Id Qty 2")]];

	u16 Recipe1_Itemid3 [[
		format("getItemName"),
		name("Recipe 1 Item ID 3")
	]];
	u16 Recipe1_Itemid_Qty3 [[name("Recipe 1 Item Id Qty 3")]];

	u8 Recipe2_min [[
		name("Recipe 1 Min")
		]];
	u8 Recipe2_max [[
		name("Recipe 1 Max")
	]];
	
	u16 Recipe2_Itemid1 [[
		format("getItemName"),
		name("Recipe 2 Item ID 1")
	]];
	u16 Recipe2_Itemid_Qty1 [[name("Recipe 2 Item Id Qty 1")]];

	u16 Recipe2_Itemid2 [[
		format("getItemName"),
		name("Recipe 2 Item ID 2")
	]];
	u16 Recipe2_Itemid_Qty2 [[name("Recipe 2 Item Id Qty 2")]];

	u16 Recipe2_Itemid3 [[
		format("getItemName"),
		name("Recipe 2 Item ID 3")
	]];
	u16 Recipe2_Itemid_Qty3 [[name("Recipe 2 Item Id Qty 3")]];

	u8 Recipe3_min [[
		name("Recipe 3 Min")
		]];
	u8 Recipe3_max [[
		name("Recipe 3 Min")
		]];

	u16 Recipe3_Itemid1 [[
		format("getItemName"),
		name("Recipe 2 Item ID 1")
	]];
	u16 Recipe3_Itemid_Qty1 [[name("Recipe 2 Item Id Qty 1")]];

	u16 Recipe3_Itemid2 [[
		format("getItemName"),
		name("Recipe 2 Item ID 2")
	]];
	u16 Recipe3_Itemid_Qty2 [[name("Recipe 2 Item Id Qty 2")]];

	u16 Recipe3_Itemid3 [[
		format("getItemName"),
		name("Recipe 2 Item ID 3")
	]];
	u16 Recipe3_Itemid_Qty3 [[name("Recipe 2 Item Id Qty 3")]];

};

// Function to count ComboShop entries with validation
fn get_combo_shop_count(ptr start_addr) {
    u32 count = 0;
    ptr current_addr = start_addr;
    
    // Each ComboShop entry is 48 bytes (0x30)
    while (count < 5000) {
        // Check file boundaries
        if (current_addr + sizeof(ComboShop) > std::mem::size()) break;
        
        // Read the main Item ID (first u16)
        u16 itemId = std::mem::read_unsigned(current_addr, 2);
        
        // Stop conditions
        // If Item ID is 0, we've reached the end
        if (itemId == 0) break;
        
        // If Item ID exceeds 16700, stop counting
        if (itemId > 16700) break;
        
        // Read other item IDs to validate
        u16 recipe1_item1 = std::mem::read_unsigned(current_addr + 8, 2);
        u16 recipe1_item2 = std::mem::read_unsigned(current_addr + 12, 2);
        u16 recipe1_item3 = std::mem::read_unsigned(current_addr + 16, 2);
        
        // Stop if any recipe item ID is invalid
        if (recipe1_item1 > 16700) break;
        if (recipe1_item2 > 16700) break;
        if (recipe1_item3 > 16700) break;
        
        count = count + 1;
        current_addr = current_addr + sizeof(ComboShop);
    }
    
    // Ensure we return at least 1 to avoid empty arrays
    if (count == 0) count = 1;
    
    return count;
};

struct TowerMedalShop {
	u16 Itemid [[format("getItemName")]];
	u8 shoptype;
	padding[1];
	u16 qty [[name("Quantity")]];
	padding[2];
	u32 price [[name("Price")]];
};

SpecialShopHeader sShopHeader @ header.ptrs.specialShops;

struct CategorizedPrice {
	u16 id [[format("getItemName")]];
	padding[2];
	u16 price;
	padding[2];

	// 01 00 01 = NCafe(Gatherables)
	// 03 02 01 = NCafe(HR5+)(Mats (HR5~7))
	// 06 06 01 = NCafe(GR1+)(GItems (GR1+))
	// 04 02 01 = NCafe(HR5+)(Decorations)
	// 04 01 01 = NCafe(HR3+)(Decorations)
	// 02 00 01 = NCafe(HR3+)(Mats (HR 1~4))
	// 02 01 01 = NCafe(Mats (HR 1~4))
	// 03 03 01 = NCafe(SR Equip)(Mats (HR 5~7))
	// 05 03 01 = NCafe(SR Equip)(Other Items)
	// 05 01 01 = NCafe(HR3+)(Other Items)
	// 05 02 01 = NCafe(HR5+)(Other Items)
	u32 shopType;
	
	padding[1];
};

struct road_cat_item_entry {
    u16 item_id                 [[
		name("Item ID"),
		format("getItemName")]];
    u16 point_cost              [[
		name("Cost Road Points"),
		comment("Cost in Road points")]];
    u8 availability_flag        [[
		name("Availability Flag"),
		comment("Availability condition - 0=Always, 1=Conditional")]];
    u8 stock_limit              [[
		name("Stock Limit"),
		comment("Max purchase qty - 0xFF=unlimited")]]; // 0xFF = unlimited
    u16 requirements            [[
		name("Requirements"),
		comment("Additional requirements bitmask")]];
};

road_cat_item_entry roadCatItemShop[while(std::mem::read_unsigned($,2))] @ header.ptrs.Road_Cat_Item_Shop_Pointer;

CategorizedPrice festiShop[while(std::mem::read_unsigned($,4))] @ sShopHeader.ptFestiShop;
CategorizedPrice nCafeShop[while(std::mem::read_unsigned($,4))] @ sShopHeader.ptNCafe;
CategorizedPrice gcpShop[while(std::mem::read_unsigned($,4))] @ sShopHeader.ptGCPExchange;
TowerMedalShop towerShopMedal[while(std::mem::read_unsigned($,2))] @ header.ptrs.towerMedalShop;
ComboShop hidenCuffCombineShop[get_combo_shop_count(header.ptrs.CombineShop)] @ header.ptrs.CombineShop [[name("Combine Shop")]];
