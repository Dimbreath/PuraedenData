-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11201007_xp", totalHitCount = 6, perHitInterval = 0.416, hitEffect = "none"}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV, SkillScript
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  SetAtkCardActive(0.833, false)
  SetAtkCardActive(1.266, true)
  SetAtkCardActive(2.666, false)
  MoveAtkCard(3, nil, 0)
  ChangeAtkState(3, "idle", true)
  SetAtkCardActive(7.399, true)
  SetDefCardsActive(0, false)
  SetDefCardsActive(3.666, true)
  for i = 1, SkillScript.totalHitCount do
    ChangeDefState(4.166 + SkillScript.perHitInterval * (i - 1), "hit_1", i == SkillScript.totalHitCount)
  end
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

