-- params : ...
-- function num : 0 , upvalues : _ENV
require("Shop_ShopWindowByName")
require("Shop_ShopItemByName")
local ShopWindow = {}
local uis, contentPane, mTime, ShopGridData = nil, nil, nil, nil
local isSendMsg = false
local currentType = -1
local isBackOpen = false
local freeItem = nil
ShopWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, uis, currentType, isBackOpen, ShopWindow, isSendMsg
  bridgeObj:SetView((WinResConfig.ShopWindow).package, (WinResConfig.ShopWindow).comName)
  contentPane = bridgeObj.contentPane
  uis = GetShop_ShopWindowUis(contentPane)
  local mType = nil
  if (bridgeObj.argTable)[1] then
    mType = (bridgeObj.argTable)[1]
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

    if mType == ShopType.Recharge then
      (uis.c1Ctr).selectedIndex = 0
    else
      -- DECOMPILER ERROR at PC33: Confused about usage of register: R2 in 'UnsetPending'

      if mType == ShopType.GiftBuy then
        (uis.c1Ctr).selectedIndex = 1
      end
    end
    currentType = mType
  end
  isBackOpen = bridgeObj.OpenFromClose
  ;
  (ShopWindow.InitShopBtn)()
  ;
  (ShopWindow.InitAssetStrip)()
  ;
  (ShopWindow.InitFunctionControl)()
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.CommodityList).itemRenderer = ShopWindow.RendererList
  ;
  (uis.CommodityList):SetVirtual()
  ;
  (uis.CommodityList):SetBeginAnim(false, "up", 0.05, 0.05, true)
  isSendMsg = false
  ;
  (ShopWindow.Binding)()
  GuideSetDelayShow(contentPane)
  -- DECOMPILER ERROR at PC69: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.TimeNameTxt).text = (PUtil.get)(20000364)
end

ShopWindow.Binding = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local winName = (WinResConfig.ShopWindow).name
  local BindingUI = RedDotMgr.BindingUI
  local RedDotComID = RedDotComID
  BindingUI(winName, RedDotComID.Shop_Grocer, (uis.ShopPanelGrp).ZahuoBtn)
  BindingUI(winName, RedDotComID.Shop_Mystical, (uis.ShopPanelGrp).ShenmiBtn)
  BindingUI(winName, RedDotComID.Shop_Token, (uis.ShopPanelGrp).DaibiBtn)
  BindingUI(winName, RedDotComID.Shop_Expedition, (uis.ShopPanelGrp).YuanzhenBtn)
  BindingUI(winName, RedDotComID.Shop_Gift, (uis.ShopPanelGrp).LibaoBtn)
  ;
  (RedDotMgr.RefreshTreeUI)(winName)
end

ShopWindow.RendererList = function(index, obj, ...)
  -- function num : 0_2 , upvalues : _ENV, ShopGridData, ShopWindow
  obj = obj:GetChild("ShopItem")
  local model = GetShop_ShopItemUis(obj)
  index = index + 1
  local data = ShopGridData[index]
  if not data or data.shopPoolId == 0 then
    return 
  end
  local GridData = ((TableData.gTable).BaseShopGridData)[data.shopGridId]
  local PoolData = ((TableData.gTable).BaseShopPoolData)[data.shopPoolId]
  local configItem = ((Util.ParseConfigStr)(PoolData.item))[1]
  local itemData, DataType = (Util.GetConfigDataByID)(configItem[2])
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R9 in 'UnsetPending'

  if DataType == PropType.EQUIP then
    (model.c1Ctr).selectedIndex = itemData.intelligence
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (model.EquiptStarList).visible = true
    ;
    (model.EquiptStarList):RemoveChildrenToPool()
    for i = 1, itemData.star do
      (model.EquiptStarList):AddItemFromPool()
    end
  else
    do
      -- DECOMPILER ERROR at PC56: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (model.EquiptStarList).visible = false
      -- DECOMPILER ERROR at PC59: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (model.c1Ctr).selectedIndex = itemData.quality
      -- DECOMPILER ERROR at PC65: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (model.IconLoader).url = (Util.GetItemUrl)(itemData.icon)
      local PoolDataStr = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.item, data.useNum)
      local amount = tonumber(PoolDataStr[3])
      -- DECOMPILER ERROR at PC80: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (model.IconNumberTxt).visible = amount > 1
      -- DECOMPILER ERROR at PC82: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (model.IconNumberTxt).text = amount
      -- DECOMPILER ERROR at PC85: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (model.ItemNameTxt).text = itemData.name
      -- DECOMPILER ERROR at PC89: Confused about usage of register: R11 in 'UnsetPending'

      ;
      ((model.NewCompGrp).root).visible = data.corner
      -- DECOMPILER ERROR at PC105: Confused about usage of register: R11 in 'UnsetPending'

      if PoolData.sell_type ~= tostring(10) or PoolData.sell_type == tostring(0) then
        ((model.SaleTipCompGrp).root).visible = false
      else
        -- DECOMPILER ERROR at PC109: Confused about usage of register: R11 in 'UnsetPending'

        ((model.SaleTipCompGrp).root).visible = true
        -- DECOMPILER ERROR at PC117: Confused about usage of register: R11 in 'UnsetPending'

        ;
        ((model.SaleTipCompGrp).SaleTxt).text = (PUtil.get)(20000071, PoolData.sell_type)
      end
      local times = GridData.sell_limit_time - data.useNum
      -- DECOMPILER ERROR at PC128: Confused about usage of register: R12 in 'UnsetPending'

      if tonumber(GridData.reset_type) == 0 then
        ((model.DayBuy).root).visible = true
        -- DECOMPILER ERROR at PC136: Confused about usage of register: R12 in 'UnsetPending'

        ;
        ((model.DayBuy).DayBuyNumberTxt).text = (PUtil.get)(20000320, times)
      else
        -- DECOMPILER ERROR at PC143: Confused about usage of register: R12 in 'UnsetPending'

        if GridData.sell_limit_time > 1 then
          ((model.DayBuy).root).visible = true
          -- DECOMPILER ERROR at PC151: Confused about usage of register: R12 in 'UnsetPending'

          ;
          ((model.DayBuy).DayBuyNumberTxt).text = (PUtil.get)(20000320, times)
        else
          -- DECOMPILER ERROR at PC155: Confused about usage of register: R12 in 'UnsetPending'

          ((model.DayBuy).root).visible = false
        end
      end
      -- DECOMPILER ERROR at PC163: Confused about usage of register: R12 in 'UnsetPending'

      if (ShopWindow.IsInfiniteTime)(GridData.sell_limit_time) then
        ((model.DayBuy).DayBuyNumberTxt).text = "∞"
      end
      local cost = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.sell_price, data.useNum)
      local contNum = tonumber(cost[3])
      -- DECOMPILER ERROR at PC176: Confused about usage of register: R14 in 'UnsetPending'

      if contNum <= 0 then
        (model.c3Ctr).selectedIndex = 1
      else
        -- DECOMPILER ERROR at PC179: Confused about usage of register: R14 in 'UnsetPending'

        (model.c3Ctr).selectedIndex = 0
        ;
        (Util.SetConsumptionByID)(cost[2], cost[3], model.CostLoader, model.CostTxt, false)
      end
      local needList = (ShopMgr.GetQualityUpCard)(itemData.id)
      -- DECOMPILER ERROR at PC197: Confused about usage of register: R15 in 'UnsetPending'

      if GridData.sell_limit_time <= data.useNum then
        (model.c2Ctr).selectedIndex = 1
      else
        -- DECOMPILER ERROR at PC200: Confused about usage of register: R15 in 'UnsetPending'

        (model.c2Ctr).selectedIndex = 0
      end
      ;
      (obj.onClick):Set(function(...)
    -- function num : 0_2_0 , upvalues : data, GridData, _ENV, ShopWindow, needList
    if GridData.sell_limit_time <= data.useNum then
      log("已售罄")
      return 
    end
    local buyData = {}
    if (ShopWindow.IsInfiniteTime)(GridData.sell_limit_time) then
      buyData.MaxNum = 100
    else
      buyData.MaxNum = GridData.sell_limit_time - data.useNum
    end
    buyData.needCards = needList
    buyData.gridID = data.shopGridId
    buyData.poolID = data.shopPoolId
    buyData.shopType = (ShopMgr.InitOpenShop)()
    buyData.buyTime = data.useNum
    OpenWindow((WinResConfig.ShopBuyWindow).name, UILayer.HUD, buyData)
  end
)
      -- DECOMPILER ERROR at PC206: Confused about usage of register: R15 in 'UnsetPending'

      ;
      (model.RedDollGrp).visible = false
      -- DECOMPILER ERROR at PC218: Confused about usage of register: R15 in 'UnsetPending'

      ;
      ((model.CardUse).root).visible = #needList > 0 and data.useNum < GridData.sell_limit_time
      -- DECOMPILER ERROR: 14 unprocessed JMP targets
    end
  end
end

ShopWindow.IsInfiniteTime = function(limit_time, ...)
  -- function num : 0_3
  do return limit_time == -1 or limit_time >= 99999 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ShopWindow.GetLimitBuyTimes = function(type, ...)
  -- function num : 0_4 , upvalues : _ENV
  local clientNum = 0
  if type == TimeType.EVERYDAY_TIME then
    clientNum = 20000072
  else
    if type == TimeType.EVERY_WEEK_TIME then
      clientNum = 20000073
    else
      if type == TimeType.EVERY_MOON_DAY_TIME then
        clientNum = 20000074
      end
    end
  end
  return (PUtil.get)(clientNum)
end

ShopWindow.InitFunctionControl = function(...)
  -- function num : 0_5 , upvalues : _ENV, uis
  local winName = (WinResConfig.ShopWindow).name
  local RegisterGuideAndControl = GuideData.RegisterGuideAndControl
  local ControlID = ControlID
  RegisterGuideAndControl(ControlID.Shop_Grocer, (uis.ShopPanelGrp).ZahuoBtn, winName)
  RegisterGuideAndControl(ControlID.Shop_Mystery, (uis.ShopPanelGrp).ShenmiBtn, winName)
  RegisterGuideAndControl(ControlID.Shop_Token, (uis.ShopPanelGrp).DaibiBtn, winName)
  RegisterGuideAndControl(ControlID.Shop_Expedition, (uis.ShopPanelGrp).YuanzhenBtn, winName)
  RegisterGuideAndControl(ControlID.Shop_Recharge, (uis.ShopPanelGrp).ChongzhiBtn, winName)
  RegisterGuideAndControl(ControlID.Shop_Gift, (uis.ShopPanelGrp).LibaoBtn, winName)
end

ShopWindow.RefreshItemList = function(...)
  -- function num : 0_6 , upvalues : ShopGridData, _ENV, uis
  ShopGridData = (ShopMgr.ShopGridData)()
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.CommodityList).numItems = #ShopGridData
end

ShopWindow.RefreshWin = function(...)
  -- function num : 0_7 , upvalues : _ENV, currentType, uis, ShopWindow, mTime, isSendMsg
  loge("刷新商店界面")
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

  if currentType == ShopType.Recharge then
    (uis.c1Ctr).selectedIndex = 0
    ;
    (ShopWindow.SetTypeShow)(currentType)
    ;
    (ShopWindow.RefreshRechargePanel)()
    ;
    (SuperSDKUtil.SendAdStoreOpened)()
    return 
  else
    if currentType == ShopType.GiftBuy then
      (ShopService.ReqActivityInfoList)()
      return 
    end
  end
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.c1Ctr).selectedIndex = 2
  ;
  (ShopWindow.SetInputIgnore)()
  local shopType, time, refreshTimes = (ShopMgr.InitOpenShop)()
  currentType = shopType
  if shopType == nil then
    return 
  end
  if mTime then
    mTime:Stop()
  end
  mTime = (LuaTime.CountDown)(time.bTime * 0.001 - (ActorData.GetServerTime)() * 0.001, uis.TimeTxt, function(...)
    -- function num : 0_7_0 , upvalues : isSendMsg, _ENV, shopType
    if not isSendMsg then
      isSendMsg = true
      ;
      (SimpleTimer.setTimeout)(1, function(...)
      -- function num : 0_7_0_0 , upvalues : _ENV, shopType
      (ShopService.OnReqShopGridData)(shopType)
    end
)
      ;
      (SimpleTimer.setTimeout)(2, function(...)
      -- function num : 0_7_0_1 , upvalues : isSendMsg
      isSendMsg = false
    end
)
    end
  end
)
  ;
  (ShopWindow.SetTypeShow)(shopType)
  local shopData = (ShopMgr.GetConfigDataByShopType)(shopType)
  ;
  (ShopWindow.RefreshItemList)()
  local RefreshNumberTxt = (uis.RefreshBtn):GetChild("RefreshNumberTxt")
  local consume = (ShopMgr.GetRefreshConsumption)(shopData.id, refreshTimes + 1)
  -- DECOMPILER ERROR at PC82: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (uis.RefreshBtn).text = (PUtil.get)(20000070)
  ;
  ((uis.RefreshBtn).onClick):Set(function(...)
    -- function num : 0_7_1 , upvalues : consume, _ENV, shopType
    if consume then
      (MessageMgr.OpenCostResConfirmWindow)(60000410, consume, function(...)
      -- function num : 0_7_1_0 , upvalues : _ENV, shopType
      (ShopService.OnReqShopReset)(shopType)
    end
)
    else
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(20000075))
    end
  end
)
  ;
  (ShopWindow.SetRefreshBtnShow)(shopData.reset_type)
  if consume then
    local consumeConfigs = ((Util.ParseConfigStr)(consume))[1]
    local consumeData = (Util.GetConfigDataByID)(consumeConfigs[2])
    ;
    ((uis.RefreshBtn):GetChild("RefreshItemLoader")).url = (Util.GetItemUrl)(consumeData.icon)
    RefreshNumberTxt.text = consumeConfigs[3]
  else
    do
      -- DECOMPILER ERROR at PC115: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (uis.RefreshBtn).visible = false
      ;
      ((uis.RefreshBtn):GetChild("RefreshItemLoader")).url = nil
      RefreshNumberTxt.text = (PUtil.get)(20000113)
    end
  end
end

ShopWindow.ShowGiftBuy = function(...)
  -- function num : 0_8 , upvalues : uis, ShopWindow, currentType, _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

  (uis.c1Ctr).selectedIndex = 1
  ;
  (ShopWindow.SetTypeShow)(currentType)
  ;
  (ShopWindow.RefreshGiftPanel)()
  ;
  (SuperSDKUtil.SendAdStoreOpened)()
end

ShopWindow.SetRefreshBtnShow = function(type, ...)
  -- function num : 0_9 , upvalues : uis
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  (uis.RefreshBtn).visible = type == 1
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ShopWindow.RefreshRechargePanel = function(...)
  -- function num : 0_10 , upvalues : uis, _ENV, ShopWindow
  local diamondGrp = uis.Diamonds
  local chargeList = (PayData.GetChargeListInfo)()
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  if #chargeList > 0 then
    (diamondGrp.root).visible = true
  else
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (diamondGrp.root).visible = false
  end
  for i,v in ipairs(chargeList) do
    local tipsGrp = diamondGrp["Tips_0" .. i .. "_Grp"]
    if tipsGrp then
      (ShopWindow.RefreshDiamondTips)(tipsGrp, v, i)
    end
  end
end

ShopWindow.RefreshDiamondTips = function(tips, info, index, ...)
  -- function num : 0_11 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  if tips and info then
    (tips.root).visible = true
    ;
    ((tips.root).onClick):Set(function(...)
    -- function num : 0_11_0 , upvalues : _ENV, info
    (PayMgr.SendPayCheck)(info.id)
  end
)
    ChangeController(tips.c1Ctr, index - 1)
    if info.totalBuyCount <= 0 then
      ChangeController(tips.c2Ctr, 0)
    else
      ChangeController(tips.c2Ctr, 1)
    end
  end
end

ShopWindow.RefreshGiftPanel = function(...)
  -- function num : 0_12 , upvalues : uis, _ENV, ShopWindow
  local list = uis.GiftList
  local chargeList = (PayData.GetGiftBuyListInfo)()
  list:RemoveChildrenToPool()
  local config = (TableData.gTable).BasePayProductData
  for i,v in ipairs(chargeList) do
    local id = v.id
    if config[id] and (config[id]).icon then
      local gift = list:AddItemFromPool((Util.GetResUrl)((config[id]).icon))
      if gift then
        (ShopWindow.RefreshGift)(gift, v, i)
      end
    end
  end
end

ShopWindow.JugeFreeGiftRedDot = function(...)
  -- function num : 0_13 , upvalues : _ENV, freeItem
  local node = RedDotManager:GetNodeByObj((WinResConfig.ShopWindow).name, RedDotComID.FREE_GIFT)
  if freeItem then
    (freeItem:GetChild("RedDot")).visible = node.NodeValue
  end
end

ShopWindow.RefreshGift = function(gift, info, ...)
  -- function num : 0_14 , upvalues : _ENV, freeItem, ShopWindow
  local config = ((TableData.gTable).BasePayProductData)[info.id]
  if gift and info and config then
    local sell_level = split(config.sell_level, ":")
    do
      local lv = (ActorData.GetLevel)()
      local isSatisfy = tonumber(sell_level[1]) <= lv and lv <= tonumber(sell_level[2])
      if isSatisfy then
        ChangeUIController(gift, "Lock", 0)
      else
        ChangeUIController(gift, "Lock", 1)
      end
      local wordTxt = (gift:GetChild("GiftTips")):GetChild("WordTxt")
      do
        local remainTime = (PayData.GetProductRemainTimes)(info.id)
        if config.product_id == "jp.red.free" then
          if freeItem == nil then
            freeItem = gift
          end
          ;
          (ShopWindow.JugeFreeGiftRedDot)()
        end
        if config.type == PayProductType.LittleMonthCard or config.type == PayProductType.BigMonthCard then
          local remainDay = (PayData.GetRemainMonthCardDay)(config.type)
          if remainDay > 0 then
            wordTxt.text = (PUtil.get)(20000325, remainDay)
          else
            wordTxt.text = (PUtil.get)(20000330)
          end
          local canGet = (PayData.GetMonthCardCanGet)(config.type)
          ;
          (gift:GetChild("RedDot")).visible = canGet
        elseif config.sell_limit_type == PayProductLimitType.NoLimit then
          wordTxt.text = (PUtil.get)(20000331)
        elseif config.sell_limit_type == PayProductLimitType.DayLimit then
          if remainTime > 0 then
            ChangeUIController(gift, "c1", 0)
            wordTxt.text = (PUtil.get)(20000332, remainTime)
          else
            ChangeUIController(gift, "c1", 1)
          end
        elseif config.sell_limit_type == PayProductLimitType.WeekLimit then
          if remainTime > 0 then
            ChangeUIController(gift, "c1", 0)
            wordTxt.text = (PUtil.get)(20000333, remainTime)
          else
            ChangeUIController(gift, "c1", 1)
          end
        elseif config.sell_limit_type == PayProductLimitType.MouthLimit then
          if remainTime > 0 then
            ChangeUIController(gift, "c1", 0)
            wordTxt.text = (PUtil.get)(20000334, remainTime)
          else
            ChangeUIController(gift, "c1", 1)
          end
        elseif config.sell_limit_type == PayProductLimitType.ForeverLimit then
          if remainTime > 0 then
            ChangeUIController(gift, "c1", 0)
            wordTxt.text = (PUtil.get)(20000335, remainTime)
          else
            ChangeUIController(gift, "c1", 1)
          end
        end
        do
          if config.type == PayProductType.ActivityGift and config.activity_id ~= nil and config.product_id ~= "jp.red.free" then
            local endTime = (ShopMgr.GetGiftCountDown)(config.activity_id)
            if endTime then
              wordTxt.text = (PUtil.get)(229, (LuaTime.GetLeftTimeStr)((math.floor)(endTime * 0.001), true))
            end
          end
          ;
          (gift.onClick):Set(function(...)
    -- function num : 0_14_0 , upvalues : config, _ENV, remainTime, ShopWindow, info
    if config.sell_limit_type == PayProductLimitType.NoLimit or remainTime > 0 then
      (ShopWindow.OnClickProduct)(info.id)
    end
  end
)
        end
        -- DECOMPILER ERROR: 20 unprocessed JMP targets
      end
    end
  end
end

ShopWindow.OnClickProduct = function(id, ...)
  -- function num : 0_15 , upvalues : _ENV
  local config = ((TableData.gTable).BasePayProductData)[id]
  if not config then
    return 
  end
  if config.type == PayProductType.BigMonthCard or config.type == PayProductType.LittleMonthCard then
    OpenWindow((WinResConfig.ShopMonthCardWindow).name, UILayer.HUD1, id)
  else
    if config.type == PayProductType.RechargeGift or config.type == PayProductType.ActivityGift then
      OpenWindow((WinResConfig.ShopGiftWindow).name, UILayer.HUD1, id)
    else
      ;
      (PayMgr.SendPayCheck)(id)
    end
  end
end

ShopWindow.InitShopBtn = function(...)
  -- function num : 0_16 , upvalues : _ENV, uis, ShopWindow
  local btnData = (ShopMgr.GetOpenShopData)()
  ;
  (((uis.ShopPanelGrp).ChongzhiBtn):GetChild("NameTxt")).text = (PUtil.get)(20000314)
  ;
  (((uis.ShopPanelGrp).LibaoBtn):GetChild("NameTxt")).text = (PUtil.get)(20000315)
  ;
  (((uis.ShopPanelGrp).ZahuoBtn):GetChild("NameTxt")).text = (PUtil.get)(20000065)
  ;
  (((uis.ShopPanelGrp).ShenmiBtn):GetChild("NameTxt")).text = (PUtil.get)(20000066)
  ;
  (((uis.ShopPanelGrp).DaibiBtn):GetChild("NameTxt")).text = (PUtil.get)(20000067)
  ;
  (((uis.ShopPanelGrp).YuanzhenBtn):GetChild("NameTxt")).text = (PUtil.get)(20000068)
  ;
  (((uis.ShopPanelGrp).ZahuoBtn):GetController("c1")).selectedIndex = 0
  ;
  (((uis.ShopPanelGrp).ShenmiBtn):GetController("c1")).selectedIndex = 1
  ;
  (((uis.ShopPanelGrp).DaibiBtn):GetController("c1")).selectedIndex = 2
  ;
  (((uis.ShopPanelGrp).YuanzhenBtn):GetController("c1")).selectedIndex = 3
  ;
  (((uis.ShopPanelGrp).ZahuoBtn).onClick):Set(function(...)
    -- function num : 0_16_0 , upvalues : ShopWindow, _ENV
    (ShopWindow.OnClickShopType)(ShopType.Grocer)
  end
)
  ;
  (((uis.ShopPanelGrp).ShenmiBtn).onClick):Set(function(...)
    -- function num : 0_16_1 , upvalues : ShopWindow, _ENV
    (ShopWindow.OnClickShopType)(ShopType.MysteryShop)
  end
)
  ;
  (((uis.ShopPanelGrp).DaibiBtn).onClick):Set(function(...)
    -- function num : 0_16_2 , upvalues : ShopWindow, _ENV
    (ShopWindow.OnClickShopType)(ShopType.TokenShop)
  end
)
  ;
  (((uis.ShopPanelGrp).YuanzhenBtn).onClick):Set(function(...)
    -- function num : 0_16_3 , upvalues : ShopWindow, _ENV
    (ShopWindow.OnClickShopType)(ShopType.ExpeditionShop)
  end
)
  ;
  (((uis.ShopPanelGrp).ChongzhiBtn).onClick):Set(function(...)
    -- function num : 0_16_4 , upvalues : ShopWindow, _ENV
    (ShopWindow.OnClickShopType)(ShopType.Recharge)
  end
)
  ;
  (((uis.ShopPanelGrp).LibaoBtn).onClick):Set(function(...)
    -- function num : 0_16_5 , upvalues : ShopWindow, _ENV
    (ShopWindow.OnClickShopType)(ShopType.GiftBuy)
  end
)
  ;
  (((uis.Diamonds).Diamonds_A_Btn):GetChild("WordTxt")).text = (PUtil.get)(20000366)
  ;
  (((uis.Diamonds).Diamonds_B_Btn):GetChild("WordTxt")).text = (PUtil.get)(20000367)
  ;
  (((uis.Diamonds).Diamonds_A_Btn).onClick):Set(function(...)
    -- function num : 0_16_6 , upvalues : _ENV
    OpenWindow((WinResConfig.ExplainWindow).name, UILayer.HUD1, (PUtil.get)(89102003), (PUtil.get)(20000366))
  end
)
  ;
  (((uis.Diamonds).Diamonds_B_Btn).onClick):Set(function(...)
    -- function num : 0_16_7 , upvalues : _ENV
    OpenWindow((WinResConfig.ExplainWindow).name, UILayer.HUD1, (PUtil.get)(89102001), (PUtil.get)(20000367))
  end
)
end

ShopWindow.OnClickShopType = function(type, ...)
  -- function num : 0_17 , upvalues : currentType, ShopWindow, _ENV
  if type == currentType then
    return 
  end
  ;
  (ShopWindow.SetTypeShow)(type)
  if type == ShopType.Recharge then
    currentType = ShopType.Recharge
    ;
    (PayService.ReqPayData)(false)
  else
    if type == ShopType.GiftBuy then
      currentType = ShopType.GiftBuy
      ;
      (PayService.ReqPayData)(false)
    else
      currentType = -1
      ;
      (ShopService.OnReqShopGridData)(type)
    end
  end
end

ShopWindow.SetInputIgnore = function(...)
  -- function num : 0_18 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  (GRoot.inst).touchable = false
  ;
  (SimpleTimer.setTimeout)(0.1, function(...)
    -- function num : 0_18_0 , upvalues : _ENV
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    (GRoot.inst).touchable = true
  end
)
end

ShopWindow.SetTypeShow = function(shopType, ...)
  -- function num : 0_19 , upvalues : _ENV, uis
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  if shopType == ShopType.Grocer then
    ((uis.ShopPanelGrp).c1Ctr).selectedIndex = 0
    local moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
    ;
    (CommonWinMgr.ChangeAssetsType)((WinResConfig.ShopWindow).name, moneyTypes)
  else
    do
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

      if shopType == ShopType.MysteryShop then
        ((uis.ShopPanelGrp).c1Ctr).selectedIndex = 1
        local moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
        ;
        (CommonWinMgr.ChangeAssetsType)((WinResConfig.ShopWindow).name, moneyTypes)
      else
        do
          -- DECOMPILER ERROR at PC56: Confused about usage of register: R1 in 'UnsetPending'

          if shopType == ShopType.TokenShop then
            ((uis.ShopPanelGrp).c1Ctr).selectedIndex = 2
            local moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.SHOP_TOKEN}
            ;
            (CommonWinMgr.ChangeAssetsType)((WinResConfig.ShopWindow).name, moneyTypes)
          else
            do
              -- DECOMPILER ERROR at PC81: Confused about usage of register: R1 in 'UnsetPending'

              if shopType == ShopType.ExpeditionShop then
                ((uis.ShopPanelGrp).c1Ctr).selectedIndex = 3
                local moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.EXPEDITION_TOKEN}
                ;
                (CommonWinMgr.ChangeAssetsType)((WinResConfig.ShopWindow).name, moneyTypes)
              else
                do
                  -- DECOMPILER ERROR at PC106: Confused about usage of register: R1 in 'UnsetPending'

                  if shopType == ShopType.Recharge then
                    ((uis.ShopPanelGrp).c1Ctr).selectedIndex = 4
                    local moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
                    ;
                    (CommonWinMgr.ChangeAssetsType)((WinResConfig.ShopWindow).name, moneyTypes)
                  else
                    do
                      -- DECOMPILER ERROR at PC131: Confused about usage of register: R1 in 'UnsetPending'

                      if shopType == ShopType.GiftBuy then
                        ((uis.ShopPanelGrp).c1Ctr).selectedIndex = 5
                        local moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
                        ;
                        (CommonWinMgr.ChangeAssetsType)((WinResConfig.ShopWindow).name, moneyTypes)
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

ShopWindow.OnShown = function(...)
  -- function num : 0_20 , upvalues : isBackOpen, ShopWindow
  if isBackOpen then
    (ShopWindow.RefreshWin)()
  end
end

ShopWindow.OnHide = function(...)
  -- function num : 0_21 , upvalues : mTime
  if mTime then
    mTime:Stop()
  end
end

ShopWindow.InitAssetStrip = function(...)
  -- function num : 0_22 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.ShopWindow).name
  m.Tip = (PUtil.get)(20000069)
  m.model = uis.AssetStrip
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

ShopWindow.OnClose = function(...)
  -- function num : 0_23 , upvalues : _ENV, ShopGridData, uis, freeItem, contentPane, currentType
  (GuideData.AbolishControlRefer)((WinResConfig.ShopWindow).name)
  ;
  (RedDotMgr.RemoveUIRefer)((WinResConfig.ShopWindow).name)
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.ShopWindow).name)
  ShopGridData = nil
  uis = nil
  freeItem = nil
  contentPane = nil
  currentType = -1
end

ShopWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_24 , upvalues : _ENV, ShopWindow, uis, ShopGridData, currentType
  if msgId == (WindowMsgEnum.ShopWindow).E_MSG_REFRESH then
    (ShopWindow.RefreshWin)()
  else
    if msgId == (WindowMsgEnum.ShopWindow).E_MSG_REFRESH_ITEM then
      (uis.CommodityList):SetAnimIsPlay(false)
      ;
      (SimpleTimer.setTimeout)(0.5, function(...)
    -- function num : 0_24_0 , upvalues : uis
    (uis.CommodityList):SetAnimIsPlay(true)
  end
)
      ;
      (ShopWindow.RefreshItemList)()
      if not (ShopService.CheckIsContainFreeItem)(ShopGridData) then
        (RedDotService.ReqRemoveRedDot)((WinResConfig.ShopWindow).name, RedDotComID.Shop_Main, 23000000 + currentType)
      end
    else
      if msgId == (WindowMsgEnum.ShopWindow).E_MSG_SET_TYPE then
        currentType = para
        ;
        (ShopWindow.RefreshWin)()
      else
        if msgId == (WindowMsgEnum.ShopWindow).E_MSG_GET_ACTIVITYINFO then
          (ShopWindow.ShowGiftBuy)()
        else
          if msgId == (WindowMsgEnum.ShopWindow).E_MSG_CLEAR_FREEGIFTREDDOT then
            (ShopWindow.JugeFreeGiftRedDot)()
          end
        end
      end
    end
  end
  if msgId == (WindowMsgEnum.NETBrokenReconnect).E_MSG_RECONNECT_Ok then
    (ShopWindow.RefreshWin)()
  end
end

return ShopWindow

