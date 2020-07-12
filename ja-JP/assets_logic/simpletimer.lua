-- params : ...
-- function num : 0 , upvalues : _ENV
local Time = Time
local getTime = function(...)
  -- function num : 0_0 , upvalues : Time
  return Time.fixedTime * 1000
end

local SimpleTimer = {}
SimpleTimer.running_timers = {}
SimpleTimer.running_timers_delList = {}
SimpleTimer.handler = nil
SimpleTimer.new = function(interval, count, perFunc, compFunc, params, ...)
  -- function num : 0_1 , upvalues : _ENV, getTime, SimpleTimer
  local obj = {}
  obj.interval = (math.floor)(tonumber(interval) * 1000 or 1000)
  obj.count = tonumber(count) or 1
  obj.perFunc = perFunc
  obj.compFunc = compFunc
  obj.params = params
  obj.handler = nil
  obj.timeBase = true
  obj.scale = 1
  obj._t = 0
  obj._c = 0
  obj._d = false
  obj.isRun = false
  obj._offt = 0
  obj.start = function(self, ...)
    -- function num : 0_1_0 , upvalues : getTime, _ENV, SimpleTimer
    if self.count == 0 then
      self:_tick(0)
      return 
    end
    if self.interval <= 0 then
      for i = 1, self.count do
        self:_tick(0)
      end
      return 
    end
    self._t = getTime()
    self.isRun = true
    ;
    (table.insert)(SimpleTimer.running_timers, self)
    if SimpleTimer.handler == nil then
      (UpdateMgr.AddFixedUpdateHandler)(SimpleTimer.each_call_back)
      SimpleTimer.handler = true
    end
  end

  obj.stop = function(self, ...)
    -- function num : 0_1_1
    self:_destroy()
  end

  obj.Comp = function(self, ...)
    -- function num : 0_1_2
    self:_comp()
  end

  obj.pause = function(self, ...)
    -- function num : 0_1_3
    self:_delFromRunningTimers()
    self.handler = nil
    self.isRun = false
  end

  obj.resume = function(self, ...)
    -- function num : 0_1_4 , upvalues : getTime, _ENV, SimpleTimer
    if self._d then
      return 
    end
    self.isRun = true
    self._t = getTime()
    ;
    (table.insert)(SimpleTimer.running_timers, self)
  end

  obj.restart = function(self, ...)
    -- function num : 0_1_5
    self:pause()
    self._t = 0
    self._c = 0
    self:start()
  end

  obj.reset = function(self, ...)
    -- function num : 0_1_6
    self:pause()
    self._t = 0
    self._c = 0
    self.perFunc = nil
    self.compFunc = nil
    self.params = nil
  end

  obj._doTick = function(self, ms, ...)
    -- function num : 0_1_7 , upvalues : getTime
    if self._d then
      return 
    end
    if self.timeBase then
      if self._d == true then
        return 
      end
      local _now = getTime()
      self._offt = self._offt + _now - self._t
      self._t = _now
      local itvl = self.interval / self.scale
      while self._offt - itvl >= 0 and self._d ~= true do
        self._offt = self._offt - itvl
        self:_tick(itvl)
      end
    else
      do
        if self._d == true then
          return 
        end
        local _now = getTime()
        self._offt = _now - self._t
        self._t = _now
        self:_tick(self._offt)
      end
    end
  end

  obj._tick = function(self, ms, ...)
    -- function num : 0_1_8
    local _c = self._c
    _c = _c + 1
    self._c = _c
    if self.perFunc then
      (self.perFunc)(self, _c, self.params)
    end
    if self.count >= 0 and self.count <= _c then
      self:_comp()
      return 
    end
  end

  obj._comp = function(self, ...)
    -- function num : 0_1_9
    local compFunc = self.compFunc
    local params = self.params
    self:_destroy()
    if compFunc then
      compFunc(self, params)
    end
  end

  obj.IsRunIng = function(self, ...)
    -- function num : 0_1_10
    if self then
      return self.isRun
    end
  end

  obj._destroy = function(self, ...)
    -- function num : 0_1_11
    if self._d then
      return 
    end
    self._d = true
    self.perFunc = nil
    self.compFunc = nil
    self.params = nil
    self.isRun = false
    if self.handler then
      self:_delFromRunningTimers()
      self.handler = nil
    end
  end

  obj._delFromRunningTimers = function(self, ...)
    -- function num : 0_1_12 , upvalues : SimpleTimer, _ENV
    for i = #SimpleTimer.running_timers, 1, -1 do
      local v = (SimpleTimer.running_timers)[i]
      if v == self then
        (table.remove)(SimpleTimer.running_timers, i)
        return 
      end
    end
  end

  return obj
end

SimpleTimer.StopAllTimer = function(...)
  -- function num : 0_2 , upvalues : SimpleTimer, _ENV
  SimpleTimer.running_timers = {}
  SimpleTimer.handler = nil
  ;
  (UpdateMgr.RemoveFixedUpdateHandler)(SimpleTimer.each_call_back)
end

SimpleTimer.each_call_back = function(...)
  -- function num : 0_3 , upvalues : Time, SimpleTimer, _ENV
  local ms = Time.fixedDeltaTime * 1000
  if #SimpleTimer.running_timers < 1 then
    if SimpleTimer.handler then
      (UpdateMgr.RemoveFixedUpdateHandler)(SimpleTimer.each_call_back)
      SimpleTimer.handler = nil
    end
    return 
  end
  local c = 0
  for i = #SimpleTimer.running_timers, 1, -1 do
    local v = (SimpleTimer.running_timers)[i]
    c = c + 1
    if v and v._d ~= true then
      v:_doTick(ms)
    end
  end
end

SimpleTimer.setTimeout = function(interval, func, params, timeBase, ...)
  -- function num : 0_4 , upvalues : SimpleTimer
  local t = (SimpleTimer.new)(interval, 1, nil, func, params)
  if timeBase == nil then
    timeBase = true
  end
  t.timeBase = timeBase
  t:start()
  return t
end

SimpleTimer.setInterval = function(interval, count, perFunc, compFunc, params, timeBase, ...)
  -- function num : 0_5 , upvalues : SimpleTimer
  local t = (SimpleTimer.new)(interval, count, perFunc, compFunc, params)
  if timeBase == nil then
    timeBase = true
  end
  t.timeBase = timeBase
  t:start()
  return t
end

return SimpleTimer

