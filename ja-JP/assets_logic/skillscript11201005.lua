-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11201005_xp", totalHitCount = 11}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  SetAtkCardActive(1.066, false)
  SetAtkCardActive(1.833, true)
  SetAtkCardActive(6.499, false)
  MoveAtkCard(7, nil, 0)
  ChangeAtkState(7, "idle", true)
  SetAtkCardActive(11.9, true)
  SetDefCardsActive(0, false)
  SetDefCardsActive(6.999, true)
  ChangeDefState(8832.45, "hit_1")
  ChangeDefState(8999.1, "hit_2")
  ChangeDefState(9199.08, "hit_1")
  ChangeDefState(9432.39, "hit_2")
  ChangeDefState(9599.04, "hit_1")
  ChangeDefState(9832.35, "hit_2")
  ChangeDefState(9999, "hit_1")
  ChangeDefState(10165.65, "hit_2")
  ChangeDefState(10332.3, "hit_1")
  ChangeDefState(10532.28, "hit_2")
  ChangeDefState(10698.93, "hit_1", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

