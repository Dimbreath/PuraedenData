-- params : ...
-- function num : 0 , upvalues : _ENV
FunctionControlMgr = {}
local Self = FunctionControlMgr
Self.FunctionState = {}
local UnlockType = {NoThing = 0, Gray = 1, Hide = 2, AddLock = 3, Controller = 4}
local CacheWindow = {(WinResConfig.BattleWinConvergeWindow).name, (WinResConfig.PlayerLevelUpWindow).name, (WinResConfig.ClearingWindow).name}
-- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

FunctionControlMgr.InitFunction = function(msg, ...)
  -- function num : 0_0 , upvalues : Self, _ENV
  Self.FunctionState = {}
  if not msg.initFuncId then
    for _,v in ipairs({}) do
      (FunctionControlMgr.SetFunctionState)(tonumber(v), true)
    end
  end
end

-- DECOMPILER ERROR at PC27: Confused about usage of register: R3 in 'UnsetPending'

FunctionControlMgr.OpenFunction = function(fID, ...)
  -- function num : 0_1 , upvalues : _ENV
  (FunctionControlMgr.SetFunctionState)(fID, true)
  local fid = tonumber(fID)
  local objS = (GuideData.GetGuideControl)(fid)
  if objS then
    for _,obj in pairs(objS) do
      (FunctionControlMgr.SetControlState)(fid, obj)
    end
  end
  do
    local functionData = ((TableData.gTable).BaseFunctionData)[fid]
    if tonumber(functionData.popup_window) == 1 then
      (FunctionControlMgr.SetFunctionWindow)(fid)
    end
    if functionData.id == ControlID.Shop_Token then
      (Util.ShowGuideTips)(GuideTipsCheckPoint.UnlockAdventureStore, (PUtil.get)(20000067))
    else
      if functionData.id == ControlID.Shop_Expedition then
        (Util.ShowGuideTips)(GuideTipsCheckPoint.UnlockHeroStore, (PUtil.get)(20000068))
      else
        if functionData.id == ControlID.HandBook_Story then
          (Util.ShowGuideTips)(GuideTipsCheckPoint.UnlockHandBookStory)
        else
          if functionData.id == ControlID.HandBook_Relation then
            (HandBookData.CheckFetterData)()
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC30: Confused about usage of register: R3 in 'UnsetPending'

FunctionControlMgr.SetFunctionState = function(fID, state, ...)
  -- function num : 0_2 , upvalues : Self, _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (Self.FunctionState)[fID] = state
  if fID == ControlID.HandBook_Intimacy then
    (RedDotMgr.SpecialIntimacyList)()
  end
end

-- DECOMPILER ERROR at PC33: Confused about usage of register: R3 in 'UnsetPending'

FunctionControlMgr.GetFunctionState = function(fID, showTip, ...)
  -- function num : 0_3 , upvalues : _ENV, Self
  if OvertureMgr.isPlaying == true then
    return true
  end
  local state = (Self.FunctionState)[tonumber(fID)]
  do
    if showTip and not state then
      local functionData = ((TableData.gTable).BaseFunctionData)[tonumber(fID)]
      if functionData ~= nil then
        (MessageMgr.SendCenterTips)(functionData.open_des)
      end
    end
    return state or false
  end
end

-- DECOMPILER ERROR at PC36: Confused about usage of register: R3 in 'UnsetPending'

FunctionControlMgr.SetControlState = function(fID, obj, ...)
  -- function num : 0_4 , upvalues : _ENV, UnlockType
  local functionData = ((TableData.gTable).BaseFunctionData)[tonumber(fID)]
  if not functionData then
    loge("未在BaseFunctionData表找到" .. fID .. "可忽略")
    return 
  end
  local state = (FunctionControlMgr.GetFunctionState)(fID)
  if state == nil then
    state = true
  end
  if functionData.lock_type == UnlockType.Gray then
    if fID == ControlID.Card_Comment then
      (FunctionControlMgr.SetObjGray)(obj:GetChild("n9"), not state)
    else
      ;
      (FunctionControlMgr.SetObjGray)(obj, not state)
    end
  else
    if functionData.lock_type == UnlockType.Hide then
      if fID <= ControlID.Adventure_Rich and ControlID.Adventure_Plot <= fID then
        local imageBtn = obj:GetChild("NameImage")
        if imageBtn then
          imageBtn.visible = state
        end
      else
        do
          obj.visible = state
          if functionData.lock_type == UnlockType.AddLock then
            local lock = obj:GetChild("LockGrp")
            local lockText = obj:GetChild("LockTxt")
            if lock then
              lock.visible = not state
            end
            if lockText then
              lockText.visible = not state
              local data = split(functionData.open_condition, ":")
              lockText.text = (PUtil.get)(20000183, data[3])
            end
          else
            do
              do
                if functionData.lock_type == UnlockType.Controller then
                  local lock = obj:GetController("lock")
                  if lock and state then
                    lock.selectedIndex = 0
                  else
                    lock.selectedIndex = 1
                  end
                end
                if state then
                  (obj.onClick):RemoveCapture(FunctionControlMgr.UnlockTipsShow)
                else
                  ;
                  (obj.onClick):AddCapture(FunctionControlMgr.UnlockTipsShow)
                end
              end
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC39: Confused about usage of register: R3 in 'UnsetPending'

FunctionControlMgr.SetObjGray = function(obj, grayed, ...)
  -- function num : 0_5 , upvalues : _ENV
  if (Util.IsNil)(obj) then
    return 
  end
  if obj.asButton then
    (Util.GrayBtn)(obj, grayed)
  else
    if obj.asLoader then
      (Util.GrayLoader)(obj, grayed)
    else
      if obj.asImage then
        (Util.GrayImage)(obj, grayed)
      else
        obj.grayed = grayed
      end
    end
  end
end

-- DECOMPILER ERROR at PC42: Confused about usage of register: R3 in 'UnsetPending'

FunctionControlMgr.UnlockTipsShow = function(eventContext, ...)
  -- function num : 0_6 , upvalues : _ENV
  local ctr = eventContext.sender
  local fID = (GuideData.GetGuideIdByControl)(ctr)
  local functionData = ((TableData.gTable).BaseFunctionData)[tonumber(fID)]
  ;
  (MessageMgr.SendCenterTips)(functionData.open_des)
  eventContext:StopPropagation()
end

-- DECOMPILER ERROR at PC45: Confused about usage of register: R3 in 'UnsetPending'

FunctionControlMgr.GetIsCacheWindow = function(...)
  -- function num : 0_7 , upvalues : _ENV, CacheWindow
  for _,v in ipairs(CacheWindow) do
    if UIMgr:IsWindowOpen(v) then
      return true
    end
  end
  return false
end

local ids = {}
-- DECOMPILER ERROR at PC49: Confused about usage of register: R4 in 'UnsetPending'

FunctionControlMgr.SetFunctionWindow = function(fid, ...)
  -- function num : 0_8 , upvalues : _ENV, ids
  (table.insert)(ids, fid)
  ;
  (SimpleTimer.setTimeout)(0.5, function(...)
    -- function num : 0_8_0 , upvalues : _ENV
    if (FunctionControlMgr.GetIsCacheWindow)() or (Util.IsPrepareLevelUpWindow)() then
      (FunctionControlMgr.IsPrepareFunctionOpenWindow)(true)
      return 
    end
    ;
    (FunctionControlMgr.OpenFunctionWindow)()
  end
)
  ;
  (GuideMgr.PlotDungeonTrigger)(fid)
end

local PrepareFunction = false
-- DECOMPILER ERROR at PC53: Confused about usage of register: R5 in 'UnsetPending'

FunctionControlMgr.OpenFunctionWindow = function(...)
  -- function num : 0_9 , upvalues : ids, _ENV
  if #ids == 0 then
    return 
  end
  local fid = ids[#ids]
  ids = {}
  local callback = function(...)
    -- function num : 0_9_0 , upvalues : _ENV, fid
    if UIMgr:IsWindowOpen((WinResConfig.HomeWindow).name) then
      OpenWindow((WinResConfig.FunctionOpenWindow).name, UILayer.HUD1, fid)
    else
      UIMgr:SetOnShownComplete((WinResConfig.HomeWindow).name, function(...)
      -- function num : 0_9_0_0 , upvalues : _ENV, fid
      OpenWindow((WinResConfig.FunctionOpenWindow).name, UILayer.HUD1, fid)
    end
)
      UIMgr:CloseToWindow((WinResConfig.HomeWindow).name)
    end
  end

  if UIMgr:IsWindowOpen((WinResConfig.BattleUIWindow).name) == true then
    ld("Battle", function(...)
    -- function num : 0_9_1 , upvalues : _ENV, callback
    (BattleMgr.CloseBattle)(true, callback)
  end
)
  else
    callback()
  end
end

-- DECOMPILER ERROR at PC56: Confused about usage of register: R5 in 'UnsetPending'

FunctionControlMgr.IsPrepareFunctionOpenWindow = function(value, ...)
  -- function num : 0_10 , upvalues : PrepareFunction
  if value == nil then
    return PrepareFunction
  else
    PrepareFunction = value
  end
end


