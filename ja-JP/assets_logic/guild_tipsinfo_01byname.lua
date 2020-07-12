-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuild_TipsInfo_01Uis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.root = ui
  return uis
end


