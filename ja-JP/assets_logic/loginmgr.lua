-- params : ...
-- function num : 0 , upvalues : _ENV
LoginMgr = {deviceUniqueIdentifier = SystemInfo.deviceUniqueIdentifier, curServerId = nil, curLoginTimestamp = 0, 
curAccountKey = {}
, 
ipList = {}
}
urlList = {
dashixiong = {id = 1, url = "http://172.16.1.66:6666", gateServerId = "901", mainServerId = "101", name = "大师兄服", btnName = (PUtil.get)(40000021)}
, 
ershixiong = {id = 2, url = "http://172.16.1.158:6666", gateServerId = "911", mainServerId = "111", name = "二师兄", btnName = (PUtil.get)(40000022)}
, 
gangdezong = {id = 3, url = "http://172.16.1.70:6666", name = "刚总服", btnName = (PUtil.get)(40000023)}
, 
shaowei = {id = 4, url = "http://172.16.1.138:6666", gateServerId = "902", mainServerId = "102", name = "绍伟服", btnName = (PUtil.get)(40000024)}
, 
aliyun = {id = 5, url = "http://39.104.20.60:6666", gateServerId = "912", mainServerId = "112", name = "测试服", btnName = (PUtil.get)(40000020)}
, 
shaojun = {id = 6, url = "http://172.16.1.142:6666", gateServerId = "905", mainServerId = "105", name = "绍军服", btnName = (PUtil.get)(146)}
, 
ershixiong_linux = {id = 7, url = "http://172.16.1.156:6666", gateServerId = "906", mainServerId = "106", name = "linux二师兄", btnName = "linux二师兄"}
, 
cehua = {id = 8, url = "http://172.16.1.143:6666", gateServerId = "915", mainServerId = "115", name = "策划大大的服", btnName = "策划大大的服"}
}
AnnouncementURL = {List = "http://172.16.1.158:6666/notice/list", Content = "http://172.16.1.158:6666/notice/info", GiftCode = "http://172.16.1.70:6666/giftCode"}
-- DECOMPILER ERROR at PC106: Confused about usage of register: R0 in 'UnsetPending'

LoginMgr.OpenLogin = function(...)
  -- function num : 0_0 , upvalues : _ENV
  do
    if Game.testPackage == true then
      local authUrl = GetAuthUrl()
      -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

      AnnouncementURL.List = authUrl .. "/notice/list"
      -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

      AnnouncementURL.Content = authUrl .. "/notice/info"
      -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

      AnnouncementURL.GiftCode = authUrl .. "/giftCode"
    end
    OpenWindow("LoginWindow", UILayer.HUD)
  end
end

-- DECOMPILER ERROR at PC109: Confused about usage of register: R0 in 'UnsetPending'

LoginMgr.ConnectAuthServer = function(urlInfo, ...)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  LoginMgr.lastUrlInfo = urlInfo
  local channel = (LoginMgr.GetChannel)()
  local formData = {account = (LoginMgr.GetTicket)(), channel = tostring(channel)}
  loge("发送认证请求：")
  loge("url :" .. urlInfo.url)
  loge("formData :" .. PrintTable(formData))
  local MsgWaiterObj = require("MsgWaiter")
  MsgWaiter("CONNECT_AUTH", "CONNECT_AUTH")
  ;
  ((CS.WWWManager).Singleton):PostWebRequestForm(urlInfo.url .. "/auth", formData, function(...)
    -- function num : 0_1_0 , upvalues : MsgWaiterObj, _ENV, urlInfo
    (MsgWaiterObj.ReceiveMsg)(nil, nil, "CONNECT_AUTH")
    loge("认证失败1")
    ;
    (MsgWaiterObj.PromptMsgTimeout)(1, function(...)
      -- function num : 0_1_0_0 , upvalues : _ENV, urlInfo
      (LoginMgr.ConnectAuthServer)(urlInfo)
    end
)
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

    LoginMgr.canTouch = true
  end
, function(str, ...)
    -- function num : 0_1_1 , upvalues : MsgWaiterObj, _ENV, urlInfo
    (MsgWaiterObj.ReceiveMsg)(nil, nil, "CONNECT_AUTH")
    if (string.find)((string.lower)(str), "<html") ~= nil or (string.find)((string.lower)(str), "html>") ~= nil then
      (MessageMgr.SendCenterTips)((PUtil.get)(40000008))
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

      LoginMgr.canTouch = true
      return 
    end
    local result_table = (Json.decode)(str)
    PrintTable(result_table)
    if result_table.code == "success" then
      local version = (result_table.data).version
      local key = "SERVER_" .. (urlInfo.id or "") .. "_VERSION"
      local saveVersion = (PlayerPrefs.GetString)(key, "")
      loge("认证成功")
      loge("之前服务器版本：" .. tostring(saveVersion))
      loge("最新服务器版本：" .. tostring(version))
      if saveVersion and version and version ~= saveVersion then
        loge("服务器有更新，需要重新进入游戏")
        if UIMgr:IsWindowOpen((WinResConfig.LoginWindow).name) == true then
          (PlayerPrefs.SetString)(key, version)
          ;
          (LoginMgr.CreateSocket)((result_table.data).host, (result_table.data).port)
        else
          ;
          (LoginMgr.ReturnToLoginWindow)()
        end
      else
        ;
        (PlayerPrefs.SetString)(key, version)
        ;
        (LoginMgr.CreateSocket)((result_table.data).host, (result_table.data).port)
      end
    else
      do
        if result_table.code == "auth_fail" then
          loge("认证失败2")
          if Game.useSDK == true then
            (SuperSDKData.Init)()
            ;
            (LoginMgr.ReturnToLoginWindow)()
            ;
            (MessageMgr.SendCenterTips)((PUtil.get)(40000009))
          else
            ;
            (MsgWaiterObj.PromptMsgTimeout)(1, function(...)
      -- function num : 0_1_1_0 , upvalues : _ENV, urlInfo
      (LoginMgr.ConnectAuthServer)(urlInfo)
    end
, (PUtil.get)(40000009))
          end
          -- DECOMPILER ERROR at PC155: Confused about usage of register: R2 in 'UnsetPending'

          LoginMgr.canTouch = true
        else
          if result_table.code == "server_error" then
            loge("服务器未开启")
            ;
            (MessageMgr.SendCenterTips)((PUtil.get)(40000008))
            -- DECOMPILER ERROR at PC171: Confused about usage of register: R2 in 'UnsetPending'

            LoginMgr.canTouch = true
          else
            if result_table.code == "server_full" then
              loge("服务器在线人数已满")
              ;
              (MessageMgr.SendCenterTips)((PUtil.get)(40000010))
              -- DECOMPILER ERROR at PC187: Confused about usage of register: R2 in 'UnsetPending'

              LoginMgr.canTouch = true
            else
              ;
              (MessageMgr.SendCenterTips)((PUtil.get)(40000011))
              -- DECOMPILER ERROR at PC197: Confused about usage of register: R2 in 'UnsetPending'

              LoginMgr.canTouch = true
            end
          end
        end
      end
    end
  end
)
end

-- DECOMPILER ERROR at PC112: Confused about usage of register: R0 in 'UnsetPending'

LoginMgr.CreateSocket = function(host, port, ...)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  LoginMgr.ipList = {}
  if (string.find)(host, ":") then
    local ipList = {}
    local urlStrs = split(host, ",")
    if urlStrs then
      for _,urlStr in ipairs(urlStrs) do
        local urlParams = split(urlStr, ":")
        if urlParams then
          local temp_ip = urlParams[1]
          local temp_port = urlParams[2]
          ;
          (table.insert)(ipList, {ip = temp_ip, port = temp_port})
        end
      end
    end
    do
      -- DECOMPILER ERROR at PC39: Confused about usage of register: R4 in 'UnsetPending'

      LoginMgr.ipList = ipList
      do
        local curIpInfo = (LoginMgr.GetRandomUrl)()
        ;
        (Net.Connect)(curIpInfo.ip, curIpInfo.port)
        do return  end
        ;
        (Net.Connect)(host, port)
      end
    end
  end
end

-- DECOMPILER ERROR at PC115: Confused about usage of register: R0 in 'UnsetPending'

LoginMgr.GetRandomUrl = function(...)
  -- function num : 0_3 , upvalues : _ENV
  if #LoginMgr.ipList <= 0 then
    return 
  end
  local ipList = LoginMgr.ipList
  local curIpIndex = (math.ceil)((math.random)(#ipList))
  if not ipList[curIpIndex] then
    local curIpInfo = ipList[#ipList]
  end
  return curIpInfo
end

-- DECOMPILER ERROR at PC118: Confused about usage of register: R0 in 'UnsetPending'

LoginMgr.GetServerName = function(...)
  -- function num : 0_4 , upvalues : _ENV
  local serverId = LoginMgr.curServerId
  if serverId then
    if Game.useSDK == true then
      return serverId
    else
      for _,v in pairs(urlList) do
        if tostring(v.mainServerId) == tostring(serverId) then
          return v.name
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC121: Confused about usage of register: R0 in 'UnsetPending'

LoginMgr.GetChannel = function(...)
  -- function num : 0_5 , upvalues : _ENV
  if Game.useSDK == true then
    return (ProtoEnum.E_CHANNEL).YOOZOO
  else
    return (ProtoEnum.E_CHANNEL).QUICK
  end
end

-- DECOMPILER ERROR at PC124: Confused about usage of register: R0 in 'UnsetPending'

LoginMgr.GetTicket = function(...)
  -- function num : 0_6 , upvalues : _ENV
  if Game.useSDK == true then
    return (SuperSDKData.GetLoginTicket)()
  end
  return LoginMgr.deviceUniqueIdentifier
end

-- DECOMPILER ERROR at PC127: Confused about usage of register: R0 in 'UnsetPending'

LoginMgr.GetAccount = function(...)
  -- function num : 0_7 , upvalues : _ENV
  if Game.useSDK == true then
    return (SuperSDKData.GetLoginUserId)()
  end
  return LoginMgr.deviceUniqueIdentifier
end

-- DECOMPILER ERROR at PC130: Confused about usage of register: R0 in 'UnsetPending'

LoginMgr.GetPlatform = function(...)
  -- function num : 0_8 , upvalues : _ENV
  local platform, str = nil, nil
  if Application.platform == RuntimePlatform.Android then
    platform = (ProtoEnum.E_PLATFORM).ANDROID
    str = "android"
  else
    if Application.platform == RuntimePlatform.IPhonePlayer then
      platform = (ProtoEnum.E_PLATFORM).IOS
      str = "ios"
    else
      platform = (ProtoEnum.E_PLATFORM).PC
      str = "pc"
    end
  end
  return platform, str
end

-- DECOMPILER ERROR at PC133: Confused about usage of register: R0 in 'UnsetPending'

LoginMgr.GetDeviceUniqueIdentifier = function(text, ...)
  -- function num : 0_9 , upvalues : _ENV
  return SystemInfo.deviceUniqueIdentifier .. text
end

-- DECOMPILER ERROR at PC136: Confused about usage of register: R0 in 'UnsetPending'

LoginMgr.ReturnToLoginWindow = function(...)
  -- function num : 0_10 , upvalues : _ENV
  local MsgWaiterObj = require("MsgWaiter")
  MsgWaiterObj.msgTimeoutFuncList = {}
  ;
  (MsgWaiterObj.Destroy)()
  local name = (WinResConfig.LoginWindow).name
  local layer = UILayer.HUD
  if UIMgr:IsWindowOpen((WinResConfig.BattleUIWindow).name) == true then
    (BattleMgr.CloseBattle)(true, function(...)
    -- function num : 0_10_0 , upvalues : _ENV, name, layer
    UIMgr:CloseAllWindow(true)
    OpenWindow(name, layer)
  end
)
  else
    UIMgr:CloseAllWindow(true)
    OpenWindow(name, layer)
  end
end

-- DECOMPILER ERROR at PC139: Confused about usage of register: R0 in 'UnsetPending'

LoginMgr.DealLogin = function(urlInfo, text, ...)
  -- function num : 0_11 , upvalues : _ENV
  if Game.useSDK == true then
    (LoginMgr.StartLogin)(LoginMgr.selectUrlInfo)
  else
    ;
    (LoginMgr.StartLogin)(urlInfo, text)
  end
end

-- DECOMPILER ERROR at PC142: Confused about usage of register: R0 in 'UnsetPending'

LoginMgr.StartLogin = function(urlInfo, text, ...)
  -- function num : 0_12 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  LoginMgr.canTouch = false
  if not text then
    text = ""
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  LoginMgr.deviceUniqueIdentifier = (LoginMgr.GetDeviceUniqueIdentifier)(text)
  ;
  (PlayerPrefs.SetString)(PlayerPrefsKeyName.LOGIN_ACCOUNT_SAVE, text)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

  LoginMgr.curLoginTimestamp = tostring((os.time)())
  ;
  (LoginMgr.ConnectAuthServer)(urlInfo)
end


