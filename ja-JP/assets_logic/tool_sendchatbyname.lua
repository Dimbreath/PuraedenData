-- params : ...
-- function num : 0 , upvalues : _ENV
GetTool_sendChatUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.NameInTxt = ui:GetChild("NameInTxt")
  uis.sendBtn = ui:GetChild("sendBtn")
  uis.yifaBtn = ui:GetChild("yifaBtn")
  uis.moneyBtn = ui:GetChild("moneyBtn")
  uis.uplevelBtn = ui:GetChild("uplevelBtn")
  uis.diamondBtn = ui:GetChild("diamondBtn")
  uis.BindBtn = ui:GetChild("BindBtn")
  uis.physicalBtn = ui:GetChild("physicalBtn")
  uis.nextAccountBtn = ui:GetChild("nextAccountBtn")
  uis.battleTestBtn = ui:GetChild("battleTestBtn")
  uis.NamingBtn = ui:GetChild("NamingBtn")
  uis.GetAllCardBtn = ui:GetChild("GetAllCardBtn")
  uis.AllCardStageMaxBtn = ui:GetChild("AllCardStageMaxBtn")
  uis.AllEquipBtn = ui:GetChild("AllEquipBtn")
  uis.root = ui
  return uis
end


