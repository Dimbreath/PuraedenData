-- params : ...
-- function num : 0 , upvalues : _ENV
GetShop_ShopPanelUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.ChongzhiBtn = ui:GetChild("ChongzhiBtn")
  uis.LibaoBtn = ui:GetChild("LibaoBtn")
  uis.ZahuoBtn = ui:GetChild("ZahuoBtn")
  uis.ShenmiBtn = ui:GetChild("ShenmiBtn")
  uis.DaibiBtn = ui:GetChild("DaibiBtn")
  uis.YuanzhenBtn = ui:GetChild("YuanzhenBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


