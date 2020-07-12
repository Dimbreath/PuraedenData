-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11202001_xp", totalHitCount = 11, perHitInterval = 0.541, hitEffect = "none"}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  SetAtkCardActive(2.63307, false)
  SetDefCardsActive(0, false)
  SetDefCardsActive(5.9994, true)
  ChangeDefState(7.06596, "hit_1", false)
  ChangeDefState(7.23261, "hit_2", false)
  ChangeDefState(7.49925, "hit_1", false)
  ChangeDefState(8.56581, "hit_2", false)
  ChangeDefState(8.73246, "hit_1", false)
  ChangeDefState(8.79912, "hit_2", false)
  ChangeDefState(8.93244, "hit_1", false)
  ChangeDefState(9.03243, "hit_2", false)
  ChangeDefState(9.13242, "hit_1", false)
  ChangeDefState(9.26574, "hit_2", false)
  ChangeDefState(9.3324, "hit_1", true)
  MoveAtkCard(4, nil, 0)
  ChangeAtkState(4, "idle", true)
  SetAtkCardActive(time - 1, true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

