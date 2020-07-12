-- params : ...
-- function num : 0 , upvalues : _ENV
SuperSDKUtil = {}
local SuperSDK = (CS.SuperSDKV4).SuperSDK
local SuperSDKPlatform = (CS.SuperSDKV4).SuperSDKPlatform
-- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.Login = function(...)
  -- function num : 0_0 , upvalues : _ENV, SuperSDK, SuperSDKPlatform
  loge("---------------SuperSDK Login ---------------------")
  ;
  ((SuperSDK.getInstance)()):Invoke(SuperSDKPlatform.MODULE_NAME, SuperSDKPlatform.FUNC_LOGIN, nil)
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.GuestLogin = function(...)
  -- function num : 0_1 , upvalues : _ENV, SuperSDKPlatform, SuperSDK
  loge("---------------SuperSDK GuestLogin ---------------------")
  local loginParams = {}
  loginParams[SuperSDKPlatform.KEY_OTHER_NAME] = "GuestLogin"
  ;
  ((SuperSDK.getInstance)()):Invoke(SuperSDKPlatform.MODULE_NAME, SuperSDKPlatform.FUNC_OTHER_FUNCTION, loginParams)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.Logout = function(...)
  -- function num : 0_2 , upvalues : _ENV, SuperSDK, SuperSDKPlatform
  loge("---------------SuperSDK Logout ---------------------")
  ;
  ((SuperSDK.getInstance)()):Invoke(SuperSDKPlatform.MODULE_NAME, SuperSDKPlatform.FUNC_LOGOUT, nil)
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.Pay = function(productId, serverOrderId, ...)
  -- function num : 0_3 , upvalues : _ENV, SuperSDKPlatform, SuperSDK
  local productConfig = (PayData.GetProductConfig)(productId)
  local sendProduct = {}
  sendProduct[SuperSDKPlatform.KEY_PRICE] = productConfig.price
  sendProduct[SuperSDKPlatform.KEY_PRODUCT_ID] = productConfig.product_id
  sendProduct[SuperSDKPlatform.KEY_PRODUCT_NAME] = productConfig.product_name
  sendProduct[SuperSDKPlatform.KEY_PRODUCT_DESC] = "测试描述"
  sendProduct[SuperSDKPlatform.KEY_POINT_RATE] = "1"
  sendProduct[SuperSDKPlatform.KEY_POINT_NAME] = "钻石"
  sendProduct[SuperSDKPlatform.KEY_ORDER_TITLE] = "测试订单"
  sendProduct[SuperSDKPlatform.KEY_PAY_EXTRA] = serverOrderId
  PrintTable(sendProduct, "发送充值订单：")
  ;
  ((SuperSDK.getInstance)()):Invoke(SuperSDKPlatform.MODULE_NAME, SuperSDKPlatform.FUNC_PAY, sendProduct)
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R4 in 'UnsetPending'

  SuperSDKData.curPayPrice = productConfig.price
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.HasForum = function(...)
  -- function num : 0_4 , upvalues : SuperSDK, SuperSDKPlatform
  return ((SuperSDK.getInstance)()):InvokeBool(SuperSDKPlatform.MODULE_NAME, SuperSDKPlatform.FUNC_HAS_FORUM, nil)
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.OpenForum = function(...)
  -- function num : 0_5 , upvalues : _ENV, SuperSDK, SuperSDKPlatform
  local hasForum = (SuperSDKUtil.HasForum)()
  if hasForum == true then
    ((SuperSDK.getInstance)()):Invoke(SuperSDKPlatform.MODULE_NAME, SuperSDKPlatform.FUNC_OPEN_FORUM, nil)
  end
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.HasUserCenter = function(...)
  -- function num : 0_6 , upvalues : SuperSDK, SuperSDKPlatform
  return ((SuperSDK.getInstance)()):InvokeBool(SuperSDKPlatform.MODULE_NAME, SuperSDKPlatform.FUNC_HAS_USER_CENTER, nil)
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.OpenUserCenter = function(...)
  -- function num : 0_7 , upvalues : _ENV, SuperSDK, SuperSDKPlatform
  local hasUserCenter = (SuperSDKUtil.HasUserCenter)()
  if hasUserCenter == true then
    ((SuperSDK.getInstance)()):Invoke(SuperSDKPlatform.MODULE_NAME, SuperSDKPlatform.FUNC_OPEN_USER_CENTER, nil)
  end
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.HasCustomServer = function(...)
  -- function num : 0_8 , upvalues : SuperSDK, SuperSDKPlatform
  return ((SuperSDK.getInstance)()):InvokeBool(SuperSDKPlatform.MODULE_NAME, SuperSDKPlatform.FUNC_HAS_CUSOMER_SERVICE, nil)
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.OpenCustomServer = function(...)
  -- function num : 0_9 , upvalues : _ENV, SuperSDK, SuperSDKPlatform
  local hasCustomServer = (SuperSDKUtil.HasCustomServer)()
  if hasCustomServer == true then
    ((SuperSDK.getInstance)()):Invoke(SuperSDKPlatform.MODULE_NAME, SuperSDKPlatform.FUNC_OPEN_CUSOMER_SERVICE, nil)
  end
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.IsGuest = function(...)
  -- function num : 0_10 , upvalues : SuperSDK, SuperSDKPlatform
  local isGuest = ((SuperSDK.getInstance)()):InvokeBool(SuperSDKPlatform.MODULE_NAME, SuperSDKPlatform.FUNC_HAS_GUEST, nil)
  return isGuest
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.BindAccount = function(...)
  -- function num : 0_11 , upvalues : SuperSDK, SuperSDKPlatform
  ((SuperSDK.getInstance)()):Invoke(SuperSDKPlatform.MODULE_NAME, SuperSDKPlatform.FUNC_GUEST_UPGRADE, nil)
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.SendOpenHomePage = function(...)
  -- function num : 0_12 , upvalues : SuperSDK, SuperSDKPlatform
  ((SuperSDK.getInstance)()):Invoke(SuperSDKPlatform.MODULE_NAME, SuperSDKPlatform.FUNC_OPEN_HOME_PAGE, nil)
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.OpenLoginPage = function(...)
  -- function num : 0_13 , upvalues : SuperSDK, SuperSDKPlatform
  ((SuperSDK.getInstance)()):Invoke(SuperSDKPlatform.MODULE_NAME, SuperSDKPlatform.FUNC_OPEN_LOGIN_PAGE, nil)
end

-- DECOMPILER ERROR at PC52: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.SendEnterGame = function(roleInfo, ...)
  -- function num : 0_14 , upvalues : SuperSDK, SuperSDKPlatform
  ((SuperSDK.getInstance)()):Invoke(SuperSDKPlatform.MODULE_NAME, SuperSDKPlatform.FUNC_ENTER_GAME, roleInfo)
end

-- DECOMPILER ERROR at PC55: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.SendCreateRole = function(roleInfo, ...)
  -- function num : 0_15 , upvalues : SuperSDK, SuperSDKPlatform
  ((SuperSDK.getInstance)()):Invoke(SuperSDKPlatform.MODULE_NAME, SuperSDKPlatform.FUNC_CREATE_ROLE, roleInfo)
end

-- DECOMPILER ERROR at PC58: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.SendLevelUp = function(roleInfo, ...)
  -- function num : 0_16 , upvalues : SuperSDK, SuperSDKPlatform
  ((SuperSDK.getInstance)()):Invoke(SuperSDKPlatform.MODULE_NAME, SuperSDKPlatform.FUNC_LEVEL_UP, roleInfo)
end

-- DECOMPILER ERROR at PC61: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.SendReportCustomData = function(...)
  -- function num : 0_17 , upvalues : _ENV
  if Application.platform ~= RuntimePlatform.Android then
    return 
  end
  if Game.useSDK ~= true then
    return 
  end
  loge(" SendReportCustomData ")
  ;
  (SDKUtil.SendCustomData)()
end

SuperSDKConst = {SHARE_PLATFORM_FACEBOOK = 7, SHARE_PLATFORM_LINE = 11, SHARE_PLATFORM_TWITTER = 12}
-- DECOMPILER ERROR at PC69: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.SendShare = function(imageUrl, platform, ...)
  -- function num : 0_18 , upvalues : _ENV, SuperSDK
  if Game.useSDK ~= true then
    return 
  end
  if imageUrl == nil or platform == nil then
    return 
  end
  local sendProduct = {}
  sendProduct.images = imageUrl
  sendProduct.platform = tostring(platform)
  PrintTable(sendProduct, "发送分享：")
  ;
  ((SuperSDK.getInstance)()):Invoke("mobsharesdk", "mobShare", sendProduct)
end

-- DECOMPILER ERROR at PC72: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.SendAppsflyerStart = function(...)
  -- function num : 0_19 , upvalues : _ENV, SuperSDK
  if Game.useSDK ~= true then
    return 
  end
  local sendProduct = {}
  sendProduct.event_id = "ad_open"
  loge("  SendAdOpen  ")
  ;
  ((SuperSDK.getInstance)()):Invoke("advert", "track", sendProduct)
  local sendProduct = {}
  sendProduct.event_id = "ad_launch"
  loge("  SendAppsflyerStart  ")
  ;
  ((SuperSDK.getInstance)()):Invoke("advert", "track", sendProduct)
end

-- DECOMPILER ERROR at PC75: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.SendAdLogin = function(...)
  -- function num : 0_20 , upvalues : _ENV, SuperSDK
  if Game.useSDK ~= true then
    return 
  end
  local sendProduct = {}
  sendProduct.event_id = "ad_login"
  sendProduct.event_value = LoginMgr.account
  ;
  ((SuperSDK.getInstance)()):Invoke("advert", "track", sendProduct)
end

-- DECOMPILER ERROR at PC78: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.SendAdCreateRole = function(...)
  -- function num : 0_21 , upvalues : _ENV, SuperSDK
  if Game.useSDK ~= true then
    return 
  end
  local sendProduct = {}
  sendProduct.event_id = "ad_createrole"
  sendProduct.event_value = LoginMgr.account
  ;
  ((SuperSDK.getInstance)()):Invoke("advert", "track", sendProduct)
end

-- DECOMPILER ERROR at PC81: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.SendAdLevelUp = function(level, ...)
  -- function num : 0_22 , upvalues : _ENV, SuperSDK
  if Game.useSDK ~= true then
    return 
  end
  local sendProduct = {}
  sendProduct.event_id = "ad_levelup"
  sendProduct.event_value = tostring(level)
  ;
  ((SuperSDK.getInstance)()):Invoke("advert", "track", sendProduct)
end

-- DECOMPILER ERROR at PC84: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.SendAdFirstPay = function(...)
  -- function num : 0_23 , upvalues : _ENV, SuperSDK
  if Game.useSDK ~= true then
    return 
  end
  local sendProduct = {}
  sendProduct.event_id = "ad_firstpay"
  ;
  ((SuperSDK.getInstance)()):Invoke("advert", "track", sendProduct)
end

-- DECOMPILER ERROR at PC87: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.SendAdCPay = function(...)
  -- function num : 0_24 , upvalues : _ENV, SuperSDK
  if Game.useSDK ~= true then
    return 
  end
  local sendProduct = {}
  sendProduct.event_id = "ad_pay"
  sendProduct.event_value = tostring(SuperSDKData.curPayPrice)
  ;
  ((SuperSDK.getInstance)()):Invoke("advert", "track", sendProduct)
end

-- DECOMPILER ERROR at PC90: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.SendAdStoreOpened = function(...)
  -- function num : 0_25 , upvalues : _ENV, SuperSDK
  if Game.useSDK ~= true then
    return 
  end
  local sendProduct = {}
  sendProduct.event_id = "ad_storeopened"
  ;
  ((SuperSDK.getInstance)()):Invoke("advert", "track", sendProduct)
end

-- DECOMPILER ERROR at PC93: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.SendAdSPayInciated = function(...)
  -- function num : 0_26 , upvalues : _ENV, SuperSDK
  if Game.useSDK ~= true then
    return 
  end
  local sendProduct = {}
  sendProduct.event_id = "ad_payinciated"
  ;
  ((SuperSDK.getInstance)()):Invoke("advert", "track", sendProduct)
end

-- DECOMPILER ERROR at PC96: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.SendAdPayCompleted = function(...)
  -- function num : 0_27 , upvalues : _ENV, SuperSDK
  if Game.useSDK ~= true then
    return 
  end
  local sendProduct = {}
  sendProduct.event_id = "ad_paycompleted"
  ;
  ((SuperSDK.getInstance)()):Invoke("advert", "track", sendProduct)
end

-- DECOMPILER ERROR at PC99: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.SendAdCharactorComplete = function(...)
  -- function num : 0_28 , upvalues : _ENV, SuperSDK
  if Game.useSDK ~= true then
    return 
  end
  local sendProduct = {}
  sendProduct.event_id = "ad_charcomplete"
  ;
  ((SuperSDK.getInstance)()):Invoke("advert", "track", sendProduct)
end

-- DECOMPILER ERROR at PC102: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.SendAdGuildJoined = function(...)
  -- function num : 0_29 , upvalues : _ENV, SuperSDK
  if Game.useSDK ~= true then
    return 
  end
  local sendProduct = {}
  sendProduct.event_id = "ad_1stguildjoined"
  ;
  ((SuperSDK.getInstance)()):Invoke("advert", "track", sendProduct)
end

-- DECOMPILER ERROR at PC105: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.SendAdOnLevel15 = function(level, ...)
  -- function num : 0_30 , upvalues : _ENV, SuperSDK
  if Game.useSDK ~= true then
    return 
  end
  if level ~= 15 then
    return 
  end
  local sendProduct = {}
  sendProduct.event_id = "ad_onlevel15"
  ;
  ((SuperSDK.getInstance)()):Invoke("advert", "track", sendProduct)
end

-- DECOMPILER ERROR at PC108: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.SendAdOnLevel30 = function(level, ...)
  -- function num : 0_31 , upvalues : _ENV, SuperSDK
  if Game.useSDK ~= true then
    return 
  end
  if level ~= 30 then
    return 
  end
  local sendProduct = {}
  sendProduct.event_id = "ad_onlevel30"
  ;
  ((SuperSDK.getInstance)()):Invoke("advert", "track", sendProduct)
end

-- DECOMPILER ERROR at PC111: Confused about usage of register: R2 in 'UnsetPending'

SuperSDKUtil.SendAdOnLevel40 = function(level, ...)
  -- function num : 0_32 , upvalues : _ENV, SuperSDK
  if Game.useSDK ~= true then
    return 
  end
  if level ~= 40 then
    return 
  end
  local sendProduct = {}
  sendProduct.event_id = "ad_onlevel40"
  ;
  ((SuperSDK.getInstance)()):Invoke("advert", "track", sendProduct)
end


