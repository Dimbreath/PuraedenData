-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11300008_xp", totalHitCount = 17}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_20, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(3000, BattleConfig.positionInvisible, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(7232, true)
  ChangeDefState(8332, "hit_1")
  ChangeDefState(8502, "hit_2")
  ChangeDefState(8672, "hit_1")
  ChangeDefState(8842, "hit_2")
  ChangeDefState(9012, "hit_1")
  ChangeDefState(9182, "hit_2")
  ChangeDefState(9352, "hit_1")
  ChangeDefState(9522, "hit_2")
  ChangeDefState(9692, "hit_1")
  ChangeDefState(9862, "hit_2")
  ChangeDefState(10032, "hit_1")
  ChangeDefState(10202, "hit_2")
  ChangeDefState(10372, "hit_1")
  ChangeDefState(10542, "hit_2")
  ChangeDefState(10712, "hit_1")
  ChangeDefState(10822, "hit_2")
  ChangeDefState(11052, "hit_1", true)
  ChangeAtkState(11332, "idle", true)
  MoveAtkCard(11332, nil, 0)
  MoveDefCard(11332, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

