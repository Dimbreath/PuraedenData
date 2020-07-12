-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11101001_xp", totalHitCount = 5, perHitInterval = 0.54, hitEffect = "none"}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_5, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  SetAtkCardActive(3.19968, false)
  MoveAtkCard(4, nil, 0)
  ChangeAtkState(4, "idle", true)
  SetAtkCardActive(7, true)
  SetDefCardsActive(0, false)
  SetDefCardsActive(4.43289, true)
  ChangeDefState(5.83275, "hit_1")
  ChangeDefState(5.9994, "hit_2")
  ChangeDefState(6.16605, "hit_1")
  ChangeDefState(6.3327, "hit_2")
  ChangeDefState(6.49935, "hit_1", true)
  MoveDefCard(6.16605, nil, 0.1)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

