-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_12030008_xp", totalHitCount = 9}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(2566, BattleConfig.positionInvisible, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(2566, true)
  ChangeDefState(3666, "hit_1")
  ChangeDefState(3999, "hit_2")
  ChangeDefState(4332, "hit_1")
  ChangeDefState(4666, "hit_2")
  ChangeDefState(4999, "hit_1")
  ChangeDefState(5332, "hit_2")
  ChangeDefState(5666, "hit_1")
  ChangeDefState(5999, "hit_2")
  ChangeDefState(6166, "hit_1", true)
  MoveAtkCard(6666, nil, 0)
  ChangeAtkState(6666, "idle", true)
  ClearSkillMask(time - 0.8, nil, 0.8, timelineEndCall)
end

return SkillScript

