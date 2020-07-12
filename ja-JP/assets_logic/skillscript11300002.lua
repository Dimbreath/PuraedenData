-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11300002_xp", totalHitCount = 11}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  ChangeDefState(3666, "hit_1")
  ChangeDefState(3832, "hit_2")
  ChangeDefState(3999, "hit_1")
  ChangeDefState(4166, "hit_2")
  ChangeDefState(4666, "hit_1")
  ChangeDefState(4832, "hit_2")
  ChangeDefState(4999, "hit_1")
  ChangeDefState(5166, "hit_2")
  ChangeDefState(5332, "hit_1")
  ChangeDefState(5499, "hit_2")
  ChangeDefState(5666, "hit_1", true)
  MoveAtkCard(6666, nil, 0)
  ChangeAtkState(6666, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

