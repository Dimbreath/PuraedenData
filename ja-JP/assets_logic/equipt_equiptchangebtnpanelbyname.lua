-- params : ...
-- function num : 0 , upvalues : _ENV
GetEquipt_EquiptChangeBtnPanelUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.AllBtn = ui:GetChild("AllBtn")
  uis.NecklaceBtn = ui:GetChild("NecklaceBtn")
  uis.RingBtn = ui:GetChild("RingBtn")
  uis.WeaponBtn = ui:GetChild("WeaponBtn")
  uis.ClothesBtn = ui:GetChild("ClothesBtn")
  uis.root = ui
  return uis
end


