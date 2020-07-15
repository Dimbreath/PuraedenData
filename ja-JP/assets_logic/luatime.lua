-- params : ...
-- function num : 0 , upvalues : _ENV
local LuaTime = {}
TimeType = {EVERYDAY_TIME = 1, EVERY_WEEK_TIME = 2, EVERY_MOON_DAY_TIME = 3, EVERY_MOON_WEEKDAY_TIME = 4, SPECIFIED_TIME = 5, START_SERVER_TIME = 6, EVERY_DAY_PERSISTENT_TIME = 7, EVERY_MOON_PERSISTENT_TIME = 8}
LuaTime.GetStampStr = function(time, ...)
  -- function num : 0_0 , upvalues : _ENV
  return (os.date)("%Y-%m-%d %H-%M-%S", (math.ceil)(time / 1000))
end

LuaTime.GetFormatTimeStr = function(format, time, ...)
  -- function num : 0_1 , upvalues : _ENV
  time = tonumber(time)
  if time == nil then
    return ""
  end
  if time > 9999999999 then
    time = (math.floor)(time * 0.001)
  end
  return (os.date)(format, time)
end

LuaTime.GetDayOfWeek = function(...)
  -- function num : 0_2 , upvalues : _ENV, LuaTime
  local day = tonumber((os.date)("%w", (LuaTime.GetTimeStamp)()))
  if day == 0 then
    day = 7
  end
  return day
end

LuaTime.GetLeftTimeStr = function(timeStamp, withoutSuffix, ...)
  -- function num : 0_3 , upvalues : _ENV, LuaTime
  timeStamp = tonumber(timeStamp)
  if timeStamp == nil then
    return ""
  end
  return (LuaTime.GetLeftTimeString)((LuaTime.GetTimeStamp)() - timeStamp, withoutSuffix)
end

LuaTime.GetLeftTimeString = function(duration, withoutSuffix, ...)
  -- function num : 0_4 , upvalues : _ENV
  local suffix = nil
  if duration == 0 then
    return (PUtil.get)(60000017)
  end
  if withoutSuffix then
    duration = (math.abs)(duration)
    if duration < 60 then
      return (PUtil.get)(60000014)
    else
      if duration < 3600 then
        return (PUtil.get)(60000011, (math.floor)(duration / 60))
      else
        if duration < 86400 then
          return (PUtil.get)(60000012, (math.floor)(duration / 3600))
        else
          return (PUtil.get)(60000013, (math.floor)(duration / 86400))
        end
      end
    end
  else
    if duration < 0 then
      if duration < 60 then
        return (PUtil.get)(60000014)
      else
        if duration < 3600 then
          return (PUtil.get)(60000340, (math.floor)(duration / 60))
        else
          if duration < 86400 then
            return (PUtil.get)(60000342, (math.floor)(duration / 3600))
          else
            if duration < 259200 then
              return (PUtil.get)(60000344, (math.floor)(duration / 86400))
            else
              return (PUtil.get)(60000344, Const.MAX_DAYS)
            end
          end
        end
      end
    else
      duration = (math.abs)(duration)
      if duration < 3600 then
        return (PUtil.get)(60000339, (math.floor)(duration / 60))
      else
        if duration < 86400 then
          return (PUtil.get)(60000341, (math.floor)(duration / 3600))
        else
          if duration < 259200 then
            return (PUtil.get)(60000343, (math.floor)(duration / 86400))
          else
            return (PUtil.get)(60000343, Const.MAX_DAYS)
          end
        end
      end
    end
  end
end

LuaTime.GetTimeStr = function(time, showDay, ...)
  -- function num : 0_5 , upvalues : _ENV
  local hours, minutes, seconds = nil, nil, nil
  hours = (math.floor)(time / 3600)
  time = time % 3600
  minutes = (math.floor)(time / 60)
  seconds = time % 60
  if hours > 0 then
    if showDay then
      local day = (math.floor)(hours / 24)
      hours = hours % 24
      return (string.format)("%02d%s %02d:%02d:%02d", day, (PUtil.get)(20000219), hours, minutes, seconds)
    else
      do
        do return (string.format)("%02d:%02d:%02d", hours, minutes, seconds) end
        do return (string.format)("%02d:%02d", minutes, seconds) end
      end
    end
  end
end

LuaTime.GetTimeStrVersion2 = function(time, ...)
  -- function num : 0_6 , upvalues : _ENV
  local arg1, arg2, arg3, arg4 = nil, nil, nil, nil
  if time < 3600 then
    arg1 = (math.floor)(time / 60)
    arg2 = (math.floor)(time % 60)
    arg3 = 60000393
    arg4 = 60000394
  else
    arg1 = (math.floor)(time / 3600)
    time = time % 3600
    arg2 = (math.floor)(time / 60)
    arg3 = 60000097
    arg4 = 60000393
  end
  return (string.format)("%02d%s%02d%s", arg1, (PUtil.get)(arg3), arg2, (PUtil.get)(arg4))
end

LuaTime.GetTimeWithoutSeondsStr = function(time, ...)
  -- function num : 0_7 , upvalues : _ENV
  local hours, minutes, seconds = nil, nil, nil
  hours = (math.floor)(time / 3600)
  time = time % 3600
  minutes = (math.floor)(time / 60)
  return (string.format)("%02d:%02d", hours, minutes)
end

LuaTime.GetTimeNum = function(time, ...)
  -- function num : 0_8 , upvalues : _ENV
  local hours, minutes, seconds = nil, nil, nil
  hours = (math.floor)(time / 3600)
  time = time % 3600
  minutes = (math.floor)(time / 60)
  seconds = time % 60
  return hours, minutes, seconds
end

LuaTime.CheckTimeUp = function(time, ...)
  -- function num : 0_9 , upvalues : _ENV, LuaTime
  time = tonumber(time)
  if time == nil then
    return false
  end
  do return time <= (LuaTime.GetTimeStamp)() end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

LuaTime.GetTimeStamp = function(...)
  -- function num : 0_10 , upvalues : _ENV
  return (math.floor)((ActorData.GetServerTime)() * 0.001)
end

LuaTime.CountDown = function(time, text, func, showDay, ...)
  -- function num : 0_11 , upvalues : _ENV, LuaTime
  time = (math.floor)(time)
  local timerInfo = {}
  text.text = (LuaTime.GetTimeStr)(time, showDay)
  timerInfo.timer = (SimpleTimer.new)(1, time, function(timer, tickTime, ...)
    -- function num : 0_11_0 , upvalues : text, LuaTime, time, showDay
    text.text = (LuaTime.GetTimeStr)(time - tickTime, showDay)
  end
, function(...)
    -- function num : 0_11_1 , upvalues : func
    if func ~= nil then
      func()
    end
  end
)
  timerInfo.Stop = function(self, ...)
    -- function num : 0_11_2
    (self.timer):stop()
  end

  timerInfo.Complete = function(self, ...)
    -- function num : 0_11_3
    (self.timer):Comp()
  end

  timerInfo.Pause = function(self, ...)
    -- function num : 0_11_4
    (self.timer):pause()
  end

  timerInfo.Resume = function(self, ...)
    -- function num : 0_11_5
    (self.timer):resume()
  end

  ;
  (timerInfo.timer):start()
  return timerInfo
end

LuaTime.InitConfigStr = function(value, ...)
  -- function num : 0_12 , upvalues : _ENV, LuaTime
  if (Util.StringIsNullOrEmpty)(value) then
    return 
  end
  local strS = split(value, ":")
  local timeType = (tonumber(strS[1]))
  -- DECOMPILER ERROR at PC14: Overwrote pending register: R3 in 'AssignReg'

  local array = .end
  local TimeType = TimeType
  if (((((timeType == TimeType.EVERYDAY_TIME and timeType ~= TimeType.EVERY_WEEK_TIME) or timeType == TimeType.EVERY_MOON_DAY_TIME) and timeType ~= TimeType.EVERY_MOON_WEEKDAY_TIME) or timeType == TimeType.SPECIFIED_TIME) and timeType ~= TimeType.START_SERVER_TIME) or timeType == TimeType.EVERY_DAY_PERSISTENT_TIME then
    array = (LuaTime.HourMin)(strS[2])
  else
  end
  if timeType == TimeType.EVERY_MOON_PERSISTENT_TIME then
    local keepTime = (LuaTime.keepTime)(strS[3])
    return array, keepTime
  end
end

LuaTime.HourMin = function(str, ...)
  -- function num : 0_13 , upvalues : _ENV
  local array = {}
  local hour = tonumber((string.sub)(str, 1, 2))
  local minute = tonumber((string.sub)(str, 3))
  if hour < 0 or hour > 24 or minute < 0 or minute > 60 then
    loge("配置错误")
    return 
  end
  array[1] = hour
  array[2] = minute
  return array
end

LuaTime.keepTime = function(str, ...)
  -- function num : 0_14 , upvalues : _ENV
  if (string.len)(str) < 2 then
    loge("配置错误")
    return 
  end
  local type = (string.sub)(str, 0, 2)
  local value = tonumber((string.sub)(str, 3))
  if type == "MX" then
    return 60 * value
  else
    if type == "SX" then
      return value
    else
      if type == "HX" then
        return 3600 * value
      else
        if type == "DX" then
          return 86400 * value
        else
          loge("配置错误")
          return 
        end
      end
    end
  end
end

LuaTime.GetRangeTime = function(str, ...)
  -- function num : 0_15 , upvalues : LuaTime, _ENV
  local time, keep = (LuaTime.InitConfigStr)(str)
  local startTime = (string.format)("%02d:%02d", time[1], time[2])
  local keepHour, keepMin = (LuaTime.GetTimeNum)(keep)
  local endHour = tonumber(time[1]) + keepHour
  local endMin = tonumber(time[2]) + keepMin
  return startTime, (string.format)("%02d:%02d", endHour, endMin)
end

LuaTime.GetGameHour = function(time, ...)
  -- function num : 0_16 , upvalues : _ENV
  local deviceZone = tonumber((os.date)("%z", 0)) / 100
  return tonumber((os.date)("%H", (math.floor)((time + (Game.timeZone - deviceZone) * 3600 * 1000) / 1000)))
end

LuaTime.GetTimeWithTimezone = function(time, ...)
  -- function num : 0_17 , upvalues : _ENV
  local deviceZone = tonumber((os.date)("%z", 0)) / 100
  return (math.floor)((time + (Game.timeZone - deviceZone) * 3600 * 1000) / 1000)
end

return LuaTime

