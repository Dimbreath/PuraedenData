-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "FX_timeline_11200003_xp", totalHitCount = 9}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_20, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  SetAtkCardActive(2999.7, false)
  MoveAtkCard(6232.71, nil, 0)
  MoveDefCard(6232.71, nil, 0)
  ChangeAtkState(6232.71, "idle", true)
  SetAtkCardActive(6232.71, true)
  SetDefCardsActive(0, false)
  SetDefCardsActive(3566.31, true)
  ChangeDefState(4499.55, "hit_1")
  ChangeDefState(4666.2, "hit_2")
  ChangeDefState(4832.85, "hit_1")
  ChangeDefState(4999.5, "hit_2")
  ChangeDefState(5166.15, "hit_1")
  ChangeDefState(5432.79, "hit_2")
  ChangeDefState(5699.43, "hit_1")
  ChangeDefState(5866.08, "hit_2")
  ChangeDefState(5999.4, "hit_1", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

