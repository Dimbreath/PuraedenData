-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_StageGrpByName")
Card_StageUpWindow = {}
local TEST_LOCKNUM = 10
local MAX_STAGE = (((TableData.gTable).BaseFixedData)[Const.MAX_CARDSTAGE]).int_value
local needItems = {}
local needItemPositionArr = {}
local headFrame, lockIcon, lockTxt, costIcon, costTxt, costInfoTxt, stageGrpCtrl = nil, nil, nil, nil, nil, nil, nil
local cardData = {}
local upNeedData = {}
local stageGrp = {}
local preUpStageData = {}
local upStageData = {}
local curStage = 0
local battleNumTxt = nil
local lostItemId = 0
local isGoldEnough = true
local isCardLevelEnable = true
local isMatEnough = true
local needMatNum = 0
local cardWindowCallBack, refreshAnim, TouchScreenBtn = nil, nil, nil
local clickEnable = true
-- DECOMPILER ERROR at PC32: Confused about usage of register: R27 in 'UnsetPending'

Card_StageUpWindow.Init = function(uis, ...)
  -- function num : 0_0 , upvalues : stageGrp, _ENV, TouchScreenBtn, needItems, headFrame, costIcon, costTxt, costInfoTxt, stageGrpCtrl, battleNumTxt
  stageGrp = (uis.PanelGrp).StageGrp
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (stageGrp.TitleTxt).text = (PUtil.get)(16)
  TouchScreenBtn = uis.TouchScreenBtn
  needItems = {}
  ;
  (table.insert)(needItems, stageGrp.ItemOneGrp)
  ;
  (table.insert)(needItems, stageGrp.ItemTwoGrp)
  ;
  (table.insert)(needItems, stageGrp.ItemThreeGrp)
  ;
  (table.insert)(needItems, stageGrp.ItemFourGrp)
  ;
  (table.insert)(needItems, stageGrp.ItemFiveGrp)
  ;
  (table.insert)(needItems, stageGrp.ItemSixGrp)
  headFrame = stageGrp.HeadFrame
  local rightBtn = stageGrp.ButtonTwoBtn
  ;
  (rightBtn.onClick):Add(Card_StageUpWindow.RightButtonClick)
  ;
  (rightBtn:GetChild("title")).text = (PUtil.get)(16)
  costIcon = stageGrp.GoldImage
  costTxt = stageGrp.NumberTxt
  costInfoTxt = stageGrp.StageUpWordTxt
  stageGrpCtrl = stageGrp.c1Ctr
  battleNumTxt = (uis.MessageGrp).BattleTwoTxt
  -- DECOMPILER ERROR at PC72: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((stageGrp.UpGrp).root).visible = false
  PlayUITrans(stageGrp.root, "refresh")
  ;
  (Card_StageUpWindow.RefreshWindow)()
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R27 in 'UnsetPending'

Card_StageUpWindow.RefreshWindow = function(...)
  -- function num : 0_1 , upvalues : cardData, isCardLevelEnable, TouchScreenBtn, _ENV, battleNumTxt, headFrame
  cardData = {}
  isCardLevelEnable = false
  TouchScreenBtn.visible = false
  local cardID = (CardData.ReturnCardID)()
  cardData = (CardData.GetCardData)(cardID)
  ;
  (Card_StageUpWindow.CheckLevelIsLocked)()
  battleNumTxt.text = cardData.fc
  local cData = {id = cardData.id, url = (CardMgr.GetHeadIconSquareUrl)(cardData), level = -1, stage = cardData.quality, star = cardData.star}
  if cardData.quality == 0 then
    cData.stage = -1
  end
  ;
  (Util.SetSquareCardInfo)(headFrame, cData, true)
  ;
  (Card_StageUpWindow.SetMaterialInfo)()
end

-- DECOMPILER ERROR at PC38: Confused about usage of register: R27 in 'UnsetPending'

Card_StageUpWindow.CheckLevelIsLocked = function(...)
  -- function num : 0_2 , upvalues : _ENV, TEST_LOCKNUM
  if TEST_LOCKNUM <= (ActorData.GetLevel)() then
    (Card_StageUpWindow.SetLockVisible)(false)
  else
    ;
    (Card_StageUpWindow.SetLockVisible)(true)
  end
end

-- DECOMPILER ERROR at PC41: Confused about usage of register: R27 in 'UnsetPending'

Card_StageUpWindow.SetLockVisible = function(isVisible, ...)
  -- function num : 0_3
end

-- DECOMPILER ERROR at PC44: Confused about usage of register: R27 in 'UnsetPending'

Card_StageUpWindow.CheckLevelIsMax = function(...)
  -- function num : 0_4 , upvalues : cardData, MAX_STAGE, _ENV
  if MAX_STAGE <= cardData.quality then
    (Card_StageUpWindow.SetMaxQualityCostHideOrShow)(false)
  else
    ;
    (Card_StageUpWindow.SetMaxQualityCostHideOrShow)(true)
  end
end

-- DECOMPILER ERROR at PC47: Confused about usage of register: R27 in 'UnsetPending'

Card_StageUpWindow.SetMaxQualityCostHideOrShow = function(isVisible, ...)
  -- function num : 0_5 , upvalues : costIcon, costTxt, costInfoTxt, stageGrp
  costIcon.visible = isVisible
  costTxt.visible = isVisible
  costInfoTxt.visible = isVisible
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (stageGrp.GoldBackImage).visible = isVisible
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (stageGrp.ButtonTwoBtn).visible = isVisible
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (stageGrp.MaxStageGrp).visible = not isVisible
end

-- DECOMPILER ERROR at PC50: Confused about usage of register: R27 in 'UnsetPending'

Card_StageUpWindow.SetMaterialInfo = function(...)
  -- function num : 0_6 , upvalues : isGoldEnough, isMatEnough, curStage, cardData, preUpStageData, _ENV, stageGrpCtrl, stageGrp, MAX_STAGE, needItems, upStageData
  isGoldEnough = false
  isMatEnough = true
  curStage = cardData.quality
  preUpStageData = {}
  preUpStageData = (CardMgr.GetBaseCardQualityData)(curStage, cardData.id)
  local levelShow = split(preUpStageData.level_show, ":")
  stageGrpCtrl.selectedIndex = tonumber(levelShow[1])
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (stageGrp.StageNumberTxt).text = curStage
  if MAX_STAGE <= curStage then
    for i,v in ipairs(needItems) do
      -- DECOMPILER ERROR at PC34: Confused about usage of register: R6 in 'UnsetPending'

      (v.root).visible = false
    end
    ;
    (Card_StageUpWindow.SetMaxQualityCostHideOrShow)(false)
    return 
  else
    ;
    (Card_StageUpWindow.SetMaxQualityCostHideOrShow)(true)
  end
  upStageData = {}
  upStageData = (CardMgr.GetBaseCardQualityData)(curStage + 1, cardData.id)
  for i,v in pairs(needItems) do
    -- DECOMPILER ERROR at PC61: Confused about usage of register: R6 in 'UnsetPending'

    (v.root).visible = false
  end
  if upStageData == nil then
    loge("表里面 没有这个字段       " .. cardData.id, curStage .. "     " .. cardData.id .. "0" .. curStage)
    return 
  end
  local needItemString = split(upStageData.need_goods, ",")
  local totalNeedNum = #needItemString
  local positionTable = split(CardStageUpMatPosition[totalNeedNum - 1], ";")
  for i = 1, totalNeedNum do
    -- DECOMPILER ERROR at PC99: Confused about usage of register: R8 in 'UnsetPending'

    if i > 1 then
      ((needItems[i - 1]).root).visible = true
    end
    ;
    (Card_StageUpWindow.SetMatDetail)(needItems[i - 1], needItemString[i], positionTable[i - 1], upStageData)
  end
end

-- DECOMPILER ERROR at PC53: Confused about usage of register: R27 in 'UnsetPending'

Card_StageUpWindow.SetMatDetail = function(obj, needData, pos, stageData, ...)
  -- function num : 0_7 , upvalues : _ENV, lostItemId, needMatNum, isMatEnough, costIcon, isGoldEnough, costTxt, costInfoTxt, cardData, isCardLevelEnable
  local splitData = split(needData, ":")
  local itemType = tonumber(splitData[1])
  local itemID = tonumber(splitData[2])
  local needNum = tonumber(splitData[3])
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R8 in 'UnsetPending'

  if itemType == 1 then
    (obj.c2Ctr).selectedIndex = (((TableData.gTable).BasePropData)[itemID]).quality - 1
    local iconImg = obj.IconLoader
    do
      local numberTxt = obj.StageTxt
      local ownNum = (ActorData.GetPropsByID)(itemID)
      numberTxt.text = needNum
      iconImg.url = (Util.GetUrlFromItemID)(itemID, itemType)
      local showText = ""
      numberTxt.UBBEnabled = true
      local tmpEnough = nil
      if needNum <= ownNum then
        showText = "[color=#3dffbd]" .. ownNum .. "[/color]" .. "[color=#ffffff]" .. "/" .. needNum .. "[/color]"
        tmpEnough = true
        -- DECOMPILER ERROR at PC51: Confused about usage of register: R13 in 'UnsetPending'

        ;
        (obj.PlusImage).visible = false
        -- DECOMPILER ERROR at PC53: Confused about usage of register: R13 in 'UnsetPending'

        ;
        (obj.c1Ctr).selectedIndex = 0
      else
        showText = "[color=#ffffff]" .. ownNum .. "[/color]" .. "[color=#ffffff]" .. "/" .. needNum .. "[/color]"
        tmpEnough = false
        lostItemId = itemID
        -- DECOMPILER ERROR at PC67: Confused about usage of register: R13 in 'UnsetPending'

        ;
        (obj.PlusImage).visible = isLockGetWay
        -- DECOMPILER ERROR at PC69: Confused about usage of register: R13 in 'UnsetPending'

        ;
        (obj.c1Ctr).selectedIndex = 1
        needMatNum = needNum
      end
      isMatEnough = not isMatEnough or tmpEnough
      numberTxt.text = showText
      local vec2 = split(pos, ",")
      local x = tonumber(vec2[1])
      local y = tonumber(vec2[2])
      ;
      (obj.root):SetPosition(x, y, 0)
      ;
      ((obj.root).onClick):Clear()
      ;
      ((obj.root).onClick):Add(function(...)
    -- function num : 0_7_0 , upvalues : tmpEnough, _ENV, itemID, needNum, ownNum
    if tmpEnough == false then
      if (FunctionControlMgr.GetFunctionState)(ControlID.GetWay_GetWay, true) == false then
        (Util.ShowGetWay)(itemID, nil, needNum, needNum - ownNum)
      end
    end
  end
)
    end
  else
    do
      if itemType == 2 then
        costIcon.visible = true
        local selfGold = (ActorData.GetAssetCount)(AssetType.GOLD)
        if needNum <= selfGold then
          isGoldEnough = true
          costTxt.visible = true
          costInfoTxt.visible = false
          costTxt.text = "[color=#3dffbd]" .. needNum .. "[/color]"
        else
          isGoldEnough = false
          costTxt.visible = true
          costInfoTxt.visible = false
          costTxt.text = "[color=#ff5f7b]" .. needNum .. "[/color]"
        end
        if stageData.card_lv_limit <= cardData.level then
          isCardLevelEnable = true
        else
          costTxt.visible = false
          costInfoTxt.visible = true
          costInfoTxt.text = "[color=#ff5f7b]" .. (PUtil.get)(43, stageData.card_lv_limit) .. "[/color]"
          costIcon.visible = false
          isCardLevelEnable = false
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC56: Confused about usage of register: R27 in 'UnsetPending'

Card_StageUpWindow.LeftButtonClick = function(...)
  -- function num : 0_8 , upvalues : _ENV, TEST_LOCKNUM, cardData, MAX_STAGE, isCardLevelEnable, isGoldEnough, isMatEnough, lostItemId, needMatNum
  if (ActorData.GetLevel)() < TEST_LOCKNUM then
    (MessageMgr.SendCenterTips)((PUtil.get)(66, TEST_LOCKNUM))
    return 
  end
  if MAX_STAGE <= cardData.quality then
    (MessageMgr.SendCenterTips)((PUtil.get)(40))
    return 
  end
  if isCardLevelEnable == false then
    (MessageMgr.SendCenterTips)((PUtil.get)(20000020))
    return 
  end
  if isGoldEnough == false then
    (MessageMgr.OpenAssetNotEnoughtWindow)(21100003)
    return 
  end
  if isMatEnough == false then
    (MessageMgr.OpenAssetNotEnoughtWindow)(lostItemId, nil, nil, needMatNum)
    return 
  end
  ;
  (CardService.ReqQualityUp)(cardData.id, 0)
end

-- DECOMPILER ERROR at PC59: Confused about usage of register: R27 in 'UnsetPending'

Card_StageUpWindow.RightButtonClick = function(...)
  -- function num : 0_9 , upvalues : cardData, MAX_STAGE, _ENV, isCardLevelEnable, isGoldEnough, isMatEnough, lostItemId, needMatNum
  if MAX_STAGE <= cardData.quality then
    (MessageMgr.SendCenterTips)((PUtil.get)(40))
    return 
  end
  if isCardLevelEnable == false then
    (MessageMgr.SendCenterTips)((PUtil.get)(20000020))
    return 
  end
  if isGoldEnough == false then
    (MessageMgr.OpenAssetNotEnoughtWindow)(21100003)
    return 
  end
  if isMatEnough == false then
    if (FunctionControlMgr.GetFunctionState)(ControlID.GetWay_GetWay, false) == false then
      (MessageMgr.SendCenterTips)((PUtil.get)(210))
    else
      local ownNum = (ActorData.GetPropsByID)(lostItemId)
      ;
      (Util.ShowGetWay)(lostItemId, nil, needMatNum, needMatNum - ownNum)
    end
    do
      do return  end
      ;
      (CardService.ReqQualityUp)(cardData.id, 1)
    end
  end
end

-- DECOMPILER ERROR at PC62: Confused about usage of register: R27 in 'UnsetPending'

Card_StageUpWindow.ResStageInfo = function(msg, func, ...)
  -- function num : 0_10 , upvalues : TouchScreenBtn, _ENV, cardData, preUpStageData, battleNumTxt, cardWindowCallBack, curStage
  TouchScreenBtn.visible = true
  ;
  (SimpleTimer.setTimeout)(0.8, function(...)
    -- function num : 0_10_0 , upvalues : _ENV, cardData, msg, preUpStageData, battleNumTxt, cardWindowCallBack, func
    OpenWindow("StageUpPropertyWindow", UILayer.HUD)
    local oldData = {}
    local fakeCardData = (Util.Copy)(cardData)
    fakeCardData.quality = msg.quality - 1
    ;
    (CardData.InitCardAttr)(oldData, fakeCardData)
    local data = {cardData = oldData, upStageData = cardData, preUpStageData = preUpStageData}
    UIMgr:SendWindowMessage((WinResConfig.StageUpPropertyWindow).name, (WindowMsgEnum.CardWindow).E_MSG_CARD_STAGEUPPROPERTY, data)
    battleNumTxt.text = cardData.fc
    if cardWindowCallBack == nil then
      cardWindowCallBack = func
    end
    cardWindowCallBack()
    ;
    (Card_StageUpWindow.RefreshWindow)()
  end
)
  local fashionTable = {}
  local skillTable = {}
  for i = curStage + 1, msg.quality do
    local preData = (CardMgr.GetBaseCardQualityData)(i - 1, cardData.id)
    local qData = (CardMgr.GetBaseCardQualityData)(i, cardData.id)
    if (split(preData.level_show, ":"))[1] ~= (split(qData.level_show, ":"))[1] then
      (Util.ShowGuideTips)(GuideTipsCheckPoint.BreakThrough, cardData.name, "[quality]" .. (split(qData.level_show, ":"))[1] .. ":" .. i .. "[/quality]" .. qData.name)
    end
    if qData.unlock_fashion_id > 0 then
      (table.insert)(fashionTable, qData.unlock_fashion_id)
    end
    if i == msg.quality then
      local skillNum = qData.skill_level_number - preUpStageData.skill_level_number
      for j = 1, skillNum do
        (table.insert)(skillTable, cardData["passiveSkillId" .. tostring(preUpStageData.skill_level_number + j)])
      end
    end
  end
  ;
  (CardData.SaveHowManySkillGetFromQ)(skillTable)
  ;
  (CardData.SaveHowManyFashionGetFromQ)(fashionTable)
  ;
  (Card_StageUpWindow.ShowLevelUpEffects)()
end

-- DECOMPILER ERROR at PC65: Confused about usage of register: R27 in 'UnsetPending'

Card_StageUpWindow.GetBaseCardQualityData = function(quality, ...)
  -- function num : 0_11 , upvalues : cardData, _ENV
  local tableID = nil
  if quality > 9 then
    tableID = cardData.id .. quality
  else
    tableID = cardData.id .. "0" .. quality
  end
  return ((TableData.gTable).BaseCardQualityUpData)[tonumber(tableID)]
end

local lvlUpTimer = nil
-- DECOMPILER ERROR at PC69: Confused about usage of register: R28 in 'UnsetPending'

Card_StageUpWindow.TimerForShowItemWithLifeTime = function(obj, dur, ...)
  -- function num : 0_12 , upvalues : lvlUpTimer, _ENV
  if lvlUpTimer ~= nil then
    lvlUpTimer:stop()
    lvlUpTimer = nil
  end
  obj.visible = true
  lvlUpTimer = (SimpleTimer.setTimeout)(dur, function(...)
    -- function num : 0_12_0 , upvalues : obj
    if obj then
      obj.visible = false
    end
  end
)
end

-- DECOMPILER ERROR at PC72: Confused about usage of register: R28 in 'UnsetPending'

Card_StageUpWindow.ShowLevelUpEffects = function(...)
  -- function num : 0_13 , upvalues : _ENV, stageGrp, headFrame
  (Card_StageUpWindow.TimerForShowItemWithLifeTime)((stageGrp.UpGrp).root, 2)
  ;
  (Card_StageUpWindow.UpSellEffect)(headFrame)
  ;
  (Card_StageUpWindow.UpSellEffect_GradeTitle)(stageGrp.StageEffectGrp)
  ;
  (Card_StageUpWindow.UpsellLine)(headFrame)
  ;
  (Card_StageUpWindow.UpsellSmall)()
  ;
  (LuaSound.PlaySound)(LuaSound.CARD_UP_FLASH, SoundBank.OTHER)
end

-- DECOMPILER ERROR at PC75: Confused about usage of register: R28 in 'UnsetPending'

Card_StageUpWindow.OnClose = function(...)
  -- function num : 0_14 , upvalues : lvlUpTimer, needItems, headFrame, lockIcon, lockTxt, costIcon, costTxt, costInfoTxt, stageGrpCtrl, stageGrp, battleNumTxt, cardWindowCallBack, TouchScreenBtn, needMatNum, clickEnable
  if lvlUpTimer ~= nil then
    lvlUpTimer:stop()
    lvlUpTimer = nil
  end
  needItems = nil
  headFrame = nil
  lockIcon = nil
  lockTxt = nil
  costIcon = nil
  costTxt = nil
  costInfoTxt = nil
  stageGrpCtrl = nil
  stageGrp = nil
  battleNumTxt = nil
  cardWindowCallBack = nil
  TouchScreenBtn = nil
  needMatNum = 0
  clickEnable = true
end

-- DECOMPILER ERROR at PC78: Confused about usage of register: R28 in 'UnsetPending'

Card_StageUpWindow.UpSellEffect = function(uiMap, ...)
  -- function num : 0_15 , upvalues : _ENV
  local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_UPSELL, true, true)
  holder:SetXY((uiMap.root).width / 2, (uiMap.root).height / 2)
  ;
  (uiMap.root):AddChild(holder)
end

-- DECOMPILER ERROR at PC81: Confused about usage of register: R28 in 'UnsetPending'

Card_StageUpWindow.UpSellEffect_GradeTitle = function(uiMap, ...)
  -- function num : 0_16 , upvalues : _ENV
  local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_UPSELL_GRADETITLE, true, true)
  holder:SetXY((uiMap.root).width / 2, (uiMap.root).height / 2)
  print("Card_StageUpWindow.UpSellEffect_GradeTitle(uiMap)", uiMap, holder)
  ;
  (uiMap.root):AddChild(holder)
end

-- DECOMPILER ERROR at PC84: Confused about usage of register: R28 in 'UnsetPending'

Card_StageUpWindow.UpsellLine = function(uiMap, ...)
  -- function num : 0_17 , upvalues : _ENV
  local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_UPSELL, true, true)
  holder:SetXY((uiMap.root).width / 2, (uiMap.root).height / 2)
  ;
  (uiMap.root):AddChild(holder)
end

-- DECOMPILER ERROR at PC87: Confused about usage of register: R28 in 'UnsetPending'

Card_StageUpWindow.UpsellSmall = function(...)
  -- function num : 0_18 , upvalues : _ENV, needItems
  for i,v in pairs(needItems) do
    if (v.root).visible == true then
      local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_TALENT_POINT_UP, true, true)
      holder:SetXY((v.root).width / 2, (v.root).height / 2)
      ;
      (v.root):AddChild(holder)
    end
  end
end


