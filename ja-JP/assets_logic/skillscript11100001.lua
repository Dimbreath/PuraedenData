-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "FX_timeline_11100001_xp", totalHitCount = 9, perHitInterval = 0.22, hitEffect = "FX_11100001_attack_hit"}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_20, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  SetAtkCardActive(3.39966, false)
  SetDefCardsActive(0, false)
  SetDefCardsActive(1.13322, true)
  ChangeDefState(1.86648, "hit_1")
  ChangeDefState(2.26644, "hit_2")
  ChangeDefState(2.73306, "hit_1")
  ChangeDefState(2.9997, "hit_2")
  ChangeDefState(3.333, "hit_1")
  ChangeDefState(3.53298, "hit_2")
  ChangeDefState(3.83295, "hit_1")
  ChangeDefState(3.9996, "hit_2")
  ChangeDefState(4.3329, "hit_1", true)
  SetAtkCardActive(4.7, true)
  MoveAtkCard(4.7, nil, 0)
  MoveDefCard(4.7, nil, 0)
  ChangeAtkState(4.3, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

