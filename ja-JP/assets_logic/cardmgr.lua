-- params : ...
-- function num : 0 , upvalues : _ENV
CardMgr = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

CardMgr.GetHeadIconSquareUrl = function(cardData, ...)
  -- function num : 0_0 , upvalues : _ENV
  if cardData then
    local fashionConfig = (CardData.GetFashionConfig)(cardData)
    if fashionConfig then
      local url = (Util.GetItemUrl)(fashionConfig.head_icon_square)
      return url
    end
  end
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

CardMgr.GetHeadIconRound = function(cardData, ...)
  -- function num : 0_1 , upvalues : _ENV
  if cardData then
    local fashionConfig = (CardData.GetFashionConfig)(cardData)
    if fashionConfig then
      local url = (Util.GetItemUrl)(fashionConfig.head_icon_round)
      return url
    end
  end
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

CardMgr.GetHeadIconBanner = function(cardData, ...)
  -- function num : 0_2 , upvalues : _ENV
  if cardData then
    local fashionConfig = (CardData.GetFashionConfig)(cardData)
    if fashionConfig then
      local url = (Util.GetItemUrl)(fashionConfig.head_icon_banner)
      return url
    end
  end
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

CardMgr.GetHeadIconBattle = function(cardData, ...)
  -- function num : 0_3 , upvalues : _ENV
  if cardData then
    local fashionConfig = (CardData.GetFashionConfig)(cardData)
    if fashionConfig and fashionConfig.head_icon_battle then
      local url = (Util.GetItemUrl)(fashionConfig.head_icon_battle)
      return url
    end
  end
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

CardMgr.GetHeadIconSkillBanner = function(cardData, ...)
  -- function num : 0_4 , upvalues : _ENV
  if cardData then
    local fashionConfig = (CardData.GetFashionConfig)(cardData)
    if fashionConfig then
      local url = (Util.GetItemUrl)(fashionConfig.head_icon_skill_banner)
      return url
    end
  end
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

CardMgr.GetSpdBundle = function(cardData, ...)
  -- function num : 0_5 , upvalues : _ENV
  if cardData then
    local fashionConfig = (CardData.GetFashionConfig)(cardData)
    if fashionConfig then
      return fashionConfig.spd_bundle
    end
  end
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

CardMgr.GetShowSpineBundle = function(cardData, ...)
  -- function num : 0_6 , upvalues : _ENV
  if cardData then
    local fashionConfig = (CardData.GetFashionConfig)(cardData)
    if fashionConfig then
      return fashionConfig.show_spine
    end
  end
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

CardMgr.GetBigBundle = function(cardData, ...)
  -- function num : 0_7 , upvalues : _ENV
  if cardData then
    local fashionConfig = (CardData.GetFashionConfig)(cardData)
    if fashionConfig then
      return fashionConfig
    end
  end
end

local _equipUnlockInfo = {}
-- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

CardMgr.TryUpgradeCardStar = function(...)
  -- function num : 0_8 , upvalues : _ENV
  if (ActorData.GetAssetCount)(AssetType.GOLD) < (CardData.CurrentUpgradeStarCost).currency then
    (MessageMgr.OpenAssetNotEnoughtWindow)(21100003)
    return 
  end
  if ((ActorData.GetCardPieceInfo)((CardData.CurrentCardInfo).id)).haveNum < (CardData.CurrentUpgradeStarCost).pieces then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000064))
    return 
  end
  ;
  (CardService.ReqStarUp)((CardData.CurrentCardInfo).id)
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

CardMgr.CheckUnlockEquipSlots = function(preCard, card, ...)
  -- function num : 0_9 , upvalues : _ENV
  local preConfig = ((TableData.gTable).BaseCardStarUpData)[preCard.id * 100 + preCard.star]
  local config = ((TableData.gTable).BaseCardStarUpData)[card.id * 100 + card.star]
  if config.unlock_equipment_num ~= preConfig.unlock_equipment_num then
    return config.unlock_equipment_num
  else
    return 0
  end
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

CardMgr.GetEquipmentUnlockStar = function(id, type, ...)
  -- function num : 0_10 , upvalues : _equipUnlockInfo, _ENV
  if _equipUnlockInfo[id] == nil then
    _equipUnlockInfo[id] = {}
    local config = nil
    local currentUnlock = 0
    local firstChange = true
    for i = 1, Const.MaxRoleStar do
      config = ((TableData.gTable).BaseCardStarUpData)[id * 100 + i]
      if currentUnlock ~= config.unlock_equipment_num then
        for j = currentUnlock + 1, config.unlock_equipment_num do
          -- DECOMPILER ERROR at PC27: Confused about usage of register: R13 in 'UnsetPending'

          (_equipUnlockInfo[id])[j] = i
        end
        currentUnlock = config.unlock_equipment_num
      end
    end
  end
  do
    return (_equipUnlockInfo[id])[type]
  end
end

-- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

CardMgr.GetUnlockEquipmentNum = function(id, star, ...)
  -- function num : 0_11 , upvalues : _ENV
  local config = ((TableData.gTable).BaseCardStarUpData)[id * 100 + star]
  if config ~= nil then
    return config.unlock_equipment_num
  else
    return 0
  end
end

-- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

CardMgr.GetBaseCardQualityData = function(quality, id, ...)
  -- function num : 0_12 , upvalues : _ENV
  local tableID = nil
  if quality > 9 then
    tableID = id .. quality
  else
    tableID = id .. "0" .. quality
  end
  return ((TableData.gTable).BaseCardQualityUpData)[tonumber(tableID)]
end

local selectedIndex = 0
local concatCards = {}
local clickedFunc = {}
local cardList = {}
local leftArrowBtn = {}
local rightArrowBtn = {}
local currentTag = nil
-- DECOMPILER ERROR at PC51: Confused about usage of register: R8 in 'UnsetPending'

CardMgr.SetButtomRoleList = function(_cardList, _clickedFunc, _selectedIndex, leftBtn, rightBtn, tag, ...)
  -- function num : 0_13 , upvalues : concatCards, _ENV, clickedFunc, cardList, currentTag, selectedIndex, leftArrowBtn, rightArrowBtn
  concatCards = {}
  concatCards = (CardData.GetObtainedCardList)()
  clickedFunc[tag] = _clickedFunc
  cardList[tag] = _cardList
  currentTag = tag
  ;
  (cardList[tag]):SetVirtual()
  ;
  (((cardList[tag]).scrollPane).onScroll):Add(function(...)
    -- function num : 0_13_0 , upvalues : _ENV, tag
    (CardMgr.CheckArrow)(tag)
  end
)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (cardList[tag]).itemRenderer = CardMgr.RefreshCardItem
  selectedIndex = _selectedIndex
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (cardList[tag]).numItems = #concatCards
  if selectedIndex > 9 then
    (cardList[tag]):ScrollToView(selectedIndex - 6)
  end
  leftArrowBtn[tag] = leftBtn
  rightArrowBtn[tag] = rightBtn
  ;
  (CardMgr.CheckArrow)(tag)
end

-- DECOMPILER ERROR at PC54: Confused about usage of register: R8 in 'UnsetPending'

CardMgr.RefreshCardItem = function(index, item, ...)
  -- function num : 0_14 , upvalues : concatCards, currentTag, _ENV, selectedIndex, cardList, clickedFunc
  index = index + 1
  local data = concatCards[index]
  ;
  (item:GetChild("RedDot")).visible = false
  do
    if currentTag ~= (WinResConfig.EquipmentWindow).name and index <= 6 then
      if not (CardData.CheckAllHeroLevelUpRedPoint)(data.id) and not (CardData.CheckAllHeroStageUpRedPoint)(data.id) and not (CardData.CheckAllHeroStarUpRedPoint)(data.id) then
        local redDot = (CardData.CheckAllHeroSkillUpRedPoint)(data.id)
      end
      ;
      (item:GetChild("RedDot")).visible = redDot
    end
    ;
    (Util.SetHeadFrame)(item, data)
    if index == selectedIndex then
      (item:GetController("c1")).selectedIndex = 1
    else
      ;
      (item:GetController("c1")).selectedIndex = 0
    end
    ;
    (item:GetController("QualityCtrl")).selectedIndex = data.intelligence + 1
    ;
    (item.onClick):Set(function(...)
    -- function num : 0_14_0 , upvalues : selectedIndex, index, cardList, currentTag, clickedFunc, data
    selectedIndex = index
    ;
    (cardList[currentTag]):RefreshVirtualListImmediately()
    if clickedFunc[currentTag] ~= nil then
      (clickedFunc[currentTag])(index, data)
    end
  end
)
  end
end

-- DECOMPILER ERROR at PC57: Confused about usage of register: R8 in 'UnsetPending'

CardMgr.ChangeCardListTag = function(tag, ...)
  -- function num : 0_15 , upvalues : currentTag
  currentTag = tag
end

-- DECOMPILER ERROR at PC60: Confused about usage of register: R8 in 'UnsetPending'

CardMgr.RefreshCardList = function(num, ...)
  -- function num : 0_16 , upvalues : cardList, currentTag
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (cardList[currentTag]).numItems = num
end

-- DECOMPILER ERROR at PC63: Confused about usage of register: R8 in 'UnsetPending'

CardMgr.CheckArrow = function(tag, ...)
  -- function num : 0_17 , upvalues : leftArrowBtn, rightArrowBtn, cardList
  if leftArrowBtn[tag] == nil or rightArrowBtn[tag] == nil then
    return 
  end
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  if ((cardList[tag]).scrollPane).contentWidth <= ((cardList[tag]).scrollPane).viewWidth then
    (leftArrowBtn[tag]).visible = false
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (rightArrowBtn[tag]).visible = false
  else
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

    if ((cardList[tag]).scrollPane).isRightMost then
      (leftArrowBtn[tag]).visible = true
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (rightArrowBtn[tag]).visible = false
    else
      -- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

      if ((cardList[tag]).scrollPane).isLeftMost then
        (leftArrowBtn[tag]).visible = false
        -- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

        ;
        (rightArrowBtn[tag]).visible = true
      else
        -- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

        ;
        (leftArrowBtn[tag]).visible = true
        -- DECOMPILER ERROR at PC43: Confused about usage of register: R1 in 'UnsetPending'

        ;
        (rightArrowBtn[tag]).visible = true
      end
    end
  end
end

-- DECOMPILER ERROR at PC66: Confused about usage of register: R8 in 'UnsetPending'

CardMgr.GetQualitySelectIndexByLevel = function(quality, cardID, ...)
  -- function num : 0_18 , upvalues : _ENV
  local selectedIndex = 0
  local preUpStageData = {}
  preUpStageData = (CardMgr.GetBaseCardQualityData)(quality, cardID)
  local levelShow = split(preUpStageData.level_show, ":")
  selectedIndex = tonumber(levelShow[1])
  return selectedIndex
end

-- DECOMPILER ERROR at PC69: Confused about usage of register: R8 in 'UnsetPending'

CardMgr.TryExchangeDebris = function(goodsIndex, count, debrisId, needCount, ...)
  -- function num : 0_19 , upvalues : _ENV
  if count == 0 then
    if needCount == 0 then
      (MessageMgr.SendCenterTips)((PUtil.get)(60000084))
    end
    return 
  end
  ;
  (CardService.ReqExchangeDebris)(goodsIndex, count, debrisId)
end

-- DECOMPILER ERROR at PC72: Confused about usage of register: R8 in 'UnsetPending'

CardMgr.OpenCardWindowWithTag = function(index, ...)
  -- function num : 0_20 , upvalues : _ENV
  ld("Card", function(...)
    -- function num : 0_20_0 , upvalues : _ENV, index
    local ownCards = (CardData.GetObtainedCardList)()
    ;
    (CardData.SaveCurClickCardID)((ownCards[1]).id)
    ;
    (CardData.SaveCurClickCardIndex)(1)
    OpenWindow("CardWindow", UILayer.HUD, index)
  end
)
end

-- DECOMPILER ERROR at PC75: Confused about usage of register: R8 in 'UnsetPending'

CardMgr.ClickCardResultByCardId = function(cardId, ...)
  -- function num : 0_21 , upvalues : _ENV
  if (CardData.IsObtained)(cardId) then
    ld("Card", function(...)
    -- function num : 0_21_0 , upvalues : _ENV, cardId
    local cData = (CardData.GetCardData)(cardId)
    local show_spine = (CardMgr.GetShowSpineBundle)(cData)
    local resList = {show_spine}
    ;
    (Util.PreloadResource)(resList)
    ;
    (CardData.SaveCurClickCardID)(cardId)
    ;
    (CardData.SaveCurClickCardIndex)((CardData.GetCardIndexByCardId)(cardId))
    OpenWindow("CardWindow", UILayer.HUD)
  end
)
  else
    local pieceInfo = (ActorData.GetCardPieceInfo)(cardId)
    local allChipNum = pieceInfo.needNum
    local piceID = pieceInfo.id
    local curChipNum = pieceInfo.haveNum
    local percent = curChipNum / allChipNum * 100
    if percent < 100 then
      (Util.ShowGetWay)(piceID, function(callback, ...)
    -- function num : 0_21_1 , upvalues : _ENV, cardId
    OpenWindow("CardDetailsWindow", UILayer.HUD, cardId)
    local excelData = ((TableData.gTable).BaseCardData)[cardId]
    local fashionIds = split(excelData.fashion_ids, ":")
    local fashionId = tonumber(fashionIds[#fashionIds])
    ;
    (AudioManager.PlayBubbleAndVoice)(false, true, fashionId, CVAudioType.HomeIdleBubble, nil, nil, false, true, false, false, callback, true)
  end
, allChipNum, allChipNum - curChipNum)
    else
      ;
      (MessageMgr.OpenConfirmWindow)((PUtil.get)(73), function(...)
    -- function num : 0_21_2 , upvalues : _ENV
    OpenWindow("CardListWindow", UILayer.HUD, "HandBookRelationWindow")
  end
, nil, (PUtil.get)(72), ((PUtil.get)(60000072)), nil, true)
    end
  end
end

local LikeCardList = {}
local cardPraiseList = {}
local hotComment = {}
local newComment = {}
-- DECOMPILER ERROR at PC84: Confused about usage of register: R12 in 'UnsetPending'

CardMgr.CardCommentState = {Like = 1, Cancel = 2}
-- DECOMPILER ERROR at PC87: Confused about usage of register: R12 in 'UnsetPending'

CardMgr.SetLikeCardList = function(id, state, ...)
  -- function num : 0_22 , upvalues : _ENV, LikeCardList
  if state == (CardMgr.CardCommentState).Like then
    (table.insert)(LikeCardList, id)
  else
    for i,v in ipairs(LikeCardList) do
      if id == v then
        (table.remove)(LikeCardList, i)
      end
    end
  end
end

-- DECOMPILER ERROR at PC90: Confused about usage of register: R12 in 'UnsetPending'

CardMgr.SetCardPraiseList = function(list, ...)
  -- function num : 0_23 , upvalues : cardPraiseList
  cardPraiseList = list
end

-- DECOMPILER ERROR at PC93: Confused about usage of register: R12 in 'UnsetPending'

CardMgr.AddPraiseToList = function(id, ...)
  -- function num : 0_24 , upvalues : _ENV, cardPraiseList
  (table.insert)(cardPraiseList, id)
  UIMgr:SendWindowMessage((WinResConfig.CardCommentWindow).name, 1)
end

-- DECOMPILER ERROR at PC96: Confused about usage of register: R12 in 'UnsetPending'

CardMgr.InitCommentContent = function(msg, ...)
  -- function num : 0_25 , upvalues : hotComment, newComment, _ENV
  if msg.paging == 1 then
    hotComment = {}
    newComment = {}
    ;
    (CardMgr.ProcessComment)(msg)
    OpenWindow((WinResConfig.CardCommentWindow).name, UILayer.HUD, msg.cardId)
    return 
  end
  ;
  (CardMgr.ProcessComment)(msg)
end

-- DECOMPILER ERROR at PC99: Confused about usage of register: R12 in 'UnsetPending'

CardMgr.AddSelfComment = function(chatData, ...)
  -- function num : 0_26 , upvalues : _ENV, newComment
  if chatData then
    (table.insert)(newComment, 1, chatData)
    UIMgr:SendWindowMessage((WinResConfig.CardCommentWindow).name, 1)
  end
end

-- DECOMPILER ERROR at PC102: Confused about usage of register: R12 in 'UnsetPending'

CardMgr.ModifyComment = function(chatData, ...)
  -- function num : 0_27 , upvalues : _ENV, hotComment, newComment
  for i,v in pairs(hotComment) do
    if v.chatId == chatData.chatId then
      hotComment[i] = chatData
    end
  end
  for i,v in pairs(newComment) do
    if v.chatId == chatData.chatId then
      newComment[i] = chatData
    end
  end
end

-- DECOMPILER ERROR at PC105: Confused about usage of register: R12 in 'UnsetPending'

CardMgr.ProcessComment = function(msg, ...)
  -- function num : 0_28 , upvalues : _ENV, hotComment, newComment
  for _,v in ipairs(msg.highChatData) do
    local isContain = false
    for _,v2 in ipairs(hotComment) do
      if v.chatId == v2.chatId then
        v = v2
        isContain = true
      end
    end
    if not isContain then
      (table.insert)(hotComment, v)
    end
  end
  for _,v in ipairs(msg.chatData) do
    local isContain = false
    for _,v2 in ipairs(newComment) do
      if v.chatId == v2.chatId then
        v = v2
        isContain = true
      end
    end
    if not isContain then
      (table.insert)(newComment, v)
    end
  end
end

-- DECOMPILER ERROR at PC108: Confused about usage of register: R12 in 'UnsetPending'

CardMgr.GetCardLikeState = function(cardID, ...)
  -- function num : 0_29 , upvalues : _ENV, LikeCardList
  if cardID == nil then
    return false
  end
  for _,v in ipairs(LikeCardList) do
    if cardID == v then
      return true
    end
  end
  return false
end

-- DECOMPILER ERROR at PC111: Confused about usage of register: R12 in 'UnsetPending'

CardMgr.GetHotComment = function(...)
  -- function num : 0_30 , upvalues : hotComment
  return hotComment
end

-- DECOMPILER ERROR at PC114: Confused about usage of register: R12 in 'UnsetPending'

CardMgr.GetNewComment = function(...)
  -- function num : 0_31 , upvalues : newComment
  return newComment
end

-- DECOMPILER ERROR at PC117: Confused about usage of register: R12 in 'UnsetPending'

CardMgr.GetCommentPraise = function(chatId, ...)
  -- function num : 0_32 , upvalues : _ENV, cardPraiseList
  for _,v in ipairs(cardPraiseList) do
    if chatId == v then
      return true
    end
  end
  return false
end

local intelligenceEffectsPool = {}
-- DECOMPILER ERROR at PC121: Confused about usage of register: R13 in 'UnsetPending'

CardMgr.SetIntelligenceEffect = function(intelligence, uiMap, ...)
  -- function num : 0_33 , upvalues : _ENV, intelligenceEffectsPool
  local effectName = nil
  if intelligence == 1 then
    effectName = UIEffectEnum.UI_CARDQUALITY_COLOR_BLUE
  else
    if intelligence == 2 then
      effectName = UIEffectEnum.UI_CARDQUALITY_COLOR_PURPLE
    else
      if intelligence == 3 then
        effectName = UIEffectEnum.UI_CARDQUALITY_COLOR_GOLD
      end
    end
  end
  local effect = nil
  for index,value in ipairs(intelligenceEffectsPool) do
    (value.effect):SetActive(false)
    if value.intelligence == intelligence then
      effect = value.effect
    end
  end
  if (Util.CheckNullString)(effect) then
    local h, e = (LuaEffect.CreateEffectToObj)(effectName, false, uiMap, (Vector2(uiMap.width * 0.5, uiMap.height * 0.5)), nil, 1, false)
    effect = e
    ;
    (table.insert)(intelligenceEffectsPool, {intelligence = intelligence, effect = effect})
  else
    do
      effect:SetActive(true)
    end
  end
end

-- DECOMPILER ERROR at PC124: Confused about usage of register: R13 in 'UnsetPending'

CardMgr.ClearIntelligenceEffectsPool = function(...)
  -- function num : 0_34 , upvalues : intelligenceEffectsPool
  intelligenceEffectsPool = {}
end


