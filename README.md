# PAYDAY 2 Copycat Local Unlock

A tiny SuperBLT mod that locally treats PAYDAY 2's Copycat perk deck as available.

## What it does

- Makes only `GenericDLCManager:has_mrwi_deck()` return `true`
- Does not patch `GenericDLCManager:is_dlc_unlocked()`
- Does not patch platform entitlement checks like `WinSteamDLCManager:_check_dlc_data()`
- Does not patch skill tree data
- Does not patch side-job save/progress state
- Does not modify broad DLC verification state
- Does not unlock paid DLC broadly
- Does not grant perk points

Intended for private/local play with friends.

## Install

1. Install [SuperBLT](https://superblt.znix.xyz/) if you do not already have it.
2. Copy this folder into your PAYDAY 2 `mods/` directory.
3. Launch PAYDAY 2.

Your folder should look like:

```text
PAYDAY 2/
  mods/
    payday2-copycat-local-unlock/
      mod.txt
      copycat_local_unlock.lua
```

## Compatibility

Version `1.2.0` is intentionally minimal. It hooks only `lib/managers/dlcmanager` and overrides only the Copycat-specific event predicate, `has_mrwi_deck()`.

Broad DLC unlocker mods like `pd2-stuff/DLC-Unlocker-PD2` patch platform DLC entitlement checks such as `WinSteamDLCManager:_check_dlc_data()`. This mod does not touch those paths.

If this still conflicts, disable every previous copy/version of this mod and send the SuperBLT log line/error; the remaining likely causes are duplicate installs or load-order behavior from another mod replacing `has_mrwi_deck()` after this one.
