#include "fn_macro.hpp"
SLOTACL_LOG("Initializing Slot ACL")
player createDiaryRecord ["skeladdons",[(localize "STR_RWT_SLOTACL_NAME"),(localize "STR_RWT_SLOTACL_DESC")]];

call RWT_fnc_slotaclList;

SLOTACL_LOG("Initialized Slot ACL")
