-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_RelationListByName")
require("HandBook_CardListTipsByName")
local HandBookRelationListWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local fetterData = {}
local MAX_FET_NUM = 7
HandBookRelationListWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, HandBookRelationListWindow
  bridgeObj:SetView((WinResConfig.HandBookRelationListWindow).package, (WinResConfig.HandBookRelationListWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetHandBook_RelationListUis(contentPane)
  local m = {}
  m.windowName = (WinResConfig.HandBookRelationListWindow).name
  m.Tip = (PUtil.get)(180)
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
  (HandBookRelationListWindow.InitListData)()
  ;
  (HandBookRelationListWindow.InitList)()
  ;
  (HandBookRelationListWindow.SetWindowInfo)()
end

HandBookRelationListWindow.SetWindowInfo = function(...)
  -- function num : 0_1 , upvalues : uis, fetterData
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

  (uis.TipsList).numItems = #fetterData
end

HandBookRelationListWindow.InitList = function(...)
  -- function num : 0_2 , upvalues : uis, HandBookRelationListWindow
  (uis.TipsList):SetVirtual()
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.TipsList).itemRenderer = HandBookRelationListWindow.RefreshItem
  ;
  (uis.TipsList):SetBeginAnim(true, "up", 0.05, 0.05, true)
end

HandBookRelationListWindow.RefreshItem = function(index, item, ...)
  -- function num : 0_3 , upvalues : fetterData, _ENV
  index = index + 1
  local cardListData = (fetterData[index]).allCardsIds
  local cardList = (item:GetChild("CardListTips")):GetChild("CardList")
  local numberTxt = (item:GetChild("CardListTips")):GetChild("NumberTxt")
  local numberFmTxt = (item:GetChild("CardListTips")):GetChild("Number_1_Txt")
  local goBtn = (item:GetChild("CardListTips")):GetChild("GoBtn")
  local lookBtn = (item:GetChild("CardListTips")):GetChild("LookBtn")
  numberTxt.text = tostring(index)
  cardList:RemoveChildrenToPool()
  for i,v in ipairs(cardListData) do
    local cardItem = cardList:AddItemFromPool()
    local cardData = (CardData.GetCardData)(tonumber(v))
    if cardData ~= nil then
      (cardItem:GetChild("LevelTxt")).visible = true
      ;
      (cardItem:GetController("c3")).selectedIndex = 0
      ;
      (Util.SetHeadFrame)(cardItem, cardData)
    else
      ;
      (cardItem:GetChild("LevelTxt")).visible = false
      ;
      (cardItem:GetChild("StageTxt")).visible = false
      local notGetCardData = ((TableData.gTable).BaseCardData)[tonumber(v)]
      ;
      (cardItem:GetController("QualityCtrl")).selectedIndex = notGetCardData.intelligence + 1
      ;
      (cardItem:GetController("c2")).selectedIndex = 0
      ;
      (cardItem:GetController("c3")).selectedIndex = 2
      ;
      (cardItem:GetChild("Expedition_1_Image")).visible = false
      for i = 1, Const.MaxRoleStar do
        (cardItem:GetChild("Star_0" .. tostring(i) .. "_smallImage")).visible = false
      end
      local cardInfo = ((TableData.gTable).BaseCardData)[tonumber(v)]
      local fashionConfig = (CardData.GetFashionConfig)(cardInfo)
      ;
      (cardItem:GetChild("IconLoader")).url = (Util.GetItemUrl)(fashionConfig.head_icon_square)
    end
  end
  if #(fetterData[index]).allReadyFetterIds < #(fetterData[index]).allFetterIds then
    numberTxt.text = "[color=#359be3]" .. #(fetterData[index]).allReadyFetterIds .. "[/color]"
    numberFmTxt.text = "[color=#858a94]" .. "/" .. #(fetterData[index]).allFetterIds .. "[/color]"
  else
    numberTxt.text = "[color=#00b47a]" .. #(fetterData[index]).allReadyFetterIds .. "[/color]"
    numberFmTxt.text = "[color=#00b47a]" .. "/" .. #(fetterData[index]).allFetterIds .. "[/color]"
  end
  local selectedIndex = 0
  if #(fetterData[index]).canFetterIds > 0 then
    selectedIndex = 0
    ;
    (goBtn:GetChild("title")).text = (PUtil.get)(181)
  else
    selectedIndex = 1
    ;
    (lookBtn:GetChild("title")).text = (PUtil.get)(158)
  end
  ;
  ((item:GetChild("CardListTips")):GetController("c1")).selectedIndex = selectedIndex
  if #(fetterData[index]).allReadyFetterIds > 0 then
    selectedIndex = 1
  else
    selectedIndex = 0
  end
  ;
  ((item:GetChild("CardListTips")):GetController("c2")).selectedIndex = selectedIndex
  ;
  (goBtn.onClick):Clear()
  ;
  (goBtn.onClick):Add(function(...)
    -- function num : 0_3_0 , upvalues : _ENV, fetterData, index
    (HandBookData.SaveCurClickedFetterTreeId)((fetterData[index]).treeId)
    UIMgr:SendWindowMessage((WinResConfig.HandBookRelationWindow).name, (WindowMsgEnum.HandBookIntimacyWindow).CLOSE_LIST_WINDOW)
    UIMgr:CloseWindow((WinResConfig.HandBookRelationListWindow).name)
  end
)
  ;
  (lookBtn.onClick):Clear()
  ;
  (lookBtn.onClick):Add(function(...)
    -- function num : 0_3_1 , upvalues : _ENV, fetterData, index
    (HandBookData.SaveCurClickedFetterTreeId)((fetterData[index]).treeId)
    UIMgr:SendWindowMessage((WinResConfig.HandBookRelationWindow).name, (WindowMsgEnum.HandBookIntimacyWindow).CLOSE_LIST_WINDOW)
    UIMgr:CloseWindow((WinResConfig.HandBookRelationListWindow).name)
  end
)
end

HandBookRelationListWindow.InitListData = function(...)
  -- function num : 0_4 , upvalues : fetterData, _ENV
  fetterData = (HandBookData.GetAllInfo)()
end

HandBookRelationListWindow.OnClose = function(...)
  -- function num : 0_5 , upvalues : _ENV, uis, contentPane, argTable, fetterData
  (CommonWinMgr.RemoveAssets)((WinResConfig.HandBookRelationListWindow).name)
  uis = nil
  contentPane = nil
  argTable = {}
  fetterData = {}
end

return HandBookRelationListWindow

