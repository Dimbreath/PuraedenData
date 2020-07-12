-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_IntimacyGetByName")
require("HandBook_IntimacyCardInfoByName")
require("HandBook_IntimacySoundByName")
GetHandBook_IntimacyPanelUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.IntimacyGetGrp = GetHandBook_IntimacyGetUis(ui:GetChild("IntimacyGetGrp"))
  uis.IntimacyCardInfo = GetHandBook_IntimacyCardInfoUis(ui:GetChild("IntimacyCardInfo"))
  uis.IntimacySound = GetHandBook_IntimacySoundUis(ui:GetChild("IntimacySound"))
  uis.Button_01_Btn = ui:GetChild("Button_01_Btn")
  uis.Button_02_Btn = ui:GetChild("Button_02_Btn")
  uis.Button_03_Btn = ui:GetChild("Button_03_Btn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


