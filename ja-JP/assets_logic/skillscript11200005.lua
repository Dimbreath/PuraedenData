-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "FX_timeline_11200005_xp", totalHitCount = 8, perHitInterval = 0.229}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  DisplaySkillMask(0, 1)
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_30, 0)
  ChangeAtkState(0, "uniqueskill", false)
  SetAtkCardActive(2.6664, false)
  SetAtkCardActive(6099.39, true)
  MoveAtkCard(6166.05, nil, 0)
  ChangeAtkState(6166.05, "idle", true)
  MoveDefCard(6166.05, nil, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(1.03323, true)
  ChangeDefState(4.19958, "hit_1")
  ChangeDefState(4.3329, "hit_2")
  ChangeDefState(4532.88, "hit_1")
  ChangeDefState(4699.53, "hit_2")
  ChangeDefState(4932.84, "hit_1")
  ChangeDefState(5132.82, "hit_2")
  ChangeDefState(5432.79, "hit_1")
  ChangeDefState(5999.4, "hit_2", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

