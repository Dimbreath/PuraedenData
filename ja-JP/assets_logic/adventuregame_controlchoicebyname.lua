-- params : ...
-- function num : 0 , upvalues : _ENV
GetAdventureGame_ControlChoiceUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.OneBtn = ui:GetChild("OneBtn")
  uis.TwoBtn = ui:GetChild("TwoBtn")
  uis.ThreeBtn = ui:GetChild("ThreeBtn")
  uis.FourBtn = ui:GetChild("FourBtn")
  uis.FiveBtn = ui:GetChild("FiveBtn")
  uis.SixBtn = ui:GetChild("SixBtn")
  uis.GoldBackImage = ui:GetChild("GoldBackImage")
  uis.Spend_A_Loader = ui:GetChild("Spend_A_Loader")
  uis.Spend_A_Txt = ui:GetChild("Spend_A_Txt")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


