-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "FX_timeline_11301003_xp", totalHitCount = 21}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  DisplaySkillMask(0, 1)
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_30, 0)
  ChangeAtkState(0, "uniqueskill", false)
  MoveAtkCard(1266.54, BattleConfig.positionInvisible, 0)
  MoveAtkCard(6432.69, BattleConfig.positionZero, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(4166.25, true)
  ChangeDefState(4499.55, "hit_1")
  ChangeDefState(4666.2, "hit_2")
  ChangeDefState(4832.85, "hit_1")
  ChangeDefState(4999.5, "hit_2")
  ChangeDefState(5166.15, "hit_1")
  ChangeDefState(5332.8, "hit_2")
  ChangeDefState(5932.74, "hit_1")
  ChangeDefState(6099.39, "hit_2")
  ChangeDefState(6932.64, "hit_1")
  ChangeDefState(7099.29, "hit_2")
  ChangeDefState(7332.6, "hit_1")
  ChangeDefState(7599.24, "hit_2")
  ChangeDefState(7765.89, "hit_1")
  ChangeDefState(8032.53, "hit_2")
  ChangeDefState(8199.18, "hit_1")
  ChangeDefState(8832.45, "hit_2")
  ChangeDefState(8999.1, "hit_1")
  ChangeDefState(9165.75, "hit_2")
  ChangeDefState(9332.4, "hit_1")
  ChangeDefState(9499.05, "hit_2")
  ChangeDefState(9665.7, "hit_1", true)
  ChangeAtkState(10165.65, "idle", true)
  MoveAtkCard(10165.65, nil, 0)
  MoveDefCard(10165.65, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

