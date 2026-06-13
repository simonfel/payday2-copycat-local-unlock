# PAYDAY 2 Copycat Local Unlock

A tiny SuperBLT mod that locally treats PAYDAY 2's Copycat perk deck unlock flag as available.

## What it does

- Treats Copycat's unlock id, `mrwi_deck`, as unlocked
- Does not unlock paid DLC broadly
- Does not grant perk points
- Does not modify unrelated DLC checks

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
