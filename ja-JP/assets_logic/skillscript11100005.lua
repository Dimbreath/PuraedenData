-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "fx_timeline_11100005_xp", totalHitCount = 4}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  SetDefCardsActive(0, false, true)
  SetDefCardsActive(5.166, true, true)
  MoveAtkCard(5.166, nil, 0.2)
  ChangeDefState(5.666, nil, false, "FX_11100005_uniqueskill_hit")
  ChangeDefState(6.166, nil)
  ChangeDefState(6.666, nil)
  ChangeDefState(7, nil, true)
  ChangeAtkState(7, "idle", true)
  ClearSkillMask(time - 0.16, nil, 0.16, timelineEndCall)
end

return SkillScript

