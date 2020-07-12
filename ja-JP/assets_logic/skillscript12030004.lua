-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_12030004_xp", totalHitCount = 6}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  ChangeDefState(1666, "hit_1")
  ChangeDefState(1833, "hit_2")
  ChangeDefState(1999, "hit_1")
  ChangeDefState(2166, "hit_2")
  ChangeDefState(2333, "hit_1")
  ChangeDefState(2499, "hit_2", true)
  MoveAtkCard(2400, nil, 0)
  ChangeAtkState(2400, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

