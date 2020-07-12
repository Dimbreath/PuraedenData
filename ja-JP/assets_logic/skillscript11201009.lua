-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "FX_timeline_11201009_xp", totalHitCount = 6, perHitInterval = 0.34441, hitEffect = "none"}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV, SkillScript
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_5, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(4.5, nil, 0)
  ChangeAtkState(4.5, "idle", true)
  SetDefCardsActive(0, false)
  SetDefCardsActive(0.9999, true)
  for i = 1, SkillScript.totalHitCount do
    ChangeDefState(1.93314 + (i - 1) * SkillScript.perHitInterval, i % 2 == 0 and "hit_1" or "hit_2", i == SkillScript.totalHitCount)
  end
  MoveDefCard(4.5, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

