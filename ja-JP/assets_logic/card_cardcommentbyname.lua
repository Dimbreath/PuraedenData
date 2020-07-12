-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_CardLoaderPicByName")
GetCard_CardCommentUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.CardLoaderImage = ui:GetChild("CardLoaderImage")
  uis.CardLoaderPic = GetCard_CardLoaderPicUis(ui:GetChild("CardLoaderPic"))
  uis.CardLoaderImage = ui:GetChild("CardLoaderImage")
  uis.TtileTxt = ui:GetChild("TtileTxt")
  uis.CommentList = ui:GetChild("CommentList")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.LoveBtn = ui:GetChild("LoveBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.Nothing_01_Image = ui:GetChild("Nothing_01_Image")
  uis.NothingTxt = ui:GetChild("NothingTxt")
  uis.CardQLoader = ui:GetChild("CardQLoader")
  uis.NothingGrp = ui:GetChild("NothingGrp")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


