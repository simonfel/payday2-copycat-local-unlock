# PAYDAY 2 Copycat Local Unlock

A tiny SuperBLT mod that locally treats PAYDAY 2's Copycat perk deck unlock flag as available.

## What it does

- Treats Copycat's unlock id, `mrwi_deck`, as unlocked
- Does not unlock paid DLC broadly
- Does not grant perk points
- Does not modify unrelated DLC checks
- Avoids platform entitlement checks used by broader DLC-related mods
- Overrides only Copycat's dedicated `GenericDLCManager:has_mrwi_deck()` predicate
- Keeps a scoped `is_dlc_unlocked("mrwi_deck")` fallback for UI paths

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

## Notes

This is intentionally scoped to Copycat's unlock id only. If the deck still appears locked, restart the game after installing the mod.

## Compatibility

Version `1.0.2` is designed to avoid conflicts with broad DLC-related mods like `pd2-stuff/DLC-Unlocker-PD2`:

- That mod patches platform entitlement checks such as `WinSteamDLCManager:_check_dlc_data()`.
- Copycat is not gated by that normal entitlement path. It is gated by `GenericDLCManager:has_mrwi_deck()`, which checks event-job reward state.
- This mod therefore overrides only `has_mrwi_deck()` and keeps a scoped `is_dlc_unlocked("mrwi_deck")` fallback.

If another mod also changes DLC behavior, keep that mod installed as usual and install this one alongside it.
