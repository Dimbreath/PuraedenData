-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "FX_timeline_11201010_xp", totalHitCount = 12}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCardFront(0, Vector3(0, 0, 0), 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(6166.05, nil, 0)
  ChangeAtkState(6166.05, "idle", true)
  SetDefCardsActive(0, false)
  SetDefCardsActive(1533.18, true)
  ChangeDefState(2833.05, "hit_1")
  ChangeDefState(3066.36, "hit_2")
  ChangeDefState(3399.66, "hit_1")
  ChangeDefState(3732.96, "hit_2")
  ChangeDefState(4166.25, "hit_1")
  ChangeDefState(4299.57, "hit_2")
  ChangeDefState(4499.55, "hit_1")
  ChangeDefState(4666.2, "hit_2")
  ChangeDefState(4799.52, "hit_1")
  ChangeDefState(4966.17, "hit_2")
  ChangeDefState(5132.82, "hit_1")
  ChangeDefState(5299.47, "hit_2", true)
  MoveDefCard(6166.05, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

