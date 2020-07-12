-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11201008_xp", totalHitCount = 9, perHitInterval = 0.2, hitEffect = "none"}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0.2)
  MoveDefCard(0, BattleConfig.positionCenter_20, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  ChangeDefState(0.76659, "hit_1", false)
  ChangeDefState(1.16655, "hit_2", false)
  ChangeDefState(1.3332, "hit_1", false)
  ChangeDefState(1.59984, "hit_2", false)
  ChangeDefState(1.79984, "hit_1", false)
  ChangeDefState(2.06646, "hit_2", false)
  ChangeDefState(2.69973, "hit_1", false)
  ChangeDefState(2.93304, "hit_2", false)
  ChangeDefState(3.16635, "hit_1", true)
  MoveAtkCard(3.5, nil, 0)
  MoveDefCard(3.5, nil, 0)
  ChangeAtkState(3.5, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

