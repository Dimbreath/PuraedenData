-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuild_ApplyUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.Word_01_Txt = ui:GetChild("Word_01_Txt")
  uis.MyApplyBtn = ui:GetChild("MyApplyBtn")
  uis.RefreshBtn = ui:GetChild("RefreshBtn")
  uis.SpeedJoinBtn = ui:GetChild("SpeedJoinBtn")
  uis.InputImage = ui:GetChild("InputImage")
  uis.InputImage = ui:GetChild("InputImage")
  uis.InputNameTxt = ui:GetChild("InputNameTxt")
  uis.QueryBtn = ui:GetChild("QueryBtn")
  uis.ApplyTipsList = ui:GetChild("ApplyTipsList")
  uis.Nothing_01_Image = ui:GetChild("Nothing_01_Image")
  uis.TalkWordTxt = ui:GetChild("TalkWordTxt")
  uis.IconLoader = ui:GetChild("IconLoader")
  uis.NothingGrp = ui:GetChild("NothingGrp")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


