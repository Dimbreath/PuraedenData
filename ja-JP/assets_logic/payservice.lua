-- params : ...
-- function num : 0 , upvalues : _ENV
PayService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

PayService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResPayCheck, PayService.OnResPayCheck)
  ;
  (Net.AddListener)((Proto.MsgName).ResPayData, PayService.OnResPayData)
  ;
  (Net.AddListener)((Proto.MsgName).ResGetMoonReward, PayService.OnResGetMoonReward)
  ;
  (Net.AddListener)((Proto.MsgName).ResPaySuccess, PayService.OnResPaySuccess)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

PayService.ReqPayData = function(isLogin, needResend, ...)
  -- function num : 0_1 , upvalues : _ENV
  (PayData.ClearData)()
  local m = {}
  m.login = isLogin
  if needResend then
    (Net.Send)((Proto.MsgName).ReqPayData, m, (Proto.MsgName).ResPayData, function(...)
    -- function num : 0_1_0 , upvalues : _ENV, isLogin, needResend
    (PayService.ReqPayData)(isLogin, needResend)
  end
)
  else
    ;
    (Net.Send)((Proto.MsgName).ReqPayData, m, (Proto.MsgName).ResPayData)
  end
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

PayService.OnResPayData = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV
  (PayData.SavePayData)(msg)
  if UIMgr:IsWindowOpen((WinResConfig.ShopWindow).name) then
    UIMgr:SendWindowMessage((WinResConfig.ShopWindow).name, (WindowMsgEnum.ShopWindow).E_MSG_REFRESH)
  end
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

PayService.ReqPayCheck = function(productId, amount, ...)
  -- function num : 0_3 , upvalues : _ENV
  local m = {}
  m.productId = productId
  m.amount = amount
  m.cParam = (PayData.GetPayCheckParam)()
  ;
  (Net.Send)((Proto.MsgName).ReqPayCheck, m, (Proto.MsgName).ResPayCheck)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

PayService.OnResPayCheck = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV
  PrintTable(msg, "服务器校验结果：")
  ;
  (PayMgr.DealAfterPayCheck)(msg)
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

PayService.ReqGetMoonReward = function(type, ...)
  -- function num : 0_5 , upvalues : _ENV
  local m = {}
  m.moonType = type
  ;
  (Net.Send)((Proto.MsgName).ReqGetMoonReward, m, (Proto.MsgName).ResGetMoonReward)
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

PayService.OnResGetMoonReward = function(msg, ...)
  -- function num : 0_6 , upvalues : _ENV
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  if msg.moonReceive then
    if msg.moonType == PayProductType.LittleMonthCard then
      ((PayData.savePayData).moonPayInfo).resMoonReceive = true
      ;
      (RedDotMgr.EliminateRedDot)((WinResConfig.ShopWindow).name, RedDotComID.Moon_Res)
    else
      -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

      if msg.moonType == PayProductType.BigMonthCard then
        ((PayData.savePayData).moonPayInfo).diaMoonReceive = true
        ;
        (RedDotMgr.EliminateRedDot)((WinResConfig.ShopWindow).name, RedDotComID.Moon_Dia)
      end
    end
    UIMgr:SendWindowMessage((WinResConfig.TaskWindow).name, (WindowMsgEnum.TaskWindow).TASK_REFRESH_WINDOW)
    UIMgr:CloseWindow((WinResConfig.ShopMonthCardWindow).name)
    UIMgr:SendWindowMessage((WinResConfig.ShopWindow).name, (WindowMsgEnum.ShopWindow).E_MSG_REFRESH)
  end
  ;
  (TaskMgr.CheckDisposeRedDot)()
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

PayService.OnResPaySuccess = function(msg, ...)
  -- function num : 0_7 , upvalues : _ENV
  if UIMgr:IsWindowOpen((WinResConfig.ShopMonthCardWindow).name) then
    UIMgr:CloseWindow((WinResConfig.ShopMonthCardWindow).name)
  else
    if UIMgr:IsWindowOpen((WinResConfig.ShopGiftWindow).name) then
      UIMgr:CloseWindow((WinResConfig.ShopGiftWindow).name)
    end
  end
  UIMgr:RemoveWindowList((WinResConfig.ShopMonthCardWindow).name)
  UIMgr:RemoveWindowList((WinResConfig.ShopGiftWindow).name)
end

;
(PayService.Init)()

