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

local COPYCAT_SPECIALIZATION_INDEX = 23
local COPYCAT_NAME_ID = "menu_st_spec_23"

if SkillTreeTweakData and not SkillTreeTweakData.__copycat_local_unlock_installed then
  SkillTreeTweakData.__copycat_local_unlock_installed = true

  local previous_init = SkillTreeTweakData.init

  function SkillTreeTweakData:init(...)
    previous_init(self, ...)

    local copycat = self.specializations and self.specializations[COPYCAT_SPECIALIZATION_INDEX]

    if copycat and copycat.name_id == COPYCAT_NAME_ID then
      copycat.dlc = nil
    end
  end
end
