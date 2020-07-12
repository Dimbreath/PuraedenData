-- params : ...
-- function num : 0 , upvalues : _ENV
require("Handler")
local csEventDis = (CS.EventDispatcher).Singleton
local EventHelper = {}
local eventTable = GetNewHandler()
local onceEventTable = GetNewHandler()
EventHelper.innerAddListener = function(eventid, func, tableobj, once, ...)
  -- function num : 0_0 , upvalues : csEventDis, onceEventTable, eventTable
  if once then
    csEventDis:AddLuaListenerOnce(eventid)
    onceEventTable:AddHandle(eventid, func, tableobj)
  else
    csEventDis:AddLuaListener(eventid)
    eventTable:AddHandle(eventid, func, tableobj)
  end
end

EventHelper.AddListener = function(eventid, func, object, ...)
  -- function num : 0_1 , upvalues : _ENV, EventHelper
  if type(eventid) == "number" then
    (EventHelper.innerAddListener)(eventid, func, object, false)
  else
    loge("err" .. type(eventid))
  end
end

EventHelper.AddOnceListener = function(eventid, func, object, ...)
  -- function num : 0_2 , upvalues : _ENV, EventHelper
  if type(eventid) == "number" then
    (EventHelper.innerAddListener)(eventid, func, object, true)
  else
    loge("err" .. type(eventid))
  end
end

EventHelper.Dispatch = function(eventid, parameter, ...)
  -- function num : 0_3 , upvalues : csEventDis
  csEventDis:DispatchEvent(eventid, parameter)
end

EventHelper.CSCallLuaDispatch = function(eventid, parameter, ...)
  -- function num : 0_4 , upvalues : eventTable, onceEventTable, EventHelper
  eventTable:RunId(eventid, parameter)
  onceEventTable:RunId(eventid, parameter)
  onceEventTable:RemoveAllHandle(eventid)
  ;
  (EventHelper.removeFromCS)(eventid)
end

EventHelper.removeFromCS = function(eventid, ...)
  -- function num : 0_5 , upvalues : eventTable, onceEventTable, csEventDis
  local count1 = eventTable:GetHandleCount(eventid)
  local count2 = onceEventTable:GetHandleCount(eventid)
  if count1 == 0 and count2 == 0 then
    csEventDis:RemoveLuaListener(eventid, 2)
  else
    if count1 == 0 then
      csEventDis:RemoveLuaListener(eventid, 0)
    else
      if count2 == 0 then
        csEventDis:RemoveLuaListener(eventid, 1)
      end
    end
  end
end

EventHelper.innerRemoveListener = function(eventid, func, once, ...)
  -- function num : 0_6 , upvalues : onceEventTable, eventTable, EventHelper
  if once then
    onceEventTable:RemoveHandle(eventid, func)
  else
    eventTable:RemoveHandle(eventid, func)
  end
  ;
  (EventHelper.removeFromCS)(eventid)
end

EventHelper.RemoveListener = function(eventid, func, ...)
  -- function num : 0_7 , upvalues : EventHelper
  (EventHelper.innerRemoveListener)(eventid, func, false)
end

EventHelper.RemoveOnceListener = function(eventid, func, ...)
  -- function num : 0_8 , upvalues : EventHelper
  (EventHelper.innerRemoveListener)(eventid, func, true)
end

return EventHelper

