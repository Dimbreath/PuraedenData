-- params : ...
-- function num : 0 , upvalues : _ENV
GuideTipsData = {}
-- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

GuideTipsData.AnimationArg = 72010030
-- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

GuideTipsData.DISPLAY_DURATION = 5
-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

GuideTipsData.INTERVAL = 0.5
-- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

GuideTipsData.MAX_DISPLAY_AMOUNT = 3
-- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

GuideTipsData.WaitingQueue = {}
local _condition = {}
local _checkpointData = {}
-- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

GuideTipsData.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV, _checkpointData, _condition
  local args = split((((TableData.gTable).BaseFixedData)[GuideTipsData.AnimationArg]).array_value, ":")
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  GuideTipsData.DISPLAY_DURATION = tonumber(args[1])
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  GuideTipsData.INTERVAL = tonumber(args[2])
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

  GuideTipsData.MAX_DISPLAY_AMOUNT = tonumber(args[3])
  for k,v in pairs((TableData.gTable).BaseGuidePointData) do
    _checkpointData[v.type] = k
    if (Util.StringIsNullOrEmpty)(v.value) == false then
      local args = split(v.value, ":")
      _condition[v.type] = {}
      -- DECOMPILER ERROR at PC56: Confused about usage of register: R7 in 'UnsetPending'

      if v.type == GuideTipsCheckPoint.AcquireArenaRank then
        (_condition[v.type]).Max = tonumber(args[1])
        -- DECOMPILER ERROR at PC62: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (_condition[v.type]).Min = tonumber(args[2])
      else
        if v.type == GuideTipsCheckPoint.MergeItem then
          local count = #args
          for i = 1, count do
            -- DECOMPILER ERROR at PC79: Confused about usage of register: R12 in 'UnsetPending'

            (_condition[v.type])[tonumber(args[i])] = true
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

GuideTipsData.GetConfigData = function(type, ...)
  -- function num : 0_1 , upvalues : _ENV, _checkpointData
  return ((TableData.gTable).BaseGuidePointData)[_checkpointData[type]]
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

GuideTipsData.CheckCondition = function(type, arg, ...)
  -- function num : 0_2 , upvalues : _ENV, _condition
  local controlID = (GuideTipsData.GetControlID)(type, arg)
  if controlID ~= nil and not (FunctionControlMgr.GetFunctionState)(controlID, false) then
    return false
  end
  if arg[1] > (_condition[GuideTipsCheckPoint.AcquireArenaRank]).Max or (_condition[GuideTipsCheckPoint.AcquireArenaRank]).Min > arg[1] then
    do return type ~= GuideTipsCheckPoint.AcquireArenaRank end
    do
      if type == GuideTipsCheckPoint.MergeItem then
        local config, itemInfo, needAmount, haveAmount = nil, nil, nil, nil
        if (_condition[type])[(arg[1]).id] then
          config = ((TableData.gTable).BasePropData)[(arg[1]).id]
          if config.type == 12 then
            itemInfo = split(config.effect_value, ":")
            needAmount = tonumber(itemInfo[2])
            haveAmount = (ActorData.GetPropsByID)(config.id)
            if haveAmount < needAmount and needAmount <= haveAmount + (arg[1]).value then
              return true, (((TableData.gTable).BasePropData)[tonumber(itemInfo[1])]).name
            else
              return false
            end
          else
            return false
          end
        else
          return false
        end
      end
      -- DECOMPILER ERROR: 6 unprocessed JMP targets
    end
  end
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

GuideTipsData.GetControlID = function(type, arg, ...)
  -- function num : 0_3 , upvalues : _ENV
  return ((GuideTipsData.GetConfigData)(type)).function_id
end

;
(GuideTipsData.Init)()

