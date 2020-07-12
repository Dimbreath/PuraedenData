-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11301006_xp", totalHitCount = 16}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(1499, BattleConfig.positionInvisible, 0)
  MoveAtkCard(4499, BattleConfig.positionZero, 0)
  MoveAtkCard(5799, BattleConfig.positionInvisible, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(5999, true)
  ChangeDefState(7432, "hit_1")
  ChangeDefState(7599, "hit_2")
  ChangeDefState(7765, "hit_1")
  ChangeDefState(7932, "hit_2")
  ChangeDefState(8065, "hit_1")
  ChangeDefState(8199, "hit_2")
  ChangeDefState(8365, "hit_1")
  ChangeDefState(8565, "hit_2")
  ChangeDefState(8732, "hit_1")
  ChangeDefState(8965, "hit_2")
  ChangeDefState(9165, "hit_1")
  ChangeDefState(9332, "hit_2")
  ChangeDefState(9499, "hit_1")
  ChangeDefState(9665, "hit_2")
  ChangeDefState(9832, "hit_1")
  ChangeDefState(9999, "hit_2", true)
  MoveAtkCard(8665, nil, 0)
  ChangeAtkState(10000, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

