-- params : ...
-- function num : 0 , upvalues : _ENV
require("Carnival_CarnivalMainByName")
local ActivityCarnivalWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local actId = 0
local activityData = nil
local currentGroup = 0
local groupList = {}
local taskList = {}
ActivityCarnivalWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, ActivityCarnivalWindow, actId, currentGroup, activityData
  bridgeObj:SetView((WinResConfig.ActivityCarnivalWindow).package, (WinResConfig.ActivityCarnivalWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetCarnival_CarnivalMainUis(contentPane)
  ;
  (ActivityCarnivalWindow.InitAssetStrip)()
  actId = (((ActivityMgr.InitSevenDayTaskData)()).baseActivityInfo).actId
  currentGroup = (((ActivityMgr.InitSevenDayTaskData)()).SevenDayActInfo).curGroup
  activityData = ((TableData.gTable).BaseActivityData)[actId]
  if activityData == nil then
    loge("BaseActivityData未配置" .. actId)
    return 
  end
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.TaskGrp).TaskList).itemRenderer = ActivityCarnivalWindow.TaskListRender
  ;
  (ActivityCarnivalWindow.InitRightBtn)()
  ;
  (ActivityCarnivalWindow.RefreshTaskList)()
  ;
  (ActivityCarnivalWindow.SetFashionShow)()
  ;
  (ActivityCarnivalWindow.SetIntegerReward)()
  ;
  (ActivityCarnivalWindow.SetCountDown)()
  local openedGroup = (((ActivityMgr.InitSevenDayTaskData)()).SevenDayActInfo).openedGroup
  -- DECOMPILER ERROR at PC68: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.TaskGrp).ChoiceList).selectedIndex = (ActivityCarnivalWindow.GetSelectGroupIndex)()
  ;
  (ActivityCarnivalWindow.BindingUI)()
end

ActivityCarnivalWindow.BindingUI = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local winName = (WinResConfig.ActivityCarnivalWindow).name
  local BindingUI = RedDotMgr.BindingUI
  local RedDotComID = RedDotComID
  BindingUI(winName, RedDotComID.SevenTask_BtnList, (uis.TaskGrp).ChoiceList, true)
  ;
  (RedDotMgr.RefreshTreeUI)(winName)
end

ActivityCarnivalWindow.GetSelectGroupIndex = function(...)
  -- function num : 0_2 , upvalues : _ENV, groupList, currentGroup
  for i,v in ipairs(groupList) do
    if tonumber(v) == currentGroup then
      return i - 1
    end
  end
end

ActivityCarnivalWindow.SetIntegerReward = function(...)
  -- function num : 0_3 , upvalues : _ENV, activityData, uis
  local undoneTask = (((ActivityMgr.InitSevenDayTaskData)()).SevenDayActInfo).undoneTask
  local canGet = (((ActivityMgr.InitSevenDayTaskData)()).SevenDayActInfo).canGet
  local integer = split(activityData.parameter1, ":")
  local onceGet = tonumber(integer[3])
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((uis.TipsGrp).GetNumberTxt).text = (PUtil.get)(20000312, canGet * onceGet)
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((uis.TipsGrp).TaskNumberTxt).text = (PUtil.get)(20000313, undoneTask)
end

ActivityCarnivalWindow.SetFashionShow = function(...)
  -- function num : 0_4 , upvalues : _ENV, activityData, uis, actId
  (Util.CreateShowModel)(activityData.fashion_id, uis.CardLoader)
  local day = (ActivityMgr.GetRemainDay)()
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  if day > 0 then
    ((uis.TipsGrp).c1Ctr).selectedIndex = 1
  else
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.TipsGrp).c1Ctr).selectedIndex = 0
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.TipsGrp).GetBtn).text = (PUtil.get)(20000293)
  end
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.TipsGrp).WordTxt).text = (PUtil.get)(20000295)
  local integer = activityData.parameter1
  local reward = split(integer, ":")
  local ConfigData = (Util.GetConfigDataByID)(tonumber(reward[2]))
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((uis.TipsGrp).HeadLoader).url = (Util.GetItemUrl)(ConfigData.icon)
  -- DECOMPILER ERROR at PC56: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((uis.TipsGrp).TimeTxt).text = (PUtil.get)(20000294, day)
  -- DECOMPILER ERROR at PC63: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((uis.TipsGrp).TimeTxt).visible = day > 0
  ;
  (((uis.TipsGrp).GetBtn).onClick):Set(function(...)
    -- function num : 0_4_0 , upvalues : day, _ENV, actId
    if day > 0 then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000205, day))
    else
      local canGet = (((ActivityMgr.InitSevenDayTaskData)()).SevenDayActInfo).canGet
      if canGet <= 0 then
        (MessageMgr.SendCenterTips)((PUtil.get)(20000206))
      else
        ;
        (ActivityService.OnReqPointReward)(actId)
      end
    end
  end
)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ActivityCarnivalWindow.SetCountDown = function(...)
  -- function num : 0_5 , upvalues : _ENV, uis
  local time = (((ActivityMgr.InitSevenDayTaskData)()).baseActivityInfo).endTime
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.TaskGrp).TimeNumberTxt).text = (LuaTime.GetFormatTimeStr)("%Y-%m-%d %H:%M", time)
end

ActivityCarnivalWindow.TaskListRender = function(index, obj, ...)
  -- function num : 0_6 , upvalues : taskList, _ENV, actId, currentGroup
  local taskData = taskList[index + 1]
  if taskData == nil then
    return 
  end
  local configData = ((TableData.gTable).BaseActivityTaskData)[taskData.id]
  if configData == nil then
    loge("BaseActivityTaskData" .. taskData.id)
    return 
  end
  ;
  (obj:GetChild("WordTxt")).text = configData.remark
  local consumeConfigs = split(configData.reward, ":")
  local consumeData = (Util.GetConfigDataByID)(tonumber(consumeConfigs[2]))
  ;
  (obj:GetChild("ItemNameTxt")).text = consumeData.name
  ;
  (obj:GetChild("ItemLoader")).url = (Util.GetItemUrl)(consumeData.icon)
  ;
  (obj:GetChild("ItemNumberTxt")).text = "×" .. consumeConfigs[3]
  local slider = obj:GetChild("ProgressBar")
  slider.value = taskData.comp / taskData.need * 100
  ;
  (obj:GetChild("ProgressTxt")).text = taskData.comp .. "/" .. taskData.need
  local taskState = taskData.status
  if taskState == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_HAS then
    ChangeUIController(obj, "c1", 1)
  else
    if taskState == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_CAN then
      ChangeUIController(obj, "c1", 2)
    else
      ChangeUIController(obj, "c1", 0)
    end
  end
  ;
  (obj.onClick):Set(function(...)
    -- function num : 0_6_0 , upvalues : taskState, _ENV, actId, currentGroup, taskData
    if taskState == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_NOT then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000201))
    else
      if taskState == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_CAN then
        (ActivityService.OnReqTaskReward)(actId, currentGroup, taskData.id)
      else
      end
    end
    if taskState == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_HAS then
    end
  end
)
end

ActivityCarnivalWindow.RefreshTaskList = function(...)
  -- function num : 0_7 , upvalues : taskList, _ENV, uis
  taskList = (((ActivityMgr.InitSevenDayTaskData)()).SevenDayActInfo).taskList
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.TaskGrp).TaskList).numItems = #taskList
end

ActivityCarnivalWindow.InitRightBtn = function(...)
  -- function num : 0_8 , upvalues : uis, ActivityCarnivalWindow, groupList, _ENV, activityData
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.TaskGrp).ChoiceList).itemRenderer = ActivityCarnivalWindow.BtnRender
  groupList = split(activityData.task_group, ":")
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.TaskGrp).ChoiceList).numItems = #groupList
end

ActivityCarnivalWindow.BtnRender = function(index, obj, ...)
  -- function num : 0_9 , upvalues : _ENV, groupList, currentGroup, uis, actId
  local taskGroup = tonumber(groupList[index + 1])
  local TaskGroupData = ((TableData.gTable).BaseActivityGroupData)[taskGroup]
  if TaskGroupData == nil then
    return 
  end
  ;
  (obj:GetChild("WordTxt")).text = TaskGroupData.name
  local isOpen = (ActivityMgr.GetTaskGroupIsOpen)(taskGroup)
  if isOpen then
    ChangeUIController(obj, "c1", 0)
  else
    ChangeUIController(obj, "c1", 1)
  end
  ;
  (obj.onClick):Set(function(...)
    -- function num : 0_9_0 , upvalues : isOpen, currentGroup, taskGroup, uis, index, _ENV, actId
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

    -- DECOMPILER ERROR at PC10: Unhandled construct in 'MakeBoolean' P1

    if isOpen and currentGroup ~= taskGroup then
      ((uis.TaskGrp).ChoiceList).selectedIndex = index
      ;
      (ActivityService.OnReqTaskGroup)(actId, taskGroup)
    end
    ;
    (MessageMgr.SendCenterTips)((PUtil.get)(20000200, index + 1))
  end
)
end

ActivityCarnivalWindow.OnShown = function(...)
  -- function num : 0_10
end

ActivityCarnivalWindow.OnHide = function(...)
  -- function num : 0_11
end

ActivityCarnivalWindow.InitAssetStrip = function(...)
  -- function num : 0_12 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.ActivityCarnivalWindow).name
  m.Tip = (PUtil.get)(20000199)
  m.model = uis.AssetStripGrp
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

ActivityCarnivalWindow.OnClose = function(...)
  -- function num : 0_13 , upvalues : _ENV, uis, contentPane, argTable
  (CommonWinMgr.RemoveAssets)((WinResConfig.ActivityCarnivalWindow).name)
  ;
  (RedDotMgr.RemoveUIRefer)((WinResConfig.ActivityCarnivalWindow).name)
  uis = nil
  contentPane = nil
  argTable = {}
end

ActivityCarnivalWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_14 , upvalues : _ENV, currentGroup, ActivityCarnivalWindow
  if msgId == (WindowMsgEnum.ActivityCarnival).E_MSG_CHANGE_GROUP then
    currentGroup = para
    ;
    (ActivityCarnivalWindow.RefreshTaskList)()
  else
    if msgId == (WindowMsgEnum.ActivityCarnival).E_MSG_GET_TASK then
      (ActivityCarnivalWindow.RefreshTaskList)()
      ;
      (ActivityCarnivalWindow.SetIntegerReward)()
    else
      if msgId == (WindowMsgEnum.ActivityCarnival).E_MSG_GET_INTEGER then
        (ActivityCarnivalWindow.SetIntegerReward)()
      end
    end
  end
end

return ActivityCarnivalWindow

