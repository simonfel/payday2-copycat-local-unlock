-- Copycat Local Unlock
-- SuperBLT hook: lib/managers/dlcmanager
--
-- PAYDAY 2's Copycat perk deck is specialization 23 and is gated by the
-- `mrwi_deck` unlock id. Unlike normal DLC, `mrwi_deck` is checked through
-- GenericDLCManager:has_mrwi_deck(), which reads event-job reward state.
--
-- Compatibility note:
-- Broad DLC unlocker mods usually patch platform entitlement checks such as
-- WinSteamDLCManager:_check_dlc_data(). Copycat does not depend on those checks,
-- so this mod avoids touching them and only overrides the Copycat-specific
-- predicate. It also keeps an is_dlc_unlocked fallback for UI paths that ask for
-- `mrwi_deck` by id.

local COPYCAT_UNLOCK_ID = "mrwi_deck"

if GenericDLCManager and not GenericDLCManager.__copycat_local_unlock_installed then
  GenericDLCManager.__copycat_local_unlock_installed = true

  local previous_has_mrwi_deck = GenericDLCManager.has_mrwi_deck
  local previous_is_dlc_unlocked = GenericDLCManager.is_dlc_unlocked

  function GenericDLCManager:has_mrwi_deck(...)
    return true
  end

  function GenericDLCManager:is_dlc_unlocked(dlc, ...)
    if dlc == COPYCAT_UNLOCK_ID then
      return true
    end

    if previous_is_dlc_unlocked then
      return previous_is_dlc_unlocked(self, dlc, ...)
    end

    return false
  end

  -- Keep a reference around for debugging/compatibility with mod stacks that
  -- inspect prior implementations.
  GenericDLCManager.__copycat_local_unlock_previous_has_mrwi_deck = previous_has_mrwi_deck
end
