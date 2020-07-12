-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11300006_xp", totalHitCount = 13}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(4666, BattleConfig.positionInvisible, 0)
  ChangeDefState(2199, "hit_1")
  ChangeDefState(2433, "hit_2")
  ChangeDefState(2633, "hit_1")
  ChangeDefState(2899, "hit_2")
  ChangeDefState(3599, "hit_1")
  ChangeDefState(3766, "hit_2")
  ChangeDefState(3932, "hit_1")
  ChangeDefState(4066, "hit_2")
  ChangeDefState(4232, "hit_1")
  ChangeDefState(4399, "hit_2")
  ChangeDefState(4599, "hit_1")
  ChangeDefState(4766, "hit_2")
  ChangeDefState(4899, "hit_1", true)
  MoveAtkCard(5466, nil, 0)
  ChangeAtkState(5466, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

