-- params : ...
-- function num : 0 , upvalues : _ENV
GetDailyDungeon_SweepUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.SweepList = ui:GetChild("SweepList")
  uis.HeadChoiceTxt = ui:GetChild("HeadChoiceTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.OnceBtn = ui:GetChild("OnceBtn")
  uis.TwiceBtn = ui:GetChild("TwiceBtn")
  uis.root = ui
  return uis
end


