-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11101004_xp", totalHitCount = 10}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(799.92, BattleConfig.positionInvisible, 0)
  MoveAtkCard(1699.83, BattleConfig.positionZero, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(999.9, true)
  ChangeDefState(1899.81, "hit_1")
  ChangeDefState(2066.46, "hit_2")
  ChangeDefState(2266.44, "hit_1")
  ChangeDefState(2399.76, "hit_2")
  ChangeDefState(2933.04, "hit_1")
  ChangeDefState(3066.36, "hit_2")
  ChangeDefState(3199.68, "hit_1")
  ChangeDefState(3333, "hit_2")
  ChangeDefState(3466.32, "hit_1")
  ChangeDefState(3632.97, "hit_2", true)
  MoveAtkCard(3399.66, nil, 0)
  ChangeAtkState(3399.66, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

