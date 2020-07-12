-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11200008_xp", totalHitCount = 8}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCardFront(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  SetAtkCardActive(2499.75, false)
  MoveAtkCard(5099.49, nil, 0)
  MoveDefCard(5099.49, nil, 0)
  ChangeAtkState(5099.49, "idle", true)
  SetAtkCardActive(5099.49, true)
  SetDefCardsActive(0, false)
  SetDefCardsActive(2566.41, true)
  ChangeDefState(3699.63, "hit_1")
  ChangeDefState(4732.86, "hit_2")
  ChangeDefState(4866.18, "hit_1")
  ChangeDefState(4999.5, "hit_2")
  ChangeDefState(5166.15, "hit_1")
  ChangeDefState(5332.8, "hit_2")
  ChangeDefState(5499.45, "hit_1")
  ChangeDefState(5666.1, "hit_2", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

