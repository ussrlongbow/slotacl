#include "fn_macro.hpp"
/*****************************************************************************
Function name: RWT_fnc_slotaclProcess;
Authors: longbow
Version: 1.0
Dependencies:
    NONE
Changelog:
    === 1.0 === 29-Sep-2016
        Initial release
Description:
    Function checks if player is allowed to occupy his slot. If not he is
    forced back to lobby. Should be called from initPlayerServer.sqf

Arguments:
    ARRAY [_player,_didjip]
        _player - player object
        _didjip - true if player joined in progress

Returns:
    NOTHING

*****************************************************************************/

SLOTACL_LOG("Entry")

// Slot ACL requires Multiplayer mode to function
if (!isMultiplayer) exitWith
{
    SLOTACL_LOG("Exit. Available only in multiplayer")
    ["Slot ACL requires Multiplayer"] call BIS_fnc_error;
};

// Exit if Slot ACL is disabled in mission parameters
if (("RWT_SLOTACL_ENABLED" call BIS_fnc_getParamValue) == 0) exitWith {SLOTACL_LOG("Exit. Slot ACL not enabled in mission paramters.")};

// read unit's name
private _unit = _this select 0;
private _unitname = vehicleVarName _unit;

// Exit if slot's variable name is not set
if (_unitname isEqualTo "") exitWith {SLOTACL_LOG("Exit. VarName not set for this slot.")};

private _listAllow = format ["rwt_slotacl_allow_%1",_unitname];
private _listDeny = format ["rwt_slotacl_deny_%1",_unitname];

// Is white list for slot defined?
private _isWhite = isNil _listAllow;

// if white list is defined check that it is an array
if (!_isWhite) then
{
    if ("ARRAY" != typeName (missionNamespace getVariable _listAllow)) then
    {
        SLOTACL_LOG("White list is not a valid array")
        _isWhite = true;
        missionNamespace setVariable [_listAllow,nil];
    }
    else
    {
        SLOTACL_LOG("Processing white list")
        if (!(getPlayerUID _unit in (missionNamespace getVariable _listAllow))) then
        {
            SLOTACL_LOG("Player is not whitelisted")
            "rwt_slotacl_notwhitelisted" remoteExecCall ["failMission",_unit];
        };
        // As we processed white list, ignore the blacklist
        _isWhite = true;
        missionNamespace setVariable [_listDeny,nil];
    };
};
// Working with blacklist
private _isBlack = isNil _listDeny;
if (!_isBlack) then
{
    if ("ARRAY" != typeName (missionNamespace getVariable _listDeny)) then
    {
        SLOTACL_LOG("Black list is not a valid array")
        _isBlack = true;
        missionNamespace setVariable [_listDeny,nil];
    }
    else
    {
        SLOTACL_LOG("Processing black list")
        if (getPlayerUID _unit in (missionNamespace getVariable _listDeny)) then
        {
            SLOTACL_LOG("Player is blacklisted")
            "rwt_slotacl_blacklisted" remoteExecCall ["failMission",_unit];
        };
    };
};

// Exit if no white/black lists defined for this slot
if (_isBlack && _isWhite) exitWith {SLOTACL_LOG("Exit. No lists defined for slot.")};
