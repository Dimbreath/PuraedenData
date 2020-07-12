-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11200007_xp", totalHitCount = 11}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCardFront(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  SetAtkCardActive(2733.06, false)
  SetAtkCardActive(5666.1, true)
  MoveAtkCard(5666.1, nil, 0)
  ChangeAtkState(5666.1, "idle", true)
  SetDefCardsActive(0, false)
  SetDefCardsActive(2733.06, true)
  MoveDefCard(5666.1, nil, 0)
  ChangeDefState(3832.95, "hit_1")
  ChangeDefState(3999.6, "hit_2")
  ChangeDefState(4166.25, "hit_1")
  ChangeDefState(4332.9, "hit_2")
  ChangeDefState(4499.55, "hit_1")
  ChangeDefState(4666.2, "hit_2")
  ChangeDefState(4832.85, "hit_1")
  ChangeDefState(4999.5, "hit_2")
  ChangeDefState(5166.15, "hit_1")
  ChangeDefState(5332.8, "hit_2")
  ChangeDefState(5499.45, "hit_1", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

