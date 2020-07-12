-- params : ...
-- function num : 0 , upvalues : _ENV
PayData = {savePayData = nil}
-- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

PayData.ClearData = function(...)
  -- function num : 0_0 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

  PayData.savePayData = nil
end

-- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

PayData.SavePayData = function(msg, ...)
  -- function num : 0_1 , upvalues : _ENV
  PrintTable(msg, "充值初始化返回数据：")
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  PayData.savePayData = msg
end

-- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

PayData.GetPayData = function(...)
  -- function num : 0_2 , upvalues : _ENV
  return PayData.savePayData
end

-- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

PayData.GetProductInfo = function(productId, ...)
  -- function num : 0_3 , upvalues : _ENV
  local info = nil
  if PayData.savePayData and (PayData.savePayData).productList then
    for i,v in ipairs((PayData.savePayData).productList) do
      if v.productId == productId then
        return (Util.Copy)(v)
      end
    end
  end
  do
    return 
  end
end

-- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

PayData.GetChargeListInfo = function(...)
  -- function num : 0_4 , upvalues : _ENV
  local list = {}
  local config = (TableData.gTable).BasePayProductData
  local platform = "ANDROID"
  if Application.platform == RuntimePlatform.Android then
    platform = "ANDROID"
  else
    if Application.platform == RuntimePlatform.IPhonePlayer then
      platform = "IOS"
    end
  end
  for i,v in pairs(config) do
    if v.platform == platform and v.type == PayProductType.RechargeDiamond then
      local info = (PayData.GetProductInfo)(v.product_id)
      if info then
        info.id = v.id
        info.sort = v.sort
        ;
        (table.insert)(list, info)
      end
    end
  end
  ;
  (table.sort)(list, function(a, b, ...)
    -- function num : 0_4_0
    do return a.sort < b.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return list
end

-- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

PayData.GetGiftBuyListInfo = function(...)
  -- function num : 0_5 , upvalues : _ENV
  local list = {}
  local config = (TableData.gTable).BasePayProductData
  local platform = "ANDROID"
  if Application.platform == RuntimePlatform.Android then
    platform = "ANDROID"
  else
    if Application.platform == RuntimePlatform.IPhonePlayer then
      platform = "IOS"
    end
  end
  for i,v in pairs(config) do
    if v.platform == platform and (v.type == PayProductType.LittleMonthCard or v.type == PayProductType.BigMonthCard or v.type == PayProductType.RechargeGift) then
      local info = (PayData.GetProductInfo)(v.product_id)
      if info then
        info.id = v.id
        info.sort = v.sort
        ;
        (table.insert)(list, info)
      end
    end
  end
  ;
  (table.sort)(list, function(a, b, ...)
    -- function num : 0_5_0 , upvalues : _ENV
    local aRe = (PayData.GetProductSortWeight)(a.id)
    local bRe = (PayData.GetProductSortWeight)(b.id)
    do return a.sort + aRe < b.sort + bRe end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return list
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R0 in 'UnsetPending'

PayData.GetProductSortWeight = function(id, ...)
  -- function num : 0_6 , upvalues : _ENV
  local config = ((TableData.gTable).BasePayProductData)[id]
  if config.type == PayProductType.BigMonthCard or config.type == PayProductType.LittleMonthCard then
    return 0
  else
    local Re = (PayData.GetProductRemainTimes)(id)
    if Re <= 0 then
      return 10000
    else
      return 0
    end
  end
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R0 in 'UnsetPending'

PayData.GetProductConfig = function(productId, ...)
  -- function num : 0_7 , upvalues : _ENV
  local config = (TableData.gTable).BasePayProductData
  local platform = "ANDROID"
  if Application.platform == RuntimePlatform.Android then
    platform = "ANDROID"
  else
    if Application.platform == RuntimePlatform.IPhonePlayer then
      platform = "IOS"
    end
  end
  for i,v in pairs(config) do
    if v.product_id == productId and v.platform == platform then
      return v
    end
  end
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R0 in 'UnsetPending'

PayData.GetPayCheckParam = function(...)
  -- function num : 0_8 , upvalues : _ENV
  local platform = "ANDROID"
  if Application.platform == RuntimePlatform.Android then
    platform = "ANDROID"
  else
    if Application.platform == RuntimePlatform.IPhonePlayer then
      platform = "IOS"
    end
  end
  return platform
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R0 in 'UnsetPending'

PayData.GetRemainMonthCardDay = function(type, ...)
  -- function num : 0_9 , upvalues : _ENV
  if type == PayProductType.LittleMonthCard then
    return ((PayData.savePayData).moonPayInfo).resMoonSurplus
  else
    if type == PayProductType.BigMonthCard then
      return ((PayData.savePayData).moonPayInfo).diaMoonSurplus
    else
      return 0
    end
  end
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R0 in 'UnsetPending'

PayData.GetMonthCardCanGet = function(type, ...)
  -- function num : 0_10 , upvalues : _ENV
  local day = (PayData.GetRemainMonthCardDay)(type)
  if day > 0 then
    local get = (PayData.GetMonthCardIsGet)(type)
    return not get
  else
    do
      do return false end
    end
  end
end

-- DECOMPILER ERROR at PC38: Confused about usage of register: R0 in 'UnsetPending'

PayData.GetMonthCardIsGet = function(type, ...)
  -- function num : 0_11 , upvalues : _ENV
  if type == PayProductType.LittleMonthCard then
    return ((PayData.savePayData).moonPayInfo).resMoonReceive
  else
    if type == PayProductType.BigMonthCard then
      return ((PayData.savePayData).moonPayInfo).diaMoonReceive
    end
  end
end

-- DECOMPILER ERROR at PC41: Confused about usage of register: R0 in 'UnsetPending'

PayData.GetProductDataByType = function(type, ...)
  -- function num : 0_12 , upvalues : _ENV
  local config = (TableData.gTable).BasePayProductData
  local platform = (PayData.GetPayCheckParam)()
  for _,v in pairs(config) do
    if v.platform == platform and v.type == type then
      return v
    end
  end
end

-- DECOMPILER ERROR at PC44: Confused about usage of register: R0 in 'UnsetPending'

PayData.GetProductTimes = function(product_id, Limit_type, ...)
  -- function num : 0_13 , upvalues : _ENV
  local list = (PayData.savePayData).productList
  for _,v in ipairs(list) do
    if v.productId == product_id then
      if Limit_type == PayProductLimitType.NoLimit or Limit_type == PayProductLimitType.ForeverLimit then
        return v.totalBuyCount
      else
        if Limit_type == PayProductLimitType.DayLimit then
          return v.todayBuyCount
        else
          if Limit_type == PayProductLimitType.WeekLimit then
            return v.weekBuyCount
          else
            if Limit_type == PayProductLimitType.MouthLimit then
              return v.monthBuyCount
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC47: Confused about usage of register: R0 in 'UnsetPending'

PayData.GetProductRemainTimes = function(id, ...)
  -- function num : 0_14 , upvalues : _ENV
  local config = ((TableData.gTable).BasePayProductData)[id]
  local buyTime = (PayData.GetProductTimes)(config.product_id, config.sell_limit_type)
  local limitTime = config.sell_limit_max
  if limitTime then
    return limitTime - buyTime
  else
    return 9999
  end
end


