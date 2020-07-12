-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11300005_xp", totalHitCount = 17}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(1166, BattleConfig.positionInvisible, 0)
  MoveAtkCard(5432, BattleConfig.positionZero, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(4699, true)
  ChangeDefState(5999, "hit_1")
  ChangeDefState(6166, "hit_2")
  ChangeDefState(6832, "hit_1")
  ChangeDefState(7332, "hit_2")
  ChangeDefState(7499, "hit_1")
  ChangeDefState(7665, "hit_2")
  ChangeDefState(7832, "hit_1")
  ChangeDefState(7999, "hit_2")
  ChangeDefState(8165, "hit_1")
  ChangeDefState(8332, "hit_2")
  ChangeDefState(8499, "hit_1")
  ChangeDefState(8665, "hit_2")
  ChangeDefState(8832, "hit_1")
  ChangeDefState(8999, "hit_2")
  ChangeDefState(9165, "hit_1")
  ChangeDefState(9332, "hit_2")
  ChangeDefState(9499, "hit_1", true)
  ChangeAtkState(10000, "idle", true)
  MoveAtkCard(10000, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

