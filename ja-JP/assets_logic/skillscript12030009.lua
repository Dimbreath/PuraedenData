-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_12030009_xp", totalHitCount = 7}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_30 + BattleConfig.positionCenter_5, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  ChangeDefState(1433, "hit_1")
  ChangeDefState(1599, "hit_2")
  ChangeDefState(1766, "hit_1")
  ChangeDefState(1933, "hit_2")
  ChangeDefState(2066, "hit_1")
  ChangeDefState(2199, "hit_2")
  ChangeDefState(2366, "hit_1", true)
  MoveAtkCard(2066, nil, 0)
  ChangeAtkState(2066, "idle", true)
  MoveDefCard(2066, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

