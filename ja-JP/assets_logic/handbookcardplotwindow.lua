-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_CardPlotByName")
require("HandBook_CardPlotHeadByName")
local HandBookCardPlotWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local listData = {}
local openType = nil
local isBackOpen = false
local redDotList = {}
local ShowModel = {}
local showType = {OPEN = 1, NO_GAIN_LINE = 2, NO_GAIN = 3, CLOSE_LINE = 4, CLOSE = 5}
local lineCount = 7
local playListUpAni = true
HandBookCardPlotWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, openType, uis, isBackOpen, playListUpAni, HandBookCardPlotWindow
  bridgeObj:SetView((WinResConfig.HandBookCardPlotWindow).package, (WinResConfig.HandBookCardPlotWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  openType = argTable[1]
  uis = GetHandBook_CardPlotUis(contentPane)
  isBackOpen = bridgeObj.OpenFromClose
  playListUpAni = true
  ;
  (HandBookCardPlotWindow.InitAssetStrip)()
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.CardPlotHeadList).HeadList).defaultItem = (Util.GetResUrl)("HandBook:CardPlotHeadAnimation")
  ;
  ((uis.CardPlotHeadList).HeadList):SetVirtual()
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.CardPlotHeadList).HeadList).itemRenderer = HandBookCardPlotWindow.ListRenderer
  ;
  (((uis.CardPlotHeadList).HeadList).onTouchBegin):Set(function(...)
    -- function num : 0_0_0 , upvalues : playListUpAni
    playListUpAni = false
  end
)
  ;
  (HandBookCardPlotWindow.SetRedDotData)()
  ;
  (HandBookCardPlotWindow.InitFunctionControl)()
end

HandBookCardPlotWindow.InitFunctionControl = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local winName = (WinResConfig.HandBookCardPlotWindow).name
  local RegisterGuideAndControl = GuideData.RegisterGuideAndControl
  local ControlID = ControlID
  RegisterGuideAndControl(ControlID.IntimacyList_List, (uis.CardPlotHeadList).HeadList, winName)
end

HandBookCardPlotWindow.SetRedDotData = function(...)
  -- function num : 0_2 , upvalues : openType, _ENV, redDotList
  if openType == (HandBookMgr.CardPlotWinType).Story then
    redDotList = (RedDotMgr.HandBookStory)()
  else
    if openType == (HandBookMgr.CardPlotWinType).Intimacy then
      redDotList = (RedDotMgr.HandBookIntimacyList)()
    end
  end
end

HandBookCardPlotWindow.IsExistRedDot = function(cardID, ...)
  -- function num : 0_3 , upvalues : _ENV, redDotList
  for _,v in ipairs(redDotList) do
    if v == cardID then
      return true
    end
  end
  return false
end

HandBookCardPlotWindow.ListRenderer = function(index, obj, ...)
  -- function num : 0_4 , upvalues : listData, showType, _ENV, lineCount, HandBookCardPlotWindow, openType, playListUpAni
  index = index + 1
  local data = listData[index]
  if data.type == showType.NO_GAIN_LINE then
    (obj:GetChild("NameTxt")).text = (PUtil.get)(20000308)
    return 
  else
    if data.type == showType.CLOSE_LINE then
      (obj:GetChild("NameTxt")).text = (PUtil.get)(20000309)
      return 
    end
  end
  for i = 1, lineCount do
    local cardObj = (obj:GetChild("CardPlotHead" .. i)):GetChild("CardPlotHead")
    local cardData = (data.dataList)[i]
    if cardData == nil then
      cardObj.visible = false
    else
      cardObj.visible = true
      local icon = cardObj:GetChild("HeadLoader")
      local name = cardObj:GetChild("NameTxt")
      local intimacyLv = cardObj:GetChild("LevelTxt")
      local ProgressNumberTxt = cardObj:GetChild("ProgressNumberTxt")
      ;
      (cardObj:GetChild("ProgressTxt")).text = (PUtil.get)(20000408)
      if data.type == showType.OPEN then
        ChangeUIController(cardObj, "c2", 0)
        local cardID = cardData.cardId
        do
          local oneCard = (CardData.GetCardData)(cardID)
          icon.url = (CardMgr.GetHeadIconBanner)(oneCard)
          name.text = oneCard.name
          local intimacy = oneCard.intimacyLv or 0
          intimacyLv.text = intimacy
          if cardData.stageCmp > 0 or intimacy > 0 then
            ProgressNumberTxt.text = "[color=#3cbcff]" .. cardData.stageCmp .. "[/color]" .. "/" .. (HandBookMgr.GetCardMaxNumStage)(cardID)
          else
            if cardData.stageCmp == (HandBookMgr.GetCardMaxNumStage)(cardID) then
              ProgressNumberTxt.text = (PUtil.get)(20000317)
            else
              ProgressNumberTxt.text = (PUtil.get)(20000316)
            end
          end
          ChangeUIController(cardObj, "c1", tonumber(oneCard.intelligence - 1))
          local redDot = cardObj:GetChild("RedDot")
          if redDot then
            redDot.visible = (HandBookCardPlotWindow.IsExistRedDot)(cardID)
          end
          ;
          (cardObj.onClick):Set(function(...)
    -- function num : 0_4_0 , upvalues : openType, _ENV, cardID
    if openType == (HandBookMgr.CardPlotWinType).Story then
      (HandBookMgr.ReserveStagePos)(-1)
      ;
      (HandBookService.OnReqCGCopyInfo)(cardID)
    else
      ;
      (HandBookService.OnReqIntimacyInfo)(cardID)
    end
  end
)
        end
      else
        do
          if data.type == showType.NO_GAIN then
            ChangeUIController(cardObj, "c2", 1)
            name.text = cardData.name
            icon.url = (CardMgr.GetHeadIconBanner)(cardData)
            ChangeUIController(cardObj, "c1", tonumber(cardData.intelligence - 1))
            ;
            (cardObj.onClick):Set(function(...)
    -- function num : 0_4_1 , upvalues : _ENV
    (MessageMgr.SendCenterTips)((PUtil.get)(20000310))
  end
)
            local redDot = cardObj:GetChild("RedDot")
            if redDot then
              redDot.visible = false
            end
          else
            do
              ChangeUIController(cardObj, "c2", 2)
              name.text = cardData.name
              icon.url = (CardMgr.GetHeadIconBanner)(cardData)
              ChangeUIController(cardObj, "c1", tonumber(cardData.intelligence - 1))
              ;
              (cardObj.onClick):Set(function(...)
    -- function num : 0_4_2 , upvalues : _ENV
    (MessageMgr.SendCenterTips)((PUtil.get)(20000311))
  end
)
              do
                do
                  local redDot = cardObj:GetChild("RedDot")
                  if redDot then
                    redDot.visible = false
                  end
                  if i == 1 and playListUpAni then
                    PlayUITrans(obj, "up")
                  end
                  -- DECOMPILER ERROR at PC225: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC225: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC225: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                  -- DECOMPILER ERROR at PC225: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC225: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC225: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                  -- DECOMPILER ERROR at PC225: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC225: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                  -- DECOMPILER ERROR at PC225: LeaveBlock: unexpected jumping out IF_STMT

                end
              end
            end
          end
        end
      end
    end
  end
end

HandBookCardPlotWindow.RefreshList = function(...)
  -- function num : 0_5 , upvalues : listData, HandBookCardPlotWindow, _ENV, lineCount, showType, openType, uis
  listData = {}
  local OpenData = (HandBookCardPlotWindow.SortList)()
  local OpenLine = (math.ceil)(#OpenData / lineCount)
  for i = 1, OpenLine do
    local data = {}
    data.type = showType.OPEN
    local cardList = {}
    for j = 1, lineCount do
      local counter = (i - 1) * lineCount + j
      local mData = OpenData[counter]
      if mData then
        (table.insert)(cardList, mData)
      end
    end
    data.dataList = cardList
    ;
    (table.insert)(listData, data)
  end
  local noGainList, closeList = (HandBookCardPlotWindow.GetNoGainAndCloseCardList)()
  do
    if #noGainList > 0 then
      local LineData = {}
      LineData.type = showType.NO_GAIN_LINE
      ;
      (table.insert)(listData, LineData)
      ;
      (HandBookCardPlotWindow.AddListDataToList)(noGainList, showType.NO_GAIN)
    end
    do
      if #closeList > 0 and openType == (HandBookMgr.CardPlotWinType).Story then
        local LineData = {}
        LineData.type = showType.CLOSE_LINE
        ;
        (table.insert)(listData, LineData)
        ;
        (HandBookCardPlotWindow.AddListDataToList)(closeList, showType.CLOSE)
      end
      -- DECOMPILER ERROR at PC83: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((uis.CardPlotHeadList).HeadList).itemProvider = function(index, ...)
    -- function num : 0_5_0 , upvalues : listData, showType, _ENV
    index = index + 1
    if (listData[index]).type == showType.NO_GAIN_LINE or (listData[index]).type == showType.CLOSE_LINE then
      return (Util.GetResUrl)("HandBook:CardPlotHeadDivision")
    else
      return (Util.GetResUrl)("HandBook:CardPlotHeadAnimation")
    end
  end

      -- DECOMPILER ERROR at PC88: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((uis.CardPlotHeadList).HeadList).numItems = #listData
    end
  end
end

HandBookCardPlotWindow.AddListDataToList = function(data, type, ...)
  -- function num : 0_6 , upvalues : _ENV, lineCount, listData
  local OpenLine = (math.ceil)(#data / lineCount)
  for i = 1, OpenLine do
    local mData = {}
    mData.type = type
    local cardList = {}
    for j = 1, lineCount do
      local counter = (i - 1) * lineCount + j
      local mData = data[counter]
      if mData then
        (table.insert)(cardList, mData)
      end
    end
    mData.dataList = cardList
    ;
    (table.insert)(listData, mData)
  end
end

HandBookCardPlotWindow.GetNoGainAndCloseCardList = function(...)
  -- function num : 0_7 , upvalues : _ENV, openType
  local data = (TableData.gTable).BaseCardData
  local closeList = {}
  local noGainList = {}
  for _,v in pairs(data) do
    -- DECOMPILER ERROR at PC28: Unhandled construct in 'MakeBoolean' P1

    if v.is_display_in_uncall == 1 and openType == (HandBookMgr.CardPlotWinType).Intimacy and not (CardData.GetCardData)(v.id) then
      (table.insert)(noGainList, v)
    end
    if v.is_handbookstage_open == 1 and not (CardData.GetCardData)(v.id) then
      (table.insert)(noGainList, v)
    end
    ;
    (table.insert)(closeList, v)
  end
  ;
  (table.sort)(noGainList, function(a, b, ...)
    -- function num : 0_7_0
    do return b.intelligence < a.intelligence end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (table.sort)(closeList, function(a, b, ...)
    -- function num : 0_7_1
    do return b.intelligence < a.intelligence end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return noGainList, closeList
end

HandBookCardPlotWindow.SortList = function(...)
  -- function num : 0_8 , upvalues : _ENV
  local SummaryData = (HandBookMgr.CGCopySummaryData)()
  local list = (Util.clone)(SummaryData)
  ;
  (table.sort)(list, function(a, b, ...)
    -- function num : 0_8_0 , upvalues : _ENV
    local aIntimacy = ((CardData.GetCardData)(a.cardId)).intimacyLv
    local bIntimacy = ((CardData.GetCardData)(b.cardId)).intimacyLv
    local aIntelligence = ((CardData.GetCardData)(a.cardId)).intelligence
    local bIntelligence = ((CardData.GetCardData)(b.cardId)).intelligence
    local aCmp = a.stageCmp
    local bCmp = b.stageCmp
    do return bIntimacy * 100000000000 + bCmp * 1000000 + bIntelligence * 10000 - b.cardId / 1000 < aIntimacy * 100000000000 + aCmp * 1000000 + aIntelligence * 10000 - a.cardId / 1000 end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return list
end

HandBookCardPlotWindow.OnShown = function(...)
  -- function num : 0_9 , upvalues : HandBookCardPlotWindow
  (HandBookCardPlotWindow.RefreshList)()
end

HandBookCardPlotWindow.OnHide = function(...)
  -- function num : 0_10
end

HandBookCardPlotWindow.OnClose = function(...)
  -- function num : 0_11 , upvalues : _ENV, redDotList, uis, contentPane, argTable, listData
  (CommonWinMgr.RemoveAssets)((WinResConfig.HandBookCardPlotWindow).name)
  ;
  (GuideData.AbolishControlRefer)((WinResConfig.HandBookCardPlotWindow).name)
  redDotList = {}
  uis = nil
  contentPane = nil
  argTable = {}
  listData = {}
end

HandBookCardPlotWindow.InitAssetStrip = function(...)
  -- function num : 0_12 , upvalues : _ENV, openType, uis
  local m = {}
  m.windowName = (WinResConfig.HandBookCardPlotWindow).name
  if openType == (HandBookMgr.CardPlotWinType).Story then
    m.Tip = (PUtil.get)(20000129)
  else
    m.Tip = (PUtil.get)(20000139)
  end
  m.closeToWindow = (WinResConfig.HandBookMainWindow).name
  m.model = uis.AssetStripGrp
  m.moneyTypes = {}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

HandBookCardPlotWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_13 , upvalues : playListUpAni, HandBookCardPlotWindow
  if msgId == 1 then
    playListUpAni = false
    ;
    (HandBookCardPlotWindow.RefreshList)()
  else
    if msgId == 2 then
      (HandBookCardPlotWindow.SetRedDotData)()
    end
  end
end

return HandBookCardPlotWindow

