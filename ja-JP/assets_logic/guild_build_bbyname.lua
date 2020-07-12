-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_BuildTipsByName")
require("Guild_BuildEffect_AByName")
GetGuild_Build_BUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BuildNumberTxt = ui:GetChild("BuildNumberTxt")
  uis.BuildTips_A = GetGuild_BuildTipsUis(ui:GetChild("BuildTips_A"))
  uis.BuildTips_B = GetGuild_BuildTipsUis(ui:GetChild("BuildTips_B"))
  uis.BuildTips_C = GetGuild_BuildTipsUis(ui:GetChild("BuildTips_C"))
  uis.Word_01_Txt = ui:GetChild("Word_01_Txt")
  uis.ExplainTxt = ui:GetChild("ExplainTxt")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.BuildEffect_A_Grp = GetGuild_BuildEffect_AUis(ui:GetChild("BuildEffect_A_Grp"))
  uis.BigRewardBtn = ui:GetChild("BigRewardBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


