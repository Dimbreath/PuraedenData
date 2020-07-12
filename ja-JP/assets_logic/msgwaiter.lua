-- params : ...
-- function num : 0 , upvalues : _ENV
local MsgWaiterObj = {}
MsgWaiterObj.TIMEOUT_TIME = 15
MsgWaiterObj.waitMsgNameTable = {}
MsgWaiterObj.msgTimeoutFuncList = {}
MsgWaiterObj.timeoutCheckTimer = nil
local _confirmMarker = "MsgWaiterConfirmWin"
MsgWaiter = function(MsgName, sendMsgName, timeoutCallback, reconnectType, showWaitingWindowType, ...)
  -- function num : 0_0 , upvalues : _ENV, MsgWaiterObj
  if type(MsgName) ~= "string" then
    return 
  end
  if not reconnectType then
    reconnectType = 1
  end
  local waitMsgCountTable = (MsgWaiterObj.waitMsgNameTable)[MsgName]
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R6 in 'UnsetPending'

  if waitMsgCountTable == nil then
    (MsgWaiterObj.waitMsgNameTable)[MsgName] = {count = 1, msg = sendMsgName}
  else
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((MsgWaiterObj.waitMsgNameTable)[MsgName]).count = ((MsgWaiterObj.waitMsgNameTable)[MsgName]).count + 1
  end
  PrintTable(MsgWaiterObj.waitMsgNameTable, "添加后监听：")
  local isWaitingWindowOpen = UIMgr:IsWindowOpen((WinResConfig.MsgWaitingWindow).name)
  if isWaitingWindowOpen == true then
    OpenWindow((WinResConfig.MsgWaitingWindow).name, UILayer.God)
    if MsgWaiterObj.timeoutCheckTimer == nil then
      MsgWaiterObj.timeoutCheckTimer = (SimpleTimer.setInterval)(1, MsgWaiterObj.TIMEOUT_TIME, function(...)
    -- function num : 0_0_0 , upvalues : _ENV, MsgName, MsgWaiterObj
    if (Net.IsConnect)() == false and MsgName ~= "CONNECT_AUTH" then
      (MsgWaiterObj.Reconnect)()
    end
  end
, function(...)
    -- function num : 0_0_1 , upvalues : MsgWaiterObj, reconnectType
    (MsgWaiterObj.PromptMsgTimeout)(reconnectType)
  end
)
    end
    ;
    (MsgWaiterObj.AddTimeoutFunc)(MsgName, timeoutCallback)
  end
end

MsgWaiterObj.AddTimeoutFunc = function(MsgName, timeoutCallback, ...)
  -- function num : 0_1 , upvalues : MsgWaiterObj
  local msgTimeoutFuncList = MsgWaiterObj.msgTimeoutFuncList
  if timeoutCallback == nil then
    return 
  end
  msgTimeoutFuncList[MsgName] = timeoutCallback
end

MsgWaiterObj.RemoveTimeoutFunc = function(MsgName, ...)
  -- function num : 0_2 , upvalues : _ENV, MsgWaiterObj
  loge("   RemoveTimeoutFunc   " .. MsgName)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (MsgWaiterObj.msgTimeoutFuncList)[MsgName] = nil
end

MsgWaiterObj.DealTimeoutFunc = function(...)
  -- function num : 0_3 , upvalues : MsgWaiterObj, _ENV
  local msgTimeoutFuncList = MsgWaiterObj.msgTimeoutFuncList
  for MsgName,timeoutCallback in pairs(msgTimeoutFuncList) do
    if timeoutCallback then
      local callback = timeoutCallback
      msgTimeoutFuncList[MsgName] = nil
      callback()
    end
  end
end

MsgWaiterObj.ReceiveMsg = function(MsgId, sendMsgId, msgName, ...)
  -- function num : 0_4 , upvalues : _ENV, MsgWaiterObj, _confirmMarker
  if MsgId == nil and sendMsgId ~= nil and msgName == nil then
    local name = (Proto.MsgNameByID)[sendMsgId]
    for msgName,info in pairs(MsgWaiterObj.waitMsgNameTable) do
      if info.msg == name then
        info.count = info.count - 1
        -- DECOMPILER ERROR at PC23: Confused about usage of register: R9 in 'UnsetPending'

        if info.count <= 0 then
          (MsgWaiterObj.waitMsgNameTable)[msgName] = nil
          ;
          (MsgWaiterObj.RemoveTimeoutFunc)(msgName)
        end
        local res_msg_id = (Proto.MsgIdByName)[msgName]
        ;
        (GuideMgr.TerminateCurrentStep)(res_msg_id)
        break
      end
    end
    do
      do
        if (_G.next)(MsgWaiterObj.waitMsgNameTable) == nil then
          (MsgWaiterObj.Destroy)()
          ;
          (MessageMgr.CloseConfirm)(_confirmMarker)
        end
        do return  end
        if MsgId then
          (GuideMgr.TerminateCurrentStep)(MsgId)
        end
        if not msgName then
          local msgName = (Proto.MsgNameByID)[MsgId]
        end
        local loadProgressTable = ActorMgr.loadProgressTable
        if loadProgressTable and #loadProgressTable > 0 then
          for i,v in ipairs(loadProgressTable) do
            if v.name == msgName then
              local value = 0.01 + v.weight / ActorMgr.allWeight
              UIMgr:SendWindowMessage((WinResConfig.LoadingWindow).name, (WindowMsgEnum.LoadingWindow).E_MSG_UPDATE_LOADING_PROCESS_TWEEN_ADD, {value = value, callback = ActorMgr.msgCompleteCallBack})
              ;
              (table.remove)(loadProgressTable, i)
              break
            end
          end
        end
        do
          loge(" msgName " .. msgName)
          PrintTable(MsgWaiterObj.waitMsgNameTable, "MsgWaiterObj.waitMsgNameTable")
          -- DECOMPILER ERROR at PC127: Confused about usage of register: R5 in 'UnsetPending'

          if (MsgWaiterObj.waitMsgNameTable)[msgName] and ((MsgWaiterObj.waitMsgNameTable)[msgName]).count > 0 then
            if msgName == (Proto.MsgName).ResPing then
              ((MsgWaiterObj.waitMsgNameTable)[msgName]).count = 0
            else
              -- DECOMPILER ERROR at PC135: Confused about usage of register: R5 in 'UnsetPending'

              ;
              ((MsgWaiterObj.waitMsgNameTable)[msgName]).count = ((MsgWaiterObj.waitMsgNameTable)[msgName]).count - 1
            end
            loge("----------1")
            if ((MsgWaiterObj.waitMsgNameTable)[msgName]).count <= 0 then
              loge("----------2")
              -- DECOMPILER ERROR at PC148: Confused about usage of register: R5 in 'UnsetPending'

              ;
              (MsgWaiterObj.waitMsgNameTable)[msgName] = nil
              ;
              (MsgWaiterObj.RemoveTimeoutFunc)(msgName)
            end
          end
          if (_G.next)(MsgWaiterObj.waitMsgNameTable) == nil then
            (MsgWaiterObj.Destroy)()
            ;
            (MessageMgr.CloseConfirm)(_confirmMarker)
          end
        end
      end
    end
  end
end

MsgWaiterObj.Reset = function(...)
  -- function num : 0_5 , upvalues : _ENV, MsgWaiterObj
  loge("  MsgWaiterObj.Reset  ")
  MsgWaiterObj._gene_req_func_list_index = 1
  ;
  (MsgWaiterObj.ClearCheckTimer)()
  MsgWaiterObj.waitMsgNameTable = {}
end

MsgWaiterObj.ClearCheckTimer = function(...)
  -- function num : 0_6 , upvalues : MsgWaiterObj
  local timeoutCheckTimer = MsgWaiterObj.timeoutCheckTimer
  if timeoutCheckTimer then
    timeoutCheckTimer:stop()
    MsgWaiterObj.timeoutCheckTimer = nil
  end
  ;
  (MsgWaiterObj.CloseWaitingWindow)()
end

MsgWaiterObj.CloseWaitingWindow = function(...)
  -- function num : 0_7 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.MsgWaitingWindow).name, true, true)
end

MsgWaiterObj.Reconnect = function(...)
  -- function num : 0_8 , upvalues : MsgWaiterObj, _ENV
  (MsgWaiterObj.Reset)()
  local ResendPak = require("ResendPak")
  ;
  (ResendPak.DoReconnect)()
end

MsgWaiterObj.PromptMsgTimeout = function(reconnectType, callback, title, ...)
  -- function num : 0_9 , upvalues : _ENV, MsgWaiterObj, _confirmMarker
  loge("    PromptMsgTimeout    " .. reconnectType)
  if reconnectType == 2 then
    (MsgWaiterObj.Reconnect)()
    return 
  end
  ;
  (MsgWaiterObj.ClearCheckTimer)()
  ;
  (ActorMgr.RemoveHeartUpdate)()
  if (MessageMgr.IsConfirmShow)(_confirmMarker) == true then
    return 
  end
  if not title then
    (MessageMgr.OpenConfirmWindow)((PUtil.get)(40000003), function(...)
    -- function num : 0_9_0 , upvalues : _ENV, MsgWaiterObj, reconnectType, callback
    if IsNetworkError() == true then
      (MsgWaiterObj.PromptMsgTimeout)(reconnectType, callback)
    else
      if callback then
        callback()
      else
        ;
        (MsgWaiterObj.Reconnect)()
      end
    end
  end
, function(...)
    -- function num : 0_9_1 , upvalues : _ENV
    (LoginMgr.ReturnToLoginWindow)()
  end
, (PUtil.get)(40000007), (PUtil.get)(40000005), (PUtil.get)(40000004), false, UILayer.God, _confirmMarker)
    for name,info in pairs(MsgWaiterObj.waitMsgNameTable) do
      loge("未收到的消息：" .. name .. "  发送的消息：" .. info.msg)
    end
  end
end

MsgWaiterObj.Destroy = function(...)
  -- function num : 0_10 , upvalues : MsgWaiterObj
  (MsgWaiterObj.Reset)()
  MsgWaiterObj.waitMsgNameTable = {}
end

return MsgWaiterObj

