-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_CardGrowUpByName")
local HandBookCardGrowUpWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local curTreeId = nil
HandBookCardGrowUpWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, HandBookCardGrowUpWindow
  bridgeObj:SetView((WinResConfig.HandBookCardGrowUpWindow).package, (WinResConfig.HandBookCardGrowUpWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetHandBook_CardGrowUpUis(contentPane)
  local m = {}
  m.windowName = (WinResConfig.HandBookCardGrowUpWindow).name
  m.Tip = (PUtil.get)(157)
  m.model = uis.AssetStripGrp
  m.closeToWindow = (WinResConfig.HandBookRelationWindow).name
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((uis.AssetStripGrp).Assets_01_Grp).root).visible = false
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((uis.AssetStripGrp).Assets_02_Grp).root).visible = false
  -- DECOMPILER ERROR at PC58: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((uis.AssetStripGrp).Assets_03_Grp).root).visible = false
  -- DECOMPILER ERROR at PC62: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((uis.AssetStripGrp).Assets_04_Grp).root).visible = false
  ;
  (HandBookCardGrowUpWindow.SetCardList)()
end

HandBookCardGrowUpWindow.SetCardList = function(...)
  -- function num : 0_1 , upvalues : curTreeId, _ENV, uis, HandBookCardGrowUpWindow
  curTreeId = (HandBookData.GetCurClickedFetterTreeId)()
  local treeData = (HandBookData.GetRelationInfoById)(curTreeId)
  local allCardsIds = treeData.allCardsIds
  ;
  (uis.CardList):RemoveChildrenToPool()
  for index,value in ipairs(allCardsIds) do
    local cardItem = ((uis.CardList):AddItemFromPool())
    do
      local selectedIndex = nil
      local cardId = value
      if not (CardData.GetCardData)(cardId) then
        local cardData = ((TableData.gTable).BaseCardData)[cardId]
      end
      if not cardData.fashionId then
        local fashionId = (((TableData.gTable).BaseCardQualityUpData)[tonumber(tostring(cardId) .. "00")]).unlock_fashion_id
      end
      ;
      (HandBookCardGrowUpWindow.SetCardTexture)(fashionId, cardItem:GetChild("CardPictureLoader"))
      local starList = cardItem:GetChild("StarList")
      local stageLvl = cardItem:GetChild("StageLevelGrp")
      ;
      (stageLvl:GetController("c1")).selectedIndex = 0
      starList:RemoveChildrenToPool()
      if (CardData.IsObtained)(cardId) then
        selectedIndex = 0
        local star = cardData.star
        for j = 1, star do
          starList:AddItemFromPool()
        end
        local quality = cardData.quality
        local stageData = (CardMgr.GetBaseCardQualityData)(cardData.quality, cardData.id)
        local levelShow = split(stageData.level_show, ":")
        ;
        (stageLvl:GetController("c1")).selectedIndex = tonumber(levelShow[1])
        ;
        (stageLvl:GetChild("StageNumberTxt")).text = quality
      else
        do
          do
            selectedIndex = 1
            ;
            (cardItem:GetController("c1")).selectedIndex = selectedIndex
            ;
            (cardItem.onClick):Clear()
            ;
            (cardItem.onClick):Add(function(...)
    -- function num : 0_1_0 , upvalues : _ENV, cardId
    (CardMgr.ClickCardResultByCardId)(cardId)
  end
)
          end
          -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
  end
end

HandBookCardGrowUpWindow.SetCardTexture = function(fashionID, loader, ...)
  -- function num : 0_2 , upvalues : _ENV
  local fashionConfig = ((TableData.gTable).BaseFashionData)[fashionID]
  if not fashionConfig then
    loge(fashionID .. "fashionID" .. "未找到")
    loader.visible = false
    return 
  end
  loader.visible = true
  local textureObj = (Util.ShowUIModel)(fashionConfig.show_texture, loader)
  local scale = fashionConfig.settlement_texture_scale / 10000
  ;
  (CSLuaUtil.SetGOScale)(textureObj, scale, scale, scale)
  local positionTable = split(fashionConfig.settlement_texture_position, ":")
  ;
  (CSLuaUtil.SetGOLocalPos)(textureObj, tonumber(positionTable[1]), tonumber(positionTable[2]), 0)
end

HandBookCardGrowUpWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_3 , upvalues : _ENV, HandBookCardGrowUpWindow
  local windowMsgEnum = WindowMsgEnum.CardWindow
  if msgId == windowMsgEnum.E_MSG_CARD_PICE_TO_CARD then
    OpenWindow("PiceGetShowWindow", UILayer.HUD, para.cardId)
  end
  ;
  (HandBookCardGrowUpWindow.SetCardList)()
end

HandBookCardGrowUpWindow.OnClose = function(...)
  -- function num : 0_4 , upvalues : _ENV, uis, contentPane, argTable, curTreeId
  (CommonWinMgr.RemoveAssets)((WinResConfig.HandBookCardGrowUpWindow).name)
  ;
  (uis.CardList):RemoveChildrenToPool()
  uis = nil
  contentPane = nil
  argTable = {}
  curTreeId = nil
end

return HandBookCardGrowUpWindow

