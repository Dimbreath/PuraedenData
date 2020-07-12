-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_StarDebrisChangeGrpWindowByName")
local StarDebrisChangeGrpWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _progressBar, _nextData = nil, nil
StarDebrisChangeGrpWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, StarDebrisChangeGrpWindow
  bridgeObj:SetView((WinResConfig.StarDebrisChangeGrpWindow).package, (WinResConfig.StarDebrisChangeGrpWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  argTable.Card = argTable[1]
  contentPane:Center()
  uis = GetCard_StarDebrisChangeGrpWindowUis(contentPane)
  ;
  (StarDebrisChangeGrpWindow.InitVariable)()
  ;
  (StarDebrisChangeGrpWindow.InitText)()
  ;
  (StarDebrisChangeGrpWindow.InitList)()
  ;
  (StarDebrisChangeGrpWindow.InitButtonEvent)()
end

StarDebrisChangeGrpWindow.InitVariable = function(...)
  -- function num : 0_1 , upvalues : _progressBar, uis
  _progressBar = ((uis.StarDebrisChangeGrp).root):GetChild("DebrisBar")
end

StarDebrisChangeGrpWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.StarDebrisChangeGrp).TitleTxt).text = (PUtil.get)(60000504)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.StarDebrisChangeGrp).SureBtn).text = (PUtil.get)(60000073)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.StarDebrisChangeGrp).Tips_01_Txt).text = (PUtil.get)(60000386)
end

StarDebrisChangeGrpWindow.InitList = function(...)
  -- function num : 0_3 , upvalues : uis, StarDebrisChangeGrpWindow
  ((uis.StarDebrisChangeGrp).AttributeList):SetVirtual()
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.StarDebrisChangeGrp).AttributeList).itemRenderer = StarDebrisChangeGrpWindow.RefreshChangedAttrItem
  ;
  ((uis.StarDebrisChangeGrp).OtherAttributeList):SetVirtual()
end

StarDebrisChangeGrpWindow.InitButtonEvent = function(...)
  -- function num : 0_4 , upvalues : uis, StarDebrisChangeGrpWindow, _ENV
  (((uis.StarDebrisChangeGrp).ReduceBtn).onClick):Add(StarDebrisChangeGrpWindow.ClickDecreaseBtn)
  ;
  (((uis.StarDebrisChangeGrp).AddBtn).onClick):Add(StarDebrisChangeGrpWindow.ClickIncreaseBtn)
  ;
  (((uis.StarDebrisChangeGrp).MinBtn).onClick):Add(StarDebrisChangeGrpWindow.ClickIncrease10TimesBtn)
  ;
  (((uis.StarDebrisChangeGrp).MaxBtn).onClick):Add(StarDebrisChangeGrpWindow.ClickMaxTimesBtn)
  ;
  (((uis.StarDebrisChangeGrp).CloseBtn).onClick):Add(StarDebrisChangeGrpWindow.ClickCloseBtn)
  ;
  (((uis.StarDebrisChangeGrp).SureBtn).onClick):Add(StarDebrisChangeGrpWindow.ClickExchangeBtn)
  local LongPressGesture = (CommonWinMgr.GetGesture)((uis.StarDebrisChangeGrp).ReduceBtn)
  LongPressGesture.trigger = 0.2
  LongPressGesture.interval = 0.2
  ;
  (LongPressGesture.onAction):Set(function(...)
    -- function num : 0_4_0 , upvalues : _ENV
    (CardData.ChangeExchangePieces)(-1)
  end
)
  LongPressGesture = (CommonWinMgr.GetGesture)((uis.StarDebrisChangeGrp).AddBtn)
  LongPressGesture.trigger = 0.2
  LongPressGesture.interval = 0.2
  ;
  (LongPressGesture.onAction):Set(function(...)
    -- function num : 0_4_1 , upvalues : _ENV
    (CardData.ChangeExchangePieces)(1)
  end
)
end

StarDebrisChangeGrpWindow.InitEvent = function(...)
  -- function num : 0_5
end

StarDebrisChangeGrpWindow.RemoveEvent = function(...)
  -- function num : 0_6
end

StarDebrisChangeGrpWindow.OnShown = function(...)
  -- function num : 0_7 , upvalues : StarDebrisChangeGrpWindow
  (StarDebrisChangeGrpWindow.InitEvent)()
  ;
  (StarDebrisChangeGrpWindow.Init)()
end

StarDebrisChangeGrpWindow.OnHide = function(...)
  -- function num : 0_8 , upvalues : StarDebrisChangeGrpWindow
  (StarDebrisChangeGrpWindow.RemoveEvent)()
end

StarDebrisChangeGrpWindow.Init = function(...)
  -- function num : 0_9 , upvalues : _ENV, argTable, uis, StarDebrisChangeGrpWindow
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  CardData.CurrentCardPieceInfo = (ActorData.GetCardPieceInfo)((argTable.Card).id)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  CardData.CurrentPieceID = (CardData.CurrentCardPieceInfo).id
  local config = ((TableData.gTable).BasePropData)[CardData.CurrentPieceID]
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.StarDebrisChangeGrp).JueSeDebrisTxt).text = config.name
  ;
  (CardData.SetWildCardId)((argTable.Card).id)
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

  CardData.WildCardAmount = (ActorData.GetGoodsCount)(CardData.WildCardId, PropType.ITEM)
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.StarDebrisChangeGrp).WangNengItemTxt).text = (((TableData.gTable).BasePropData)[CardData.WildCardId]).name
  local cardData = ((TableData.gTable).BaseCardData)[(argTable.Card).id]
  local piecesId = tonumber((split(cardData.recruit_cost, ":"))[2])
  -- DECOMPILER ERROR at PC69: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((uis.StarDebrisChangeGrp).CardPicesLoader).url = (Util.GetItemUrl)((((TableData.gTable).BasePropData)[piecesId]).icon)
  ;
  (StarDebrisChangeGrpWindow.InitExchangePieces)()
  ;
  (StarDebrisChangeGrpWindow.RefreshPiecesInfo)()
  ;
  (StarDebrisChangeGrpWindow.InitAttrInfo)()
end

StarDebrisChangeGrpWindow.InitExchangePieces = function(...)
  -- function num : 0_10 , upvalues : _ENV, argTable
  local config = ((TableData.gTable).BaseCardStarUpData)[(argTable.Card).id * 100 + (argTable.Card).star]
  local costs = split(config.next_cost, ",")
  local count = #costs
  local eachCost = nil
  for i = 1, count do
    eachCost = split(costs[i], ":")
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R8 in 'UnsetPending'

    if tonumber(eachCost[2]) ~= AssetType.GOLD then
      CardData.CurrentCardPiecesNeed = tonumber(eachCost[3])
      -- DECOMPILER ERROR at PC38: Confused about usage of register: R8 in 'UnsetPending'

      CardData.CurrentExchangePieces = 0
      break
    end
  end
end

StarDebrisChangeGrpWindow.RefreshPiecesInfo = function(...)
  -- function num : 0_11 , upvalues : _ENV, uis, _progressBar
  (CardData.CheckExchangeAmount)()
  ;
  (Util.SetItemFrame)(((uis.StarDebrisChangeGrp).WangNengItemGrp).root, CardData.WildCardId, CardData.WildCardAmount - CardData.CurrentExchangePieces)
  local debrisAmount = (CardData.CurrentCardPieceInfo).haveNum + CardData.CurrentExchangePieces
  ;
  (Util.SetDebrisFrame)(((uis.StarDebrisChangeGrp).JueSeDebrisGrp).root, CardData.CurrentPieceID, debrisAmount)
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.StarDebrisChangeGrp).DebrisNumberTxt).text = tostring(debrisAmount) .. "/" .. tostring(CardData.CurrentCardPiecesNeed)
  _progressBar.value = debrisAmount / CardData.CurrentCardPiecesNeed * 100
  -- DECOMPILER ERROR at PC60: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.StarDebrisChangeGrp).ChangeNumberTxt).text = tostring(CardData.CurrentExchangePieces) .. "/" .. tostring(CardData.CardPiecesToUpgrade)
end

StarDebrisChangeGrpWindow.InitAttrInfo = function(...)
  -- function num : 0_12 , upvalues : _nextData, _ENV, argTable, uis
  _nextData = (CardData.GetNextStarCardData)(argTable.Card)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.StarDebrisChangeGrp).TipsTxt).text = (PUtil.get)(60000074, (argTable.Card).star + 1)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.StarDebrisChangeGrp).AttributeList).numItems = #CardData.StarUpProperty
  local config = ((TableData.gTable).BaseCardStarUpData)[_nextData.id * 100 + _nextData.star]
  local teamBuff = split(config.team_add_attr, ",")
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.StarDebrisChangeGrp).OtherAttributeList).itemRenderer = function(index, item, ...)
    -- function num : 0_12_0 , upvalues : _ENV, teamBuff
    local data = split(teamBuff[index + 1], ":")
    local subConfig = ((TableData.gTable).BaseAttributeData)[tonumber(data[2])]
    ;
    (item:GetChild("NameTxt")).text = subConfig.display_name
    ;
    (item:GetChild("NumberTxt")).text = data[3]
  end

  -- DECOMPILER ERROR at PC40: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.StarDebrisChangeGrp).OtherAttributeList).numItems = #teamBuff
end

StarDebrisChangeGrpWindow.RefreshChangedAttrItem = function(index, item, ...)
  -- function num : 0_13 , upvalues : _ENV, argTable, _nextData
  local config = ((TableData.gTable).BaseAttributeData)[(CardData.StarUpProperty)[index + 1]]
  ;
  (item:GetChild("NameTxt")).text = config.display_name
  ;
  (item:GetChild("NowNumberTxt")).text = (argTable.Card)[config.name]
  ;
  (item:GetChild("AfterNumberTxt")).text = _nextData[config.name]
end

StarDebrisChangeGrpWindow.ClickDecreaseBtn = function(...)
  -- function num : 0_14 , upvalues : _ENV
  (CardData.ChangeExchangePieces)(-1)
end

StarDebrisChangeGrpWindow.ClickIncreaseBtn = function(...)
  -- function num : 0_15 , upvalues : _ENV
  (CardData.ChangeExchangePieces)(1)
end

StarDebrisChangeGrpWindow.ClickIncrease10TimesBtn = function(...)
  -- function num : 0_16 , upvalues : _ENV
  (CardData.ChangeExchangePieces)(10)
end

StarDebrisChangeGrpWindow.ClickMaxTimesBtn = function(...)
  -- function num : 0_17 , upvalues : _ENV
  (CardData.SetToMaxExchange)()
end

StarDebrisChangeGrpWindow.ClickCloseBtn = function(...)
  -- function num : 0_18 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.StarDebrisChangeGrpWindow).name)
end

StarDebrisChangeGrpWindow.ClickExchangeBtn = function(...)
  -- function num : 0_19 , upvalues : _ENV
  (CardMgr.TryExchangeDebris)((ActorData.GetItemObjectIndex)(CardData.WildCardId), CardData.CurrentExchangePieces, CardData.CurrentPieceID, CardData.CardPiecesToUpgrade)
end

StarDebrisChangeGrpWindow.OnClose = function(...)
  -- function num : 0_20 , upvalues : uis, contentPane, argTable, _progressBar, _nextData
  uis = nil
  contentPane = nil
  argTable = {}
  _progressBar = nil
  _nextData = nil
end

StarDebrisChangeGrpWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_21 , upvalues : _ENV, StarDebrisChangeGrpWindow
  if msgId == (WindowMsgEnum.CardWindow).E_MSG_CARD_PIECE_EXCHANGE_COUNT then
    (StarDebrisChangeGrpWindow.RefreshPiecesInfo)()
  else
    if msgId == (WindowMsgEnum.CardWindow).E_MSG_CARD_AFTER_EXCHANGE then
      (StarDebrisChangeGrpWindow.Init)()
    end
  end
end

return StarDebrisChangeGrpWindow

