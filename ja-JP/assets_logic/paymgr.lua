-- params : ...
-- function num : 0 , upvalues : _ENV
PayMgr = {}
PayProductType = {RechargeDiamond = 1, LittleMonthCard = 2, BigMonthCard = 3, RechargeGift = 4, ActivityGift = 5}
PayProductLimitType = {NoLimit = 0, DayLimit = 1, WeekLimit = 2, MouthLimit = 3, ForeverLimit = 4}
-- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

PayMgr.SendPayCheck = function(configId, ...)
  -- function num : 0_0 , upvalues : _ENV
  local config = ((TableData.gTable).BasePayProductData)[configId]
  if config then
    if Game.useSDK == false then
      (LoginService.OnReqSendChar)("gm,payTest," .. config.product_id .. "," .. (string.format)("%.01f", config.price) .. "," .. (PayData.GetPayCheckParam)())
    else
      ;
      (SuperSDKUtil.SendAdSPayInciated)()
      ;
      (PayService.ReqPayCheck)(config.product_id, config.price)
    end
  end
end

-- DECOMPILER ERROR at PC21: Confused about usage of register: R0 in 'UnsetPending'

PayMgr.DealAfterPayCheck = function(msg, ...)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC20: Unhandled construct in 'MakeBoolean' P1

  -- DECOMPILER ERROR at PC20: Unhandled construct in 'MakeBoolean' P1

  if msg and msg.productId ~= "jp.red.free" and Game.useSDK == true then
    (SuperSDKUtil.Pay)(msg.productId, msg.sOrderId .. "_" .. msg.sParam .. "_" .. (PayData.GetPayCheckParam)())
  end
  ;
  (RedDotMgr.EliminateRedDot)((WinResConfig.ShopWindow).name, RedDotComID.FREE_GIFT)
end


