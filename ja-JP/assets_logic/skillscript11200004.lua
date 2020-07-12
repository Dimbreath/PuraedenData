-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "FX_timeline_11200004_xp", totalHitCount = 4, perHitInterval = 0.333}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  DisplaySkillMask(0, 1)
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  MoveAtkCard(3, nil, 0)
  ChangeAtkState(3, "idle", true)
  SetDefCardsActive(0, false)
  SetDefCardsActive(2.9997, true)
  PlayAtkEffect(3.03303, "fx_timeline_11200004_xp_buff")
  ClearSkillMask(time - 0.5, nil, 0.5, timelineEndCall)
end

return SkillScript

