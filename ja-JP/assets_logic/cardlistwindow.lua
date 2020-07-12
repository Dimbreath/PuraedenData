-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_CardListByName")
require("Card_HaveCardinfoGrpByName")
require("Card_HaveCardinfoGrpCompByName")
local CardListWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local allCards = {}
local ownCards = {}
local notOwnCards = {}
local canMergeCards = {}
local scrollView = nil
local CardType = {Own = 1, NotOwn = 2, NotOwnHead = 3, CanMerge = 4}
local frontCardDataList = {}
local bottomCardDataList = {}
local _ownCardsLineCount = nil
local isInitList = false
local LineAmountNum = 7
local frontLine = 1
local cardFilterType = 0
local lastClickType = 0
local bridge = nil
local lastIndex = 0
local haveUrl = ""
local notHaveUrl = ""
local isNeedTrans = true
local bridgeObj = nil
CardListWindow.OnInit = function(_bridgeObj, ...)
  -- function num : 0_0 , upvalues : bridgeObj, _ENV, contentPane, argTable, bridge, uis, cardFilterType, lastClickType, haveUrl, notHaveUrl, CardListWindow
  bridgeObj = _bridgeObj
  bridgeObj:SetView((WinResConfig.CardListWindow).package, (WinResConfig.CardListWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  bridge = bridgeObj
  contentPane:Center()
  uis = GetCard_CardListUis(contentPane)
  cardFilterType = 0
  lastClickType = 0
  local m = {}
  m.windowName = (WinResConfig.CardListWindow).name
  m.Tip = (PUtil.get)(31)
  m.model = uis.AssetStripGrp
  if argTable[1] == nil then
    m.closeToWindow = (WinResConfig.HomeWindow).name
  else
    m.closeToWindow = argTable[1]
  end
  m.moneyTypes = {}
  ;
  (CommonWinMgr.RegisterAssets)(m)
  haveUrl = (Util.GetResUrl)("Card:HaveCardinfoGrp")
  notHaveUrl = (Util.GetResUrl)("Card:UnHavetiaoGrp")
  ;
  (CardListWindow.WindowsBasicInit)()
  ;
  (GuideData.RegisterGuideAndControl)(ControlID.CardList_List, (uis.CardHeadListCmp).CardHeadList, (WinResConfig.CardListWindow).name)
  ;
  (LuaSound.PlaySound)(LuaSound.COMMON_SLIDE_2, SoundBank.OTHER)
end

CardListWindow.OnShown = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  if UIMgr:IsWindowOpen((WinResConfig.GuideWindow).name) then
    (((uis.CardHeadListCmp).CardHeadList).scrollPane).touchEffect = false
  end
end

CardListWindow.WindowsBasicInit = function(...)
  -- function num : 0_2 , upvalues : scrollView, uis, haveUrl, CardListWindow
  scrollView = (uis.CardHeadListCmp).CardHeadList
  scrollView.defaultItem = haveUrl
  scrollView:SetVirtual()
  scrollView.itemRenderer = CardListWindow.RefreshCardItem
  ;
  (CardListWindow.InitCardListState)()
  ;
  (CardListWindow.CardsInfoInit)()
  ;
  (CardListWindow.SetOnChangedEvent)()
end

CardListWindow.InitCardListState = function(...)
  -- function num : 0_3 , upvalues : CardListWindow
  (CardListWindow.GetAllCards)()
  ;
  (CardListWindow.GetOwnCards)()
  ;
  (CardListWindow.GetNotOwnCards)()
end

CardListWindow.OnClickBackButton = function(...)
  -- function num : 0_4 , upvalues : _ENV
  UIMgr:CloseWindow("CardListWindow")
end

CardListWindow.CardsInfoInit = function(isTrans, ...)
  -- function num : 0_5 , upvalues : isNeedTrans, bridgeObj, CardListWindow, ownCards, notOwnCards, canMergeCards
  if isTrans == nil then
    isNeedTrans = not bridgeObj.OpenFromClose
  else
    isNeedTrans = false
  end
  ;
  (CardListWindow.RefreshScroll)(ownCards, notOwnCards, canMergeCards)
end

CardListWindow.GetAllCards = function(...)
  -- function num : 0_6 , upvalues : _ENV, allCards
  for k,v in pairs((TableData.gTable).BaseCardData) do
    (table.insert)(allCards, v)
  end
end

CardListWindow.GetOwnCards = function(...)
  -- function num : 0_7 , upvalues : canMergeCards, _ENV, ownCards
  canMergeCards = (CardData.GetCanMergeCardList)()
  ;
  (table.sort)(canMergeCards, function(a, b, ...)
    -- function num : 0_7_0
    if b.star >= a.star then
      do return a.star == b.star end
      do return b.id < a.id end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  ownCards = (CardData.GetObtainedCardList)()
  ;
  (table.sort)(ownCards, function(a, b, ...)
    -- function num : 0_7_1
    if a.star == b.star then
      if a.level == b.level then
        if a.quality == b.quality then
          if b.id >= a.id then
            do return a.fc ~= b.fc end
            do return b.quality < a.quality end
            do return b.level < a.level end
            do return b.star < a.star end
            do return b.fc < a.fc end
            -- DECOMPILER ERROR: 10 unprocessed JMP targets
          end
        end
      end
    end
  end
)
end

CardListWindow.GetNotOwnCards = function(...)
  -- function num : 0_8 , upvalues : notOwnCards, _ENV
  notOwnCards = (CardData.GetNotObtainedCardList)()
  for i,v in ipairs(notOwnCards) do
    local excelData = ((TableData.gTable).BaseCardData)[v.id]
    local piceID = (split(excelData.recruit_cost, ":"))[2]
    local curChipNum = (ActorData.GetPropsByID)(piceID)
    v.piceNum = curChipNum
  end
  ;
  (table.sort)(notOwnCards, function(a, b, ...)
    -- function num : 0_8_0
    if b.id >= a.id then
      do return a.star ~= b.star end
      do return b.star < a.star end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
end

CardListWindow.RefreshScroll = function(_ownCards, _notOwnCards, ...)
  -- function num : 0_9 , upvalues : isInitList, bridge, frontCardDataList, bottomCardDataList, canMergeCards, cardFilterType, _ENV, CardType, _ownCardsLineCount, LineAmountNum, frontLine, scrollView, notHaveUrl, haveUrl, lastIndex
  isInitList = true
  if bridge.OpenFromClose == true then
    isInitList = true
  end
  frontCardDataList = {}
  bottomCardDataList = {}
  for i = 1, #canMergeCards do
    local data = canMergeCards[i]
    if data.attr_prior == cardFilterType or cardFilterType == 0 then
      (table.insert)(frontCardDataList, {cardData = data, type = CardType.CanMerge})
    end
  end
  for i = 1, #_ownCards do
    local data = _ownCards[i]
    if data.attr_prior == cardFilterType or cardFilterType == 0 then
      (table.insert)(frontCardDataList, {cardData = data, type = CardType.Own, cardIndex = i})
    end
  end
  _ownCardsLineCount = (math.ceil)(#frontCardDataList / LineAmountNum)
  for i = 1, #_notOwnCards do
    local data = _notOwnCards[i]
    if data.attr_prior == cardFilterType or cardFilterType == 0 then
      (table.insert)(bottomCardDataList, {cardData = data, type = CardType.NotOwn})
    end
  end
  local CutLineCount = 0
  if #bottomCardDataList > 0 then
    CutLineCount = 1
  end
  frontLine = (math.ceil)(#frontCardDataList / LineAmountNum)
  scrollView.itemProvider = function(index, ...)
    -- function num : 0_9_0 , upvalues : CutLineCount, frontLine, notHaveUrl, haveUrl
    if CutLineCount > 0 and index == frontLine then
      return notHaveUrl
    else
      return haveUrl
    end
  end

  scrollView.numItems = frontLine + CutLineCount + (math.ceil)(#bottomCardDataList / LineAmountNum)
  if bridge.OpenFromClose == true then
    scrollView:ScrollToView(lastIndex)
    lastIndex = 0
  end
  isInitList = false
end

CardListWindow.RefreshCardItem = function(index, item, ...)
  -- function num : 0_10 , upvalues : frontLine, CardType, _ENV, CardListWindow
  local cType = nil
  if index < frontLine then
    cType = CardType.Own
  else
    if index == frontLine then
      cType = CardType.NotOwnHead
    else
      cType = CardType.NotOwn
    end
  end
  local nameTxt = item:GetChild("NameTxt")
  if nameTxt then
    nameTxt.text = (PUtil.get)(20000308)
  end
  ;
  (CardListWindow.SetCardPrefabData)(item, cType, index)
end

CardListWindow.SetCardPrefabData = function(obj, cType, index, ...)
  -- function num : 0_11 , upvalues : CardType, _ENV, isInitList, isNeedTrans, LineAmountNum, frontCardDataList, bottomCardDataList, frontLine, bridge, lastIndex, CardListWindow, scrollView
  do
    if cType == CardType.NotOwnHead then
      local word = obj:GetChild("NameTxt")
      if word then
        word.text = (PUtil.get)(20000350)
      end
      if obj and isInitList and isNeedTrans then
        PlayUITrans(obj, "in")
      end
      return 
    end
    local soundName = LuaSound.COMMON_CARD_CLICK
    for i = 1, LineAmountNum do
      do
        local ui = (obj:GetChild("HaveCardinfoGrpComp" .. i)):GetChild("HaveCardinfoGrpComp")
        local cdMap = (GetCard_HaveCardinfoGrpCompUis(ui))
        local data = nil
        if cType == CardType.Own then
          data = frontCardDataList[index * LineAmountNum + i]
        else
          data = bottomCardDataList[(index - frontLine - 1) * LineAmountNum + i]
        end
        if data then
          local cData = data.cardData
          ui.visible = true
          -- DECOMPILER ERROR at PC83: Unhandled construct in 'MakeBoolean' P1

          -- DECOMPILER ERROR at PC83: Unhandled construct in 'MakeBoolean' P1

          -- DECOMPILER ERROR at PC83: Unhandled construct in 'MakeBoolean' P1

          if obj and i == 1 and isInitList and isNeedTrans and bridge.OpenFromClose == true and lastIndex - 2 <= index then
            PlayUITrans(obj, "up")
          end
          PlayUITrans(obj, "up")
          if not isInitList then
            ui.alpha = 1
            ui.scale = Vector2.one
          end
          -- DECOMPILER ERROR at PC99: Confused about usage of register: R12 in 'UnsetPending'

          ;
          (cdMap.NameTxt).text = cData.name
          -- DECOMPILER ERROR at PC104: Confused about usage of register: R12 in 'UnsetPending'

          ;
          (cdMap.LevelTxt).text = "Lv." .. cData.level
          -- DECOMPILER ERROR at PC107: Confused about usage of register: R12 in 'UnsetPending'

          ;
          (cdMap.BattleNumberTxt).text = cData.fc
          -- DECOMPILER ERROR at PC113: Confused about usage of register: R12 in 'UnsetPending'

          ;
          (cdMap.HeadLoader).url = (CardMgr.GetHeadIconBanner)(cData)
          for i = 1, 7 do
            (ui:GetChild("Star_0" .. i .. "_Image")).visible = i <= cData.star
          end
          local preUpStageData = {}
          preUpStageData = (CardMgr.GetBaseCardQualityData)(cData.quality, cData.id)
          local levelShow = split(preUpStageData.level_show, ":")
          -- DECOMPILER ERROR at PC147: Confused about usage of register: R14 in 'UnsetPending'

          ;
          ((cdMap.StageCardinfo).c1Ctr).selectedIndex = tonumber(levelShow[1])
          -- DECOMPILER ERROR at PC151: Confused about usage of register: R14 in 'UnsetPending'

          ;
          ((cdMap.StageCardinfo).StageNumberTxt).text = cData.quality
          -- DECOMPILER ERROR at PC154: Confused about usage of register: R14 in 'UnsetPending'

          ;
          ((cdMap.RedDot).root).visible = false
          -- DECOMPILER ERROR at PC158: Confused about usage of register: R14 in 'UnsetPending'

          ;
          (cdMap.c2Ctr).selectedIndex = cData.intelligence - 1
          -- DECOMPILER ERROR at PC164: Confused about usage of register: R14 in 'UnsetPending'

          if data.type == CardType.Own then
            (cdMap.c1Ctr).selectedIndex = 0
            ;
            (ui.onClick):Set(function(...)
    -- function num : 0_11_0 , upvalues : lastIndex, index, CardListWindow, cData, data
    lastIndex = index
    ;
    (CardListWindow.OnCardClick)(cData, data.cardIndex)
  end
)
            do
              if (CardData.CheckIsSixHeroId)(cData.id) then
                if not (CardData.CheckAllHeroLevelUpRedPoint)(cData.id) and not (CardData.CheckAllHeroStageUpRedPoint)(cData.id) and not (CardData.CheckAllHeroStarUpRedPoint)(cData.id) then
                  local redDot = (CardData.CheckAllHeroSkillUpRedPoint)(cData.id)
                end
                -- DECOMPILER ERROR at PC199: Confused about usage of register: R15 in 'UnsetPending'

                ;
                ((cdMap.RedDot).root).visible = redDot
              end
              do
                do
                  local mHolder = (cdMap.root):GetChild("DebrisSfx")
                  if mHolder then
                    mHolder.visible = false
                  end
                  -- DECOMPILER ERROR at PC209: Confused about usage of register: R14 in 'UnsetPending'

                  ;
                  (cdMap.c1Ctr).selectedIndex = 1
                  local pieceInfo = (ActorData.GetCardPieceInfo)(cData.id)
                  local allChipNum = pieceInfo.needNum
                  local piceID = pieceInfo.id
                  local curChipNum = pieceInfo.haveNum
                  -- DECOMPILER ERROR at PC222: Confused about usage of register: R18 in 'UnsetPending'

                  ;
                  (cdMap.FragmentNumberTxt).text = curChipNum .. "/" .. allChipNum
                  local percent = curChipNum / allChipNum * 100
                  -- DECOMPILER ERROR at PC226: Confused about usage of register: R19 in 'UnsetPending'

                  ;
                  (cdMap.CardDebrisProgressBar).value = percent
                  do
                    if obj then
                      local callBack = function(...)
    -- function num : 0_11_1 , upvalues : cdMap, percent, _ENV, scrollView
    local mHolder = (cdMap.root):GetChild("DebrisSfx")
    if cdMap and percent >= 100 then
      if mHolder == nil then
        mHolder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_CHARACTER_BORDER, false, false)
        mHolder:SetXY((cdMap.root).width / 2, (cdMap.root).height / 2)
        mHolder.name = "DebrisSfx"
        ;
        (cdMap.root):AddChild(mHolder)
        ;
        (Util.SetSfxClipInList)((mHolder.displayObject).gameObject, scrollView)
      end
      mHolder.visible = true
    else
      if mHolder ~= nil then
        mHolder.visible = false
      end
    end
  end

                      if isInitList then
                        callBack()
                        -- DECOMPILER ERROR at PC251: Unhandled construct in 'MakeBoolean' P1

                        -- DECOMPILER ERROR at PC251: Unhandled construct in 'MakeBoolean' P1

                        if i == 1 and isNeedTrans and bridge.OpenFromClose == true and lastIndex - 2 <= index then
                          PlayUITrans(obj, "up", function(...)
    -- function num : 0_11_2 , upvalues : callBack
    callBack()
  end
)
                        end
                        PlayUITrans(obj, "up", function(...)
    -- function num : 0_11_3 , upvalues : callBack
    callBack()
  end
)
                        callBack()
                      else
                        callBack()
                      end
                      ;
                      (ui.onClick):Set(function(...)
    -- function num : 0_11_4 , upvalues : lastIndex, index, percent, _ENV, piceID, cData, allChipNum, curChipNum
    lastIndex = index
    if percent < 100 then
      (Util.ShowGetWay)(piceID, function(callback, ...)
      -- function num : 0_11_4_0 , upvalues : _ENV, cData
      local excelData = ((TableData.gTable).BaseCardData)[cData.id]
      local fashionIds = split(excelData.fashion_ids, ":")
      local fashionId = tonumber(fashionIds[#fashionIds])
      ;
      (AudioManager.PlayBubbleAndVoice)(false, true, fashionId, CVAudioType.HomeIdleBubble, nil, nil, false, true, false, false, callback, true)
    end
, allChipNum, allChipNum - curChipNum)
    else
      ;
      (MessageMgr.OpenSoloConfirmWindow)((PUtil.get)(183), function(...)
      -- function num : 0_11_4_1 , upvalues : _ENV, piceID, cData
      local propid = (ActorData.GetItemObjectIndex)(piceID)
      ;
      (CardService.ReqUseProp)(cData.id, propid, 1, UsePropScene.PiceToCard)
    end
, (PUtil.get)(72), (PUtil.get)(74), true)
    end
    ;
    (CardData.SaveCurClickCardID)(cData.id)
  end
)
                    end
                    ui.visible = false
                  end
                  -- DECOMPILER ERROR at PC274: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC274: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC274: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC274: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC274: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC274: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC274: LeaveBlock: unexpected jumping out DO_STMT

                end
              end
            end
          end
        end
      end
    end
    -- DECOMPILER ERROR: 10 unprocessed JMP targets
  end
end

CardListWindow.OnCardClick = function(cData, index, ...)
  -- function num : 0_12 , upvalues : _ENV
  ld("Card", function(...)
    -- function num : 0_12_0 , upvalues : _ENV, cData, index
    local show_spine = (CardMgr.GetShowSpineBundle)(cData)
    local resList = {show_spine}
    ;
    (Util.PreloadResource)(resList)
    ;
    (CardData.SaveCurClickCardID)(cData.id)
    ;
    (CardData.SaveCurClickCardIndex)(index)
    ;
    (Util.SetDelayCall)(function(...)
      -- function num : 0_12_0_0 , upvalues : _ENV
      OpenWindow("CardWindow", UILayer.HUD)
    end
)
  end
)
end

CardListWindow.SetOnChangedEvent = function(...)
  -- function num : 0_13 , upvalues : uis, _ENV, CardListWindow
  ((uis.AllBtn):GetChild("NameTxt")).text = (PUtil.get)(25)
  ;
  ((uis.ATKBtn):GetChild("NameTxt")).text = (PUtil.get)(6)
  ;
  ((uis.DEFBtn):GetChild("NameTxt")).text = (PUtil.get)(1)
  ;
  ((uis.ASSBtn):GetChild("NameTxt")).text = (PUtil.get)(20000226)
  ;
  ((uis.AllBtn).onClick):Set(CardListWindow.OnClickChoiceBtn)
  ;
  ((uis.ATKBtn).onClick):Set(CardListWindow.OnClickChoiceBtn)
  ;
  ((uis.DEFBtn).onClick):Set(CardListWindow.OnClickChoiceBtn)
  ;
  ((uis.ASSBtn).onClick):Set(CardListWindow.OnClickChoiceBtn)
end

CardListWindow.OnClickChoiceBtn = function(...)
  -- function num : 0_14 , upvalues : CardListWindow, cardFilterType, uis, lastClickType, scrollView
  (CardListWindow.DisposeAllButtoTrans)()
  cardFilterType = (uis.c1Ctr).selectedIndex
  if cardFilterType == lastClickType then
    (scrollView.scrollPane):ScrollTop(false)
    ;
    (CardListWindow.CardsInfoInit)()
    lastClickType = cardFilterType
  end
end

CardListWindow.DisposeAllButtoTrans = function(...)
  -- function num : 0_15 , upvalues : _ENV, uis
  DisposeTrans(uis.AllBtn, "TypeBtnIn")
  DisposeTrans(uis.AllBtn, "TypeBtnOut")
  DisposeTrans(uis.DEFBtn, "TypeBtnIn")
  DisposeTrans(uis.DEFBtn, "TypeBtnOut")
  DisposeTrans(uis.ASSBtn, "TypeBtnIn")
  DisposeTrans(uis.ASSBtn, "TypeBtnOut")
  DisposeTrans(uis.ATKBtn, "TypeBtnIn")
  DisposeTrans(uis.ATKBtn, "TypeBtnOut")
end

CardListWindow.ScrollToCardByID = function(cardID, ...)
  -- function num : 0_16 , upvalues : _ENV, frontCardDataList, LineAmountNum, scrollView
  local index = 0
  for i,v in ipairs(frontCardDataList) do
    if (v.cardData).id == cardID then
      index = i
    end
  end
  local line = (math.ceil)(index / LineAmountNum)
  ;
  (SimpleTimer.setTimeout)(0.1, function(...)
    -- function num : 0_16_0 , upvalues : scrollView, line, index, LineAmountNum, _ENV
    scrollView:ScrollToView(line - 1, false)
    local mIndex = scrollView:ItemIndexToChildIndex(line - 1)
    local childNum = index % LineAmountNum
    if childNum == 0 then
      childNum = LineAmountNum
    end
    local cardModel = (scrollView:GetChildAt(mIndex)):GetChildAt(childNum - 1)
    UIMgr:SendWindowMessage((WinResConfig.GuideWindow).name, (WindowMsgEnum.GuideWindow).GUIDE_INFER, cardModel)
  end
)
end

CardListWindow.OnClose = function(...)
  -- function num : 0_17 , upvalues : bridge, _ENV, uis, contentPane, haveUrl, notHaveUrl, allCards, ownCards, notOwnCards, canMergeCards, scrollView, frontCardDataList, bottomCardDataList, argTable
  bridge = nil
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.CardListWindow).name)
  ;
  (GuideData.AbolishControlRefer)((WinResConfig.CardListWindow).name)
  uis = nil
  contentPane = nil
  haveUrl = nil
  notHaveUrl = nil
  allCards = {}
  allCards = {}
  ownCards = {}
  notOwnCards = {}
  canMergeCards = {}
  scrollView = nil
  frontCardDataList = {}
  bottomCardDataList = {}
  argTable = {}
end

CardListWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_18 , upvalues : _ENV, CardListWindow
  local windowMsgEnum = WindowMsgEnum.CardWindow
  if msgId == windowMsgEnum.E_MSG_CARD_PICE_TO_CARD then
    OpenWindow("PiceGetShowWindow", UILayer.HUD, para.cardId)
  else
    if msgId == windowMsgEnum.E_MSG_CARD_CLOSEGET_TOLIST then
      (CardListWindow.InitCardListState)()
      ;
      (CardListWindow.CardsInfoInit)()
    else
      if msgId == windowMsgEnum.E_MSG_CARD_LIST_SCROLL then
        local cardID = para
        ;
        (CardListWindow.ScrollToCardByID)(cardID)
      else
        do
          if msgId == (WindowMsgEnum.CardWindow).E_MSG_GETWAY_CLOESED then
            (CardListWindow.CardsInfoInit)(false)
          end
        end
      end
    end
  end
end

return CardListWindow

