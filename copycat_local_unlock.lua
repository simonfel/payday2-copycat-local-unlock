-- Copycat Local Unlock
-- SuperBLT hook: lib/tweak_data/skilltreetweakdata
--
-- PAYDAY 2's Copycat perk deck is specialization 23. The deck metadata has
-- `dlc = "mrwi_deck"`, which makes the UI treat it as locked unless the old
-- event reward has been claimed.
--
-- To avoid conflicting with broader DLC unlocker mods, this mod does NOT patch
-- GenericDLCManager, platform entitlement checks, or DLC verification state.
-- It only removes the Copycat deck's own metadata gate after SkillTreeTweakData
-- builds the specialization table.
--
-- Use SuperBLT's hook API when available instead of replacing
-- SkillTreeTweakData:init directly. Direct method wrapping is more likely to
-- fight other mods that also touch skill tree initialization.

local COPYCAT_SPECIALIZATION_INDEX = 23
local COPYCAT_NAME_ID = "menu_st_spec_23"
local POST_HOOK_ID = "copycat_local_unlock_skilltree_init"

local function unlock_copycat(skilltree)
  local copycat = skilltree and skilltree.specializations and skilltree.specializations[COPYCAT_SPECIALIZATION_INDEX]

  if copycat and copycat.name_id == COPYCAT_NAME_ID then
    copycat.dlc = nil
  end
end

if Hooks and Hooks.PostHook and SkillTreeTweakData then
  Hooks:PostHook(SkillTreeTweakData, "init", POST_HOOK_ID, function(self, ...)
    unlock_copycat(self)
  end)
elseif SkillTreeTweakData and not SkillTreeTweakData.__copycat_local_unlock_installed then
  -- Fallback for older BLT environments without Hooks:PostHook.
  SkillTreeTweakData.__copycat_local_unlock_installed = true

  local previous_init = SkillTreeTweakData.init

  function SkillTreeTweakData:init(...)
    previous_init(self, ...)
    unlock_copycat(self)
  end
end
