-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuild_RegisterUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.InputImage = ui:GetChild("InputImage")
  uis.InputImage = ui:GetChild("InputImage")
  uis.GuildNameTxt = ui:GetChild("GuildNameTxt")
  uis.SpendImage = ui:GetChild("SpendImage")
  uis.ItmeLoader = ui:GetChild("ItmeLoader")
  uis.SpendNumberTxt = ui:GetChild("SpendNumberTxt")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.root = ui
  return uis
end


