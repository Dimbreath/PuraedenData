-- params : ...
-- function num : 0 , upvalues : _ENV
LoginService = {}
local MsgWaiterObj = require("MsgWaiter")
-- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

LoginService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResLogin, LoginService.OnResLogin)
  ;
  (Net.AddListener)((Proto.MsgName).ResRegister, LoginService.OnResRegister)
  ;
  (Net.AddListener)((Proto.MsgName).ResAlert, LoginService.OnResAlert)
  ;
  (Net.AddListener)((Proto.MsgName).ResGetBindReward, LoginService.OnResGetBindReward)
end

local IsGuest = function(...)
  -- function num : 0_1 , upvalues : _ENV
  if Game.useSDK == true then
    return (SuperSDKUtil.IsGuest)()
  else
    return false
  end
end

-- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

LoginService.ReqLogin = function(isReconnect, ...)
  -- function num : 0_2 , upvalues : _ENV, IsGuest
  local t = {}
  if isReconnect == true then
    t.type = (ProtoEnum.E_LOGIN_TYPE).RELINK
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

    LoginService.isRegister = nil
  else
    t.type = (ProtoEnum.E_LOGIN_TYPE).DEFAULT
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

    LoginService.isRegister = false
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

    LoginMgr.curAccountKey = ""
  end
  t.channel = (LoginMgr.GetChannel)()
  t.account = (LoginMgr.GetAccount)()
  t.platform = (LoginMgr.GetPlatform)()
  t.password = ""
  t.deviceId = SystemInfo.deviceUniqueIdentifier
  t.key = LoginMgr.curAccountKey or ""
  t.guest = IsGuest()
  ;
  (Net.Send)((Proto.MsgName).ReqLogin, t, (Proto.MsgName).ResLogin)
  if isReconnect ~= true then
    ld("Overture")
    ld("Card")
    ld("Equipt")
    ld("RedDot")
    ld("Activity", function(...)
    -- function num : 0_2_0 , upvalues : _ENV
    (ActivityMgr.BindingFunctionID)()
  end
)
    ld("Battle")
    ld("PlotDungeon")
    ld("Chat")
    ld("AssetShop")
    ld("FunctionControl")
    ld("GuideTips")
    ld("Task")
  end
end

-- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

LoginService.ReqLogout = function(...)
  -- function num : 0_3 , upvalues : _ENV, MsgWaiterObj
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

  LoginMgr.account = nil
  local t = {}
  ;
  (Net.Send)((Proto.MsgName).ReqLogout, t)
  ;
  (Net.Close)()
  if AdventureData ~= nil then
    (AdventureData.ResetData)()
  end
  if RedDotManager then
    RedDotManager:ResetEntireTree()
  end
  if EquiptData then
    (EquiptData.ClearEquipData)()
  end
  if PlotDungeonMgr then
    (PlotDungeonMgr.RevertDungeonData)()
  end
  ;
  (MsgWaiterObj.ClearCheckTimer)()
  ;
  (ActorMgr.RemoveHeartUpdate)()
  UIMgr:CloseAllWindow(true)
  OpenWindow("LoginWindow", UILayer.HUD)
end

-- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

LoginService.OnResLogin = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV, IsGuest
  PrintTable(msg, "", "收到登陆回应:")
  local result = msg.result
  local type = msg.type
  local channel = msg.channel
  local waitTime = msg.waitTime
  local currentTime = msg.currentTime
  local serverId = msg.sId
  local platformServerId = msg.psId
  ;
  (ActorData.SetServerTime)(currentTime)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R8 in 'UnsetPending'

  if result == (ProtoEnum.E_LOGIN_RESULT).SUCCESS then
    LoginMgr.account = msg.account
    ;
    (SuperSDKUtil.SendAdLogin)()
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'

    LoginMgr.curServerId = serverId
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R8 in 'UnsetPending'

    LoginMgr.curPlatformServerId = platformServerId
    log("登陆成功")
    ;
    (ActorService.ReqDetailInfo)()
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R8 in 'UnsetPending'

    LoginMgr.curAccountKey = msg.key
    local SettingOpen = tonumber((Util.GetPlayerSetting)(PlayerPrefsKeyName.SCROLL_INFO, "0"))
    if SettingOpen == 1 then
      (ActorService.ReqHorseSet)(true)
    end
    if IsGuest() == false then
      (LoginService.ReqUpgradeAccount)()
    end
  else
    do
      if result == (ProtoEnum.E_LOGIN_RESULT).FAIL then
        log("登陆失败")
        ;
        (MessageMgr.SendCenterTips)((PUtil.get)(40000001))
      else
        if result == (ProtoEnum.E_LOGIN_RESULT).AUTH then
          log("登录过期，重新认证")
          -- DECOMPILER ERROR at PC91: Confused about usage of register: R8 in 'UnsetPending'

          if Game.useSDK == true then
            LoginMgr.directLogin = true
            ;
            (SuperSDKUtil.Login)()
          else
            ;
            (LoginMgr.ConnectAuthServer)(LoginMgr.lastUrlInfo)
          end
        else
          -- DECOMPILER ERROR at PC108: Confused about usage of register: R8 in 'UnsetPending'

          if result == (ProtoEnum.E_LOGIN_RESULT).REGISTER then
            LoginMgr.curServerId = serverId
            -- DECOMPILER ERROR at PC110: Confused about usage of register: R8 in 'UnsetPending'

            LoginMgr.curPlatformServerId = platformServerId
            do
              if Game.jumpOverture == true then
                local ss = (PlayerPrefs.GetString)(PlayerPrefsKeyName.LOGIN_ACCOUNT_SAVE, "")
                ;
                (LoginService.ReqRegister)(ss)
                return 
              end
              ;
              (OvertureMgr.OpenOverture)(function(...)
    -- function num : 0_4_0 , upvalues : _ENV
    log("登陆成功，需要先去注册账号")
    local key = (LoginMgr.GetAccount)() .. "_NAME"
    local ss = (Util.GetPlayerSetting)(key)
    ;
    (LoginService.ReqRegister)(ss)
  end
)
              if result == (ProtoEnum.E_LOGIN_RESULT).WAIT then
                log("登陆成功，需要进行排队")
                ;
                (MessageMgr.SendCenterTips)((PUtil.get)(40000002))
              else
                if result == (ProtoEnum.E_LOGIN_RESULT).LOCK then
                  log("账号被封")
                  ;
                  (MessageMgr.SendCenterTips)((PUtil.get)(40000018))
                end
              end
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

LoginService.ReqRegister = function(name, ...)
  -- function num : 0_5 , upvalues : _ENV, IsGuest
  if name == nil or name == "" then
    name = "unknown"
  end
  local defaultsHeads = {}
  local headDataConfig = (TableData.gTable).BasePlayerHeadIconData
  for k,v in pairs(headDataConfig) do
    if v.type == 1 then
      (table.insert)(defaultsHeads, k)
    end
  end
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

  LoginService.isRegister = true
  local headConfigStr = (((TableData.gTable).BaseFixedData)[72000010]).array_value
  local t = {}
  t.fashionHead = defaultsHeads[(math.random)(1, #defaultsHeads)]
  t.fashionShow = tonumber(headConfigStr)
  t.nickName = name
  t.channel = (LoginMgr.GetChannel)()
  t.account = (LoginMgr.GetAccount)()
  t.platform = (LoginMgr.GetPlatform)()
  t.password = ""
  t.deviceId = SystemInfo.deviceUniqueIdentifier
  t.guest = IsGuest()
  ;
  (Net.Send)((Proto.MsgName).ReqRegister, t, (Proto.MsgName).ResLogin)
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

LoginService.OnResRegister = function(msg, ...)
  -- function num : 0_6 , upvalues : _ENV
  PrintTable(msg, "", "收到注册角色回应:")
  local result = msg.result
  if result ~= (ProtoEnum.E_REGISTER_RESULT).REGISTER_ING or result == (ProtoEnum.E_REGISTER_RESULT).REPEATED then
    (LoginService.ReqLogin)()
  end
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

LoginService.OnResAlert = function(msg, ...)
  -- function num : 0_7 , upvalues : _ENV, MsgWaiterObj
  PrintTable(msg, "", "收到提示消息:")
  local type = msg.type
  local msgId = msg.msgId
  local content = msg.content
  local param = msg.param
  if msgId then
    (MsgWaiterObj.ReceiveMsg)(nil, msgId)
  end
  if type == (ProtoEnum.E_ALERT_TYPE).HIDE then
    return 
  end
  local needQuitBattle = false
  if not (Util.StringIsNullOrEmpty)(content) then
    local str = ((TableData.gTable).BaseAlertData)[content]
    if str and str.name then
      content = str.name
      if not (Util.StringIsNullOrEmpty)(param) then
        local id = tonumber(param)
        if id then
          local config = (Util.GetConfigDataByID)(id)
          if config then
            content = (string.format)(content, config.name)
          end
        end
      end
    end
  end
  do
    if msgId == (Proto.MsgIdByName).ReqArenaFight then
      (MessageMgr.SendCenterTips)((PUtil.get)(60000503))
      if UIMgr:IsWindowOpen((WinResConfig.FormationWindow).name) then
        UIMgr:CloseWindow((WinResConfig.FormationWindow).name)
      end
      ;
      (ArenaService.ReqArenaData)(ArenaRefreshDataType.Rank)
    else
      if type == (ProtoEnum.E_ALERT_TYPE).WARN then
        needQuitBattle = true
        local btnText = nil
        if msgId < 0 then
          if msgId == -1 then
            btnText = (PUtil.get)(40000015)
          end
          ;
          (MsgWaiterObj.ClearCheckTimer)()
          ;
          (ActorMgr.RemoveHeartUpdate)()
          if UIMgr:IsWindowOpen((WinResConfig.BattleUIWindow).name) == true then
            UIMgr:SendWindowMessage((WinResConfig.BattleUIWindow).name, (WindowMsgEnum.BattleUIWindow).E_MSG_BATTLE_PAUSE)
          end
        end
        ;
        (MessageMgr.OpenSoloConfirmWindow)(content, function(...)
    -- function num : 0_7_0 , upvalues : msgId, _ENV
    if msgId == -1 or msgId == -2 or msgId == -3 then
      (LoginMgr.ReturnToLoginWindow)()
    else
      if (msgId == (Proto.MsgIdByName).InitBattleData or msgId == (Proto.MsgIdByName).ReqSettleStage) and UIMgr:IsWindowOpen((WinResConfig.BattleWinConvergeWindow).name) ~= true then
        if UIMgr:IsWindowOpen((WinResConfig.BattleFailConvergeWindow).name) == true then
          ld("Battle", function(...)
      -- function num : 0_7_0_0 , upvalues : _ENV
      (BattleMgr.CloseBattle)()
    end
)
          local Net = require("Net")
          if (Net.IsConnect)() == false then
            (Net.ReConnect)()
          end
        end
      end
    end
  end
, nil, btnText)
      else
        do
          if type == (ProtoEnum.E_ALERT_TYPE).NOTICE then
            loge("跑马灯来了。。。。。。。。。。。。。。。")
            local noticeData = ((TableData.gTable).BaseNoticeData)[msgId]
            local playerIndex = (ActorData.GetPlayerIndex)()
            local SettingOpen = tonumber((Util.GetPlayerSetting)(PlayerPrefsKeyName.SCROLL_INFO, "0"))
            if SettingOpen == 0 or msg.playerIndex and playerIndex == msg.playerIndex and noticeData.is_lottery_show == 1 then
              loge("跑马灯关闭")
              return 
            end
            if noticeData then
              local remark = noticeData.remark
              local noticeContent = nil
              if remark and not (Util.StringIsNullOrEmpty)(remark) then
                local cons = split(content, ",")
                noticeContent = (string.format)(remark, cons[1], cons[2], cons[3], cons[4], cons[5], cons[6])
              else
                do
                  noticeContent = content
                  if tonumber(noticeData.replace) ~= 1 then
                    do
                      do
                        (MessageMgr.SendNoticeMsg)(noticeContent, not (LoginService.CheckIsShowNotice)(noticeData.show_function_ids))
                        ;
                        (MessageMgr.SendNoticeMsg)(content)
                        loge("跑马灯" .. msgId .. "未找到")
                        -- DECOMPILER ERROR: 3 unprocessed JMP targets
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

-- DECOMPILER ERROR at PC29: Confused about usage of register: R2 in 'UnsetPending'

LoginService.CheckIsShowNotice = function(str, ...)
  -- function num : 0_8 , upvalues : _ENV
  local show_function_ids = (Util.ParseConfigStr)(str)
  local mLv = (ActorData.GetLevel)()
  for _,v in ipairs(show_function_ids) do
    local mixLv = tonumber(v[1])
    local maxLv = tonumber(v[2])
    if mLv <= maxLv and mixLv <= mLv then
      for i = 3, #v do
        local functionID = tonumber(v[i])
        if functionID == 0 then
          return true
        end
        local WindowNameData = ((TableData.gTable).BaseWindowNameData)[functionID]
        if WindowNameData and UIMgr:IsWindowOpen(WindowNameData.window_name) then
          return true
        end
      end
    end
  end
  return false
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

LoginService.OnReqSendChar = function(msg, ...)
  -- function num : 0_9 , upvalues : _ENV
  local m = {}
  m.content = msg
  ;
  (Net.Send)((Proto.MsgName).ReqChat, m)
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

LoginService.ReqUpgradeAccount = function(...)
  -- function num : 0_10 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqUpgradeAccount, m)
end

-- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

LoginService.ReqGetBindReward = function(...)
  -- function num : 0_11 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqGetBindReward, m)
end

-- DECOMPILER ERROR at PC41: Confused about usage of register: R2 in 'UnsetPending'

LoginService.OnResGetBindReward = function(...)
  -- function num : 0_12 , upvalues : _ENV
  loge("OnResGetBindReward")
  ;
  (ActorData.SetBindRewardGet)(true)
  SendActivityWindowMessage((ActivityWindowName.ActivityBindingView).name, 1)
end

;
(LoginService.Init)()

