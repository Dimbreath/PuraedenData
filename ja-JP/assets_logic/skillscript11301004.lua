-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11301004_xp", totalHitCount = 15}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(6666, BattleConfig.positionInvisible, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(8932, true)
  SetDefCardsActive(12498, false)
  ChangeDefState(10165, "hit_1")
  ChangeDefState(10332, "hit_2")
  ChangeDefState(10498, "hit_1")
  ChangeDefState(10665, "hit_2")
  ChangeDefState(10832, "hit_1")
  ChangeDefState(10998, "hit_2")
  ChangeDefState(11165, "hit_1")
  ChangeDefState(11332, "hit_2")
  ChangeDefState(11498, "hit_1")
  ChangeDefState(11665, "hit_2")
  ChangeDefState(11832, "hit_1")
  ChangeDefState(11998, "hit_2")
  ChangeDefState(12165, "hit_1")
  ChangeDefState(12332, "hit_2")
  ChangeDefState(12498, "hit_1", true)
  MoveAtkCard(14998, nil, 0)
  ChangeAtkState(14998, "idle", true)
  SetDefCardsActive(14998, true)
  MoveAtkCard(14998, nil, 0)
  ClearSkillMask(time - 0.8, nil, 0.8, timelineEndCall)
end

return SkillScript

