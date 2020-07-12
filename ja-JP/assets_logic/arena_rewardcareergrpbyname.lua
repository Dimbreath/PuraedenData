-- params : ...
-- function num : 0 , upvalues : _ENV
GetArena_RewardCareerGrpUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.CareerList = ui:GetChild("CareerList")
  uis.Tips_01_Txt = ui:GetChild("Tips_01_Txt")
  uis.Tips_02_Txt = ui:GetChild("Tips_02_Txt")
  uis.Tips_03_Txt = ui:GetChild("Tips_03_Txt")
  uis.root = ui
  return uis
end


