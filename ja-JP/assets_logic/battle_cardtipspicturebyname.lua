-- params : ...
-- function num : 0 , upvalues : _ENV
GetBattle_CardTipsPictureUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.CardPictureLoader = ui:GetChild("CardPictureLoader")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


