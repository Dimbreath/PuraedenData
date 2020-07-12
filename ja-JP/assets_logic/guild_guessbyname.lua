-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_FarByName")
require("Guild_MiddleByName")
require("Guild_LampByName")
require("CommonResource_AssetStripByName")
require("Guild_NewResultByName")
GetGuild_GuessUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Far = GetGuild_FarUis(ui:GetChild("Far"))
  uis.Middle = GetGuild_MiddleUis(ui:GetChild("Middle"))
  uis.Lamp = GetGuild_LampUis(ui:GetChild("Lamp"))
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.Decorate_13_Image = ui:GetChild("Decorate_13_Image")
  uis.Decorate_15_Image = ui:GetChild("Decorate_15_Image")
  uis.RecordBtn = ui:GetChild("RecordBtn")
  uis.GuessNumberTxt = ui:GetChild("GuessNumberTxt")
  uis.GuessBtn = ui:GetChild("GuessBtn")
  uis.AllBtn = ui:GetChild("AllBtn")
  uis.SpendWordTxt = ui:GetChild("SpendWordTxt")
  uis.SpendItemLoader = ui:GetChild("SpendItemLoader")
  uis.SpendNumberTxt = ui:GetChild("SpendNumberTxt")
  uis.NewResult = GetGuild_NewResultUis(ui:GetChild("NewResult"))
  uis.root = ui
  return uis
end


