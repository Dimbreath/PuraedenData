-- params : ...
-- function num : 0 , upvalues : _ENV
GetHome_ActivityUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.PicList = ui:GetChild("PicList")
  uis.PageNumberList = ui:GetChild("PageNumberList")
  uis.root = ui
  return uis
end


