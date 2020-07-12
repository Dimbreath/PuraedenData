-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_YangChengBtnBgByName")
require("CommonResource_RedDollByName")
GetCard_YangChengBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.YangChengBtnBg = GetCard_YangChengBtnBgUis(ui:GetChild("YangChengBtnBg"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.RedDot = GetCommonResource_RedDollUis(ui:GetChild("RedDot"))
  uis.buttonCtr = ui:GetController("button")
  uis.lockCtr = ui:GetController("lock")
  uis.root = ui
  return uis
end


