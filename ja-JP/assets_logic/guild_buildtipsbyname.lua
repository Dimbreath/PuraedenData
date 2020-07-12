-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuild_BuildTipsUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.RewardList = ui:GetChild("RewardList")
  uis.Spend_01_Image = ui:GetChild("Spend_01_Image")
  uis.Spend_01_Loader = ui:GetChild("Spend_01_Loader")
  uis.SpendTxt = ui:GetChild("SpendTxt")
  uis.SpendBtn = ui:GetChild("SpendBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


