-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11202003_xp", totalHitCount = 10, perHitInterval = 0.35}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV, SkillScript
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  DisplaySkillMask(0, 1)
  ChangeAtkState(0, "uniqueskill", false)
  SetDefCardsActive(0, false)
  SetAtkCardActive(1.416, false)
  MoveAtkCard(2, nil, 0.2)
  ChangeAtkState(2, "idle", true)
  SetAtkCardActive(11.049, true)
  SetDefCardsActive(6.83, true)
  for i = 1, SkillScript.totalHitCount do
    ChangeDefState(7.33 + (i - 1) * SkillScript.perHitInterval, "hit_1", i == SkillScript.totalHitCount)
  end
  ClearSkillMask(time - 2, nil, 2, timelineEndCall)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

