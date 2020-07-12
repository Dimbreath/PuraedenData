-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11101003_xp", totalHitCount = 10, perHitInterval = 0.361, hitEffect = "none"}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  SetAtkCardActive(1.09989, false)
  SetAtkCardActive(5.9, true)
  SetDefCardsActive(0, false)
  SetDefCardsActive(1.49985, true)
  ChangeDefState(2699.73, "hit_1")
  ChangeDefState(2933.04, "hit_2")
  ChangeDefState(3133.02, "hit_1")
  ChangeDefState(3333, "hit_2")
  ChangeDefState(3532.98, "hit_1")
  ChangeDefState(3832.95, "hit_2")
  ChangeDefState(4032.93, "hit_1")
  ChangeDefState(4232.91, "hit_2")
  ChangeDefState(4499.55, "hit_1")
  ChangeDefState(4666.2, "hit_2", true)
  MoveAtkCard(2, nil, 0)
  ChangeAtkState(2, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

