-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_12030006_xp", totalHitCount = 12}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_20, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  ChangeDefState(366.63, "hit_1")
  ChangeDefState(999.9, "hit_2")
  ChangeDefState(1166.55, "hit_1")
  ChangeDefState(1333.2, "hit_2")
  ChangeDefState(1499.85, "hit_1")
  ChangeDefState(1666.5, "hit_2")
  ChangeDefState(1833.15, "hit_1")
  ChangeDefState(1999.8, "hit_2")
  ChangeDefState(2166.45, "hit_1")
  ChangeDefState(2333.1, "hit_2")
  ChangeDefState(2499.75, "hit_1")
  ChangeDefState(2666.4, "hit_2", true)
  MoveAtkCard(2366.43, nil, 0)
  ChangeAtkState(2366.43, "idle", true)
  MoveDefCard(2366.43, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

