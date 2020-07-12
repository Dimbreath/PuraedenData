-- params : ...
-- function num : 0 , upvalues : _ENV
SuperSDKMgr = {}
local SuperSDK = (CS.SuperSDKV4).SuperSDK
local SuperSDKPlatform = (CS.SuperSDKV4).SuperSDKPlatform
local StringUtil = CS.StringUtil
local SuperSDKConstants = (CS.SuperSDKV4).SuperSDKConstants
local GetCommonMsg = function(msg, ...)
  -- function num : 0_0 , upvalues : SuperSDKPlatform, _ENV
  msg[SuperSDKPlatform.KEY_ROLE_ID] = (ActorData.GetPlayerIndex)()
  msg[SuperSDKPlatform.KEY_ROLE_NAME] = (ActorData.GetNickName)()
  msg[SuperSDKPlatform.KEY_ROLE_LEVEL] = (ActorData.GetLevel)()
  msg[SuperSDKPlatform.KEY_SERVER_ID] = LoginMgr.curPlatformServerId
  msg[SuperSDKPlatform.KEY_SERVER_NAME] = (LoginMgr.GetServerName)()
  msg[SuperSDKPlatform.KEY_OP_SID] = ""
  msg[SuperSDKPlatform.KEY_ROLE_CREATE_TIME] = (ActorData.GetRegisterTime)()
end

local url = "http://msl.gtarcade.com/mobilemyServers/addMyServer"
-- DECOMPILER ERROR at PC17: Confused about usage of register: R6 in 'UnsetPending'

SuperSDKMgr.SendMsgAddMyServer = function(...)
  -- function num : 0_1 , upvalues : _ENV, url
  if Game.useSDK ~= true then
    return 
  end
  local account = (LoginMgr.GetAccount)()
  local gameId = (SuperSDKData.GetLoginGameId)()
  local opId = (SuperSDKData.GetLoginOpId)()
  local serverId = LoginMgr.curPlatformServerId
  local roleId = (ActorData.GetPlayerIndex)()
  local roleName = (ActorData.GetNickName)()
  local level = (ActorData.GetLevel)()
  local job = "0"
  local appId = "58d385d54937da"
  local is_mix = "1"
  local timestamp = tostring((math.floor)((ActorData.GetServerTime)() / 1000))
  local param = "account=" .. account .. "&appId=" .. appId .. "&gameId=" .. gameId .. "&is_mix=" .. is_mix .. "&job=" .. job .. "&level=" .. level .. "&opId=" .. opId .. "&roleId=" .. roleId .. "&roleName=" .. roleName .. "&serverId=" .. serverId .. "&timestamp=" .. timestamp
  local md5Util = CS.MD5Util
  local sign = (md5Util.Hash)(param .. "8Rm@]bbF|H3cqAOSMSL")
  param = param .. "&sign=" .. sign
  ;
  ((CS.WWWManager).Singleton):PostWebRequest(url .. "?" .. param, nil, function(...)
    -- function num : 0_1_0 , upvalues : _ENV
    loge("连接失败")
  end
, function(str, ...)
    -- function num : 0_1_1 , upvalues : _ENV
    loge(str)
  end
)
end

-- DECOMPILER ERROR at PC20: Confused about usage of register: R6 in 'UnsetPending'

SuperSDKMgr.SendEnterGame = function(...)
  -- function num : 0_2 , upvalues : _ENV, GetCommonMsg
  if Game.useSDK ~= true then
    return 
  end
  local msg = {}
  GetCommonMsg(msg)
  ;
  (SuperSDKUtil.SendEnterGame)(msg)
  ;
  (SuperSDKMgr.SendMsgAddMyServer)()
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R6 in 'UnsetPending'

SuperSDKMgr.SendCreateRole = function(...)
  -- function num : 0_3 , upvalues : _ENV, GetCommonMsg
  if Game.useSDK ~= true then
    return 
  end
  local msg = {}
  GetCommonMsg(msg)
  ;
  (SuperSDKUtil.SendCreateRole)(msg)
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R6 in 'UnsetPending'

SuperSDKMgr.SendLevelUp = function(...)
  -- function num : 0_4 , upvalues : _ENV, GetCommonMsg
  if Game.useSDK ~= true then
    return 
  end
  local msg = {}
  GetCommonMsg(msg)
  ;
  (SuperSDKUtil.SendLevelUp)(msg)
  ;
  (SuperSDKMgr.SendMsgAddMyServer)()
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R6 in 'UnsetPending'

SuperSDKMgr.InitSDKCallback = function(...)
  -- function num : 0_5 , upvalues : _ENV
  (SDKUtil.SetSDKCallback)(SuperSDKMgr.DealSDKCallback)
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R6 in 'UnsetPending'

SuperSDKMgr.DealSDKCallback = function(moduleName, funcName, result, ...)
  -- function num : 0_6 , upvalues : _ENV, SuperSDKPlatform
  local result_table = (Json.decode)(result)
  PrintTable(result_table, "sdk 返回 ：")
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R4 in 'UnsetPending'

  if result_table.data and (result_table.data).parameters and type((result_table.data).parameters) == "string" then
    (result_table.data).parameters = (Json.decode)((result_table.data).parameters)
  end
  if moduleName == SuperSDKPlatform.MODULE_NAME then
    if funcName == SuperSDKPlatform.FUNC_INIT then
      loge("---------------SuperSDK initCallBack ---------------------")
      ;
      (SuperSDKMgr.DealSDKInit)(result_table)
    else
      if funcName == SuperSDKPlatform.FUNC_LOGIN then
        loge("---------------SuperSDK loginCallBack ---------------------")
        ;
        (SuperSDKMgr.DealSDKLogin)(result_table)
      else
        if funcName == SuperSDKPlatform.FUNC_LOGOUT then
          loge("---------------SuperSDK logoutCallBack ---------------------")
          ;
          (SuperSDKMgr.DealSDKLogout)(result_table)
        else
          if funcName == SuperSDKPlatform.FUNC_PAY_ORDER_ID then
            loge("---------------SuperSDK getOrderIdCallBack ---------------------")
            ;
            (SuperSDKMgr.DealSDKPayOrderId)(result_table)
          else
            if funcName == SuperSDKPlatform.FUNC_PAY then
              loge("---------------SuperSDK payCallBack ---------------------")
              ;
              (SuperSDKMgr.DealSDKPay)(result_table)
            else
              if funcName == SuperSDKPlatform.FUNC_EXIT then
                loge("---------------SuperSDK exitCallBack ---------------------")
                ;
                (SuperSDKMgr.DealSDKExit)(result_table)
              else
                if funcName == SuperSDKPlatform.FUNC_OTHER_FUNCTION then
                  loge("---------------SuperSDK callSpecialCallBack ---------------------")
                  ;
                  (SuperSDKMgr.DealSDKOtherFunction)(result_table)
                else
                  if funcName == SuperSDKPlatform.FUNC_GUEST_UPGRADE then
                    loge("---------------SuperSDK guestUpgradeCallback ---------------------")
                    ;
                    (SuperSDKMgr.DealSDKGuestUpgrade)(result_table)
                  end
                end
              end
            end
          end
        end
      end
    end
  else
  end
  if ((moduleName == "xsdk" and moduleName ~= "push") or moduleName == "mobsharesdk") and funcName == "mobShare" then
    loge("---------------SuperSDK mobsharesdk ---------------------")
    ;
    (SuperSDKMgr.DealSDKShare)(result_table)
  end
end

local loginGame = function(result_table, isGuestLogin, ...)
  -- function num : 0_7 , upvalues : StringUtil, _ENV, SuperSDK, SuperSDKPlatform
  local osdk_ticket, ticket_json = nil, nil
  if isGuestLogin == true then
    osdk_ticket = ((result_table.data).parameters).osdk_ticket
  else
    osdk_ticket = (result_table.data).osdk_ticket
  end
  ticket_json = (StringUtil.Base64ToCommonString)(osdk_ticket)
  loge("osdk_ticket:" .. osdk_ticket)
  ;
  (SuperSDKData.SetLoginTicket)(osdk_ticket)
  loge("ticket_json:" .. ticket_json)
  local ticketTable = (Json.decode)(ticket_json)
  ;
  (SuperSDKData.SetLoginUserId)(ticketTable.osdk_user_id)
  ;
  (SuperSDKData.SetLoginExtend)(ticketTable.extend)
  ;
  (PlayerPrefs.SetString)("OSDK_USER_ID", ticketTable.osdk_user_id)
  if LoginMgr.directLogin == true then
    (LoginMgr.DealLogin)()
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R5 in 'UnsetPending'

    LoginMgr.directLogin = false
  end
  ;
  ((SuperSDK.getInstance)()):Invoke(SuperSDKPlatform.MODULE_NAME, SuperSDKPlatform.FUNC_OTHER_FUNCTION, {otherFuncName = "getDataForTx"})
end

-- DECOMPILER ERROR at PC36: Confused about usage of register: R7 in 'UnsetPending'

SuperSDKMgr.DealSDKInit = function(result_table, ...)
  -- function num : 0_8
end

-- DECOMPILER ERROR at PC39: Confused about usage of register: R7 in 'UnsetPending'

SuperSDKMgr.DealSDKLogin = function(result_table, ...)
  -- function num : 0_9 , upvalues : SuperSDKConstants, loginGame, _ENV
  local code = result_table.code
  if code == SuperSDKConstants.SUCCESS then
    loginGame(result_table)
  else
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

    LoginMgr.canTouch = true
  end
end

-- DECOMPILER ERROR at PC42: Confused about usage of register: R7 in 'UnsetPending'

SuperSDKMgr.DealSDKLogout = function(result_table, ...)
  -- function num : 0_10 , upvalues : SuperSDKConstants, _ENV
  if result_table and result_table.code == SuperSDKConstants.SUCCESS then
    (SuperSDKData.Init)()
    ;
    (LoginService.ReqLogout)()
  end
end

-- DECOMPILER ERROR at PC45: Confused about usage of register: R7 in 'UnsetPending'

SuperSDKMgr.DealSDKExit = function(result_table, ...)
  -- function num : 0_11 , upvalues : SuperSDKConstants, _ENV
  if result_table and result_table.code == SuperSDKConstants.SUCCESS then
    (Application.Quit)()
  end
end

-- DECOMPILER ERROR at PC48: Confused about usage of register: R7 in 'UnsetPending'

SuperSDKMgr.DealSDKPay = function(result_table, ...)
  -- function num : 0_12 , upvalues : SuperSDKConstants, _ENV
  if result_table and result_table.code == SuperSDKConstants.SUCCESS then
    (SuperSDKUtil.SendAdCPay)()
    ;
    (SuperSDKUtil.SendAdPayCompleted)()
  end
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  SuperSDKData.curPayPrice = nil
end

-- DECOMPILER ERROR at PC51: Confused about usage of register: R7 in 'UnsetPending'

SuperSDKMgr.DealSDKPayOrderId = function(result_table, ...)
  -- function num : 0_13
end

-- DECOMPILER ERROR at PC54: Confused about usage of register: R7 in 'UnsetPending'

SuperSDKMgr.DealSDKGuestUpgrade = function(result_table, ...)
  -- function num : 0_14 , upvalues : _ENV, SuperSDKConstants
  SendActivityWindowMessage((ActivityWindowName.ActivityBindingView).name, 1)
  if result_table and result_table.code == SuperSDKConstants.SUCCESS then
    (LoginService.ReqUpgradeAccount)()
  end
end

-- DECOMPILER ERROR at PC57: Confused about usage of register: R7 in 'UnsetPending'

SuperSDKMgr.DealSDKOtherFunction = function(result_table, ...)
  -- function num : 0_15 , upvalues : SuperSDKPlatform, SuperSDKConstants, loginGame, _ENV
  if result_table and result_table.data and (result_table.data)[SuperSDKPlatform.KEY_OTHER_NAME] == "GuestLogin" then
    if result_table.code == SuperSDKConstants.SUCCESS then
      loginGame(result_table, true)
    else
      ;
      (PlayerPrefs.SetString)("OSDK_USER_ID", "guest_error")
      ;
      (SuperSDKUtil.Login)()
    end
  end
end

-- DECOMPILER ERROR at PC60: Confused about usage of register: R7 in 'UnsetPending'

SuperSDKMgr.DealSDKShare = function(result_table, ...)
  -- function num : 0_16 , upvalues : SuperSDKConstants, _ENV
  if result_table then
    if result_table.code == SuperSDKConstants.SUCCESS then
      (MessageMgr.SendCenterTips)((PUtil.get)(40002065))
    end
  end
end


