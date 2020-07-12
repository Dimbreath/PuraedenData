-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11202004_xp", totalHitCount = 9}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_20, 0)
  DisplaySkillMask(0, 1)
  ChangeAtkState(0, "uniqueskill", false)
  SetDefCardsActive(0, false)
  SetDefCardsActive(3566, true)
  MoveAtkCard(5999, nil, 0.2)
  ChangeAtkState(5999, "idle", true)
  MoveDefCard(5999, nil, 0)
  ChangeDefState(4299, "hit_1")
  ChangeDefState(4499, "hit_2")
  ChangeDefState(4666, "hit_1")
  ChangeDefState(4832, "hit_2")
  ChangeDefState(4999, "hit_1")
  ChangeDefState(5166, "hit_2")
  ChangeDefState(5332, "hit_1")
  ChangeDefState(5499, "hit_2")
  ChangeDefState(5666, "hit_1", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

