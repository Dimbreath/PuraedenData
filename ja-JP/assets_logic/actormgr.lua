-- params : ...
-- function num : 0 , upvalues : _ENV
ActorMgr = {defaultInterval = 50, 
loadProgressTable = {}
, allWeight = 0}
local sendInterval = 0
local sendTime = 0
-- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

ActorMgr.InitHeartMessageUpdate = function(...)
  -- function num : 0_0 , upvalues : sendInterval, sendTime, _ENV
  sendInterval = 0
  sendTime = Time.realtimeSinceStartup
  ;
  (ActorMgr.RemoveHeartUpdate)()
  ;
  (UpdateMgr.AddUpdateHandler)(ActorMgr.HeartMessageCallBack)
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

ActorMgr.HeartMessageCallBack = function(...)
  -- function num : 0_1 , upvalues : _ENV, sendTime, sendInterval
  if sendInterval <= Time.realtimeSinceStartup - sendTime then
    sendInterval = ActorMgr.defaultInterval
    sendTime = Time.realtimeSinceStartup
    ;
    (ActorService.System_ReqPing)()
  end
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

ActorMgr.RemoveHeartUpdate = function(...)
  -- function num : 0_2 , upvalues : _ENV
  (UpdateMgr.RemoveUpdateHandler)(ActorMgr.HeartMessageCallBack)
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

ActorMgr.ReqEnterInfo = function(callBack, ...)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ActorMgr.loadProgressTable = {}
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ActorMgr.allWeight = 0
  ;
  (PayService.ReqPayData)(true, true)
  ;
  (ActorMgr.AddNeedLoadMsg)((Proto.MsgName).ResPayData, 10)
  ;
  (GuideService.ReqNewHand)(true)
  ;
  (ActorMgr.AddNeedLoadMsg)((Proto.MsgName).ResNormalGuide, 10)
  ;
  (GuideService.ReqPictureNewHand)(false, nil, true)
  ;
  (ActorMgr.AddNeedLoadMsg)((Proto.MsgName).ResImageGuide, 10)
  if (FunctionControlMgr.GetFunctionState)(ControlID.Adventure_Plot, false) then
    (PlotDungeonService.ReqStoryInfo)(DungeonType.BasicDungeon, true, true)
    ;
    (ActorMgr.AddNeedLoadMsg)((Proto.MsgName).ResStoryInit, 10)
  end
  -- DECOMPILER ERROR at PC65: Confused about usage of register: R1 in 'UnsetPending'

  ActorMgr.msgCompleteCallBack = function(...)
    -- function num : 0_3_0 , upvalues : _ENV
    (HomeMgr.OpenHome)()
  end

end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

ActorMgr.AddNeedLoadMsg = function(name, weight, ...)
  -- function num : 0_4 , upvalues : _ENV
  if ActorMgr.loadProgressTable then
    (table.insert)(ActorMgr.loadProgressTable, {name = name, weight = weight})
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

    ActorMgr.allWeight = ActorMgr.allWeight + weight
  end
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

ActorMgr.RefreshAfterReconnect = function(...)
  -- function num : 0_5 , upvalues : _ENV
  UIMgr:SendBroadcastMessage((WindowMsgEnum.NETBrokenReconnect).E_MSG_RECONNECT_Ok)
  ;
  (CommonWinMgr.RefreshAssets)()
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'

ActorMgr.PlayEnterSound = function(...)
  -- function num : 0_6 , upvalues : _ENV
  local voiceTable = {}
  local config = (TableData.gTable).BaseCardData
  for _,v in pairs(config) do
    if v.voice_path and v.voice_path ~= "" then
      (table.insert)(voiceTable, v.voice_path)
    end
  end
  if #voiceTable > 0 then
    local index = (math.ceil)((math.random)(1, #voiceTable))
    local path = voiceTable[index]
    if path then
      (LuaSound.AudioMgrPlaySound)(path, false)
    end
  end
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R2 in 'UnsetPending'

ActorMgr.GetCanShowFashion = function(fashionShow, ...)
  -- function num : 0_7 , upvalues : _ENV
  do
    if fashionShow then
      local fashionConfig = ((TableData.gTable).BaseFashionData)[fashionShow]
      if fashionConfig and fashionConfig.type == 3 and ((TableData.gTable).BaseFashionData)[fashionShow - 1] then
        return fashionShow - 1
      end
    end
    return fashionShow
  end
end


