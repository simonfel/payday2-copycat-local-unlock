-- Copycat Local Unlock
-- SuperBLT hook: lib/managers/dlcmanager
--
-- PAYDAY 2's Copycat perk deck is gated by exactly one DLC-manager predicate:
-- GenericDLCManager:has_mrwi_deck(). The base game implementation checks the
-- old Shredding Christmas event reward claim state.
--
-- To avoid conflicting with broader DLC unlocker mods, this mod does NOT patch
-- platform entitlement checks, GenericDLCManager:is_dlc_unlocked(), skill tree
-- data, side-job state, or DLC verification state. It only answers yes for the
-- Copycat event predicate.

if GenericDLCManager and not GenericDLCManager.__copycat_local_unlock_installed then
  GenericDLCManager.__copycat_local_unlock_installed = true
  GenericDLCManager.__copycat_local_unlock_previous_has_mrwi_deck = GenericDLCManager.has_mrwi_deck

  function GenericDLCManager:has_mrwi_deck(...)
    return true
  end
end
