-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_CardPictureLoaderPicByName")
require("HandBook_StageLevelByName")
GetHandBook_CardPictureUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.CardPictureLoaderPic = GetHandBook_CardPictureLoaderPicUis(ui:GetChild("CardPictureLoaderPic"))
  uis.StarList = ui:GetChild("StarList")
  uis.StageLevelGrp = GetHandBook_StageLevelUis(ui:GetChild("StageLevelGrp"))
  uis.UnHaveTxt = ui:GetChild("UnHaveTxt")
  uis.GoBtn = ui:GetChild("GoBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


