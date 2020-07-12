-- params : ...
-- function num : 0 , upvalues : _ENV
GetHome_BackGroundChoiceUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.StateChoiceBtn = ui:GetChild("StateChoiceBtn")
  uis.BgList = ui:GetChild("BgList")
  uis.LeftBtn = ui:GetChild("LeftBtn")
  uis.RightBtn = ui:GetChild("RightBtn")
  uis.root = ui
  return uis
end


