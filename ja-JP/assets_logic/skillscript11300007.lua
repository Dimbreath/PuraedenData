-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11300007_xp", totalHitCount = 9}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_20, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(1700, BattleConfig.positionInvisible, 0)
  MoveAtkCard(5332.8, BattleConfig.positionZero, 0)
  RotationAtkCard(5332, {x = 0, y = 0, z = 0})
  RotationAtkCard(7165)
  MoveAtkCard(7165.95, BattleConfig.positionInvisible, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(8199.18, true)
  ChangeDefState(9332.4, "hit_1")
  ChangeDefState(9499.05, "hit_2")
  ChangeDefState(9665.7, "hit_1")
  ChangeDefState(9832.35, "hit_2")
  ChangeDefState(9999, "hit_1")
  ChangeDefState(10165.65, "hit_2")
  ChangeDefState(10332.3, "hit_1")
  ChangeDefState(10498.95, "hit_2")
  ChangeDefState(10698.93, "hit_1", true)
  ChangeAtkState(11665.5, "idle", true)
  MoveAtkCard(11665.5, nil, 0)
  MoveDefCard(11332.2, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

