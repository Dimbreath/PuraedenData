-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_12030007_xp", totalHitCount = 10}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_20, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  ChangeDefState(1066.56, "hit_1")
  ChangeDefState(1233.21, "hit_2")
  ChangeDefState(1399.86, "hit_1")
  ChangeDefState(1566.51, "hit_2")
  ChangeDefState(1733.16, "hit_1")
  ChangeDefState(1899.81, "hit_2")
  ChangeDefState(2066.46, "hit_1")
  ChangeDefState(2233.11, "hit_2")
  ChangeDefState(2399.76, "hit_1")
  ChangeDefState(2566.41, "hit_2", true)
  MoveAtkCard(2700, nil, 0)
  ChangeAtkState(2700, "idle", true)
  MoveDefCard(2700, nil, 0)
  ClearSkillMask(time - 0.6, nil, 0.6, timelineEndCall)
end

return SkillScript

