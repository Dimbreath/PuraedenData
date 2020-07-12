-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuild_MemberUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.MemberTipsList = ui:GetChild("MemberTipsList")
  uis.root = ui
  return uis
end


