-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11201004_xp", totalHitCount = 11}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_20, 0)
  MoveAtkCard(3199, BattleConfig.positionInvisible, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  SetDefCardsActive(0, false)
  SetDefCardsActive(3432, true)
  ChangeDefState(4099, "hit_1")
  ChangeDefState(4266, "hit_2")
  ChangeDefState(4466, "hit_1")
  ChangeDefState(4666, "hit_2")
  ChangeDefState(4832, "hit_1")
  ChangeDefState(4999, "hit_2")
  ChangeDefState(5166, "hit_1")
  ChangeDefState(5332, "hit_2")
  ChangeDefState(5499, "hit_1")
  ChangeDefState(5666, "hit_2")
  ChangeDefState(5832, "hit_1", true)
  MoveAtkCard(6166, nil, 0)
  ChangeAtkState(6166, "idle", true)
  MoveDefCard(6166, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

