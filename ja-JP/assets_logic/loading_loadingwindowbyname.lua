-- params : ...
-- function num : 0 , upvalues : _ENV
GetLoading_LoadingWindowUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.BgLoader = ui:GetChild("BgLoader")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.LoadingProgressBar = ui:GetChild("LoadingProgressBar")
  uis.root = ui
  return uis
end


