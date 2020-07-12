-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11200002_xp", totalHitCount = 8}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_13, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(999.9, BattleConfig.positionInvisible, 0)
  MoveAtkCard(1533.18, BattleConfig.positionZero, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(1033.23, true)
  ChangeDefState(1733.16, "hit_1")
  ChangeDefState(2233.11, "hit_2")
  ChangeDefState(2599.74, "hit_1")
  ChangeDefState(2933.04, "hit_2")
  ChangeDefState(3399.66, "hit_1")
  ChangeDefState(3532.98, "hit_2")
  ChangeDefState(3666.3, "hit_1")
  ChangeDefState(3799.62, "hit_2", true)
  MoveAtkCard(3999.6, nil, 0)
  ChangeAtkState(3999.6, "idle", true)
  MoveDefCard(3999.6, nil, 0)
  ClearSkillMask(time - 0.8, nil, 0.8, timelineEndCall)
end

return SkillScript

