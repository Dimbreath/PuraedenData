-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_12030005_xp", totalHitCount = 8}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  SetAtkCardActive(1533.18, false)
  SetDefCardsActive(0, false)
  SetDefCardsActive(1533.18, true)
  ChangeDefState(2333.1, "hit_1")
  ChangeDefState(3233.01, "hit_2")
  ChangeDefState(3399.66, "hit_1")
  ChangeDefState(3566.31, "hit_2")
  ChangeDefState(3732.96, "hit_1")
  ChangeDefState(3899.61, "hit_2")
  ChangeDefState(4066.26, "hit_1")
  ChangeDefState(4266.24, "hit_2", true)
  SetAtkCardActive(4932.84, true)
  MoveAtkCard(4932.84, nil, 0)
  ChangeAtkState(4932.84, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

