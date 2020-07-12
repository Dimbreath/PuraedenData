-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
GetMail_MailUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.Decorate_02_Image = ui:GetChild("Decorate_02_Image")
  uis.Decorate_03_Image = ui:GetChild("Decorate_03_Image")
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.Decorate_05_Image = ui:GetChild("Decorate_05_Image")
  uis.Decorate_06_Image = ui:GetChild("Decorate_06_Image")
  uis.Decorate_07_Image = ui:GetChild("Decorate_07_Image")
  uis.Decorate_08_Image = ui:GetChild("Decorate_08_Image")
  uis.Decorate_09_Image = ui:GetChild("Decorate_09_Image")
  uis.CardLoader = ui:GetChild("CardLoader")
  uis.UnHaveMailTxt = ui:GetChild("UnHaveMailTxt")
  uis.AllGetBtn = ui:GetChild("AllGetBtn")
  uis.GetBtn = ui:GetChild("GetBtn")
  uis.DeleteBtn = ui:GetChild("DeleteBtn")
  uis.MailNumberWordTxt = ui:GetChild("MailNumberWordTxt")
  uis.MailNumberTxt = ui:GetChild("MailNumberTxt")
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.WordList = ui:GetChild("WordList")
  uis.EnclosureWordTxt = ui:GetChild("EnclosureWordTxt")
  uis.ItemList = ui:GetChild("ItemList")
  uis.SendPeopleWordTxt = ui:GetChild("SendPeopleWordTxt")
  uis.SendPeopleNameTxt = ui:GetChild("SendPeopleNameTxt")
  uis.SendPeopleGrp = ui:GetChild("SendPeopleGrp")
  uis.SendTimeWordTxt = ui:GetChild("SendTimeWordTxt")
  uis.SendTimeTxt = ui:GetChild("SendTimeTxt")
  uis.SendTimeGrp = ui:GetChild("SendTimeGrp")
  uis.MailList = ui:GetChild("MailList")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


