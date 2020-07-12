-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11300004_xp", totalHitCount = 14}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(999, BattleConfig.positionInvisible, 0)
  MoveAtkCard(3566, BattleConfig.positionZero, 0)
  MoveAtkCard(4166, BattleConfig.positionInvisible, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(5732, true)
  ChangeDefState(6532, "hit_1")
  ChangeDefState(6666, "hit_2")
  ChangeDefState(6865, "hit_1")
  ChangeDefState(6999, "hit_2")
  ChangeDefState(7765, "hit_1")
  ChangeDefState(7965, "hit_2")
  ChangeDefState(8165, "hit_1")
  ChangeDefState(8365, "hit_2")
  ChangeDefState(8565, "hit_1")
  ChangeDefState(8765, "hit_2")
  ChangeDefState(8965, "hit_1")
  ChangeDefState(9165, "hit_2")
  ChangeDefState(9365, "hit_1")
  ChangeDefState(9499, "hit_2", true)
  ChangeAtkState(9999, "idle", true)
  MoveAtkCard(9999, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

