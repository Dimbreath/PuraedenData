-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11202006_xp", totalHitCount = 13}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero)
  MoveDefCardFront(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(4000, BattleConfig.positionInvisible, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(4900, true)
  ChangeDefState(5832, "hit_1")
  ChangeDefState(6023, "hit_2")
  ChangeDefState(6214, "hit_1")
  ChangeDefState(6405, "hit_2")
  ChangeDefState(6596, "hit_1")
  ChangeDefState(6787, "hit_2")
  ChangeDefState(6978, "hit_1")
  ChangeDefState(7169, "hit_2")
  ChangeDefState(7360, "hit_1")
  ChangeDefState(7551, "hit_2")
  ChangeDefState(7742, "hit_1")
  ChangeDefState(7933, "hit_2")
  ChangeDefState(8132, "hit_1", true)
  MoveDefCard(8432, nil, 0)
  MoveAtkCard(8432, nil, 0)
  ChangeAtkState(8432, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

