-- params : ...
-- function num : 0 , upvalues : _ENV
GetArena_RefreshBtnUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.RefreshBtnTxt = ui:GetChild("RefreshBtnTxt")
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


