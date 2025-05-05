#pragma once

/**
	@param n The item ID
	@return The item ID, formatted as expected by Ferias /sozai/sozai.htm?{ID}
	Optionally also returns the item name, comment out the first return
	to disable.
*/
fn getItemName(u16 n) {
	return std::format("{:04X} | {}", n, rIPPS(header.ptrs.itemNames, n));
return std::format("{:04X}", n);
};