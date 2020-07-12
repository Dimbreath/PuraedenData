-- params : ...
-- function num : 0 , upvalues : _ENV
require("Task_TaskByName")
require("Task_TaskDetailedByName")
local TaskWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local openTaskType = TaskType.Daily
local AlreadyShow = false
local offsetY = 0
local gotoId = 0
local isBackOpen = false
local taskListData = nil
TaskWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, TaskWindow, isBackOpen, openTaskType
  bridgeObj:SetView((WinResConfig.TaskWindow).package, (WinResConfig.TaskWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetTask_TaskUis(contentPane)
  ;
  (TaskWindow.InitAssetStrip)()
  isBackOpen = bridgeObj.OpenFromClose
  ;
  (TaskWindow.InitTaskTabBtn)()
  ;
  (TaskWindow.InitFunctionControl)()
  if not isBackOpen and argTable[1] then
    openTaskType = argTable[1]
  end
  ;
  (uis.TaskDetailedList):SetVirtual()
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.TaskDetailedList).itemRenderer = TaskWindow.Renderer
  ;
  (uis.TaskDetailedList):SetBeginAnim(false, "up", 0.05, 0.05)
  if isBackOpen then
    (uis.TaskDetailedList):SetAnimIsPlay(false)
    if openTaskType == TaskType.Daily then
      (((uis.TaskPanelGrp).DayBtn).onClick):Call()
    else
      if openTaskType == TaskType.Weekly then
        (((uis.TaskPanelGrp).WeekBtn).onClick):Call()
      else
        if openTaskType == TaskType.GrowUp then
          (((uis.TaskPanelGrp).AlwaysBtn).onClick):Call()
        end
      end
    end
    ;
    (uis.TaskDetailedList):SetAnimIsPlay(false)
  else
    -- DECOMPILER ERROR at PC96: Confused about usage of register: R1 in 'UnsetPending'

    if openTaskType == TaskType.Daily then
      ((uis.TaskPanelGrp).c1Ctr).selectedIndex = 0
    else
      -- DECOMPILER ERROR at PC105: Confused about usage of register: R1 in 'UnsetPending'

      if openTaskType == TaskType.Weekly then
        ((uis.TaskPanelGrp).c1Ctr).selectedIndex = 1
      else
        -- DECOMPILER ERROR at PC114: Confused about usage of register: R1 in 'UnsetPending'

        if openTaskType == TaskType.GrowUp then
          ((uis.TaskPanelGrp).c1Ctr).selectedIndex = 2
        end
      end
    end
    ;
    (TaskWindow.RefreshWin)()
  end
  ;
  (Util.SetOnClickDelay)(0.5)
  ;
  (TaskWindow.Binding)()
  GuideSetDelayShow(contentPane)
end

TaskWindow.Binding = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local BindingUI = RedDotMgr.BindingUI
  local RedDotComID = RedDotComID
  local winName = (WinResConfig.TaskWindow).name
  BindingUI(winName, RedDotComID.Task_Daily, (uis.TaskPanelGrp).DayBtn)
  BindingUI(winName, RedDotComID.Task_Weekly, (uis.TaskPanelGrp).WeekBtn)
  BindingUI(winName, RedDotComID.Task_GrowUp, (uis.TaskPanelGrp).AlwaysBtn)
  ;
  (RedDotMgr.RefreshTreeUI)(winName)
end

TaskWindow.OnShown = function(...)
  -- function num : 0_2
end

TaskWindow.OnHide = function(...)
  -- function num : 0_3 , upvalues : AlreadyShow
  AlreadyShow = false
end

TaskWindow.OnClose = function(...)
  -- function num : 0_4 , upvalues : _ENV, uis, contentPane, argTable
  (GuideData.AbolishControlRefer)((WinResConfig.TaskWindow).name)
  ;
  (RedDotMgr.RemoveUIRefer)((WinResConfig.TaskWindow).name)
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.TaskWindow).name)
  uis = nil
  contentPane = nil
  argTable = {}
end

TaskWindow.SetListTouchEnable = function(...)
  -- function num : 0_5 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.TaskDetailedList).scrollPane).touchEffect = false
  ;
  (SimpleTimer.setTimeout)(1, function(...)
    -- function num : 0_5_0 , upvalues : uis
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    ((uis.TaskDetailedList).scrollPane).touchEffect = true
  end
)
end

TaskWindow.RefreshWin = function(force, ...)
  -- function num : 0_6 , upvalues : openTaskType, isBackOpen, gotoId, uis, TaskWindow, AlreadyShow, _ENV, offsetY
  local taskType = openTaskType
  -- DECOMPILER ERROR at PC11: Unhandled construct in 'MakeBoolean' P3

  local isPlay = (isBackOpen and gotoId and gotoId > 0)
  ;
  ((uis.TaskDetailedList).scrollPane):CancelDragging()
  ;
  (uis.TaskDetailedList):SetAnimIsPlay(not isPlay)
  ;
  (TaskWindow.SetName)(taskType)
  ;
  (TaskWindow.SetTaskList)(taskType)
  ;
  (TaskWindow.SetLivelinessState)(taskType)
  AlreadyShow = true
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R3 in 'UnsetPending'

  if isPlay then
    if (TaskMgr.GetTaskIsNotComplete)(gotoId) then
      ((uis.TaskDetailedList).scrollPane).posY = offsetY
    else
      ((uis.TaskDetailedList).scrollPane):ScrollTop(false)
    end
    isBackOpen = false
    if force then
      (SimpleTimer.setTimeout)(0.1, function(...)
    -- function num : 0_6_0 , upvalues : TaskWindow
    (TaskWindow.PlayListAni)()
  end
)
    else
      (TaskWindow.PlayListAni)()
    end
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

TaskWindow.PlayListAni = function(...)
  -- function num : 0_7 , upvalues : uis, _ENV
  local InfoList = uis.TaskDetailedList
  local child = {}
  for i = 0, InfoList.numChildren - 1 do
    local obj = InfoList:GetChildAt(i)
    obj.visible = false
    ;
    (table.insert)(child, obj)
  end
  local num = 0
  ;
  ((SimpleTimer.new)(0.05, #child, function(...)
    -- function num : 0_7_0 , upvalues : num, child, _ENV
    num = num + 1
    local obj = child[num]
    PlayUITrans(obj, "up")
    obj.visible = true
  end
)):start()
end

TaskWindow.SetLivelinessState = function(taskType, ...)
  -- function num : 0_8 , upvalues : _ENV, uis
  local boxList = (TaskMgr.GetTaskBox)(taskType)
  local isSixBox = false
  if #boxList == 5 then
    isSixBox = false
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((uis.TaskRateGrp).c1Ctr).selectedIndex = 0
  else
    if #boxList == 6 then
      isSixBox = true
      -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((uis.TaskRateGrp).c1Ctr).selectedIndex = 1
    else
      loge("传入的数据错误")
    end
  end
  for i = 1, 6 do
    local boxGrp = ((uis.TaskRateGrp).root):GetChild("Reward_0" .. i)
    do
      local lineGrp = ((uis.TaskRateGrp).root):GetChild("Line_0" .. i)
      if isSixBox or i ~= 6 then
        if not boxList[i] then
          loge("服务器活跃度宝箱数据有误")
          return 
        end
        local boxID = (boxList[i]).id
        local boxState = (TaskMgr.GetTaskBoxState)(boxID)
        if boxState == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_CAN then
          ChangeUIController(boxGrp, "c1", 1)
          ChangeUIController(lineGrp, "c1", 0)
        else
          if boxState == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_NOT then
            ChangeUIController(boxGrp, "c1", 0)
            ChangeUIController(lineGrp, "c1", 1)
          else
            ChangeUIController(boxGrp, "c1", 2)
            ChangeUIController(lineGrp, "c1", 0)
          end
        end
        local box = boxGrp:GetChild("IconLoader")
        local livelinessNum = boxGrp:GetChild("Number_01_Txt")
        local liveliness = (boxList[i]).liveness
        if boxState == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_HAS then
          livelinessNum.text = (PUtil.get)(20000240)
        else
          livelinessNum.text = liveliness
        end
        local items = (Util.ParseConfigStr)((boxList[i]).reward)
        if #items > 1 then
          loge("配置错误，奖励物品配置超过一个")
        end
        local item = items[1]
        local ConfigData = (Util.GetConfigDataByID)(tonumber(item[2]))
        box.url = (Util.GetItemUrl)(ConfigData.icon)
        do
          local NumTxt = boxGrp:GetChild("Number_02_Txt")
          NumTxt.visible = tonumber(item[3]) > 1
          NumTxt.text = item[3]
          ;
          (CommonWinMgr.RegisterItemLongPress)(box, item[2])
          ;
          (box.onClick):Set(function(eventContext, ...)
    -- function num : 0_8_0 , upvalues : boxState, _ENV, boxID
    eventContext:StopPropagation()
    if boxState == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_CAN then
      (TaskService.ReqGetTaskBox)(boxID)
    else
    end
    if boxState == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_NOT then
    end
  end
)
          -- DECOMPILER ERROR at PC167: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC167: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

TaskWindow.GetMinAndMaxLiveliness = function(boxList, ...)
  -- function num : 0_9 , upvalues : _ENV
  local minNum = 0
  if not boxList[1] or not boxList[#boxList] then
    loge("服务器活跃度宝箱数据有误")
    return 0, 0
  end
  local minData = ((TableData.gTable).BaseTaskBoxData)[(boxList[1]).pre]
  if minData then
    minNum = minData.liveness
  end
  local maxNum = (boxList[#boxList]).liveness
  return minNum, maxNum
end

TaskWindow.SetName = function(taskType, ...)
  -- function num : 0_10 , upvalues : _ENV, uis
  local liveliness = (TaskMgr.GetLiveliness)(taskType)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  if taskType == TaskType.Daily then
    ((uis.TaskRateGrp).c2Ctr).selectedIndex = 0
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((uis.TaskRateGrp).WordTxt).text = liveliness
  else
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

    if taskType == TaskType.Weekly then
      ((uis.TaskRateGrp).c2Ctr).selectedIndex = 1
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((uis.TaskRateGrp).WordTxt).text = liveliness
    else
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

      if taskType == TaskType.GrowUp then
        ((uis.TaskRateGrp).c2Ctr).selectedIndex = 2
        -- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

        ;
        ((uis.TaskRateGrp).WordTxt).text = liveliness
      end
    end
  end
end

TaskWindow.Renderer = function(index, item, ...)
  -- function num : 0_11 , upvalues : taskListData, _ENV, TaskWindow, offsetY, uis, gotoId, openTaskType
  local data = taskListData[index + 1]
  if not data then
    return 
  end
  local objModel = GetTask_TaskDetailedUis(item)
  local mouthType = data.MouthType
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (objModel.Complete_01_Txt).visible = mouthType == nil
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (objModel.Complete_02_Txt).visible = mouthType == nil
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (objModel.Complete_03_Txt).visible = mouthType == nil
  if mouthType ~= nil then
    local productData = (PayData.GetProductDataByType)(mouthType)
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (objModel.NameTxt).text = productData.product_name
    local remainTime = data.remainTime
    local rewards = (Util.ParseConfigStr)(productData.show_day_reward)
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (objModel.ItemList).numItems = 0
    for _,v in ipairs(rewards) do
      local item = (Util.CreateFrame)(tonumber(v[2]), false, tonumber(v[3]), false, true)
      ;
      (objModel.ItemList):AddChild(item)
    end
    -- DECOMPILER ERROR at PC72: Confused about usage of register: R8 in 'UnsetPending'

    if data.status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_NOT then
      (objModel.c1Ctr).selectedIndex = 0
      -- DECOMPILER ERROR at PC78: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (objModel.JumpBtn).text = (PUtil.get)(20000328)
      ;
      ((objModel.JumpBtn).onClick):Set(function(...)
    -- function num : 0_11_0 , upvalues : _ENV
    ld("Shop")
    ;
    (ShopMgr.ExternalGotoShop)(ShopType.GiftBuy)
  end
)
      -- DECOMPILER ERROR at PC89: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (objModel.TipsTxt).text = (PUtil.get)(20000330)
    else
      -- DECOMPILER ERROR at PC98: Confused about usage of register: R8 in 'UnsetPending'

      if data.status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_CAN then
        (objModel.c1Ctr).selectedIndex = 1
        -- DECOMPILER ERROR at PC104: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (objModel.functionBtn).text = (PUtil.get)(60000023)
        ;
        ((objModel.functionBtn).onClick):Set(function(...)
    -- function num : 0_11_1 , upvalues : _ENV, mouthType, TaskWindow
    (PayService.ReqGetMoonReward)(mouthType)
    ;
    (TaskWindow.SetListTouchEnable)()
  end
)
        -- DECOMPILER ERROR at PC116: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (objModel.TipsTxt).text = (PUtil.get)(20000329, remainTime)
      else
        -- DECOMPILER ERROR at PC119: Confused about usage of register: R8 in 'UnsetPending'

        (objModel.c1Ctr).selectedIndex = 2
        -- DECOMPILER ERROR at PC126: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (objModel.TipsTxt).text = (PUtil.get)(20000329, remainTime)
      end
    end
    return 
  end
  local TaskConfig = ((TableData.gTable).BaseTaskData)[tonumber(data.id)]
  -- DECOMPILER ERROR at PC142: Confused about usage of register: R6 in 'UnsetPending'

  if data.status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_NOT then
    (objModel.c1Ctr).selectedIndex = 0
    -- DECOMPILER ERROR at PC149: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (objModel.JumpBtn).visible = TaskConfig.target_href_id > 0
    -- DECOMPILER ERROR at PC155: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (objModel.JumpBtn).text = (PUtil.get)(60000072)
    ;
    ((objModel.JumpBtn).onClick):Set(function(...)
    -- function num : 0_11_2 , upvalues : offsetY, uis, gotoId, _ENV, data, TaskConfig
    offsetY = ((uis.TaskDetailedList).scrollPane).posY
    gotoId = tonumber(data.id)
    ;
    (Util.GetWayGoto)(TaskConfig.target_href_id)
  end
)
    -- DECOMPILER ERROR at PC164: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (objModel.Complete_01_Txt).color = Const.TaskLackColorRGB
    -- DECOMPILER ERROR at PC168: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (objModel.Complete_02_Txt).color = Const.WhiteColorRGB
    -- DECOMPILER ERROR at PC172: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (objModel.Complete_03_Txt).color = Const.WhiteColorRGB
  else
    -- DECOMPILER ERROR at PC181: Confused about usage of register: R6 in 'UnsetPending'

    if data.status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_CAN then
      (objModel.c1Ctr).selectedIndex = 1
      -- DECOMPILER ERROR at PC187: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (objModel.functionBtn).text = (PUtil.get)(20000091)
      ;
      ((objModel.functionBtn).onClick):Set(function(...)
    -- function num : 0_11_3 , upvalues : _ENV, data, TaskWindow
    (TaskService.ReqSubmitTask)(data.id)
    ;
    (TaskWindow.SetListTouchEnable)()
  end
)
      -- DECOMPILER ERROR at PC196: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (objModel.Complete_01_Txt).color = Const.TaskBlueColorRGB
      -- DECOMPILER ERROR at PC200: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (objModel.Complete_02_Txt).color = Const.TaskBlueColorRGB
      -- DECOMPILER ERROR at PC204: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (objModel.Complete_03_Txt).color = Const.TaskBlueColorRGB
    else
      -- DECOMPILER ERROR at PC213: Confused about usage of register: R6 in 'UnsetPending'

      if data.status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_HAS then
        (objModel.c1Ctr).selectedIndex = 2
      end
    end
  end
  -- DECOMPILER ERROR at PC216: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (objModel.Complete_01_Txt).text = data.comp
  -- DECOMPILER ERROR at PC219: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (objModel.Complete_03_Txt).text = data.need
  -- DECOMPILER ERROR at PC222: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (objModel.NameTxt).text = TaskConfig.name
  -- DECOMPILER ERROR at PC225: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (objModel.TipsTxt).text = TaskConfig.remark
  local rewards = (Util.ParseConfigStr)(TaskConfig.reward)
  -- DECOMPILER ERROR at PC231: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (objModel.ItemList).numItems = 0
  for _,v in ipairs(rewards) do
    local item = (Util.CreateFrame)(tonumber(v[2]), false, tonumber(v[3]), false, true)
    ;
    (objModel.ItemList):AddChild(item)
  end
  local LivelinessValue = TaskConfig.liveness
  do
    if LivelinessValue > 0 then
      local item = (Util.CreateFrame)((TaskMgr.GetLivelinessId)(openTaskType), false, LivelinessValue, false, true)
      ;
      (objModel.ItemList):AddChild(item)
    end
    -- DECOMPILER ERROR: 14 unprocessed JMP targets
  end
end

TaskWindow.SetTaskList = function(taskType, ...)
  -- function num : 0_12 , upvalues : taskListData, _ENV, TaskWindow, uis
  taskListData = (TaskMgr.GetTaskList)(taskType)
  if taskType == TaskType.Daily then
    (TaskWindow.AddToTaskList)(PayProductType.BigMonthCard)
    ;
    (TaskWindow.AddToTaskList)(PayProductType.LittleMonthCard)
    ;
    (table.sort)(taskListData, function(a, b, ...)
    -- function num : 0_12_0 , upvalues : _ENV
    local aTotal = 0
    if a.status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_CAN then
      aTotal = 10000
    else
      if a.status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_NOT then
        aTotal = 1000
      else
        aTotal = -10000
      end
    end
    local bTotal = 0
    if b.status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_CAN then
      bTotal = 10000
    else
      if b.status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_NOT then
        bTotal = 1000
      else
        bTotal = -10000
      end
    end
    local aType = 0
    if a.MouthType then
      aType = -10
    end
    local bType = 0
    if b.MouthType then
      bType = -10
    end
    do return bTotal + bType < aTotal + aType end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  end
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.TaskDetailedList).numItems = #taskListData
end

TaskWindow.AddToTaskList = function(type, ...)
  -- function num : 0_13 , upvalues : _ENV, taskListData
  local data = {}
  data.MouthType = type
  local remainTime = (PayData.GetRemainMonthCardDay)(type)
  local isGet = (PayData.GetMonthCardIsGet)(type)
  if remainTime > 0 then
    if isGet then
      data.status = (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_HAS
    else
      data.status = (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_CAN
    end
  else
    data.status = (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_NOT
  end
  data.remainTime = remainTime
  ;
  (table.insert)(taskListData, data)
end

TaskWindow.InitTaskTabBtn = function(...)
  -- function num : 0_14 , upvalues : uis, _ENV, TaskWindow
  (((uis.TaskPanelGrp).DayBtn):GetChild("NameTxt")).text = (PUtil.get)(20000088)
  ;
  (((uis.TaskPanelGrp).WeekBtn):GetChild("NameTxt")).text = (PUtil.get)(20000089)
  ;
  (((uis.TaskPanelGrp).AlwaysBtn):GetChild("NameTxt")).text = (PUtil.get)(20000090)
  ;
  (((uis.TaskPanelGrp).DayBtn):GetController("c1")).selectedIndex = 0
  ;
  (((uis.TaskPanelGrp).WeekBtn):GetController("c1")).selectedIndex = 1
  ;
  (((uis.TaskPanelGrp).AlwaysBtn):GetController("c1")).selectedIndex = 2
  ;
  (((uis.TaskPanelGrp).DayBtn).onClick):Set(function(...)
    -- function num : 0_14_0 , upvalues : TaskWindow, _ENV, uis
    (TaskWindow.OnClickTab)(TaskType.Daily)
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.TaskPanelGrp).c1Ctr).selectedIndex = 0
    ;
    ((uis.TaskDetailedList).scrollPane):ScrollTop(false)
  end
)
  ;
  (((uis.TaskPanelGrp).WeekBtn).onClick):Set(function(...)
    -- function num : 0_14_1 , upvalues : TaskWindow, _ENV, uis
    (TaskWindow.OnClickTab)(TaskType.Weekly)
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.TaskPanelGrp).c1Ctr).selectedIndex = 1
    ;
    ((uis.TaskDetailedList).scrollPane):ScrollTop(false)
  end
)
  ;
  (((uis.TaskPanelGrp).AlwaysBtn).onClick):Set(function(...)
    -- function num : 0_14_2 , upvalues : TaskWindow, _ENV, uis
    (TaskWindow.OnClickTab)(TaskType.GrowUp)
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.TaskPanelGrp).c1Ctr).selectedIndex = 2
    ;
    ((uis.TaskDetailedList).scrollPane):ScrollTop(false)
  end
)
end

TaskWindow.OnClickTab = function(taskType, ...)
  -- function num : 0_15 , upvalues : openTaskType, AlreadyShow, _ENV
  if openTaskType == taskType and AlreadyShow then
    return 
  end
  openTaskType = taskType
  ;
  (TaskService.ReqTaskData)(openTaskType)
  ;
  (Util.SetOnClickDelay)(0.5)
end

TaskWindow.InitFunctionControl = function(...)
  -- function num : 0_16 , upvalues : _ENV, uis
  local winName = (WinResConfig.TaskWindow).name
  local RegisterGuideAndControl = GuideData.RegisterGuideAndControl
  local ControlID = ControlID
  RegisterGuideAndControl(ControlID.Task_Daily, (uis.TaskPanelGrp).DayBtn, winName)
  RegisterGuideAndControl(ControlID.Task_Week, (uis.TaskPanelGrp).WeekBtn, winName)
  RegisterGuideAndControl(ControlID.Task_GrowUp, (uis.TaskPanelGrp).AlwaysBtn, winName)
  RegisterGuideAndControl(ControlID.Task_List, uis.TaskDetailedList, winName)
end

TaskWindow.InitAssetStrip = function(...)
  -- function num : 0_17 , upvalues : _ENV, uis, openTaskType
  local m = {}
  m.windowName = (WinResConfig.TaskWindow).name
  m.Tip = (PUtil.get)(20000087)
  m.model = uis.AssetStripGrp
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  m.BackBtnFun = function(...)
    -- function num : 0_17_0 , upvalues : openTaskType, _ENV
    openTaskType = TaskType.Daily
  end

  m.CloseBtnFun = m.BackBtnFun
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

TaskWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_18 , upvalues : _ENV, TaskWindow, openTaskType, uis
  if msgId == (WindowMsgEnum.TaskWindow).TASK_REFRESH_TASK_LIVELINESS then
    (TaskWindow.SetLivelinessState)(openTaskType)
  else
    if msgId == (WindowMsgEnum.TaskWindow).TASK_REFRESH_WINDOW then
      (TaskWindow.RefreshWin)(para)
    else
      -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

      if msgId == (WindowMsgEnum.TaskWindow).TASK_CLOSE_SCROLL then
        ((uis.TaskDetailedList).scrollPane).touchEffect = false
      end
    end
  end
  if msgId == (WindowMsgEnum.NETBrokenReconnect).E_MSG_RECONNECT_Ok then
    (TaskWindow.RefreshWin)()
  end
end

return TaskWindow

