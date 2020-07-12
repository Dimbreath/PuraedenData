-- params : ...
-- function num : 0 , upvalues : _ENV
require("Lottery_CardLoaderPicByName")
GetLottery_CardShowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.CardLoaderPic = GetLottery_CardLoaderPicUis(ui:GetChild("CardLoaderPic"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.StarList = ui:GetChild("StarList")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


