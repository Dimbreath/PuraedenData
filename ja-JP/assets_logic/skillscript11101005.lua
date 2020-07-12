-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11101005_xp", totalHitCount = 10}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCardFront(0, nil, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(1299.87, BattleConfig.positionInvisible, 0)
  MoveAtkCard(2166.45, BattleConfig.positionZero, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(1366.53, true)
  ChangeDefState(2266.44, "hit_1")
  ChangeDefState(2866.38, "hit_2")
  ChangeDefState(3599.64, "hit_1")
  ChangeDefState(4299.57, "hit_2")
  ChangeDefState(4466.22, "hit_1")
  ChangeDefState(4599.54, "hit_2")
  ChangeDefState(4732.86, "hit_1")
  ChangeDefState(4866.18, "hit_2")
  ChangeDefState(4999.5, "hit_1")
  ChangeDefState(5132.82, "hit_2", true)
  MoveAtkCard(5166.15, nil, 0)
  MoveDefCard(5599.44, nil, 0)
  ChangeAtkState(3399.66, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

