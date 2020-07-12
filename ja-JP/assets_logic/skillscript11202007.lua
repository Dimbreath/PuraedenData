-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11202007_xp", totalHitCount = 9}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCardFront(0, Vector3.zero, 0)
  DisplaySkillMask(0, 1)
  ChangeAtkState(0, "uniqueskill", false)
  MoveAtkCard(799.92, BattleConfig.positionInvisible, 0)
  MoveAtkCard(1499.85, BattleConfig.positionZero, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(1199.88, true)
  MoveAtkCard(4166.25, nil, 0)
  MoveDefCard(4166.25, nil, 0)
  ChangeAtkState(4166.25, "idle", true)
  ChangeDefState(2799.72, "hit_1")
  ChangeDefState(2999.7, "hit_2")
  ChangeDefState(3133.02, "hit_1")
  ChangeDefState(3266.34, "hit_2")
  ChangeDefState(3399.66, "hit_1")
  ChangeDefState(3532.98, "hit_2")
  ChangeDefState(3666.3, "hit_1")
  ChangeDefState(3799.62, "hit_2")
  ChangeDefState(3932.94, "hit_1", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

