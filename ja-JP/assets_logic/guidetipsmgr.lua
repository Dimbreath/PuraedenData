-- params : ...
-- function num : 0 , upvalues : _ENV
GuideTipsMgr = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

GuideTipsMgr.ShowGuideTips = function(checkpoint, ...)
  -- function num : 0_0 , upvalues : _ENV
  local result, args = (GuideTipsData.CheckCondition)(checkpoint, {...})
  if result == false then
    return 
  end
  if checkpoint == GuideTipsCheckPoint.MergeItem then
    (GuideTipsMgr.Enqueue)({Type = checkpoint, 
Args = {args}
})
  else
    ;
    (GuideTipsMgr.Enqueue)({Type = checkpoint, 
Args = {...}
})
  end
  if not UIMgr:IsWindowOpen((WinResConfig.GuideTipsWindow).name) then
    OpenWindow((WinResConfig.GuideTipsWindow).name, UILayer.Notice)
  else
    UIMgr:SendWindowMessage((WinResConfig.GuideTipsWindow).name, (WindowMsgEnum.GuideTips).E_MSG_SHOW_TIPS)
  end
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

GuideTipsMgr.Enqueue = function(data, ...)
  -- function num : 0_1 , upvalues : _ENV
  (table.insert)(GuideTipsData.WaitingQueue, data)
  ;
  (table.sort)(GuideTipsData.WaitingQueue, function(x, y, ...)
    -- function num : 0_1_0 , upvalues : _ENV
    local xConfig = (GuideTipsData.GetConfigData)(x.Type)
    local yConfig = (GuideTipsData.GetConfigData)(y.Type)
    if xConfig.sort == yConfig.sort then
      return false
    else
      return xConfig.sort < yConfig.sort
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

GuideTipsMgr.Dequeue = function(...)
  -- function num : 0_2 , upvalues : _ENV
  if #GuideTipsData.WaitingQueue == 0 then
    return 
  end
  return (table.remove)(GuideTipsData.WaitingQueue, 1)
end


