-- params : ...
-- function num : 0 , upvalues : _ENV
Card_LevelUpWindow = {}
local propType = 1
local TEST_LOCKNUM = 10
local lockIcon, lockTxt = nil, nil
local SpeedX = 0
local TotalNum = 0
local SpeedFactor = 1
local TotalCostNum = 0
local lvlNeedItems = {}
local uis, levelTxt, expBar, characType = nil, nil, nil, nil
local MAX_LEVEL = (((TableData.gTable).BaseFixedData)[Const.MAX_CARDLEVEL]).int_value
local battleNumTxt = nil
local fakeCardData = {}
local canLvlUpNumTotal = 0
local lvlGrp, expTxt = nil, nil
local isExpFull = false
local needItemsObj = {}
local totalFrame = 5
local frame = 0
local totalFakeCost = 0
local expPool = 0
local scrollTimer = nil
local fakeMax = false
local isFakeplaying = false
local severData = {}
local cardWindowCallBack = nil
local isLongPress = false
local refreshAnim = nil
local tips1IsTip = false
local tips2IsTip = false
local tips3IsTip = false
local longPressMatEffectTimer = nil
local selectedIndex = 0
local isEnableSingleClick = true
local enableEffect = true
local enableEffectTimer = nil
-- DECOMPILER ERROR at PC45: Confused about usage of register: R40 in 'UnsetPending'

Card_LevelUpWindow.Init = function(_uis, ...)
  -- function num : 0_0 , upvalues : uis, lvlNeedItems, lvlGrp, _ENV, propType, needItemsObj, canLvlUpNumTotal, battleNumTxt, expTxt
  uis = _uis
  lvlNeedItems = {}
  lvlGrp = (uis.PanelGrp).LevelGrp
  for k,v in pairs((TableData.gTable).BasePropData) do
    if v.type == propType then
      (table.insert)(lvlNeedItems, v)
    end
  end
  needItemsObj = {lvlGrp.ItemOneGrp, lvlGrp.ItemTwoGrp, lvlGrp.ItemThreeGrp, lvlGrp.ItemFourGrp}
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (lvlGrp.TitleTxt).text = (PUtil.get)(21)
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (lvlGrp.TipsTxt).text = (PUtil.get)(203)
  canLvlUpNumTotal = 0
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((lvlGrp.UpGrp).root).visible = false
  battleNumTxt = (uis.MessageGrp).BattleTwoTxt
  expTxt = lvlGrp.ExpTxt
  PlayUITrans(lvlGrp.root, "refresh")
  ;
  (Card_LevelUpWindow.LevelUpGroupRefresh)(true)
end

-- DECOMPILER ERROR at PC48: Confused about usage of register: R40 in 'UnsetPending'

Card_LevelUpWindow.LevelUpGroupRefresh = function(isInit, ...)
  -- function num : 0_1 , upvalues : scrollTimer, lvlGrp, uis, levelTxt, expBar, fakeCardData, _ENV, characType, isExpFull, MAX_LEVEL, expTxt, battleNumTxt, enableEffect
  if scrollTimer ~= nil then
    scrollTimer:Comp()
    scrollTimer = nil
  end
  lvlGrp = (uis.PanelGrp).LevelGrp
  levelTxt = lvlGrp.LevelTxt
  expBar = lvlGrp.ExpProgressBar
  fakeCardData = {}
  local cardID = (CardData.ReturnCardID)()
  fakeCardData = (Util.Copy)((CardData.GetCardData)(cardID))
  local cData = {url = (CardMgr.GetHeadIconSquareUrl)(fakeCardData), level = -1, stage = -1, star = fakeCardData.star, id = fakeCardData.id}
  ;
  (Util.SetSquareCardInfo)(lvlGrp.HeadFrame, cData, true)
  local curExp = (math.floor)(fakeCardData.exp)
  local needExp = 0
  characType = fakeCardData.grow_type
  local characLvl = fakeCardData.level
  local maxNeedExp = 0
  for i,v in pairs((TableData.gTable).BaseCardLevelUpData) do
    if v.type == characType and v.level == characLvl then
      needExp = v.next_exp
      break
    end
  end
  do
    local percent = nil
    percent = curExp / needExp * 100
    if needExp <= curExp then
      isExpFull = true
    else
      isExpFull = false
    end
    expBar.value = percent
    levelTxt.text = fakeCardData.level
    ;
    (Card_LevelUpWindow.CheckLevelIsLocked)()
    if MAX_LEVEL <= fakeCardData.level and isExpFull == true then
      expTxt.text = (PUtil.get)(80)
    else
      expTxt.text = curExp .. "/" .. needExp
    end
    battleNumTxt.text = fakeCardData.fc
    if isInit == true then
      (Card_LevelUpWindow.UpdateItem)()
      enableEffect = true
    end
  end
end

-- DECOMPILER ERROR at PC51: Confused about usage of register: R40 in 'UnsetPending'

Card_LevelUpWindow.UpdateItem = function(...)
  -- function num : 0_2 , upvalues : lvlGrp, _ENV, lvlNeedItems, needItemsObj, frame, totalFrame, isExpFull, isLongPress, fakeCardData, MAX_LEVEL, expPool, selectedIndex, scrollTimer, isFakeplaying, TotalNum, TotalCostNum, fakeMax, tips1IsTip, tips2IsTip, tips3IsTip, totalFakeCost, longPressMatEffectTimer
  local itemExpText = {(lvlGrp.ItemOneGrp).EXPNumberTxt, (lvlGrp.ItemTwoGrp).EXPNumberTxt, (lvlGrp.ItemThreeGrp).EXPNumberTxt, (lvlGrp.ItemFourGrp).EXPNumberTxt}
  local curItems = {}
  for i = 1, 4 do
    do
      local itemID = 21110000 + i
      ;
      (table.insert)(curItems, (ActorData.GetPropsIDAndNum)(itemID))
    end
  end
  for i = 1, #lvlNeedItems do
    local itemInfoObj = needItemsObj[i]
    local icon = itemInfoObj.IconLoader
    local plusImage = itemInfoObj.PlusImage
    local isLockGetWay = (FunctionControlMgr.GetFunctionState)(ControlID.GetWay_GetWay, false)
    local numberTxt = itemInfoObj.NumberTxt
    local itemExcelData = ((TableData.gTable).BasePropData)[(curItems[i]).id]
    local url = (Util.GetItemUrl)(itemExcelData.icon)
    if icon then
      icon.url = url
    end
    if numberTxt then
      if (curItems[i]).count <= 0 then
        numberTxt.text = "[color=#ff5656]" .. "0" .. "[/color]"
        numberTxt.visible = false
        icon.color = ((CS.UnityEngine).Color).gray
        plusImage.visible = isLockGetWay
      else
        numberTxt.visible = true
        icon.color = ((CS.UnityEngine).Color).white
        numberTxt.text = tostring((curItems[i]).count)
        plusImage.visible = false
      end
    end
    -- DECOMPILER ERROR at PC91: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (itemExpText[i]).text = (PUtil.get)(23) .. itemExcelData.effect_value
    ;
    (icon.onTouchBegin):Clear()
    ;
    (icon.onClick):Clear()
    ;
    (LuaSound.SetClickSound)(icon, LuaSound.CARD_USE_EXP_ITEM)
    ;
    (icon.onClick):Add(function(...)
    -- function num : 0_2_0 , upvalues : frame, totalFrame, _ENV, isExpFull, isLongPress, curItems, i, isLockGetWay, fakeCardData, MAX_LEVEL, expPool, selectedIndex
    if frame < totalFrame then
      print("这个是单次点击", frame, isExpFull)
      if isLongPress == true then
        isLongPress = false
        return 
      end
      if (curItems[i]).count <= 0 or isLockGetWay then
        (Util.ShowGetWay)((curItems[i]).id)
      end
      do return  end
      if MAX_LEVEL <= fakeCardData.level then
        if isExpFull == false then
          (MessageMgr.SendCenterTips)((PUtil.get)(45))
          do return  end
          if (ActorData.GetLevel)() <= fakeCardData.level then
            if isExpFull == false then
              (MessageMgr.SendCenterTips)((PUtil.get)(46))
              do return  end
              if isExpFull == true then
                return 
              end
              expPool = 0
              selectedIndex = i
              ;
              (Card_LevelUpWindow.ReqUsePropFunc)(fakeCardData.id, (curItems[i]).id, 1)
            end
          end
        end
      end
    end
  end
)
    local longPress = (FairyGUI.LongPressGesture)(icon)
    longPress:Enable(true)
    longPress.trigger = 0.3
    longPress.interval = 0.1
    longPress:AddEventListener("onLongPressBegin", function(...)
    -- function num : 0_2_1 , upvalues : _ENV, scrollTimer, isFakeplaying, isLongPress, TotalNum, curItems, i, TotalCostNum, expPool, frame, fakeMax, tips1IsTip, tips2IsTip, tips3IsTip, selectedIndex, fakeCardData, itemExcelData, totalFakeCost, longPressMatEffectTimer
    (Card_LevelUpWindow.StopPropEffects)()
    if scrollTimer ~= nil then
      scrollTimer:Comp()
      scrollTimer = nil
    end
    isFakeplaying = true
    isLongPress = true
    TotalNum = (curItems[i]).count
    TotalCostNum = 0
    expPool = 0
    frame = 0
    fakeMax = false
    tips1IsTip = false
    tips2IsTip = false
    tips3IsTip = false
    selectedIndex = i
    local totalExp = 0
    for i = fakeCardData.level, (ActorData.GetLevel)() do
      local exp = ((CardData.GetCardLevelUpConfig)(fakeCardData.grow_type, i)).next_exp
      totalExp = totalExp + exp
    end
    totalExp = totalExp - fakeCardData.exp
    local singleExp = itemExcelData.effect_value
    totalFakeCost = (math.ceil)((totalExp) / singleExp)
    if TotalNum < totalFakeCost then
      totalFakeCost = TotalNum
    end
    longPressMatEffectTimer = (SimpleTimer.new)(0.18, -1, function(...)
      -- function num : 0_2_1_0 , upvalues : _ENV
      (Card_LevelUpWindow.UsePropEffects)()
    end
)
    longPressMatEffectTimer:start()
  end
)
    longPress:AddEventListener("onLongPressAction", function(...)
    -- function num : 0_2_2 , upvalues : TotalNum, tips1IsTip, isLockGetWay, _ENV, numberTxt, icon, itemInfoObj, fakeCardData, MAX_LEVEL, isExpFull, tips2IsTip, tips3IsTip, i, itemExcelData
    if TotalNum <= 0 then
      if tips1IsTip == false then
        if isLockGetWay then
          (MessageMgr.SendCenterTips)((PUtil.get)(44))
        end
        numberTxt.visible = false
        icon.color = ((CS.UnityEngine).Color).gray
        -- DECOMPILER ERROR at PC24: Confused about usage of register: R0 in 'UnsetPending'

        ;
        (itemInfoObj.PlusImage).visible = isLockGetWay
        tips1IsTip = true
        ;
        (Card_LevelUpWindow.StopPropEffects)()
      end
      return 
    end
    if MAX_LEVEL <= fakeCardData.level then
      if isExpFull ~= false or tips2IsTip == false then
        (MessageMgr.SendCenterTips)((PUtil.get)(45))
        tips2IsTip = true
        ;
        (Card_LevelUpWindow.StopPropEffects)()
      end
      return 
    end
    if (ActorData.GetLevel)() <= fakeCardData.level then
      if isExpFull ~= false or tips3IsTip == false then
        (MessageMgr.SendCenterTips)((PUtil.get)(46))
        tips3IsTip = true
        ;
        (Card_LevelUpWindow.StopPropEffects)()
      end
      return 
    end
    ;
    (LuaSound.PlaySound)(LuaSound.CARD_USE_EXP_ITEM, SoundBank.OTHER)
    ;
    (Card_LevelUpWindow.PropsOnUpdate)(numberTxt, i, itemExcelData.effect_value)
  end
)
    longPress:AddEventListener("onLongPressEnd", function(...)
    -- function num : 0_2_3 , upvalues : _ENV, curItems, i
    (Card_LevelUpWindow.PropsOnEnd)((curItems[i]).id)
  end
)
  end
end

-- DECOMPILER ERROR at PC54: Confused about usage of register: R40 in 'UnsetPending'

Card_LevelUpWindow.CheckIsFullExp = function(...)
  -- function num : 0_3
end

-- DECOMPILER ERROR at PC57: Confused about usage of register: R40 in 'UnsetPending'

Card_LevelUpWindow.CheckLevelIsLocked = function(...)
  -- function num : 0_4 , upvalues : _ENV, TEST_LOCKNUM
  if TEST_LOCKNUM <= (ActorData.GetLevel)() then
    (Card_LevelUpWindow.SetLockVisible)(false)
  else
    ;
    (Card_LevelUpWindow.SetLockVisible)(true)
  end
end

-- DECOMPILER ERROR at PC60: Confused about usage of register: R40 in 'UnsetPending'

Card_LevelUpWindow.SetLockVisible = function(isVisible, ...)
  -- function num : 0_5
end

local perExp = 0
-- DECOMPILER ERROR at PC64: Confused about usage of register: R41 in 'UnsetPending'

Card_LevelUpWindow.ScrollOnBegin = function(...)
  -- function num : 0_6 , upvalues : _ENV, fakeCardData
  local dealTimer = (SimpleTimer.new)(0.01, -1, function(...)
    -- function num : 0_6_0 , upvalues : _ENV
    (Card_LevelUpWindow.ScrollOnUpdate)()
  end
, Card_LevelUpWindow.ScrollShowCallBack)
  local cType = fakeCardData.grow_type
  local curLvl = fakeCardData.level
  local curExp = fakeCardData.exp
  local nextExp = ((CardData.GetCardLevelUpConfig)(cType, curLvl)).next_exp
  dealTimer:start()
  return dealTimer
end

-- DECOMPILER ERROR at PC67: Confused about usage of register: R41 in 'UnsetPending'

Card_LevelUpWindow.ScrollOnUpdate = function(...)
  -- function num : 0_7 , upvalues : expPool, scrollTimer, fakeCardData, _ENV, perExp
  if expPool <= 0 then
    scrollTimer:Comp()
    scrollTimer = nil
    return 
  end
  local cType = fakeCardData.grow_type
  local curLvl = fakeCardData.level
  local curExp = fakeCardData.exp
  local nextExp = ((CardData.GetCardLevelUpConfig)(cType, curLvl)).next_exp
  if perExp == 0 then
    perExp = expPool / 30
  end
  if perExp < expPool / 30 then
    perExp = expPool / 30
  end
  local levelUpExp = nextExp - curExp
  if levelUpExp < perExp then
    if curLvl < (ActorData.GetLevel)() then
      perExp = levelUpExp
    else
      perExp = expPool
    end
  end
  if expPool - perExp <= 0 then
    perExp = expPool
  end
  expPool = expPool - perExp
  ;
  (Card_LevelUpWindow.CheckForPercentAndLvlUp)(perExp)
end

-- DECOMPILER ERROR at PC70: Confused about usage of register: R41 in 'UnsetPending'

Card_LevelUpWindow.PropsOnUpdate = function(numberTxt, iType, expPerItem, ...)
  -- function num : 0_8 , upvalues : totalFakeCost, SpeedX, SpeedFactor, _ENV, TotalCostNum, TotalNum
  if totalFakeCost <= 0 then
    return 
  end
  local curCost = 0
  SpeedX = SpeedX + SpeedFactor
  if SpeedX < 400 then
    SpeedX = (math.floor)(SpeedX + 0.2)
  end
  curCost = SpeedX
  if totalFakeCost - curCost <= 0 then
    curCost = totalFakeCost
  end
  totalFakeCost = totalFakeCost - curCost
  TotalCostNum = TotalCostNum + curCost
  ;
  (Card_LevelUpWindow.AddItemExpToPool)(expPerItem, curCost)
  TotalNum = TotalNum - curCost
  numberTxt.text = TotalNum
end

-- DECOMPILER ERROR at PC73: Confused about usage of register: R41 in 'UnsetPending'

Card_LevelUpWindow.PropsOnEnd = function(id, ...)
  -- function num : 0_9 , upvalues : _ENV, SpeedX, TotalNum, TotalCostNum, totalFakeCost, isExpFull, fakeCardData, canLvlUpNumTotal
  (Card_LevelUpWindow.StopPropEffects)()
  SpeedX = 1
  TotalNum = 0
  local totalCost = TotalCostNum
  if totalFakeCost <= totalCost then
    isExpFull = true
  end
  if totalCost > 0 then
    (Card_LevelUpWindow.ReqUsePropFunc)(fakeCardData.id, id, totalCost)
  end
  canLvlUpNumTotal = 0
end

-- DECOMPILER ERROR at PC76: Confused about usage of register: R41 in 'UnsetPending'

Card_LevelUpWindow.ReqUsePropFunc = function(cId, pID, num, ...)
  -- function num : 0_10 , upvalues : _ENV
  local propid = (ActorData.GetItemObjectIndex)(pID)
  ;
  (CardService.ReqUseProp)(cId, propid, num, UsePropScene.CardLevelUp)
end

-- DECOMPILER ERROR at PC79: Confused about usage of register: R41 in 'UnsetPending'

Card_LevelUpWindow.LvlUpLeftButtonClick = function(...)
  -- function num : 0_11 , upvalues : fakeCardData, MAX_LEVEL, isExpFull, _ENV
  if MAX_LEVEL <= fakeCardData.level then
    if isExpFull == false then
      (CardService.ReqLevelUp)(fakeCardData.id, 1)
    else
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(45))
      return 
    end
  else
    if (ActorData.GetLevel)() <= fakeCardData.level then
      if isExpFull == false then
        (CardService.ReqLevelUp)(fakeCardData.id, 1)
      else
        ;
        (MessageMgr.SendCenterTips)((PUtil.get)(46))
        return 
      end
    else
      ;
      (CardService.ReqLevelUp)(fakeCardData.id, 1)
    end
  end
end

-- DECOMPILER ERROR at PC82: Confused about usage of register: R41 in 'UnsetPending'

Card_LevelUpWindow.LvlUpRightButtonClick = function(...)
  -- function num : 0_12 , upvalues : _ENV, fakeCardData, MAX_LEVEL, isExpFull
  local playerLvl = (ActorData.GetLevel)()
  if MAX_LEVEL <= fakeCardData.level then
    if isExpFull == false then
      (CardService.ReqLevelUp)(fakeCardData.id, 1)
    else
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(45))
      return 
    end
  else
    if playerLvl <= fakeCardData.level then
      if isExpFull == false then
        (CardService.ReqLevelUp)(fakeCardData.id, 1)
      else
        ;
        (MessageMgr.SendCenterTips)((PUtil.get)(46))
        return 
      end
    else
      ;
      (CardService.ReqLevelUp)(fakeCardData.id, 1000)
    end
  end
end

-- DECOMPILER ERROR at PC85: Confused about usage of register: R41 in 'UnsetPending'

Card_LevelUpWindow.AddItemExpToPool = function(expPerItem, num, ...)
  -- function num : 0_13 , upvalues : _ENV
  local overExp = expPerItem * num
  ;
  (Card_LevelUpWindow.AddExpToPool)(overExp)
end

-- DECOMPILER ERROR at PC88: Confused about usage of register: R41 in 'UnsetPending'

Card_LevelUpWindow.CheckForPercentAndLvlUp = function(exp, ...)
  -- function num : 0_14 , upvalues : fakeCardData, _ENV, isExpFull, levelTxt, battleNumTxt, lvlGrp, expTxt, expBar
  local overExp = exp
  local fakeOverExp = 0
  local cType = fakeCardData.grow_type
  local curLvl = fakeCardData.level
  local curExp = fakeCardData.exp
  local totalCostExp = overExp + curExp
  fakeOverExp = totalCostExp
  local nextExp = ((CardData.GetCardLevelUpConfig)(cType, curLvl)).next_exp
  local aimBarValue = 0
  if nextExp <= fakeOverExp then
    if curLvl + 1 <= (ActorData.GetLevel)() then
      fakeCardData.level = fakeCardData.level + 1
      fakeCardData.exp = fakeOverExp - nextExp
      nextExp = ((CardData.GetCardLevelUpConfig)(cType, curLvl + 1)).next_exp
      isExpFull = false
      ;
      (Card_LevelUpWindow.ShowLevelUpEffects)()
    else
      fakeCardData.exp = fakeOverExp
      isExpFull = true
    end
    local finalLevel = fakeCardData.level
    local maxLevel = (ActorData.GetLevel)()
    if finalLevel <= maxLevel then
      fakeCardData.level = finalLevel
      levelTxt.text = finalLevel
    else
      fakeCardData.level = maxLevel
      levelTxt.text = maxLevel
    end
    local changedData = {}
    ;
    (CardData.InitCardAttr)(changedData, fakeCardData)
    battleNumTxt.text = changedData.fc
    fakeCardData.fc = changedData.fc
    local cData = {url = (CardMgr.GetHeadIconSquareUrl)(fakeCardData), level = -1, stage = -1, star = fakeCardData.star, id = fakeCardData.id}
    ;
    (Util.SetSquareCardInfo)(lvlGrp.HeadFrame, cData, true)
  else
    do
      fakeCardData.exp = fakeOverExp
      aimBarValue = fakeCardData.exp / nextExp * 100
      expTxt.text = (math.floor)(fakeCardData.exp) .. "/" .. nextExp
      expBar.value = aimBarValue
    end
  end
end

-- DECOMPILER ERROR at PC91: Confused about usage of register: R41 in 'UnsetPending'

Card_LevelUpWindow.ResLevelInfo = function(msg, func, ...)
  -- function num : 0_15 , upvalues : severData, isFakeplaying, scrollTimer, _ENV, cardWindowCallBack
  severData = {}
  severData = msg
  if isFakeplaying == true then
    isFakeplaying = false
    if scrollTimer and scrollTimer:IsRunIng() then
      (Card_LevelUpWindow.ScrollShowCallBack)()
      print("往经验池添加经验 添加", msg.totalExp)
      ;
      (Card_LevelUpWindow.AddExpToPool)(msg.totalExp)
      if cardWindowCallBack ~= nil then
        cardWindowCallBack = func
      end
    end
  end
end

-- DECOMPILER ERROR at PC94: Confused about usage of register: R41 in 'UnsetPending'

Card_LevelUpWindow.ResGoodChange = function(func, ...)
  -- function num : 0_16 , upvalues : _ENV, cardWindowCallBack
  (Card_LevelUpWindow.UpdateItem)()
  if cardWindowCallBack ~= nil then
    cardWindowCallBack = func
  end
  ;
  (Card_LevelUpWindow.UsePropEffects)()
end

-- DECOMPILER ERROR at PC97: Confused about usage of register: R41 in 'UnsetPending'

Card_LevelUpWindow.ScrollShowCallBack = function(...)
  -- function num : 0_17 , upvalues : severData, _ENV, fakeCardData
  if severData and severData.id then
    (CardData.SetCardDataExp)(severData.id, severData.exp)
    ;
    (CardData.SetCardDataLevel)(severData.id, severData.level)
    local changedData = {}
    ;
    (CardData.InitCardAttr)(changedData, fakeCardData)
    ;
    (CardData.SetCardDataFc)(severData.id, changedData.fc)
    UIMgr:SendWindowMessage("CardWindow", (WindowMsgEnum.CardWindow).E_MSG_CARD_REFRESHCARDLISTBUTTOM, {})
    ;
    (Card_LevelUpWindow.LevelUpGroupRefresh)(false)
    severData = {}
  end
end

local lvlUpTimer = nil
-- DECOMPILER ERROR at PC101: Confused about usage of register: R42 in 'UnsetPending'

Card_LevelUpWindow.TimerForShowItemWithLifeTime = function(obj, dur, ...)
  -- function num : 0_18 , upvalues : lvlUpTimer, _ENV
  if lvlUpTimer ~= nil then
    lvlUpTimer:stop()
    lvlUpTimer = nil
  end
  obj.visible = true
  lvlUpTimer = (SimpleTimer.setTimeout)(dur, function(...)
    -- function num : 0_18_0 , upvalues : obj
    if obj then
      obj.visible = false
    end
  end
)
end

-- DECOMPILER ERROR at PC104: Confused about usage of register: R42 in 'UnsetPending'

Card_LevelUpWindow.ShowLevelUpEffects = function(...)
  -- function num : 0_19 , upvalues : _ENV, lvlGrp, expBar
  (Card_LevelUpWindow.TimerForShowItemWithLifeTime)((lvlGrp.UpGrp).root, 2)
  ;
  (Card_LevelUpWindow.PlayEffects)((lvlGrp.HeadFrame).LevelEffect)
  ;
  (Card_LevelUpWindow.PlayEffectsSlider)(expBar)
  ;
  (LuaSound.PlaySound)(LuaSound.CARD_UP_FLASH, SoundBank.OTHER)
  UIMgr:SendWindowMessage("CardWindow", (WindowMsgEnum.CardWindow).E_MSG_CARD_LEVELUP_TRUE, {})
end

-- DECOMPILER ERROR at PC107: Confused about usage of register: R42 in 'UnsetPending'

Card_LevelUpWindow.OnClose = function(...)
  -- function num : 0_20 , upvalues : lvlUpTimer, lockIcon, lockTxt, lvlNeedItems, uis, levelTxt, expBar, battleNumTxt, lvlGrp, expTxt, needItemsObj, cardWindowCallBack, scrollTimer, enableEffectTimer, enableEffect
  if lvlUpTimer ~= nil then
    lvlUpTimer:stop()
    lvlUpTimer = nil
  end
  lockIcon = nil
  lockTxt = nil
  lvlNeedItems = {}
  uis = nil
  levelTxt = nil
  expBar = nil
  battleNumTxt = nil
  lvlGrp = nil
  expTxt = nil
  needItemsObj = {}
  cardWindowCallBack = nil
  if scrollTimer ~= nil then
    scrollTimer:stop()
    scrollTimer = nil
  end
  if enableEffectTimer ~= nil then
    enableEffectTimer:stop()
    enableEffectTimer = nil
  end
  enableEffect = true
end

-- DECOMPILER ERROR at PC110: Confused about usage of register: R42 in 'UnsetPending'

Card_LevelUpWindow.AddExpToPool = function(exp, ...)
  -- function num : 0_21 , upvalues : perExp, expPool, scrollTimer, _ENV
  perExp = 0
  expPool = expPool + exp
  if scrollTimer == nil then
    scrollTimer = (Card_LevelUpWindow.ScrollOnBegin)()
  end
end

-- DECOMPILER ERROR at PC113: Confused about usage of register: R42 in 'UnsetPending'

Card_LevelUpWindow.SubExpInPool = function(exp, ...)
  -- function num : 0_22 , upvalues : expPool
  local succSubExp = 0
  if expPool - exp > 0 then
    succSubExp = exp
  else
    succSubExp = expPool
  end
  expPool = expPool - succSubExp
  return succSubExp
end

-- DECOMPILER ERROR at PC116: Confused about usage of register: R42 in 'UnsetPending'

Card_LevelUpWindow.PlayEffects = function(uiMap, ...)
  -- function num : 0_23 , upvalues : enableEffect, _ENV, enableEffectTimer
  if enableEffect then
    local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_UPGRADE, true, true)
    holder:SetXY((uiMap.root).width / 2, (uiMap.root).height / 2)
    ;
    (uiMap.root):AddChild(holder)
    enableEffect = false
    enableEffectTimer = (SimpleTimer.setTimeout)(0.4, function(...)
    -- function num : 0_23_0 , upvalues : enableEffect
    enableEffect = true
  end
)
  end
end

-- DECOMPILER ERROR at PC119: Confused about usage of register: R42 in 'UnsetPending'

Card_LevelUpWindow.PlayEffectsSlider = function(uiMap, ...)
  -- function num : 0_24 , upvalues : _ENV
  local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_UPGRADE_BLOODSTRIP, true, true)
  holder:SetXY(uiMap.width / 2, uiMap.height / 2)
  uiMap:AddChild(holder)
end

-- DECOMPILER ERROR at PC122: Confused about usage of register: R42 in 'UnsetPending'

Card_LevelUpWindow.UsePropEffects = function(...)
  -- function num : 0_25 , upvalues : selectedIndex, needItemsObj, _ENV
  if selectedIndex == 0 then
    return 
  end
  local uiMap = needItemsObj[selectedIndex]
  local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_UPSELL_SMALL, true, true)
  holder:SetXY((uiMap.root).width / 2, (uiMap.root).height / 2)
  ;
  (uiMap.root):AddChild(holder)
  selectedIndex = 0
end

-- DECOMPILER ERROR at PC125: Confused about usage of register: R42 in 'UnsetPending'

Card_LevelUpWindow.StopPropEffects = function(...)
  -- function num : 0_26 , upvalues : longPressMatEffectTimer
  if longPressMatEffectTimer ~= nil then
    longPressMatEffectTimer:stop()
    longPressMatEffectTimer = nil
  end
end


