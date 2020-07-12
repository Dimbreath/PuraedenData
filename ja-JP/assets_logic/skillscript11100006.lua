-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "fx_timeline_11100006_xp", totalHitCount = 6, perHitInterval = 0.6, hitEffect = "none"}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_20, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(766.59, BattleConfig.positionInvisible, 0)
  MoveAtkCard(2099.79, BattleConfig.positionZero, 0)
  SetDefCardsActive(0, false, true)
  SetDefCardsActive(1333.2, true, true)
  MoveAtkCard(3466.32, nil, 0)
  MoveDefCard(3466.32, nil, 0)
  ChangeDefState(2233.11, "hit_1")
  ChangeDefState(2499.75, "hit_2")
  ChangeDefState(2899.71, "hit_1")
  ChangeDefState(3166.35, "hit_2")
  ChangeDefState(3399.66, "hit_1")
  ChangeDefState(3666.3, "hit_2", true)
  ChangeAtkState(3466.32, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

