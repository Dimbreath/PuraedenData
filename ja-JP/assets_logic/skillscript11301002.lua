-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "FX_timeline_11301002_xp", totalHitCount = 20}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCardFront(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  SetAtkCardActive(1466, false)
  MoveAtkCard(10832, nil, 0)
  ChangeAtkState(10832, "idle", true)
  SetAtkCardActive(10832, true)
  MoveDefCard(10832, nil, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(4832, true)
  ChangeDefState(5732, "hit_1")
  ChangeDefState(5932, "hit_2")
  ChangeDefState(6132, "hit_1")
  ChangeDefState(6332, "hit_2")
  ChangeDefState(6532, "hit_1")
  ChangeDefState(6732, "hit_2")
  ChangeDefState(6932, "hit_1")
  ChangeDefState(8165, "hit_2")
  ChangeDefState(8332, "hit_1")
  ChangeDefState(8499, "hit_2")
  ChangeDefState(8665, "hit_1")
  ChangeDefState(8832, "hit_2")
  ChangeDefState(8999, "hit_1")
  ChangeDefState(9165, "hit_2")
  ChangeDefState(9332, "hit_1")
  ChangeDefState(9499, "hit_2")
  ChangeDefState(9665, "hit_1")
  ChangeDefState(9832, "hit_2")
  ChangeDefState(9999, "hit_1")
  ChangeDefState(10165, "hit_2", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

