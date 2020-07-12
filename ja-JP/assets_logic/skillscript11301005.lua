-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11301005_xp", totalHitCount = 11}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(4599.54, BattleConfig.positionInvisible, 0)
  MoveAtkCard(6965.98, BattleConfig.positionZero, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(6166.05, true)
  ChangeDefState(7332.6, "hit_1")
  ChangeDefState(7565.91, "hit_2")
  ChangeDefState(9499.05, "hit_1")
  ChangeDefState(9732.36, "hit_2")
  ChangeDefState(9865.68, "hit_1")
  ChangeDefState(9999, "hit_2")
  ChangeDefState(10132.32, "hit_1")
  ChangeDefState(10232.31, "hit_2")
  ChangeDefState(10365.63, "hit_1")
  ChangeDefState(10498.95, "hit_2")
  ChangeDefState(10665.6, "hit_1", true)
  MoveAtkCard(11, nil, 0.2)
  ChangeAtkState(11, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

