-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_12030003_xp", totalHitCount = 6}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCardFront(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  ChangeDefState(1866.48, "hit_1")
  ChangeDefState(1999.8, "hit_2")
  ChangeDefState(2133.12, "hit_1")
  ChangeDefState(2266.44, "hit_2")
  ChangeDefState(2399.76, "hit_1")
  ChangeDefState(2566.41, "hit_2", true)
  MoveAtkCard(3, nil, 0)
  ChangeAtkState(3, "idle", true)
  MoveDefCard(3, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

