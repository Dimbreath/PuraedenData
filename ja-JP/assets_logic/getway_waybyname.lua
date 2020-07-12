-- params : ...
-- function num : 0 , upvalues : _ENV
GetGetWay_WayUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.DungeonLoader = ui:GetChild("DungeonLoader")
  uis.TypeTxt = ui:GetChild("TypeTxt")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.BattleNumberTxt = ui:GetChild("BattleNumberTxt")
  uis.SkipBtn = ui:GetChild("SkipBtn")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


