-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_ItemFrameByName")
GetGetWay_TicketUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.titilenameTxt = ui:GetChild("titilenameTxt")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.Item_01_Grp = GetCommonResource_ItemFrameUis(ui:GetChild("Item_01_Grp"))
  uis.Item_02_Grp = GetCommonResource_ItemFrameUis(ui:GetChild("Item_02_Grp"))
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.ChangeNumberTxt = ui:GetChild("ChangeNumberTxt")
  uis.ReduceBtn = ui:GetChild("ReduceBtn")
  uis.AddBtn = ui:GetChild("AddBtn")
  uis.Add10Btn = ui:GetChild("Add10Btn")
  uis.MaxBtn = ui:GetChild("MaxBtn")
  uis.NumberGrp = ui:GetChild("NumberGrp")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.root = ui
  return uis
end


