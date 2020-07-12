-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuild_PlayerHeadUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Head_02_Image = ui:GetChild("Head_02_Image")
  uis.ActorHeadLoader = ui:GetChild("ActorHeadLoader")
  uis.LevelTxt = ui:GetChild("LevelTxt")
  uis.TouchBtn = ui:GetChild("TouchBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


