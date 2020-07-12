-- params : ...
-- function num : 0 , upvalues : _ENV
TaskService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

TaskService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResTaskData, TaskService.OnResTaskData)
  ;
  (Net.AddListener)((Proto.MsgName).ResGetTaskBox, TaskService.OnResGetTaskBox)
  ;
  (Net.AddListener)((Proto.MsgName).ResSubmitTask, TaskService.OnResSubmitTask)
end

local mType = nil
local canReq = true
local mForce = false
-- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

TaskService.ReqTaskData = function(type, force, ...)
  -- function num : 0_1 , upvalues : canReq, _ENV, mType, mForce
  if canReq then
    local m = {}
    m.type = type
    ;
    (Net.Send)((Proto.MsgName).ReqTaskData, m, (Proto.MsgName).ResTaskData)
    canReq = false
    ;
    (SimpleTimer.setTimeout)(0.1, function(...)
    -- function num : 0_1_0 , upvalues : canReq
    canReq = true
  end
)
    mType = type
    mForce = force
  end
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

TaskService.OnResTaskData = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV, mType, mForce
  (TaskMgr.InitTaskData)(msg, mType, mForce)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

TaskService.ReqGetTaskBox = function(boxId, ...)
  -- function num : 0_3 , upvalues : _ENV
  local m = {}
  m.boxId = boxId
  ;
  (Net.Send)((Proto.MsgName).ReqGetTaskBox, m, (Proto.MsgName).ResGetTaskBox)
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

TaskService.OnResGetTaskBox = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV
  (TaskMgr.SetTaskBox)(msg)
  local boxData = ((TableData.gTable).BaseTaskBoxData)[msg.boxId]
  if boxData then
    (MessageMgr.OpenItemBuyTipsWindowByStr)(boxData.reward)
  end
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

TaskService.ReqSubmitTask = function(taskId, ...)
  -- function num : 0_5 , upvalues : _ENV
  local m = {}
  m.id = taskId
  ;
  (Net.Send)((Proto.MsgName).ReqSubmitTask, m, (Proto.MsgName).ResSubmitTask)
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

TaskService.OnResSubmitTask = function(msg, ...)
  -- function num : 0_6 , upvalues : _ENV
  (TaskMgr.SetTaskData)(msg)
end

;
(TaskService.Init)()

