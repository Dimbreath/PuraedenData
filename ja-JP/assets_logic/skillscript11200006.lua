-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11200006_xp", totalHitCount = 8, perHitInterval = 0.53, hitEffect = "none"}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_20, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  SetAtkCardActive(1.36653, false)
  SetAtkCardActive(6.16605, true)
  MoveAtkCard(6.16605, nil, 0)
  MoveDefCard(6.16605, nil, 0)
  ChangeAtkState(6.16605, "idle", true)
  SetDefCardsActive(0, false)
  SetDefCardsActive(1.46652, true)
  ChangeDefState(1.9998, "hit_1")
  ChangeDefState(2.39976, "hit_2")
  ChangeDefState(4.3329, "hit_1")
  ChangeDefState(4.49955, "hit_2")
  ChangeDefState(4.6662, "hit_1")
  ChangeDefState(4.9995, "hit_2")
  ChangeDefState(5.26614, "hit_1")
  ChangeDefState(5.59944, "hit_2", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

