-- Copycat Local Unlock
-- SuperBLT hook: lib/managers/dlcmanager
--
-- PAYDAY 2 gates the Copycat perk deck behind the DLC/unlock id `mrwi_deck`.
-- This mod only reports that specific id as unlocked. It does not unlock paid DLC,
-- does not grant perk points, and does not touch unrelated DLC checks.
--
-- Compatibility note:
-- Other DLC-related mods may also wrap GenericDLCManager methods. This file is
-- intentionally tiny and chain-safe: it preserves whatever implementation was
-- installed before it, changes only `mrwi_deck`, and avoids overriding `has_dlc`
-- so broad DLC mods can keep owning their behavior.

local COPYCAT_UNLOCK_ID = "mrwi_deck"

if GenericDLCManager and not GenericDLCManager.__copycat_local_unlock_installed then
  GenericDLCManager.__copycat_local_unlock_installed = true

  local previous_is_dlc_unlocked = GenericDLCManager.is_dlc_unlocked

  function GenericDLCManager:is_dlc_unlocked(dlc, ...)
    if dlc == COPYCAT_UNLOCK_ID then
      return true
    end

    if previous_is_dlc_unlocked then
      return previous_is_dlc_unlocked(self, dlc, ...)
    end

    return false
  end
end
