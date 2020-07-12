-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11101002_xp", totalHitCount = 9, perHitInterval = 0.427735, hitEffect = "none"}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_5, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  SetAtkCardActive(1.79982, false)
  SetDefCardsActive(0, false)
  SetDefCardsActive(2.06646, true)
  ChangeDefState(2.79972, "hit_1")
  ChangeDefState(2.93304, "hit_2")
  ChangeDefState(3.16635, "hit_1")
  ChangeDefState(3.49965, "hit_2")
  ChangeDefState(4.06626, "hit_1")
  ChangeDefState(4.23291, "hit_2")
  ChangeDefState(4.49955, "hit_1")
  ChangeDefState(4.73286, "hit_2")
  ChangeDefState(5.06616, "hit_1", true)
  SetAtkCardActive(5.066, true)
  MoveAtkCard(5.066, nil, 0)
  ChangeAtkState(5.066, "idle", true)
  MoveDefCard(5.066, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

