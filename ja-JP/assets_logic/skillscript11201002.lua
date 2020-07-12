-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11201002_xp", totalHitCount = 13}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0.1)
  MoveDefCardFront(0, nil, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(166.65, BattleConfig.positionInvisible, 0)
  MoveAtkCard(733.26, BattleConfig.positionZero, 0)
  MoveAtkCard(4332.9, nil, 0)
  ChangeAtkState(4332.9, "idle", true)
  SetDefCardsActive(0, false)
  SetDefCardsActive(333.3, true)
  ChangeDefState(1166.55, "hit_1")
  ChangeDefState(1299.87, "hit_2")
  ChangeDefState(1433.19, "hit_1")
  ChangeDefState(1666.5, "hit_2")
  ChangeDefState(1799.82, "hit_1")
  ChangeDefState(1999.8, "hit_2")
  ChangeDefState(2266.44, "hit_1")
  ChangeDefState(2399.76, "hit_2")
  ChangeDefState(2533.08, "hit_1")
  ChangeDefState(3066.36, "hit_2")
  ChangeDefState(3199.68, "hit_1")
  ChangeDefState(3333, "hit_2")
  ChangeDefState(3466.32, "hit_1", true)
  MoveDefCard(3999.6, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

