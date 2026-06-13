-- Copycat Local Unlock
-- SuperBLT hooks:
--   lib/tweak_data/skilltreetweakdata
--   lib/managers/sidejobeventmanager
--
-- PAYDAY 2's Copycat perk deck is rewarded by the event side job
-- `cg22_community_4` (Shredding Christmas). That side job's personal path is
-- `cg22_sacrifice_objective`, requiring 30 presents shredded.
--
-- To avoid conflicting with broader DLC unlocker mods, this mod does NOT patch
-- GenericDLCManager, platform entitlement checks, or DLC verification state.
-- It marks only the local Shredding Christmas side job state as completed and
-- claimed, and also removes Copycat's deck metadata gate as a UI fallback.

CopycatLocalUnlock = CopycatLocalUnlock or {}

local COPYCAT_SPECIALIZATION_INDEX = 23
local COPYCAT_NAME_ID = "menu_st_spec_23"

local COPYCAT_CHALLENGE_ID = "cg22_community_4"
local SHREDDING_PROGRESS_ID = "cg22_sacrifice_objective"
local CG22_STAGE_ID = "cg22_stages"

local function unlock_copycat_skilltree(skilltree)
  local copycat = skilltree and skilltree.specializations and skilltree.specializations[COPYCAT_SPECIALIZATION_INDEX]

  if copycat and copycat.name_id == COPYCAT_NAME_ID then
    copycat.dlc = nil
  end
end

local function complete_objective(objective)
  if not objective then
    return
  end

  objective.progress = objective.max_progress or objective.progress or 1
  objective.completed = true
end

local function complete_copycat_side_job(event_jobs)
  if not event_jobs or not event_jobs.get_challenge then
    return
  end

  local challenge = event_jobs:get_challenge(COPYCAT_CHALLENGE_ID)

  if not challenge then
    return
  end

  for _, objective in ipairs(challenge.objectives or {}) do
    if objective.choice_id == COPYCAT_CHALLENGE_ID then
      complete_objective(objective)

      for choice_index, choice_objective in ipairs(objective.challenge_choices or {}) do
        if choice_objective.progress_id == SHREDDING_PROGRESS_ID then
          complete_objective(choice_objective)
        end

        if objective.challenge_choices_saved_values and objective.challenge_choices_saved_values[choice_index] then
          objective.challenge_choices_saved_values[choice_index].progress = choice_objective.progress
          objective.challenge_choices_saved_values[choice_index].completed = choice_objective.completed
        end
      end
    elseif objective.stage_id == CG22_STAGE_ID then
      complete_objective(objective)
    end
  end

  challenge.completed = true

  local all_rewarded = true

  for _, reward in ipairs(challenge.rewards or {}) do
    reward.rewarded = true

    if not reward.rewarded then
      all_rewarded = false
    end
  end

  challenge.rewarded = all_rewarded
end

local function install_post_hook(target, method, id, fn)
  if Hooks and Hooks.PostHook and target and target[method] then
    Hooks:PostHook(target, method, id, fn)
    return true
  end

  return false
end

if SkillTreeTweakData and not CopycatLocalUnlock.skilltree_hook_installed then
  CopycatLocalUnlock.skilltree_hook_installed = true

  if not install_post_hook(SkillTreeTweakData, "init", "copycat_local_unlock_skilltree_init", function(self, ...)
    unlock_copycat_skilltree(self)
  end) and not SkillTreeTweakData.__copycat_local_unlock_installed then
    -- Fallback for older BLT environments without Hooks:PostHook.
    SkillTreeTweakData.__copycat_local_unlock_installed = true

    local previous_init = SkillTreeTweakData.init

    function SkillTreeTweakData:init(...)
      previous_init(self, ...)
      unlock_copycat_skilltree(self)
    end
  end
end

if SideJobEventManager then
  if not CopycatLocalUnlock.event_setup_hook_installed then
    CopycatLocalUnlock.event_setup_hook_installed = true

    if not install_post_hook(SideJobEventManager, "_setup", "copycat_local_unlock_event_setup", function(self, ...)
      complete_copycat_side_job(self)
    end) and not SideJobEventManager.__copycat_local_unlock_setup_installed then
      SideJobEventManager.__copycat_local_unlock_setup_installed = true

      local previous_setup = SideJobEventManager._setup

      function SideJobEventManager:_setup(...)
        previous_setup(self, ...)
        complete_copycat_side_job(self)
      end
    end
  end

  if not CopycatLocalUnlock.event_load_hook_installed then
    CopycatLocalUnlock.event_load_hook_installed = true

    if not install_post_hook(SideJobEventManager, "load", "copycat_local_unlock_event_load", function(self, ...)
      complete_copycat_side_job(self)
    end) and not SideJobEventManager.__copycat_local_unlock_load_installed then
      SideJobEventManager.__copycat_local_unlock_load_installed = true

      local previous_load = SideJobEventManager.load

      function SideJobEventManager:load(...)
        previous_load(self, ...)
        complete_copycat_side_job(self)
      end
    end
  end
end

if managers and managers.event_jobs then
  complete_copycat_side_job(managers.event_jobs)
end
