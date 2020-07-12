-- params : ...
-- function num : 0 , upvalues : _ENV
require("Class")
local Handler = class()
Handler.ctor = function(self, ...)
  -- function num : 0_0
  self.handles = {}
  self.inHand = false
  self.hasRemoveHand = false
end

Handler.RunHandles = function(self, hands, data, ...)
  -- function num : 0_1 , upvalues : _ENV
  self.inHand = true
  for _,ft in pairs(hands) do
    if ft ~= nil then
      if ft.t ~= nil then
        (ft.func)(ft.t, data)
      else
        ;
        (ft.func)(data)
      end
    end
  end
  self.inHand = false
  self:innerRemove()
end

Handler.RunId = function(self, msgId, data, ...)
  -- function num : 0_2
  if (self.handles)[msgId] == nil then
    return 
  end
  self:RunHandles(((self.handles)[msgId]).table, data)
end

Handler.getHandIndex = function(self, msgId, handle, ...)
  -- function num : 0_3
  if (self.handles)[msgId] == nil then
    return -1
  end
  local hds = ((self.handles)[msgId]).table
  for i = 1, #hds do
    if (hds[i]).func == handle and not (hds[i]).markRemove then
      return i
    end
  end
  return -1
end

Handler.GetHandleCount = function(self, msgId, ...)
  -- function num : 0_4
  if (self.handles)[msgId] == nil then
    return 0
  end
  local hds = ((self.handles)[msgId]).table
  local count = 0
  for i = 1, #hds do
    if (hds[i]).func ~= nil and not (hds[i]).markRemove then
      count = count + 1
    end
  end
  return count
end

Handler.AddHandle = function(self, msgId, handle, tableObj, ...)
  -- function num : 0_5
  local index = 1
  local t = nil
  if (self.handles)[msgId] == nil then
    t = {hasRemveEle = false, 
table = {}
}
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self.handles)[msgId] = t
  else
    local existIndex = self:getHandIndex(msgId, handle)
    if existIndex ~= -1 then
      return false
    end
    t = (self.handles)[msgId]
    index = #t.table + 1
  end
  do
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (t.table)[index] = {func = handle, t = tableObj, markRemove = false}
    return true
  end
end

Handler.RemoveHandle = function(self, msgId, handle, ...)
  -- function num : 0_6
  if (self.handles)[msgId] == nil then
    return false
  end
  local existIndex = self:getHandIndex(msgId, handle)
  if existIndex == -1 then
    return false
  end
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.handles)[msgId]).hasRemveEle = true
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((((self.handles)[msgId]).table)[existIndex]).markRemove = true
  self.hasRemoveHand = true
  if not self.inHand then
    self:innerRemove()
  end
  return true
end

Handler.RemoveAllHandle = function(self, msgId, ...)
  -- function num : 0_7
  if (self.handles)[msgId] == nil then
    return 
  end
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.handles)[msgId]).hasRemveEle = true
  local hds = ((self.handles)[msgId]).table
  for i = 1, #hds do
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R7 in 'UnsetPending'

    (hds[i]).markRemove = true
  end
  self.hasRemoveHand = true
  if not self.inHand then
    self:innerRemove()
  end
  return true
end

Handler.innerRemove = function(self, ...)
  -- function num : 0_8 , upvalues : _ENV
  if self.hasRemoveHand then
    for _,t in pairs(self.handles) do
      if t.hasRemveEle then
        for i = #t.table, 1, -1 do
          if ((t.table)[i]).markRemove then
            (table.remove)(t.table, i)
          end
        end
        t.hasRemveEle = false
      end
    end
  end
  do
    self.hasRemoveHand = false
  end
end

GetNewHandler = function(...)
  -- function num : 0_9 , upvalues : Handler
  return Handler:new()
end


