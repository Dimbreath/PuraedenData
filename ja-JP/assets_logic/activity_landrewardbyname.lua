-- params : ...
-- function num : 0 , upvalues : _ENV
require("Activity_Day_7ByName")
require("Activity_Day_6ByName")
require("Activity_Day_5ByName")
require("Activity_Day_4ByName")
require("Activity_Day_3ByName")
require("Activity_Day_2ByName")
require("Activity_Day_1ByName")
GetActivity_LandRewardUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Day_7 = GetActivity_Day_7Uis(ui:GetChild("Day_7"))
  uis.Day_6 = GetActivity_Day_6Uis(ui:GetChild("Day_6"))
  uis.Day_5 = GetActivity_Day_5Uis(ui:GetChild("Day_5"))
  uis.Day_4 = GetActivity_Day_4Uis(ui:GetChild("Day_4"))
  uis.Day_3 = GetActivity_Day_3Uis(ui:GetChild("Day_3"))
  uis.Day_2 = GetActivity_Day_2Uis(ui:GetChild("Day_2"))
  uis.Day_1 = GetActivity_Day_1Uis(ui:GetChild("Day_1"))
  uis.root = ui
  return uis
end


