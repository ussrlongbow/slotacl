# Arma 3: Slot access control lists (slotacl for short)

## What's this all about?
This script is designed to give a mission maker or server administrator an approach to limit access to certain slots for specific players.

## How does it work?
Every slot in game can be assigned a whitelist or blacklist (you can even assign both, but if whitelist defined, blacklist is ignored.

Whitelist allows only specific player to occupy the slot, this is useful when you want to keep a separate slot in game for admin/zeus.

Blacklist works in opposite direction: it denies some players to take specific slots, it might be useful on public servers, when you are tired of naughty pilots, who did not complete proper VR heli training, and instantly crashing helicopters with teammates onboard.

## Installation
Script is packaged to be used with [Arma 3 Mission Skeleton](https://github.com/ussrlongbow/a3ms) (A3MS for short) to simplify installation.

If you have used A3MS - just extract the script archive to `addons` directory inside your mission, and then run `build.bat` script.

## Enabling slotacl
slotacl can be toggled from mission parameters, by default it is disabled, to enable it you have 3 options:
* Enable this feature manually on mission start from lobby (requires admin access to server)
* Override default param from server configuration file, [see BiKi](https://community.bistudio.com/wiki/server.cfg#Arma_2:_Operation_Arrowhead_-_multiple_mission_parameters_configuration)
* Change default value from `0` to `1` in file `addons\longbow\slotacl\cfgparams.hpp` at class `RWT_SLOTACL_ENABLED`

## Usage
To use slotacl against playable slots, requires those slots to have a name. After slot is named you can configure white/black list for it.

The directory `addons\longbow\slotacl\settings` contains `whitelist.hpp` and `blacklist.hpp`.

The commented out line contains an example how to add more entries.

For example, we have a game slot named **soldier1**, and we want to allow only players with UIDs "123" and "456" to occupy it, so we add to our `whitelist.hpp` a line:

`RWT_SLOTACL_ALLOW(soldier1) = ["123","456"];`

And if we want to restrict player with UID "789" to occupy slot named **pilot1**, we need to add the following line to `blacklist.hpp`:

``RWT_SLOTACL_DENY(pilot1) = ["789"];`
