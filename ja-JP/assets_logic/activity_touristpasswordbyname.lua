-- params : ...
-- function num : 0 , upvalues : _ENV
GetActivity_TouristPassWordUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.TipsTxt = ui:GetChild("TipsTxt")
  uis.ChoiceBtn = ui:GetChild("ChoiceBtn")
  uis.PassWord_01_Txt = ui:GetChild("PassWord_01_Txt")
  uis.PassWord_02_Txt = ui:GetChild("PassWord_02_Txt")
  uis.Input_01_Txt = ui:GetChild("Input_01_Txt")
  uis.Input_02_Txt = ui:GetChild("Input_02_Txt")
  uis.IDTxt = ui:GetChild("IDTxt")
  uis.IDNumberTxt = ui:GetChild("IDNumberTxt")
  uis.CopyBtn = ui:GetChild("CopyBtn")
  uis.ContentList = ui:GetChild("ContentList")
  uis.root = ui
  return uis
end


