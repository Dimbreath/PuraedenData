-- params : ...
-- function num : 0 , upvalues : _ENV
GetShop_GiftUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Decorate_03_Image = ui:GetChild("Decorate_03_Image")
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.Decorate_02_Image = ui:GetChild("Decorate_02_Image")
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.ItemNameTxt = ui:GetChild("ItemNameTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.Reward_0_List = ui:GetChild("Reward_0_List")
  uis.Reward_1_List = ui:GetChild("Reward_1_List")
  uis.Reward_2_List = ui:GetChild("Reward_2_List")
  uis.Reward_3_List = ui:GetChild("Reward_3_List")
  uis.Reward_4_List = ui:GetChild("Reward_4_List")
  uis.Reward_5_List = ui:GetChild("Reward_5_List")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


