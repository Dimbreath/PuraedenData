-- params : ...
-- function num : 0 , upvalues : _ENV
require("Shop_DiamondsTipsByName")
GetShop_DiamondsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Tips_01_Grp = GetShop_DiamondsTipsUis(ui:GetChild("Tips_01_Grp"))
  uis.Tips_02_Grp = GetShop_DiamondsTipsUis(ui:GetChild("Tips_02_Grp"))
  uis.Tips_03_Grp = GetShop_DiamondsTipsUis(ui:GetChild("Tips_03_Grp"))
  uis.Tips_04_Grp = GetShop_DiamondsTipsUis(ui:GetChild("Tips_04_Grp"))
  uis.Tips_05_Grp = GetShop_DiamondsTipsUis(ui:GetChild("Tips_05_Grp"))
  uis.Tips_06_Grp = GetShop_DiamondsTipsUis(ui:GetChild("Tips_06_Grp"))
  uis.Diamonds_A_Btn = ui:GetChild("Diamonds_A_Btn")
  uis.Diamonds_B_Btn = ui:GetChild("Diamonds_B_Btn")
  uis.root = ui
  return uis
end


