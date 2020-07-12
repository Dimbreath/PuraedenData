-- params : ...
-- function num : 0 , upvalues : _ENV
GetShop_MonthUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Decorate_03_Image = ui:GetChild("Decorate_03_Image")
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.Decorate_02_Image = ui:GetChild("Decorate_02_Image")
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.ItemNameTxt = ui:GetChild("ItemNameTxt")
  uis.RewardAList = ui:GetChild("RewardAList")
  uis.RewardBList = ui:GetChild("RewardBList")
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.Decorate_05_Image = ui:GetChild("Decorate_05_Image")
  uis.TipsTxt = ui:GetChild("TipsTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.DayImage = ui:GetChild("DayImage")
  uis.DayTxt = ui:GetChild("DayTxt")
  uis.GetBtn = ui:GetChild("GetBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


