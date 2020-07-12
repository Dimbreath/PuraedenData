-- params : ...
-- function num : 0 , upvalues : _ENV
TaskMgr = {}
TaskType = {GrowUp = 1, Daily = 2, Weekly = 3}
local self = TaskMgr
self.TaskList = {}
self.BoxList = {}
self.Liveliness = {}
self.TaskType = nil
-- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

TaskMgr.InitTaskData = function(msg, type, force, ...)
  -- function num : 0_0 , upvalues : self, _ENV
  self.TaskList = {}
  for _,v in ipairs(msg.taskList) do
    (table.insert)(self.TaskList, v)
  end
  self.BoxList = {}
  for _,v in ipairs(msg.taskBoxList) do
    (table.insert)(self.BoxList, v)
  end
  self.Liveliness = {}
  for _,v in ipairs(msg.livenessList) do
    (table.insert)(self.Liveliness, v)
  end
  self.TaskType = type
  if UIMgr:IsWindowOpen((WinResConfig.TaskWindow).name) and not msg.getBox then
    UIMgr:SendWindowMessage((WinResConfig.TaskWindow).name, (WindowMsgEnum.TaskWindow).TASK_REFRESH_WINDOW, force)
  end
  ;
  (GuideMgr.InGuideOpenWindow)((WinResConfig.TaskWindow).name, UILayer.HUD, self.TaskType)
end

-- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

TaskMgr.GetCurrentTaskType = function(...)
  -- function num : 0_1 , upvalues : self
  return self.TaskType
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

TaskMgr.CheckDisposeRedDot = function(...)
  -- function num : 0_2 , upvalues : _ENV, self
  if (TaskMgr.CheckIsCanCommit)() then
    local conID = 0
    if self.TaskType == TaskType.Daily then
      conID = RedDotComID.Task_Daily
    else
      if self.TaskType == TaskType.Weekly then
        conID = RedDotComID.Task_Weekly
      else
        if self.TaskType == TaskType.GrowUp then
          conID = RedDotComID.Task_GrowUp
        end
      end
    end
    ;
    (RedDotService.ReqRemoveRedDot)((WinResConfig.TaskWindow).name, conID)
  end
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

TaskMgr.CheckIsCanCommit = function(...)
  -- function num : 0_3 , upvalues : self, _ENV
  if self.TaskType == TaskType.Daily then
    local BigMonth = (PayData.GetMonthCardCanGet)(PayProductType.BigMonthCard)
    local LittleMonth = (PayData.GetMonthCardCanGet)(PayProductType.LittleMonthCard)
    if LittleMonth or BigMonth then
      return false
    end
  end
  do
    for _,v in ipairs(self.TaskList) do
      if v.status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_CAN then
        return false
      end
    end
    for _,v in ipairs(self.BoxList) do
      if v.status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_CAN then
        return false
      end
    end
    return true
  end
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

TaskMgr.GetTaskIsNotComplete = function(id, ...)
  -- function num : 0_4 , upvalues : _ENV, self
  for _,v in ipairs(self.TaskList) do
    if v.status ~= (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_NOT then
      do
        do return v.id ~= id end
        -- DECOMPILER ERROR at PC16: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC16: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

TaskMgr.SetTaskData = function(msg, ...)
  -- function num : 0_5 , upvalues : _ENV, self
  if msg.result then
    for _,v in ipairs(self.TaskList) do
      if v.id == msg.id then
        v.status = (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_HAS
      end
    end
    local taskData = ((TableData.gTable).BaseTaskData)[tonumber(msg.id)]
    local rewards = (Util.ParseConfigStr)(taskData.reward)
    local items = {}
    for _,v in ipairs(rewards) do
      local ItemDataModel = {}
      ItemDataModel.id = tonumber(v[2])
      ItemDataModel.Num = tonumber(v[3])
      ;
      (table.insert)(items, ItemDataModel)
    end
    local LivelinessValue = taskData.liveness
    do
      if LivelinessValue > 0 then
        local ItemDataModel = {}
        ItemDataModel.id = (TaskMgr.GetLivelinessId)(taskData.type)
        ItemDataModel.Num = LivelinessValue
        ;
        (table.insert)(items, ItemDataModel)
      end
      ;
      (MessageMgr.OpenItemBuyTipsWindow)(items)
      ;
      (TaskMgr.CheckDisposeRedDot)()
    end
  end
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

TaskMgr.GetTaskList = function(taskType, ...)
  -- function num : 0_6 , upvalues : _ENV, self
  local taskList = {}
  for _,v in ipairs(self.TaskList) do
    local taskData = ((TableData.gTable).BaseTaskData)[tonumber(v.id)]
    if taskData.type == taskType then
      (table.insert)(taskList, v)
    end
  end
  ;
  (table.sort)(taskList, function(a, b, ...)
    -- function num : 0_6_0 , upvalues : _ENV
    local aData = ((TableData.gTable).BaseTaskData)[tonumber(a.id)]
    local bData = ((TableData.gTable).BaseTaskData)[tonumber(b.id)]
    local aTotal = 0
    if a.status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_CAN then
      aTotal = 10000
    else
      if a.status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_NOT then
        aTotal = 1000
      end
    end
    local bTotal = 0
    if b.status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_CAN then
      bTotal = 10000
    else
      if b.status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_NOT then
        bTotal = 1000
      end
    end
    do return bTotal - bData.sort_weight < aTotal - aData.sort_weight end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return taskList
end

-- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

TaskMgr.GetLiveliness = function(taskType, ...)
  -- function num : 0_7 , upvalues : _ENV, self
  for _,v in ipairs(self.Liveliness) do
    if tonumber(v.id) == tonumber(taskType) then
      return v.value
    end
  end
end

self.GroupGrowUpTaskBox = function(...)
  -- function num : 0_8 , upvalues : self, _ENV
  local mList = {}
  local mList2 = {}
  local currentBox = (self.GetCurrentGrowUpTaskBox)()
  for _,v in ipairs(self.GrowUpBox) do
    (table.insert)(mList, v)
    if #mList == 5 then
      (table.insert)(mList2, mList)
      mList = {}
    end
  end
  local Num = (math.floor)((math.abs)(currentBox - 1) / 5) + 1
  return mList2[Num]
end

self.GetCurrentGrowUpTaskBox = function(...)
  -- function num : 0_9 , upvalues : _ENV, self
  for i,v in ipairs(self.GrowUpBox) do
    if (TaskMgr.GetTaskBoxState)(v.id) == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_CAN then
      return i
    end
  end
  return 0
end

-- DECOMPILER ERROR at PC45: Confused about usage of register: R1 in 'UnsetPending'

TaskMgr.GetTaskBoxState = function(boxID, ...)
  -- function num : 0_10 , upvalues : _ENV, self
  boxID = tonumber(boxID)
  for _,v in ipairs(self.BoxList) do
    if v.id == boxID then
      return v.status
    end
  end
  return (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_NOT
end

-- DECOMPILER ERROR at PC48: Confused about usage of register: R1 in 'UnsetPending'

TaskMgr.SetTaskBox = function(msg, ...)
  -- function num : 0_11 , upvalues : _ENV, self
  if msg.result then
    for _,v in ipairs(self.BoxList) do
      if v.id == msg.boxId then
        v.status = (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_HAS
      end
    end
    UIMgr:SendWindowMessage((WinResConfig.TaskWindow).name, (WindowMsgEnum.TaskWindow).TASK_REFRESH_TASK_LIVELINESS)
    ;
    (TaskMgr.CheckDisposeRedDot)()
  end
end

-- DECOMPILER ERROR at PC51: Confused about usage of register: R1 in 'UnsetPending'

TaskMgr.GetTaskBox = function(taskType, ...)
  -- function num : 0_12 , upvalues : _ENV, self
  local boxS = {}
  for _,v in ipairs(self.BoxList) do
    local boxData = ((TableData.gTable).BaseTaskBoxData)[v.id]
    if boxData.type == taskType then
      (table.insert)(boxS, boxData)
    end
  end
  ;
  (table.sort)(boxS, function(a, b, ...)
    -- function num : 0_12_0
    do return a.sort < b.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return boxS
end

-- DECOMPILER ERROR at PC54: Confused about usage of register: R1 in 'UnsetPending'

TaskMgr.GetLivelinessId = function(taskType, ...)
  -- function num : 0_13 , upvalues : _ENV
  local Id = 0
  if taskType == TaskType.Daily then
    Id = AssetType.DAILY_LIVELINESS
  else
    if taskType == TaskType.Weekly then
      Id = AssetType.WEEKLY_LIVELINESS
    else
      if taskType == TaskType.GrowUp then
        Id = AssetType.GROW_UP
      end
    end
  end
  return Id
end

-- DECOMPILER ERROR at PC57: Confused about usage of register: R1 in 'UnsetPending'

TaskMgr.GetTaskTypeName = function(type, ...)
  -- function num : 0_14 , upvalues : _ENV
  if type == TaskType.Daily then
    return (PUtil.get)(20000088)
  else
    if type == TaskType.Weekly then
      return (PUtil.get)(20000089)
    else
      if type == TaskType.GrowUp then
        return (PUtil.get)(20000090)
      end
    end
  end
end


