-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11201006_xp", totalHitCount = 10}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_30, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(1.03323, BattleConfig.positionInvisible, 0)
  MoveAtkCard(1.83315, BattleConfig.positionZero, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(1.6665, true)
  ChangeDefState(2566.41, "hit_1")
  ChangeDefState(2833.05, "hit_2")
  ChangeDefState(3133.02, "hit_1")
  ChangeDefState(4066.26, "hit_2")
  ChangeDefState(4199.58, "hit_1")
  ChangeDefState(4332.9, "hit_2")
  ChangeDefState(4466.22, "hit_1")
  ChangeDefState(4599.54, "hit_2")
  ChangeDefState(4732.86, "hit_1")
  ChangeDefState(4966.17, "hit_2", true)
  MoveAtkCard(time - 1.5, nil, 0)
  ChangeAtkState(time - 1.5, "idle", true)
  MoveDefCard(time - 1.5, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

