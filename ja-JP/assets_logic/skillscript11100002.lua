-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "FX_timeline_11100002_xp", totalHitCount = 13}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_20, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(1666, BattleConfig.positionInvisible, 0)
  MoveAtkCard(2766, BattleConfig.positionZero, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(1.76649, true)
  ChangeDefState(2.89971, "hit_1")
  ChangeDefState(3.03303, "hit_2")
  ChangeDefState(3.49965, "hit_1")
  ChangeDefState(3.59964, "hit_2")
  ChangeDefState(3.76629, "hit_1")
  ChangeDefState(3.89961, "hit_2")
  ChangeDefState(3.9996, "hit_1")
  ChangeDefState(4.13292, "hit_2")
  ChangeDefState(4.26624, "hit_1")
  ChangeDefState(4.3329, "hit_2")
  ChangeDefState(4.53288, "hit_1")
  ChangeDefState(4.79952, "hit_2")
  ChangeDefState(4.86618, "hit_1", true)
  MoveAtkCard(5832, nil, 0)
  MoveDefCard(5832, nil, 0)
  ChangeAtkState(5832, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

