-- params : ...
-- function num : 0 , upvalues : _ENV
GetMail_MailDetailedUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Mail_01_Image = ui:GetChild("Mail_01_Image")
  uis.Mail_02_Image = ui:GetChild("Mail_02_Image")
  uis.Mail_03_Image = ui:GetChild("Mail_03_Image")
  uis.Mail_04_Image = ui:GetChild("Mail_04_Image")
  uis.Mail_05_Image = ui:GetChild("Mail_05_Image")
  uis.Mail_06_Image = ui:GetChild("Mail_06_Image")
  uis.Mail_07_Image = ui:GetChild("Mail_07_Image")
  uis.MailNameTxt = ui:GetChild("MailNameTxt")
  uis.SendPeopleWordTxt = ui:GetChild("SendPeopleWordTxt")
  uis.SendPeopleNameTxt = ui:GetChild("SendPeopleNameTxt")
  uis.SendPeopleGrp = ui:GetChild("SendPeopleGrp")
  uis.SendTimeWordTxt = ui:GetChild("SendTimeWordTxt")
  uis.SendTimeTxt = ui:GetChild("SendTimeTxt")
  uis.SendTimeGrp = ui:GetChild("SendTimeGrp")
  uis.MailTouchBtn = ui:GetChild("MailTouchBtn")
  uis.MailDetailedGrp = ui:GetChild("MailDetailedGrp")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


