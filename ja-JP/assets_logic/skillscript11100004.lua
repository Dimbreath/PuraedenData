-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "FX_timeline_11100004_xp", totalHitCount = 6, perHitInterval = 0.3}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCardFront(0, Vector3.zero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  SetAtkCardActive(1.166, false)
  SetDefCardsActive(0, false)
  SetDefCardsActive(3399.66, true)
  ChangeDefState(4.16625, "hit_1")
  ChangeDefState(4.3329, "hit_2")
  ChangeDefState(5.3328, "hit_1")
  ChangeDefState(5.49945, "hit_2")
  ChangeDefState(5.6661, "hit_1")
  ChangeDefState(5.93274, "hit_2", true)
  MoveAtkCard(2, nil, 0.2)
  MoveDefCard(5832.75, nil, 0)
  SetAtkCardActive(5832.75, true)
  ChangeAtkState(2, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

