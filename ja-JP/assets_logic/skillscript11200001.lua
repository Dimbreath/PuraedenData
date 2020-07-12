-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11200001_xp", totalHitCount = 12}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_30, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  SetAtkCardActive(2949.7, false)
  SetAtkCardActive(7499.25, true)
  SetDefCardsActive(0, false)
  SetDefCardsActive(3932.94, true)
  ChangeDefState(4832.85, "hit_1")
  ChangeDefState(5099.49, "hit_2")
  ChangeDefState(5299.47, "hit_1")
  ChangeDefState(5566.11, "hit_2")
  ChangeDefState(5832.75, "hit_1")
  ChangeDefState(6066.06, "hit_2")
  ChangeDefState(6332.7, "hit_1")
  ChangeDefState(6599.34, "hit_2")
  ChangeDefState(6732.66, "hit_1")
  ChangeDefState(6932.64, "hit_2")
  ChangeDefState(7132.62, "hit_1")
  ChangeDefState(7299.27, "hit_2", true)
  MoveAtkCard(7499.25, nil, 0)
  ChangeAtkState(7499.25, "idle", true)
  MoveDefCard(7499.25, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

