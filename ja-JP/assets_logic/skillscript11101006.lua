-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11101006_xp", totalHitCount = 10, perHitInterval = 0.35552, hitEffect = "none"}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_15, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  SetDefCardsActive(0, false)
  SetDefCardsActive(0.86658, true)
  ChangeDefState(2166.45, "hit_1")
  ChangeDefState(2399.76, "hit_2")
  ChangeDefState(2566.41, "hit_1")
  ChangeDefState(2799.72, "hit_2")
  ChangeDefState(2999.7, "hit_1")
  ChangeDefState(3199.68, "hit_2")
  ChangeDefState(3399.66, "hit_1")
  ChangeDefState(3599.64, "hit_2")
  ChangeDefState(3866.28, "hit_1")
  ChangeDefState(4099.59, "hit_2", true)
  MoveAtkCard(4099.59, nil, 0)
  MoveDefCard(4099.59, nil, 0)
  ChangeAtkState(4099.59, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

