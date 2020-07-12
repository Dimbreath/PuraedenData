-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_12030002_xp", totalHitCount = 12}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCardFront(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  ChangeDefState(799.92, "hit_1")
  ChangeDefState(966.57, "hit_2")
  ChangeDefState(1133.22, "hit_1")
  ChangeDefState(1266.54, "hit_2")
  ChangeDefState(1433.19, "hit_1")
  ChangeDefState(1599.84, "hit_2")
  ChangeDefState(1733.16, "hit_1")
  ChangeDefState(1899.81, "hit_2")
  ChangeDefState(2099.79, "hit_1")
  ChangeDefState(2266.44, "hit_2")
  ChangeDefState(2433.09, "hit_1")
  ChangeDefState(2666.4, "hit_2", true)
  MoveAtkCard(2700, nil, 0.2)
  ChangeAtkState(2700, "idle", true)
  MoveDefCard(2700, nil, 0)
  ClearSkillMask(time - 0.5, nil, 0.5, timelineEndCall)
end

return SkillScript

