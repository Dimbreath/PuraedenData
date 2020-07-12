-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_GuessItem_01ByName")
require("Guild_GuessItem_02ByName")
require("Guild_GuessItem_03ByName")
require("Guild_GuessItem_04ByName")
require("Guild_GuessItem_05ByName")
require("Guild_GuessItem_06ByName")
require("Guild_GuessItem_07ByName")
require("Guild_GuessItem_08ByName")
require("Guild_GuessItem_09ByName")
GetGuild_LampUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.GuessItem_01_Grp = GetGuild_GuessItem_01Uis(ui:GetChild("GuessItem_01_Grp"))
  uis.GuessItem_02_Grp = GetGuild_GuessItem_02Uis(ui:GetChild("GuessItem_02_Grp"))
  uis.GuessItem_03_Grp = GetGuild_GuessItem_03Uis(ui:GetChild("GuessItem_03_Grp"))
  uis.GuessItem_04_Grp = GetGuild_GuessItem_04Uis(ui:GetChild("GuessItem_04_Grp"))
  uis.GuessItem_05_Grp = GetGuild_GuessItem_05Uis(ui:GetChild("GuessItem_05_Grp"))
  uis.GuessItem_06_Grp = GetGuild_GuessItem_06Uis(ui:GetChild("GuessItem_06_Grp"))
  uis.GuessItem_07_Grp = GetGuild_GuessItem_07Uis(ui:GetChild("GuessItem_07_Grp"))
  uis.GuessItem_08_Grp = GetGuild_GuessItem_08Uis(ui:GetChild("GuessItem_08_Grp"))
  uis.GuessItem_09_Grp = GetGuild_GuessItem_09Uis(ui:GetChild("GuessItem_09_Grp"))
  uis.root = ui
  return uis
end


