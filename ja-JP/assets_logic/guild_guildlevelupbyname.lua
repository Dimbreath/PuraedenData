-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniBByName")
GetGuild_GuildLevelUpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniBUis(ui:GetChild("BlackBgAni"))
  uis.RedImage = ui:GetChild("RedImage")
  uis.IconLoader = ui:GetChild("IconLoader")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.TouchTxt = ui:GetChild("TouchTxt")
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.root = ui
  return uis
end


