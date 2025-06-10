// Include standard system and I/O patterns
#include <std/sys.pat>
#include <std/io.pat>
#include <misc/s32p.pat>

// DEFAULT DISPLAY: Include common data headers and constants
#include <mhfdat/header.hexpat>
#include <mhfdat/constants.hexpat>

// CONDITIONAL DISPLAY: Include specific modules based on defined flags
#ifdef __ITEMS
#include <mhfdat/items.hexpat>
#endif

#ifdef __SHOP
#include <mhfdat/shop.hexpat>
#endif

#ifdef __WEAPONS
#include <mhfdat/weapons.hexpat>
#endif

#ifdef __EQUIPMENTS
#include <mhfdat/equipments.hexpat>
#endif

#ifdef __CRAFTING
#include <mhfdat/crafting.hexpat>
#endif

#ifdef __PART_BREAKS
#include <mhfdat/partbreaks.hexpat>
#endif

#ifdef __QUESTS
#include <mhfdat/quests.hexpat>
#endif

#ifdef __ARENA
#include <mhfdat/arena.hexpat>
#endif

#ifdef __SEASONAL_EVENTS
#include <mhfdat/seasonalevents.hexpat>
#endif

#ifdef __SHARPNESS
#include <mhfdat/sharpness.hexpat>
#endif

#ifdef __DECOMPILE
#include <mhfdat/decompile/decompile.hexpat>
#endif

#ifdef __DECOID
#include <mhfdat/decoID.hexpat>
#endif

#ifdef __CONSTANTS
#include <mhfdat/constants.hexpat>
#endif