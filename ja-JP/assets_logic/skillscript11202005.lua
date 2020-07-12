-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11202005_xp", totalHitCount = 6}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  ChangeDefState(666, nil, false, "FX_timeline_11202005_xp_hit")
  ChangeDefState(999, nil)
  ChangeDefState(1333, nil)
  ChangeDefState(1666, nil)
  ChangeDefState(1999, nil)
  ChangeDefState(2333, nil, true)
  ChangeAtkState(2000, "idle", true)
  MoveAtkCard(2000, nil, 0.2)
  ClearSkillMask(time - 0.2, nil, 0.2, timelineEndCall)
end

return SkillScript

