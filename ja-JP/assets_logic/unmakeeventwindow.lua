-- params : ...
-- function num : 0 , upvalues : _ENV
require("AdventureGame_UnMakeEventWindowByName")
local UnMakeEventWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
UnMakeEventWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, UnMakeEventWindow
  bridgeObj:SetView((WinResConfig.UnMakeEventWindow).package, (WinResConfig.UnMakeEventWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetAdventureGame_UnMakeEventWindowUis(contentPane)
  ;
  (UnMakeEventWindow.InitVariable)()
  ;
  (UnMakeEventWindow.InitText)()
  ;
  (UnMakeEventWindow.InitList)()
  ;
  (UnMakeEventWindow.InitButtonEvent)()
end

UnMakeEventWindow.InitVariable = function(...)
  -- function num : 0_1
end

UnMakeEventWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.UnMakeEventGrp).titlenameTxt).text = (PUtil.get)(60000468)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.UnMakeEventGrp).SureBtn).text = (PUtil.get)(60000004)
end

UnMakeEventWindow.InitList = function(...)
  -- function num : 0_3 , upvalues : uis, UnMakeEventWindow
  ((uis.UnMakeEventGrp).EventList):SetVirtual()
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.UnMakeEventGrp).EventList).itemRenderer = UnMakeEventWindow.RefreshEventItems
end

UnMakeEventWindow.InitButtonEvent = function(...)
  -- function num : 0_4 , upvalues : uis, UnMakeEventWindow
  (((uis.UnMakeEventGrp).CloseBtn).onClick):Add(UnMakeEventWindow.ClickCloseBtn)
  ;
  (((uis.UnMakeEventGrp).SureBtn).onClick):Add(UnMakeEventWindow.ClickCloseBtn)
end

UnMakeEventWindow.InitEvent = function(...)
  -- function num : 0_5
end

UnMakeEventWindow.RemoveEvent = function(...)
  -- function num : 0_6
end

UnMakeEventWindow.OnShown = function(...)
  -- function num : 0_7 , upvalues : UnMakeEventWindow
  (UnMakeEventWindow.InitEvent)()
  ;
  (UnMakeEventWindow.Init)()
end

UnMakeEventWindow.OnHide = function(...)
  -- function num : 0_8
end

UnMakeEventWindow.Init = function(...)
  -- function num : 0_9 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.UnMakeEventGrp).EventList).numItems = #AdventureData.UndoneEvent
end

UnMakeEventWindow.OnClose = function(...)
  -- function num : 0_10 , upvalues : _ENV, UnMakeEventWindow, uis, contentPane, argTable
  UIMgr:SendWindowMessage((WinResConfig.AdventureGameWindow).name, (WindowMsgEnum.Adventure).E_MSG_REFRESH_UNDONE_EVENT)
  ;
  (UnMakeEventWindow.RemoveEvent)()
  uis = nil
  contentPane = nil
  argTable = {}
end

UnMakeEventWindow.RefreshEventItems = function(index, item, ...)
  -- function num : 0_11 , upvalues : _ENV
  local data = (AdventureData.UndoneEvent)[index + 1]
  local config = ((TableData.gTable).BaseAdventureEventData)[data.eventId]
  ;
  (item:GetController("c1")).selectedIndex = (AdventureData.EVENT_ICON_INDEX)[config.event_icon]
  ;
  (item:GetController("c2")).selectedIndex = 1
  ;
  (item.onClick):Set(function(...)
    -- function num : 0_11_0 , upvalues : _ENV, config, data
    (AdventureMgr.TriggerEvent)(config.type, data.nodeId, tonumber(config.parameter))
  end
)
end

UnMakeEventWindow.ClickCloseBtn = function(...)
  -- function num : 0_12 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.UnMakeEventWindow).name)
end

UnMakeEventWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_13 , upvalues : _ENV, UnMakeEventWindow
  if msgId == (WindowMsgEnum.Adventure).E_MSG_REFRESH_UNDONE_EVENT then
    if #AdventureData.UndoneEvent == 0 then
      UIMgr:CloseWindow((WinResConfig.UnMakeEventWindow).name)
    else
      ;
      (UnMakeEventWindow.Init)()
    end
  end
end

return UnMakeEventWindow

