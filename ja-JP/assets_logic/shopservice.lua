-- params : ...
-- function num : 0 , upvalues : _ENV
ShopService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

ShopService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResShopData, ShopService.OnResShopData)
  ;
  (Net.AddListener)((Proto.MsgName).ResShopGridData, ShopService.OnResShopGridData)
  ;
  (Net.AddListener)((Proto.MsgName).ResShopReset, ShopService.OnResShopReset)
  ;
  (Net.AddListener)((Proto.MsgName).ResShopBuy, ShopService.OnResShopBuy)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

ShopService.OnReqShopData = function(...)
  -- function num : 0_1 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqShopData, m, (Proto.MsgName).ResShopData)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

ShopService.OnResShopData = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV
  (ShopMgr.InitShop)(msg)
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

ShopService.OnReqShopGridData = function(shopType, ...)
  -- function num : 0_3 , upvalues : _ENV
  local m = {}
  m.shopType = tonumber(shopType)
  ;
  (Net.Send)((Proto.MsgName).ReqShopGridData, m, (Proto.MsgName).ResShopGridData)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

ShopService.OnResShopGridData = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV
  if msg then
    if not (ShopService.CheckIsContainFreeItem)(msg.shopGridData) then
      (RedDotService.ReqRemoveRedDot)((WinResConfig.ShopWindow).name, RedDotComID.Shop_Main, 23000000 + msg.shopType)
    end
    ;
    (ShopMgr.InitShopGridData)(msg)
  end
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

ShopService.CheckIsContainFreeItem = function(shopGridData, ...)
  -- function num : 0_5 , upvalues : _ENV
  for _,v in ipairs(shopGridData) do
    local PoolData = ((TableData.gTable).BaseShopPoolData)[v.shopPoolId]
    local cost = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.sell_price, v.useNum)
    if tonumber(cost[3]) <= 0 then
      return true
    end
  end
  return false
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

ShopService.OnReqShopReset = function(type, ...)
  -- function num : 0_6 , upvalues : _ENV
  local m = {}
  m.shopType = type
  ;
  (Net.Send)((Proto.MsgName).ReqShopReset, m, (Proto.MsgName).ResShopReset)
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

ShopService.OnResShopReset = function(msg, ...)
  -- function num : 0_7 , upvalues : _ENV
  if msg then
    (ShopMgr.InitShopGridData)(msg)
  end
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

ShopService.OnReqShopBuy = function(type, poolId, gridId, num, ...)
  -- function num : 0_8 , upvalues : _ENV
  local m = {}
  m.shopType = type
  m.shopPoolId = poolId
  m.shopGridId = gridId
  m.shopNum = num
  ;
  (Net.Send)((Proto.MsgName).ReqShopBuy, m, (Proto.MsgName).ResShopBuy)
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R0 in 'UnsetPending'

ShopService.OnResShopBuy = function(msg, ...)
  -- function num : 0_9 , upvalues : _ENV
  if msg.success then
    (ShopMgr.SetShopGridData)(msg.shopGridData)
    UIMgr:CloseWindow((WinResConfig.ShopBuyWindow).name)
    UIMgr:SendWindowMessage((WinResConfig.ShopWindow).name, (WindowMsgEnum.ShopWindow).E_MSG_REFRESH_ITEM)
  end
end

;
(ShopService.Init)()

