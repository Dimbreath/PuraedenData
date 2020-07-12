-- params : ...
-- function num : 0 , upvalues : _ENV
require("Shop_MonthWindowByName")
local ShopMonthCardWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local configData = nil
local canBuy = false
ShopMonthCardWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, canBuy, configData, ShopMonthCardWindow
  bridgeObj:SetView((WinResConfig.ShopMonthCardWindow).package, (WinResConfig.ShopMonthCardWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  local productID = tonumber(argTable[1])
  uis = GetShop_MonthWindowUis(contentPane)
  uis = uis.Month
  canBuy = false
  configData = ((TableData.gTable).BasePayProductData)[productID]
  local addEffect = function(component, ...)
    -- function num : 0_0_0 , upvalues : _ENV
    local count = component.numChildren
    local effect, item = nil, nil
    for i = 0, count - 1 do
      item = component:GetChildAt(i)
      effect = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_MONTHLYCARD_SMALL, true, true)
      item:AddChild(effect)
      effect:SetXY(item.width * 0.5, item.height * 0.5)
    end
  end

  -- DECOMPILER ERROR at PC35: Confused about usage of register: R3 in 'UnsetPending'

  if configData.type == PayProductType.LittleMonthCard then
    (uis.c1Ctr).selectedIndex = 0
    local obj = UIMgr:CreateObject("Shop", "RewardA")
    ;
    (uis.RewardAList):AddChild(obj)
    canBuy = (((PayData.GetPayData)()).moonPayInfo).resCanBuy
    addEffect(obj)
  else
    do
      -- DECOMPILER ERROR at PC61: Confused about usage of register: R3 in 'UnsetPending'

      if configData.type == PayProductType.BigMonthCard then
        (uis.c1Ctr).selectedIndex = 1
        local obj = UIMgr:CreateObject("Shop", "RewardB")
        ;
        (uis.RewardBList):AddChild(obj)
        canBuy = (((PayData.GetPayData)()).moonPayInfo).diaCanBuy
        addEffect(obj)
      end
      do
        ;
        (ShopMonthCardWindow.InitEvent)()
        -- DECOMPILER ERROR at PC87: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (uis.ItemNameTxt).text = (PUtil.get)(20000355)
        -- DECOMPILER ERROR at PC93: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (uis.TipsTxt).text = (PUtil.get)(20000356)
        -- DECOMPILER ERROR at PC99: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (uis.TitleTxt).text = (PUtil.get)(20000406)
        local lod = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_MONTHLYCARD_HUGE, true, true)
        ;
        (uis.root):AddChild(lod)
        lod:SetXY((uis.Decorate_03_Image).x + (uis.Decorate_03_Image).width * 0.5, (uis.Decorate_03_Image).y + (uis.Decorate_03_Image).height * 0.5)
      end
    end
  end
end

ShopMonthCardWindow.InitEvent = function(...)
  -- function num : 0_1 , upvalues : uis, _ENV, canBuy, configData
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_1_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.ShopMonthCardWindow).name)
  end
)
  if canBuy then
    ChangeUIController(uis.SureBtn, "c1", 0)
  else
    ChangeUIController(uis.SureBtn, "c1", 1)
  end
  ;
  ((uis.SureBtn).onClick):Set(function(...)
    -- function num : 0_1_1 , upvalues : canBuy, _ENV, configData
    if canBuy then
      (PayMgr.SendPayCheck)(configData.id)
    else
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(20000386))
    end
  end
)
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.SureBtn).text = (PUtil.get)(20000324)
  local canGet = (PayData.GetMonthCardCanGet)(configData.type)
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

  if canGet then
    (uis.GetBtn).text = (PUtil.get)(20000293)
    ChangeUIController(uis.GetBtn, "c1", 0)
  else
    -- DECOMPILER ERROR at PC53: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.GetBtn).text = (PUtil.get)(20000011)
    ChangeUIController(uis.GetBtn, "c1", 1)
  end
  ;
  ((uis.GetBtn).onClick):Set(function(...)
    -- function num : 0_1_2 , upvalues : canGet, _ENV, configData
    if canGet then
      (PayService.ReqGetMoonReward)(configData.type)
    else
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(20000387))
    end
  end
)
end

ShopMonthCardWindow.OnShown = function(...)
  -- function num : 0_2 , upvalues : _ENV, configData, uis
  local remainDay = (PayData.GetRemainMonthCardDay)(configData.type)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  if remainDay > 0 then
    (uis.c2Ctr).selectedIndex = 1
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.DayTxt).text = (PUtil.get)(20000325, remainDay)
  else
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.c2Ctr).selectedIndex = 0
  end
end

ShopMonthCardWindow.OnHide = function(...)
  -- function num : 0_3
end

ShopMonthCardWindow.OnClose = function(...)
  -- function num : 0_4 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

ShopMonthCardWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_5
end

return ShopMonthCardWindow

