-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11201001_xp", totalHitCount = 16}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_20, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(1499, BattleConfig.positionInvisible, 0)
  MoveAtkCard(1933, BattleConfig.positionZero, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(1766, true)
  ChangeDefState(2066, "hit_1")
  ChangeDefState(2233, "hit_2")
  ChangeDefState(3333, "hit_1")
  ChangeDefState(3499, "hit_2")
  ChangeDefState(3699, "hit_1")
  ChangeDefState(3899, "hit_2")
  ChangeDefState(4066, "hit_1")
  ChangeDefState(4832, "hit_2")
  ChangeDefState(5032, "hit_1")
  ChangeDefState(5199, "hit_2")
  ChangeDefState(5566, "hit_1")
  ChangeDefState(5766, "hit_2")
  ChangeDefState(5932, "hit_1")
  ChangeDefState(6099, "hit_2")
  ChangeDefState(6266, "hit_1")
  ChangeDefState(6432, "hit_2", true)
  MoveDefCard(6832, nil, 0)
  MoveAtkCard(6832, nil, 0)
  ChangeAtkState(6832, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

