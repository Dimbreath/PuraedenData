-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11300001_xp", totalHitCount = 10}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCardFront(0, nil, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(666, BattleConfig.positionInvisible, 0)
  MoveAtkCard(4332, BattleConfig.positionZero, 0)
  MoveAtkCard(5766, BattleConfig.positionInvisible, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(5766, true)
  SetDefCardsActive(8332, false)
  ChangeDefState(6499, "hit_1")
  ChangeDefState(6832, "hit_2")
  ChangeDefState(6999, "hit_1")
  ChangeDefState(7165, "hit_2")
  ChangeDefState(7332, "hit_1")
  ChangeDefState(7499, "hit_2")
  ChangeDefState(7665, "hit_1")
  ChangeDefState(7832, "hit_2")
  ChangeDefState(7999, "hit_1")
  ChangeDefState(10832, "hit_2", true)
  ChangeAtkState(11665, "idle", true)
  MoveAtkCard(11665, nil, 0)
  SetDefCardsActive(11665, true)
  MoveDefCard(11665, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

