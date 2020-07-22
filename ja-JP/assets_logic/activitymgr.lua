-- params : ...
-- function num : 0 , upvalues : _ENV
ActivityMgr = {}
local openActivityList = {}
local self = ActivityMgr
-- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

ActivityMgr.VitGetState = {MayGet = 0, AlreadyGet = 1, Unable = 2, Buy = 3}
-- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

ActivityMgr.ActivityType = {SevenTask = 1, ActivityDungeon = 2, Drop_Multiple = 3, Limit_Gift = 4, Daily_Pay = 5, Total_Pay = 6, Activity_Lottery = 8, Newbie_Lottery = 9}
ActivityWindowName = {
ActivitySignView = {name = "ActivitySignView", MsgID = (WindowMsgEnum.ActivityMainWindow).SING_INIT, BtnSort = 1, PkgName = "Activity", resName = "Sign", btnBg = "Activity:Activity_002", isOpen = true, RedDotID = RedDotComID.Activity_Sign}
, 
ActivityCakeView = {name = "ActivityCakeView", MsgID = (WindowMsgEnum.ActivityMainWindow).VIT_GET_INIT, BtnSort = 2, PkgName = "Activity", resName = "Cake", btnBg = "Activity:Activity_001", isOpen = true, RedDotID = RedDotComID.Activity_Cake}
, 
ActivitySevenDayView = {name = "ActivitySevenDayView", MsgID = (WindowMsgEnum.ActivityMainWindow).SEVEN_DAY, BtnSort = 3, PkgName = "Activity", resName = "LandReward", btnBg = "Activity:Activity_005", isOpen = true, RedDotID = RedDotComID.Activity_SevenLogin}
, 
ActivityBindingView = {name = "ActivityBindingView", MsgID = (WindowMsgEnum.ActivityMainWindow).BINDING, BtnSort = 4, PkgName = "Activity", resName = "Binding", btnBg = "Activity:Activity_003", isOpen = true}
, 
ActivityGiftCodeView = {name = "ActivityGiftCodeView", MsgID = (WindowMsgEnum.ActivityMainWindow).GIFT_CODE, BtnSort = 5, PkgName = "Activity", resName = "Code", btnBg = "Activity:Activity_004", isOpen = true}
}
-- DECOMPILER ERROR at PC95: Confused about usage of register: R2 in 'UnsetPending'

ActivityMgr.OnClickHomeActivityBtn = function(msgID, ...)
  -- function num : 0_0 , upvalues : _ENV
  if msgID == (WindowMsgEnum.ActivityMainWindow).SING_INIT then
    (ActivityService.OnReqSignInInit)()
  else
    if msgID == (WindowMsgEnum.ActivityMainWindow).VIT_GET_INIT then
      (ActivityService.OnReqVitGetInit)()
    else
      if msgID == (WindowMsgEnum.ActivityMainWindow).BINDING then
        (ActivityMgr.ServiceOpenWindow)(msgID)
      else
        if msgID == (WindowMsgEnum.ActivityMainWindow).GIFT_CODE then
          (ActivityMgr.ServiceOpenWindow)(msgID)
        else
          if msgID == (WindowMsgEnum.ActivityMainWindow).SEVEN_DAY then
            (ActivityService.ReqLoginAct)()
          end
        end
      end
    end
  end
end

self.functionWithMsgID = {}
-- DECOMPILER ERROR at PC100: Confused about usage of register: R2 in 'UnsetPending'

ActivityMgr.BindingMsgIDWithFunctionID = function(msgID, functionID, ...)
  -- function num : 0_1 , upvalues : self
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.functionWithMsgID)[msgID] = functionID
end

-- DECOMPILER ERROR at PC103: Confused about usage of register: R2 in 'UnsetPending'

ActivityMgr.GetActivityDataByMsgID = function(msgID, ...)
  -- function num : 0_2 , upvalues : _ENV
  for _,v in pairs(ActivityWindowName) do
    if msgID == v.MsgID then
      return v
    end
  end
end

-- DECOMPILER ERROR at PC106: Confused about usage of register: R2 in 'UnsetPending'

ActivityMgr.BindingFunctionID = function(...)
  -- function num : 0_3 , upvalues : _ENV
  (ActivityMgr.BindingMsgIDWithFunctionID)((WindowMsgEnum.ActivityMainWindow).SEVEN_DAY, ControlID.Activity_SevenDay)
end

-- DECOMPILER ERROR at PC109: Confused about usage of register: R2 in 'UnsetPending'

ActivityMgr.GetIsOpenByMsgID = function(msgID, ...)
  -- function num : 0_4 , upvalues : self, _ENV
  local functionID = (self.functionWithMsgID)[msgID]
  if msgID == (WindowMsgEnum.ActivityMainWindow).BINDING then
    return not (ActorData.GetBindRewardGet)()
  else
    if functionID then
      return (FunctionControlMgr.GetFunctionState)(functionID, false)
    end
  end
  return true
end

-- DECOMPILER ERROR at PC112: Confused about usage of register: R2 in 'UnsetPending'

ActivityMgr.GetOpenActivityEntire = function(msgID, ...)
  -- function num : 0_5 , upvalues : _ENV
  for _,v in pairs(ActivityWindowName) do
    local isOpen = (ActivityMgr.GetIsOpenByMsgID)(v.MsgID)
    if v.isOpen and isOpen and msgID == v.MsgID then
      return true
    end
  end
  return false
end

-- DECOMPILER ERROR at PC115: Confused about usage of register: R2 in 'UnsetPending'

ActivityMgr.ServiceOpenWindow = function(msgID, ...)
  -- function num : 0_6 , upvalues : _ENV
  if not UIMgr:IsWindowOpen((WinResConfig.ActivityMainWindow).name) then
    UIMgr:SetOnShownComplete((WinResConfig.ActivityMainWindow).name, function(...)
    -- function num : 0_6_0 , upvalues : _ENV, msgID
    UIMgr:SendWindowMessage((WinResConfig.ActivityMainWindow).name, msgID)
  end
)
    OpenWindow((WinResConfig.ActivityMainWindow).name, UILayer.HUD)
  else
    UIMgr:SendWindowMessage((WinResConfig.ActivityMainWindow).name, msgID)
  end
end

-- DECOMPILER ERROR at PC118: Confused about usage of register: R2 in 'UnsetPending'

ActivityMgr.SetOpenActivityList = function(data, ...)
  -- function num : 0_7 , upvalues : openActivityList
  openActivityList = data
end

-- DECOMPILER ERROR at PC121: Confused about usage of register: R2 in 'UnsetPending'

ActivityMgr.RemoveActivity = function(actID, ...)
  -- function num : 0_8 , upvalues : _ENV, openActivityList
  for i,v in ipairs(openActivityList) do
    if v == actID then
      (table.remove)(openActivityList, i)
    end
  end
end

-- DECOMPILER ERROR at PC124: Confused about usage of register: R2 in 'UnsetPending'

ActivityMgr.GetActivityIsOpenByID = function(id, ...)
  -- function num : 0_9 , upvalues : _ENV, openActivityList
  for _,v in ipairs(openActivityList) do
    if tonumber(v) == tonumber(id) then
      return true
    end
  end
  return false
end

-- DECOMPILER ERROR at PC127: Confused about usage of register: R2 in 'UnsetPending'

ActivityMgr.GetActivityIsOpen = function(type, ...)
  -- function num : 0_10 , upvalues : _ENV, openActivityList
  for _,v in ipairs(openActivityList) do
    local activityData = ((TableData.gTable).BaseActivityData)[v]
    if activityData.type == type then
      return true
    end
  end
  return false
end

-- DECOMPILER ERROR at PC130: Confused about usage of register: R2 in 'UnsetPending'

ActivityMgr.GetOpenActivityByType = function(type, ...)
  -- function num : 0_11 , upvalues : _ENV, openActivityList
  for _,v in ipairs(openActivityList) do
    local activityData = ((TableData.gTable).BaseActivityData)[v]
    if activityData.type == type then
      return tonumber(v)
    end
  end
end

-- DECOMPILER ERROR at PC133: Confused about usage of register: R2 in 'UnsetPending'

ActivityMgr.GetMultipleIsOpenByChallengeType = function(challengeType, ...)
  -- function num : 0_12 , upvalues : _ENV, openActivityList
  for _,v in ipairs(openActivityList) do
    local activityData = ((TableData.gTable).BaseActivityData)[v]
    if activityData.type == (ActivityMgr.ActivityType).Drop_Multiple then
      local param = split(activityData.parameter1, ":")
      if param and tonumber(param[1]) == challengeType then
        return true
      end
    end
  end
  return false
end

-- DECOMPILER ERROR at PC136: Confused about usage of register: R2 in 'UnsetPending'

ActivityMgr.VitGetInitData = function(data, ...)
  -- function num : 0_13 , upvalues : self
  if data == nil then
    return self.VitGetInit
  else
    self.VitGetInit = data
  end
end

-- DECOMPILER ERROR at PC139: Confused about usage of register: R2 in 'UnsetPending'

ActivityMgr.GetVitConfigData = function(...)
  -- function num : 0_14 , upvalues : self, _ENV
  if self.VitConfigData ~= nil and #self.VitConfigData > 0 then
    return self.VitConfigData
  end
  local VitGetData = (TableData.gTable).BaseVitGetData
  self.VitConfigData = {}
  for _,v in pairs(VitGetData) do
    (table.insert)(self.VitConfigData, v)
  end
  ;
  (table.sort)(self.VitConfigData, function(a, b, ...)
    -- function num : 0_14_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return self.VitConfigData
end

-- DECOMPILER ERROR at PC142: Confused about usage of register: R2 in 'UnsetPending'

ActivityMgr.GetVitState = function(id, ...)
  -- function num : 0_15 , upvalues : _ENV, self
  for _,v in ipairs((self.VitGetInit).canGetId) do
    if id == v then
      return (ActivityMgr.VitGetState).MayGet
    end
  end
  for _,v in ipairs((self.VitGetInit).extraId) do
    if id == v then
      return (ActivityMgr.VitGetState).Buy
    end
  end
  for _,v in ipairs((self.VitGetInit).getedId) do
    if id == v then
      return (ActivityMgr.VitGetState).AlreadyGet
    end
  end
  return (ActivityMgr.VitGetState).Unable
end

-- DECOMPILER ERROR at PC145: Confused about usage of register: R2 in 'UnsetPending'

ActivityMgr.SetGetVitData = function(id, ...)
  -- function num : 0_16 , upvalues : _ENV, self
  (table.insert)((self.VitGetInit).getedId, id)
  local pos = 0
  for i,v in ipairs((self.VitGetInit).extraId) do
    if v == id then
      pos = i
    end
  end
  if pos > 0 then
    (table.remove)((self.VitGetInit).extraId, pos)
    return 
  end
  for i,v in ipairs((self.VitGetInit).canGetId) do
    if v == id then
      pos = i
    end
  end
  if pos > 0 then
    (table.remove)((self.VitGetInit).canGetId, pos)
    if #(self.VitGetInit).canGetId <= 0 then
      (RedDotMgr.EliminateRedDot)((WinResConfig.ActivityMainWindow).name, RedDotComID.Activity_Cake)
    end
    return 
  end
  loge("未在可领取和可补领集合中找到" .. id)
end

-- DECOMPILER ERROR at PC151: Confused about usage of register: R2 in 'UnsetPending'

ActivityMgr.SignItemState = {Already = 1, Enable = 2, UnEnable = 3}
-- DECOMPILER ERROR at PC154: Confused about usage of register: R2 in 'UnsetPending'

ActivityMgr.SingInitData = function(data, ...)
  -- function num : 0_17 , upvalues : self
  if data == nil then
    return self.SignInit
  else
    self.SignInit = data
  end
end

-- DECOMPILER ERROR at PC157: Confused about usage of register: R2 in 'UnsetPending'

ActivityMgr.SetSignData = function(data, ...)
  -- function num : 0_18 , upvalues : self
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (self.SignInit).totalSignInDay = data.totalSignInDay
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.SignInit).signInedDay = data.signInedDay
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.SignInit).canSignIn = false
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.SignInit).canGetExtra = data.canGetExtra
end

-- DECOMPILER ERROR at PC160: Confused about usage of register: R2 in 'UnsetPending'

ActivityMgr.SetExtraId = function(id, enableGet, ...)
  -- function num : 0_19 , upvalues : self
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.SignInit).extraId = id
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.SignInit).canGetExtra = enableGet
end

-- DECOMPILER ERROR at PC163: Confused about usage of register: R2 in 'UnsetPending'

ActivityMgr.CheckIsDisPosRedDot = function(...)
  -- function num : 0_20 , upvalues : self, _ENV
  if not (self.SignInit).canSignIn and not (ActivityMgr.EnableGetExtra)() then
    (RedDotMgr.EliminateRedDot)((WinResConfig.ActivityMainWindow).name, RedDotComID.Activity_Sign)
  end
end

-- DECOMPILER ERROR at PC166: Confused about usage of register: R2 in 'UnsetPending'

ActivityMgr.GetSignState = function(index, ...)
  -- function num : 0_21 , upvalues : self, _ENV
  local SignNum = (self.SignInit).signInedDay
  if index < SignNum then
    return (ActivityMgr.SignItemState).Already
  else
    if index == SignNum and (self.SignInit).canSignIn then
      return (ActivityMgr.SignItemState).Enable
    else
      return (ActivityMgr.SignItemState).UnEnable
    end
  end
end

-- DECOMPILER ERROR at PC169: Confused about usage of register: R2 in 'UnsetPending'

ActivityMgr.EnableGetExtra = function(...)
  -- function num : 0_22 , upvalues : self
  return (self.SignInit).canGetExtra
end

local maxInteger = {}
-- DECOMPILER ERROR at PC173: Confused about usage of register: R3 in 'UnsetPending'

ActivityMgr.InitSevenDayTaskData = function(data, ...)
  -- function num : 0_23 , upvalues : self
  if data == nil then
    return self.SevenDayTaskData
  else
    self.SevenDayTaskData = data
  end
end

-- DECOMPILER ERROR at PC176: Confused about usage of register: R3 in 'UnsetPending'

ActivityMgr.GetRemainDay = function(...)
  -- function num : 0_24 , upvalues : _ENV, self
  return (math.ceil)(((self.SevenDayTaskData).SevenDayActInfo).rewardTime / 86400000)
end

-- DECOMPILER ERROR at PC179: Confused about usage of register: R3 in 'UnsetPending'

ActivityMgr.GetTaskGroupIsOpen = function(groupID, ...)
  -- function num : 0_25 , upvalues : _ENV
  local groupList = (((ActivityMgr.InitSevenDayTaskData)()).SevenDayActInfo).openedGroup
  for _,v in ipairs(groupList) do
    if v == groupID then
      return true
    end
  end
  return false
end

-- DECOMPILER ERROR at PC182: Confused about usage of register: R3 in 'UnsetPending'

ActivityMgr.GetMaxInteger = function(actId, ...)
  -- function num : 0_26 , upvalues : maxInteger, _ENV
  if maxInteger[actId] then
    return maxInteger[actId]
  else
    local int = (ActivityMgr.CalculateMaxInteger)(actId)
    local activityData = ((TableData.gTable).BaseActivityData)[actId]
    local onceGet = (split(activityData.parameter1, ":"))[3]
    maxInteger[actId] = int * tonumber(onceGet)
    return int
  end
end

-- DECOMPILER ERROR at PC185: Confused about usage of register: R3 in 'UnsetPending'

ActivityMgr.CalculateMaxInteger = function(actId, ...)
  -- function num : 0_27 , upvalues : _ENV
  local activityData = ((TableData.gTable).BaseActivityData)[actId]
  local groupList = split(activityData.task_group, ":")
  local count = 0
  for _,v in ipairs(groupList) do
    local activityData = ((TableData.gTable).BaseActivityGroupData)[tonumber(v)]
    local taskList = split(activityData.task_list, ":")
    for _,v2 in ipairs(taskList) do
      local taskData = ((TableData.gTable).BaseActivityTaskData)[tonumber(v2)]
      count = count + taskData.reward_points
    end
  end
  return count
end

-- DECOMPILER ERROR at PC188: Confused about usage of register: R3 in 'UnsetPending'

ActivityMgr.InitSevenLoginData = function(data, ...)
  -- function num : 0_28 , upvalues : self
  if data == nil then
    return self.SevenLoginData
  else
    self.SevenLoginData = data
  end
end

-- DECOMPILER ERROR at PC191: Confused about usage of register: R3 in 'UnsetPending'

ActivityMgr.InitActivityDungeonData = function(data, ...)
  -- function num : 0_29 , upvalues : self
  if data == nil then
    return self.DungeonActivityInfo
  else
    self.DungeonActivityInfo = data
  end
end

-- DECOMPILER ERROR at PC194: Confused about usage of register: R3 in 'UnsetPending'

ActivityMgr.PlotRedDotShow = function(...)
  -- function num : 0_30 , upvalues : _ENV
  local value = (Util.GetPlayerSetting)(PlayerPrefsKeyName.ACTIVITY_DUNGEON_PLOT_DOT, -1)
  do return not value or tonumber(value) > 0 end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end


