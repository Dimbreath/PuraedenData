-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11201003_xp", totalHitCount = 5, perHitInterval = 0.333, hitEffect = "none"}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV, SkillScript
  MoveAtkCard(0, BattleConfig.positionZero, 0.1)
  MoveDefCard(0, BattleConfig.positionCenter_20 + BattleConfig.positionCenter_5, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  SetAtkCardActive(1.899, false)
  MoveAtkCard(2, nil, 0.2)
  ChangeAtkState(2, "idle", true)
  SetAtkCardActive(5.666, true)
  SetDefCardsActive(0, false)
  SetDefCardsActive(0.433, true)
  ChangeDefState(1.499, "hit_1")
  for i = 1, SkillScript.totalHitCount - 1 do
    ChangeDefState(3.333 + (i - 1) * SkillScript.perHitInterval, "hit_1", i == SkillScript.totalHitCount - 1)
  end
  MoveDefCard(3, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

