-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_IntimacyGetPeachByName")
require("HandBook_IntimacyUseItemByName")
GetHandBook_IntimacyGetUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.Decorate_02_Image = ui:GetChild("Decorate_02_Image")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.IntimacyGetPeachGrp = GetHandBook_IntimacyGetPeachUis(ui:GetChild("IntimacyGetPeachGrp"))
  uis.Item_01_Grp = GetHandBook_IntimacyUseItemUis(ui:GetChild("Item_01_Grp"))
  uis.Item_02_Grp = GetHandBook_IntimacyUseItemUis(ui:GetChild("Item_02_Grp"))
  uis.Item_03_Grp = GetHandBook_IntimacyUseItemUis(ui:GetChild("Item_03_Grp"))
  uis.Item_04_Grp = GetHandBook_IntimacyUseItemUis(ui:GetChild("Item_04_Grp"))
  uis.Item_05_Grp = GetHandBook_IntimacyUseItemUis(ui:GetChild("Item_05_Grp"))
  uis.ExpProgressBar = ui:GetChild("ExpProgressBar")
  uis.ExpTxt = ui:GetChild("ExpTxt")
  uis.LevelUpBarGrp = ui:GetChild("LevelUpBarGrp")
  uis.CardQLoader = ui:GetChild("CardQLoader")
  uis.TipsBtn = ui:GetChild("TipsBtn")
  uis.root = ui
  return uis
end


