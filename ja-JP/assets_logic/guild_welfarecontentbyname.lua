-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_Content_01ByName")
require("Guild_Content_02ByName")
require("Guild_Content_03ByName")
require("Guild_Content_04ByName")
require("Guild_Content_05ByName")
require("Guild_Content_06ByName")
GetGuild_WelfareContentUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Content_01 = GetGuild_Content_01Uis(ui:GetChild("Content_01"))
  uis.Content_02 = GetGuild_Content_02Uis(ui:GetChild("Content_02"))
  uis.Content_03 = GetGuild_Content_03Uis(ui:GetChild("Content_03"))
  uis.Content_04 = GetGuild_Content_04Uis(ui:GetChild("Content_04"))
  uis.Content_05 = GetGuild_Content_05Uis(ui:GetChild("Content_05"))
  uis.Content_06 = GetGuild_Content_06Uis(ui:GetChild("Content_06"))
  uis.root = ui
  return uis
end


