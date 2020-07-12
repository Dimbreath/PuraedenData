-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11202002_xp", totalHitCount = 9, perHitInterval = 0.274, hitEffect = "none"}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV, SkillScript
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_30, 0)
  DisplaySkillMask(0, 1)
  ChangeAtkState(0, "uniqueskill", false)
  DelayCall(0.89991, function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    MoveAtkCard(0, BattleConfig.positionInvisible, 0)
  end
)
  DelayCall(1.39986, function(...)
    -- function num : 0_0_1 , upvalues : _ENV
    MoveAtkCard(0, BattleConfig.positionZero, 0)
  end
)
  SetDefCardsActive(0, false)
  SetDefCardsActive(0.9999, true)
  ChangeDefState(1.69983, "hit_1")
  for i = 1, SkillScript.totalHitCount - 1 do
    ChangeDefState(3.79962 + (i - 1) * SkillScript.perHitInterval, i % 2 == 0 and "hit_1" or "hit_2", i == SkillScript.totalHitCount - 1)
  end
  MoveAtkCard(5.5, nil, 0)
  MoveDefCard(5.5, nil, 0)
  ChangeAtkState(5.5, "idle", true)
  ClearSkillMask(time - 0.7, nil, 0.7, timelineEndCall)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

