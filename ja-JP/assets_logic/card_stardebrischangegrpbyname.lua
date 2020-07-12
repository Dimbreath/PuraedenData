-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_ItemFrameByName")
require("CommonResource_HeadDebrisByName")
GetCard_StarDebrisChangeGrpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.CardPicesLoader = ui:GetChild("CardPicesLoader")
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.DebrisNumberTxt = ui:GetChild("DebrisNumberTxt")
  uis.AttributeList = ui:GetChild("AttributeList")
  uis.OtherAttributeList = ui:GetChild("OtherAttributeList")
  uis.WangNengItemGrp = GetCommonResource_ItemFrameUis(ui:GetChild("WangNengItemGrp"))
  uis.WangNengItemTxt = ui:GetChild("WangNengItemTxt")
  uis.JueSeDebrisGrp = GetCommonResource_HeadDebrisUis(ui:GetChild("JueSeDebrisGrp"))
  uis.JueSeDebrisTxt = ui:GetChild("JueSeDebrisTxt")
  uis.TipsTxt = ui:GetChild("TipsTxt")
  uis.Tips_01_Txt = ui:GetChild("Tips_01_Txt")
  uis.ChangeNumberTxt = ui:GetChild("ChangeNumberTxt")
  uis.ReduceBtn = ui:GetChild("ReduceBtn")
  uis.AddBtn = ui:GetChild("AddBtn")
  uis.MinBtn = ui:GetChild("MinBtn")
  uis.MaxBtn = ui:GetChild("MaxBtn")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.StarDebrisChangeGrp = ui:GetChild("StarDebrisChangeGrp")
  uis.root = ui
  return uis
end


