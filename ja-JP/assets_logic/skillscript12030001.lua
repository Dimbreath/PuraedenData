-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_12030001_xp", totalHitCount = 10}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCardFront(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  ChangeDefState(466, "hit_1")
  ChangeDefState(633, "hit_2")
  ChangeDefState(799, "hit_1")
  ChangeDefState(966, "hit_2")
  ChangeDefState(1133, "hit_1")
  ChangeDefState(1266, "hit_2")
  ChangeDefState(1466, "hit_1")
  ChangeDefState(1666, "hit_2")
  ChangeDefState(1833, "hit_1")
  ChangeDefState(1999, "hit_2", true)
  MoveAtkCard(2333, nil, 0.2)
  ChangeAtkState(2333, "idle", true)
  MoveDefCard(2333, nil, 0)
  ClearSkillMask(time - 0.5, nil, 0.5, timelineEndCall)
end

return SkillScript

