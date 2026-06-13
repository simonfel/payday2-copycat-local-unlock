# PAYDAY 2 Copycat Local Unlock

A tiny SuperBLT mod that locally treats PAYDAY 2's Copycat perk deck as available.

## What it does

- Removes Copycat's deck metadata gate: `dlc = "mrwi_deck"`
- Does not patch `GenericDLCManager`
- Does not patch platform entitlement checks like `WinSteamDLCManager:_check_dlc_data()`
- Does not modify DLC verification state
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

Version `1.0.3` avoids the DLC manager entirely so it should not fight broad DLC unlocker mods like `pd2-stuff/DLC-Unlocker-PD2`.

That mod patches platform DLC entitlement checks. This mod instead hooks `lib/tweak_data/skilltreetweakdata` and removes only the `dlc` field from specialization 23, Copycat, after the game's skill tree data is initialized.

If the deck still appears locked, restart the game after installing the mod.
