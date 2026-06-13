-- Copycat Local Unlock
-- SuperBLT hook: lib/managers/dlcmanager
--
-- PAYDAY 2 gates the Copycat perk deck behind the DLC/unlock id `mrwi_deck`.
-- This mod only reports that specific id as unlocked. It does not unlock paid DLC,
-- does not grant perk points, and does not touch unrelated DLC checks.

local COPYCAT_UNLOCK_ID = "mrwi_deck"

local _is_dlc_unlocked = GenericDLCManager.is_dlc_unlocked

function GenericDLCManager:is_dlc_unlocked(dlc)
  if dlc == COPYCAT_UNLOCK_ID then
    return true
  end

  return _is_dlc_unlocked(self, dlc)
end

-- Some menu paths use `has_dlc` directly. Keep the override scoped to Copycat only.
local _has_dlc = GenericDLCManager.has_dlc

function GenericDLCManager:has_dlc(dlc)
  if dlc == COPYCAT_UNLOCK_ID then
    return true
  end

  return _has_dlc(self, dlc)
end
