-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "FX_timeline_11100003_xp", totalHitCount = 9, perHitInterval = 0.166}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_20, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  SetDefCardsActive(0, false)
  SetDefCardsActive(1.1662, true)
  ChangeDefState(2.19978, "hit_1")
  ChangeDefState(2.43309, "hit_2")
  ChangeDefState(2.73306, "hit_1")
  ChangeDefState(3.09969, "hit_2")
  ChangeDefState(3.46632, "hit_1")
  ChangeDefState(3.83295, "hit_2")
  ChangeDefState(4.03293, "hit_1")
  ChangeDefState(4.23291, "hit_2")
  ChangeDefState(4.49955, "hit_1", true)
  MoveAtkCard(5, nil, 0)
  MoveDefCard(5, nil, 0)
  ChangeAtkState(5, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

