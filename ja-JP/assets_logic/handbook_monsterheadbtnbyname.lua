-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_FrameEffByName")
require("CommonResource_HeadFrameByName")
GetHandBook_MonsterHeadBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Choice = GetCommonResource_FrameEffUis(ui:GetChild("Choice"))
  uis.Decorate_02_Image = ui:GetChild("Decorate_02_Image")
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.HeadFrameGrp = GetCommonResource_HeadFrameUis(ui:GetChild("HeadFrameGrp"))
  uis.MonsterNameTxt = ui:GetChild("MonsterNameTxt")
  uis.buttonCtr = ui:GetController("button")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


