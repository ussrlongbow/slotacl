#define RWT_SLOTACL_ALLOW(VARNAME) rwt_slotacl_allow_##VARNAME
#define RWT_SLOTACL_DENY(VARNAME)  rwt_slotacl_deny_##VARNAME

// Runs only on server
if (!isServer) exitWith {};

// This function contains white and black lists for slots.
// Two whitelist or blacklist people to occupy certain slots
// your playable slot should be given a name in editor:
// 1. Open your mission in editor
// 2. Right-click on a playable unit
// 3. Click on "Attributes" in drop-down list
// 4. Expand section "Object: Init"
// 5. Enter the name in "Variable Name" field
// 
// Using this file you can whitelist or blacklist people from slot
// If you use a blacklist - all UIDs which are listed in it are restricted
// to occupy this slot. Example:
// RWT_SLOTACL_DENY(man1) = ["123","456"];
// Users with UIDs 123 and 456 will be restricted to occupy a slot named man1
// White list works in an opposite direction it allows only specified UIDs to
// occupy the slot. If you create a whitelist for slot, black list for that 
// slot is ignored.
// Keep in mind that if empty white list is specified for slot - noone would
// be able to take it.
// White lists and black lists are ignored for Virtual Units (Headless clients)

// More examples
// Allow only player with UID 123 to occupy slot named 'admin'
// RWT_SLOTACL_ALLOW(admin) = ["123"];
//
// Deny players with UIDs 456 and 789 to occupy slots 'pilot1' and 'pilot2'
// RWT_SLOTACL_DENY(pilot1) = ["456","789"];
// RWT_SLOTACL_DENY(pilot2) = ["456","789"];

