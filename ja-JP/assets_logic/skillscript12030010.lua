-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_12030010_xp", totalHitCount = 11}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  ChangeDefState(1899.81, "hit_1")
  ChangeDefState(2066.46, "hit_2")
  ChangeDefState(2266.44, "hit_1")
  ChangeDefState(2433.09, "hit_2")
  ChangeDefState(2599.74, "hit_1")
  ChangeDefState(2766.39, "hit_2")
  ChangeDefState(2933.04, "hit_1")
  ChangeDefState(3099.69, "hit_2")
  ChangeDefState(3266.34, "hit_1")
  ChangeDefState(3466.32, "hit_2")
  ChangeDefState(3632.97, "hit_1", true)
  MoveAtkCard(4, nil, 0)
  ChangeAtkState(4, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

