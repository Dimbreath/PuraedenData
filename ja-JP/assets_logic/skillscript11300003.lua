-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11300003_xp", totalHitCount = 12}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(1899, BattleConfig.positionInvisible, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(4832, true)
  ChangeDefState(5666, "hit_1")
  ChangeDefState(5832, "hit_2")
  ChangeDefState(5999, "hit_1")
  ChangeDefState(6166, "hit_2")
  ChangeDefState(7499, "hit_1")
  ChangeDefState(7665, "hit_2")
  ChangeDefState(7832, "hit_1")
  ChangeDefState(7999, "hit_2")
  ChangeDefState(8165, "hit_1")
  ChangeDefState(8332, "hit_2")
  ChangeDefState(8499, "hit_1")
  ChangeDefState(8665, "hit_2", true)
  MoveAtkCard(8999, nil, 0)
  ChangeAtkState(8999, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

