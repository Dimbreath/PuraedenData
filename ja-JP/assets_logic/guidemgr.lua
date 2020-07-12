-- params : ...
-- function num : 0 , upvalues : _ENV
GuideMgr = {}
local Stage = FairyGUI.Stage
local Self = GuideMgr
local GuideProcessData = {}
local DungeonProcessData = {}
local MindGuideData = {}
local PictureGuideData = {}
local m = {}
local m2 = {}
Self.CallBack = {}
Self.PictureListID = {}
-- DECOMPILER ERROR at PC17: Confused about usage of register: R8 in 'UnsetPending'

GuideMgr.InitBaseGuideProcessData = function(...)
  -- function num : 0_0 , upvalues : GuideProcessData, _ENV, DungeonProcessData
  GuideProcessData = {}
  local baseData = (Util.Copy)((TableData.gTable).BaseGuideProcessData)
  for _,v in pairs(baseData) do
    local m = {}
    m.id = v.id
    m.level = v.level
    m.FunctionId = v.function_id
    m.nextID = v.next_id
    local stepS = {}
    for i = 1, 10 do
      local m2 = {}
      m2.Key = v["key" .. i]
      m2.basicStep = v["step" .. i]
      m2.specialStep = v["step" .. i .. "_"]
      m2.exp = v["exp" .. i]
      if m2.basicStep and not (Util.StringIsNullOrEmpty)(m2.basicStep) and m2.basicStep ~= "0" then
        stepS[i] = m2
      end
    end
    m.stepS = stepS
    if m.FunctionId and m.FunctionId > 0 then
      DungeonProcessData[v.id] = m
    else
      GuideProcessData[v.id] = m
    end
  end
  ;
  (GuideMgr.InitMildGuide)()
  ;
  (GuideMgr.InitPictureGuideData)()
end

-- DECOMPILER ERROR at PC20: Confused about usage of register: R8 in 'UnsetPending'

GuideMgr.IsInMainGuide = function(...)
  -- function num : 0_1 , upvalues : _ENV
  return UIMgr:IsWindowOpen((WinResConfig.GuideWindow).name)
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R8 in 'UnsetPending'

GuideMgr.IsInPictureGuide = function(...)
  -- function num : 0_2 , upvalues : _ENV
  return UIMgr:IsWindowOpen((WinResConfig.GuidePictureWindow).name)
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R8 in 'UnsetPending'

GuideMgr.SetGuideShow = function(visible, ...)
  -- function num : 0_3 , upvalues : _ENV
  if not GameObject then
    GameObject = (CS.UnityEngine).GameObject
  end
  local guideCamera = (GameObject.Find)("GuideCamera")
  if guideCamera == nil then
    return 
  end
  UIMgr:SendWindowMessage((WinResConfig.GuideWindow).name, (WindowMsgEnum.GuideWindow).GUIDE_SET_GUIDE_SHOW, visible)
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R8 in 'UnsetPending'

GuideMgr.GuideId = function(pID, ...)
  -- function num : 0_4 , upvalues : Self, _ENV
  if pID ~= nil then
    if Self.IsDungeon then
      Self.PpID = tonumber(pID)
    else
      Self.pID = tonumber(pID)
    end
  else
    if Self.IsDungeon then
      return tonumber(Self.PpID)
    else
      return tonumber(Self.pID)
    end
  end
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R8 in 'UnsetPending'

GuideMgr.GuideStepGroupId = function(sgID, ...)
  -- function num : 0_5 , upvalues : Self, _ENV
  if sgID ~= nil then
    if Self.IsDungeon then
      Self.PsgID = tonumber(sgID)
    else
      Self.sgID = tonumber(sgID)
    end
  else
    if Self.IsDungeon then
      return tonumber(Self.PsgID)
    else
      return tonumber(Self.sgID)
    end
  end
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R8 in 'UnsetPending'

GuideMgr.GuideStepId = function(sID, ...)
  -- function num : 0_6 , upvalues : Self, _ENV
  if sID ~= nil then
    if Self.IsDungeon then
      Self.PsID = tonumber(sID)
    else
      Self.sID = tonumber(sID)
    end
  else
    if Self.IsDungeon then
      return tonumber(Self.PsID)
    else
      return tonumber(Self.sID)
    end
  end
end

-- DECOMPILER ERROR at PC38: Confused about usage of register: R8 in 'UnsetPending'

GuideMgr.GuideStepGroupSpecial = function(special, ...)
  -- function num : 0_7 , upvalues : Self
  if special ~= nil then
    Self.special = special
  else
    return Self.special
  end
end

-- DECOMPILER ERROR at PC41: Confused about usage of register: R8 in 'UnsetPending'

GuideMgr.CurrentGuideIsDungeon = function(dungeon, ...)
  -- function num : 0_8 , upvalues : Self
  if dungeon ~= nil then
    Self.IsDungeon = dungeon
  else
    return Self.IsDungeon
  end
end

-- DECOMPILER ERROR at PC44: Confused about usage of register: R8 in 'UnsetPending'

GuideMgr.SetProcessEndCallBack = function(pID, fun, ...)
  -- function num : 0_9 , upvalues : _ENV, Self
  if fun == nil or type(fun) ~= "function" then
    return 
  end
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (Self.CallBack)[pID] = fun
end

-- DECOMPILER ERROR at PC47: Confused about usage of register: R8 in 'UnsetPending'

GuideMgr.InItServiceData = function(pID, sgID, sID, isDungeon, ...)
  -- function num : 0_10 , upvalues : Self, _ENV, DungeonProcessData, GuideProcessData
  Self.IsDungeon = isDungeon
  if pID == nil or pID == 0 then
    if not isDungeon then
      (GuideMgr.SetFirstGuideData)(Const.InitProcessId)
    end
    return 
  end
  local guideData = {}
  if isDungeon then
    guideData = DungeonProcessData[pID]
  else
    guideData = GuideProcessData[pID]
  end
  local GroupStep = (guideData.stepS)[sgID]
  local stepS = split(GroupStep.basicStep, "|")
  local isPassKey = false
  if GroupStep.Key > 0 then
    isPassKey = (GuideMgr.IsPassKeyGuide)(stepS, GroupStep.Key, sID)
  else
    isPassKey = GroupStep.exp <= (ActorData.GetAmountExp)()
  end
  ;
  (GuideMgr.GuideStepGroupSpecial)(true)
  if isPassKey then
    local nextGroup = (GuideMgr.GetNextStepGroup)(pID, sgID)
    if nextGroup then
      (GuideMgr.GuideId)(pID)
      ;
      (GuideMgr.GuideStepGroupId)(nextGroup)
      local GroupStep = (guideData.stepS)[nextGroup]
      local stepS = split(GroupStep.specialStep, "|")
      ;
      (GuideMgr.GuideStepId)(stepS[1])
    else
      (GuideMgr.SetNextGuide)(pID, true)
    end
  else
    (GuideMgr.GuideId)(pID)
    ;
    (GuideMgr.GuideStepGroupId)(sgID)
    local stepS = split(GroupStep.specialStep, "|")
    ;
    (GuideMgr.GuideStepId)(stepS[1])
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC50: Confused about usage of register: R8 in 'UnsetPending'

GuideMgr.SetNextGuide = function(pId, forceSpecial, ...)
  -- function num : 0_11 , upvalues : Self, _ENV, GuideProcessData
  if Self.IsDungeon then
    Self.PpID = -1
    loge("功能引导结束")
    return 
  end
  local guideProcess = GuideProcessData[pId]
  if guideProcess.nextID == nil or guideProcess.nextID <= 0 then
    (GuideMgr.GuideId)(-1)
  else
    ;
    (GuideMgr.SetFirstGuideData)(guideProcess.nextID, forceSpecial)
  end
end

-- DECOMPILER ERROR at PC53: Confused about usage of register: R8 in 'UnsetPending'

GuideMgr.SetFirstGuideData = function(pID, forceSpecial, ...)
  -- function num : 0_12 , upvalues : _ENV, Self, DungeonProcessData, GuideProcessData
  ;
  (GuideMgr.GuideStepGroupSpecial)(forceSpecial or false)
  ;
  (GuideMgr.GuideId)(pID)
  ;
  (GuideMgr.GuideStepGroupId)(1)
  local stepS = {}
  if Self.IsDungeon then
    stepS = (DungeonProcessData[pID]).stepS
  else
    stepS = (GuideProcessData[pID]).stepS
  end
  local step = nil
  if (GuideMgr.GuideStepGroupSpecial)() then
    step = split((stepS[1]).specialStep, "|")
  else
    step = split((stepS[1]).basicStep, "|")
  end
  ;
  (GuideMgr.GuideStepId)(step[1])
end

-- DECOMPILER ERROR at PC56: Confused about usage of register: R8 in 'UnsetPending'

GuideMgr.SetStartGuideData = function(pID, isDungeon, ...)
  -- function num : 0_13 , upvalues : Self, _ENV
  Self.IsDungeon = isDungeon
  ;
  (GuideMgr.SetFirstGuideData)(pID)
end

-- DECOMPILER ERROR at PC59: Confused about usage of register: R8 in 'UnsetPending'

GuideMgr.IsPassKeyGuide = function(stepS, key, sID, ...)
  -- function num : 0_14 , upvalues : _ENV
  if key == sID then
    return true
  end
  for _,v in ipairs(stepS) do
    if tonumber(v) == sID then
      return false
    end
    if tonumber(v) == key then
      return true
    end
  end
end

-- DECOMPILER ERROR at PC62: Confused about usage of register: R8 in 'UnsetPending'

GuideMgr.InGuideOpenWindow = function(windowName, layer, data, ...)
  -- function num : 0_15 , upvalues : _ENV
  if not layer then
    layer = UILayer.HUD
  end
  if (GuideMgr.IsInMainGuide)() then
    OpenWindowByDelayClose(windowName, layer, Const.GuideDelayTime, data)
  else
    OpenWindow(windowName, layer, data)
  end
end

-- DECOMPILER ERROR at PC65: Confused about usage of register: R8 in 'UnsetPending'

GuideMgr.GetCtrInfer = function(id, ...)
  -- function num : 0_16 , upvalues : _ENV
  if id == nil then
    return 
  end
  local conID = tonumber(id)
  if ControlID.PlotDungeon_OneOne <= id and id <= ControlID.PlotDungeon_TwoFive then
    conID = ControlID.PlotDungeon_Stage
  end
  local guideCtr = (GuideData.GetGuideControl)(conID)
  if guideCtr and guideCtr[1] then
    local con = guideCtr[1]
    if id == ControlID.CardList_List or id == ControlID.CardList_List2 then
      local cardID = 0
      if id == ControlID.CardList_List then
        cardID = 11100003
      else
        cardID = 11100002
      end
    else
      do
        if ControlID.PlotDungeon_OneOne <= id and id <= ControlID.PlotDungeon_OneFive then
          local chapterId = (PlotDungeonMgr.GetSelectChapter)()
          if chapterId == 51100001 then
            local num = id % 10
            return (con:GetChild("0" .. num .. "_Btn")):GetChild("CardQLoader")
          else
            do
              do
                do return  end
                if ControlID.PlotDungeon_TwoOne <= id and id <= ControlID.PlotDungeon_TwoFive then
                  local chapterId = (PlotDungeonMgr.GetSelectChapter)()
                  if chapterId == 51100002 then
                    local num = id % 10 - 5
                    return (con:GetChild("0" .. num .. "_Btn")):GetChild("CardQLoader")
                  else
                    do
                      do
                        do return  end
                        if id == ControlID.PlotDungeon_OneBox then
                          local chapterId = (PlotDungeonMgr.GetSelectChapter)()
                          if chapterId == 51100001 then
                            return con
                          else
                            return 
                          end
                        else
                          do
                            if id == ControlID.PlotDungeon_TwoBox then
                              local chapterId = (PlotDungeonMgr.GetSelectChapter)()
                              if chapterId == 51100002 then
                                return con
                              else
                                return 
                              end
                            else
                              do
                                if id == ControlID.HeroChapterList_FirstChapter then
                                  return con
                                else
                                  if id == ControlID.HeroChapterSage_OneOne then
                                    return ((con:GetChildAt(0)):GetChild("Monster_01_Grp")):GetChild("CharacterLoader")
                                  else
                                    if id == ControlID.Tower_OneOne then
                                      return con
                                    else
                                      if id == ControlID.Task_List then
                                        local index = con:ItemIndexToChildIndex(0)
                                        UIMgr:SendWindowMessage((WinResConfig.TaskWindow).name, (WindowMsgEnum.TaskWindow).TASK_CLOSE_SCROLL)
                                        return con:GetChildAt(index)
                                      else
                                        do
                                          -- DECOMPILER ERROR at PC185: Unhandled construct in 'MakeBoolean' P1

                                          if id == ControlID.Daily_GoldOne and DailyDungeonMgr.curSelectTrialType == PlayType.CoinDungeon then
                                            return con:GetChildAt(0)
                                          end
                                          -- DECOMPILER ERROR at PC200: Unhandled construct in 'MakeBoolean' P1

                                          if id == ControlID.Daily_MedicalOne and DailyDungeonMgr.curSelectTrialType == PlayType.RoleExpDungeon then
                                            return con:GetChildAt(0)
                                          end
                                          if id == ControlID.Equipment_IdentifyBag or id == ControlID.Equipment_AllBag then
                                            local index = con:ItemIndexToChildIndex(0)
                                            return con:GetChildAt(index)
                                          else
                                            do
                                              if con.asList ~= nil then
                                                local mList = con.asList
                                                if mList.isVirtual then
                                                  local index = con:ItemIndexToChildIndex(0)
                                                  return con:GetChildAt(index)
                                                else
                                                  do
                                                    do
                                                      do return con:GetChildAt(0) end
                                                      do return con end
                                                    end
                                                  end
                                                end
                                              end
                                            end
                                          end
                                        end
                                      end
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC68: Confused about usage of register: R8 in 'UnsetPending'

GuideMgr.GuideStepPlayOver = function(ignoreFull, ...)
  -- function num : 0_17 , upvalues : _ENV, Self
  local pID = (GuideMgr.GuideId)()
  local sgID = (GuideMgr.GuideStepGroupId)()
  local sID = (GuideMgr.GuideStepId)()
  local isSpecial = (GuideMgr.GuideStepGroupSpecial)()
  local StepData = ((TableData.gTable).BaseGuideStepData)[sID]
  local isStop = StepData.is_stop == (GuideData.GuideStop).Stop
  if Self.IsDungeon then
    (GuideService.SavePlotGuideData)(pID, sgID, sID)
  else
    (GuideService.SaveBasicGuideData)(pID, sgID, sID)
  end
  loge("发送的pID.." .. pID .. "sgID" .. sgID .. "sID" .. sID)
  local nextGuideStep = (GuideMgr.GetNextGuideStep)(pID, sgID, sID, isSpecial, true, ignoreFull)
  if nextGuideStep then
    (GuideMgr.GuideStepId)(nextGuideStep)
    if isStop then
      UIMgr:SendWindowMessage((WinResConfig.GuideWindow).name, (WindowMsgEnum.GuideWindow).GUIDE_FINISH)
    else
      (GuideMgr.PlayGuide)(nextGuideStep)
    end
  else
    local fun = (Self.CallBack)[pID]
    if fun ~= nil then
      fun()
      -- DECOMPILER ERROR at PC88: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (Self.CallBack)[pID] = nil
    end
    ;
    (GuideMgr.SetNextGuide)(pID)
    UIMgr:SendWindowMessage((WinResConfig.GuideWindow).name, (WindowMsgEnum.GuideWindow).GUIDE_FINISH)
  end
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC71: Confused about usage of register: R8 in 'UnsetPending'

GuideMgr.GetGuideGroupData = function(pID, sgID, ...)
  -- function num : 0_18 , upvalues : DungeonProcessData, GuideProcessData, _ENV
  local data = DungeonProcessData[pID]
  if data == nil then
    data = GuideProcessData[pID]
  end
  if not data then
    (GuideMgr.GuideLog)(pID .. "未在配置BaseGuideProcessData中")
    return 
  end
  local sgData = (data.stepS)[sgID]
  return sgData
end

-- DECOMPILER ERROR at PC74: Confused about usage of register: R8 in 'UnsetPending'

GuideMgr.GetNextGuideStep = function(pId, sgId, sid, isSpecial, setValue, ignoreFull, ...)
  -- function num : 0_19 , upvalues : _ENV
  local sgID = sgId
  local sID = sid
  local sgData = (GuideMgr.GetGuideGroupData)(pId, sgID)
  if not sgData then
    UIMgr:SendWindowMessage((WinResConfig.GuideWindow).name, (WindowMsgEnum.GuideWindow).GUIDE_FINISH)
  end
  local stepStr = nil
  if isSpecial then
    stepStr = sgData.specialStep
  else
    stepStr = sgData.basicStep
  end
  local stepS = split(stepStr, "|")
  local NextStepId = -1
  for i,v in ipairs(stepS) do
    if tonumber(v) == sID then
      if ignoreFull then
        for j = i + 1, #stepS do
          local tempID = tonumber(stepS[j])
          local StepData = ((TableData.gTable).BaseGuideStepData)[tempID]
          if tonumber(StepData.full_screen) == 0 then
            NextStepId = tempID
            break
          end
        end
        break
      end
      NextStepId = tonumber(stepS[i + 1])
      break
    end
  end
  do
    if NextStepId == -1 then
      (GuideMgr.GuideLog)("未在Pid" .. pId .. "中找到    sgID:" .. sgID .. "    SID:" .. sID .. "是否是特殊步骤" .. tostring(isSpecial))
      return 
    else
      if NextStepId then
        return NextStepId
      else
        local NextGroup = (GuideMgr.GetNextStepGroup)(pId, sgID)
        if NextGroup then
          local NextGroupStepData = (GuideMgr.GetGuideGroupData)(pId, NextGroup)
          if not (Util.StringIsNullOrEmpty)(NextGroupStepData.basicStep) then
            if setValue then
              (GuideMgr.GuideStepGroupSpecial)(false)
              ;
              (GuideMgr.GuideStepGroupId)(NextGroup)
            end
            local NextGroupStepS = split(NextGroupStepData.basicStep, "|")
            return NextGroupStepS[1]
          end
        else
          do
            do return  end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC77: Confused about usage of register: R8 in 'UnsetPending'

GuideMgr.GetNextStepGroup = function(pid, groupId, ...)
  -- function num : 0_20 , upvalues : Self, DungeonProcessData, GuideProcessData
  local processData = {}
  if Self.IsDungeon then
    processData = DungeonProcessData[pid]
  else
    processData = GuideProcessData[pid]
  end
  local stepS = processData.stepS
  if stepS[groupId + 1] ~= nil then
    return groupId + 1
  end
end

-- DECOMPILER ERROR at PC80: Confused about usage of register: R8 in 'UnsetPending'

GuideMgr.PlayGuide = function(sId, ...)
  -- function num : 0_21 , upvalues : _ENV
  (GuideMgr.CloseMildGuide)()
  local StepData = ((TableData.gTable).BaseGuideStepData)[tonumber(sId)]
  if StepData then
    if UIMgr:IsWindowOpen((WinResConfig.GuideWindow).name) then
      if StepData.window_name and StepData.window_name > 0 then
        local winName = ((TableData.gTable).BaseWindowNameData)[StepData.window_name]
        do
          if StepData.plotplay_Id == nil or StepData.plotplay_Id <= 0 then
            UIMgr:SendWindowMessage((WinResConfig.GuideWindow).name, (WindowMsgEnum.GuideWindow).GUIDE_CHECK)
          end
          if UIMgr:IsWindowOpen(winName.window_name) then
            UIMgr:SendWindowMessage((WinResConfig.GuideWindow).name, (WindowMsgEnum.GuideWindow).GUIDE_CONTINUAL)
          else
            UIMgr:SetOnShownComplete(winName.window_name, function(...)
    -- function num : 0_21_0 , upvalues : _ENV, winName
    if UIMgr:IsWindowOpen((WinResConfig.PlotPlayPanelWindow).name) then
      UIMgr:SendWindowMessage((WinResConfig.GuideWindow).name, (WindowMsgEnum.GuideWindow).GUIDE_FINISH)
      UIMgr:SetOnHideComplete((WinResConfig.PlotPlayPanelWindow).name, function(...)
      -- function num : 0_21_0_0 , upvalues : _ENV, winName
      (GuideMgr.CheckIsTriggerGuide)(winName.window_name)
      ;
      (Util.SetOnClickDelay)(1)
    end
)
    else
      UIMgr:SendWindowMessage((WinResConfig.GuideWindow).name, (WindowMsgEnum.GuideWindow).GUIDE_CONTINUAL)
    end
  end
)
          end
        end
      else
        do
          -- DECOMPILER ERROR at PC71: Confused about usage of register: R2 in 'UnsetPending'

          ;
          (GRoot.inst).touchable = false
          ;
          (SimpleTimer.setTimeout)(0.2, function(...)
    -- function num : 0_21_1 , upvalues : _ENV
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    (GRoot.inst).touchable = true
    UIMgr:SendWindowMessage((WinResConfig.GuideWindow).name, (WindowMsgEnum.GuideWindow).GUIDE_CONTINUAL)
  end
)
          OpenWindow((WinResConfig.GuideWindow).name, UILayer.Guide)
          ;
          (GuideMgr.GuideLog)("配置表BaseGuideStepData未找到sid.." .. sId)
          UIMgr:SendWindowMessage((WinResConfig.GuideWindow).name, (WindowMsgEnum.GuideWindow).GUIDE_FINISH)
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC83: Confused about usage of register: R8 in 'UnsetPending'

GuideMgr.CheckIsTriggerGuide = function(windowName, ...)
  -- function num : 0_22 , upvalues : _ENV, Self, DungeonProcessData, GuideProcessData
  if Game.jumpNewHand == true then
    return 
  end
  local guideSwitch = (Util.GetPlayerSetting)(PlayerPrefsKeyName.GUIDE_OPEN, 1)
  if tonumber(guideSwitch) == 0 then
    return 
  end
  local PpID = Self.PpID
  local PsID = Self.PsID
  if PpID and PpID > 0 and PsID and PsID > 0 then
    local condition = (GuideMgr.CheckTriggerCondition)(windowName, PsID)
    if condition then
      return 
    end
    local guideData = DungeonProcessData[PpID]
    if guideData then
      (GuideMgr.SetWaitClickTime)(0.3)
      ;
      (SimpleTimer.setTimeout)(0.2, function(...)
    -- function num : 0_22_0 , upvalues : _ENV, PsID
    (GuideMgr.PlayGuide)(PsID)
  end
)
      ;
      (GuideMgr.CurrentGuideIsDungeon)(true)
      return 
    end
  end
  do
    local pID = Self.pID
    local sID = Self.sID
    if pID and pID > 0 and sID and sID > 0 then
      local condition = (GuideMgr.CheckTriggerCondition)(windowName, sID)
      if condition then
        return 
      end
      local guideData = GuideProcessData[pID]
      if guideData and guideData.level == (ActorData.GetLevel)() then
        (GuideMgr.SetWaitClickTime)(0.3)
        ;
        (SimpleTimer.setTimeout)(0.2, function(...)
    -- function num : 0_22_1 , upvalues : _ENV, sID
    (GuideMgr.PlayGuide)(sID)
  end
)
        ;
        (GuideMgr.CurrentGuideIsDungeon)(false)
      end
    end
  end
end

-- DECOMPILER ERROR at PC86: Confused about usage of register: R8 in 'UnsetPending'

GuideMgr.SetWaitClickTime = function(time, ...)
  -- function num : 0_23 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (GRoot.inst).touchable = false
  ;
  (SimpleTimer.setTimeout)(time, function(...)
    -- function num : 0_23_0 , upvalues : _ENV
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    (GRoot.inst).touchable = true
  end
)
end

-- DECOMPILER ERROR at PC89: Confused about usage of register: R8 in 'UnsetPending'

GuideMgr.CheckTriggerCondition = function(winName, sid, ...)
  -- function num : 0_24 , upvalues : _ENV
  local StepData = ((TableData.gTable).BaseGuideStepData)[sid]
  if not StepData then
    return true
  end
  local mWindowName = ((TableData.gTable).BaseWindowNameData)[tonumber(StepData.window_name)]
  if mWindowName == nil or mWindowName.window_name == nil or winName ~= mWindowName.window_name then
    return true
  end
  if (Util.IsPrepareLevelUpWindow)() then
    UIMgr:SetOnHideComplete((WinResConfig.PlayerLevelUpWindow).name, function(...)
    -- function num : 0_24_0 , upvalues : _ENV, winName
    (GuideMgr.CheckIsTriggerGuide)(winName)
  end
)
    return true
  end
  if (FunctionControlMgr.IsPrepareFunctionOpenWindow)() then
    UIMgr:SetOnHideComplete((WinResConfig.FunctionOpenWindow).name, function(...)
    -- function num : 0_24_1 , upvalues : _ENV, winName
    (GuideMgr.CheckIsTriggerGuide)(winName)
  end
)
    return true
  end
  if UIMgr:IsWindowOpen((WinResConfig.LoadingWindow).name) then
    UIMgr:SetOnHideComplete((WinResConfig.LoadingWindow).name, function(...)
    -- function num : 0_24_2 , upvalues : _ENV, winName
    (GuideMgr.CheckIsTriggerGuide)(winName)
  end
)
    return true
  end
  if UIMgr:IsWindowOpen((WinResConfig.RewardShowWindow).name) then
    UIMgr:SetOnHideComplete((WinResConfig.RewardShowWindow).name, function(...)
    -- function num : 0_24_3 , upvalues : _ENV, winName
    (GuideMgr.CheckIsTriggerGuide)(winName)
  end
)
    return true
  end
  return false
end

-- DECOMPILER ERROR at PC92: Confused about usage of register: R8 in 'UnsetPending'

GuideMgr.PlotDungeonTrigger = function(fID, ...)
  -- function num : 0_25 , upvalues : _ENV, DungeonProcessData, Self
  local enterGuide = false
  local stepData = nil
  for _,v in pairs(DungeonProcessData) do
    if v.FunctionId == fID then
      enterGuide = true
      stepData = v
    end
  end
  if not enterGuide then
    return 
  end
  ;
  (GuideMgr.GuideLog)("设置副本数据引导id.." .. stepData.id)
  ;
  (GuideMgr.CurrentGuideIsDungeon)(true)
  ;
  (GuideMgr.SetFirstGuideData)(stepData.id)
  ;
  (GuideService.SavePlotGuideData)(Self.PpID, -1)
end

-- DECOMPILER ERROR at PC95: Confused about usage of register: R8 in 'UnsetPending'

GuideMgr.TerminateCurrentStep = function(msgID, ...)
  -- function num : 0_26 , upvalues : _ENV
  local sID = (GuideMgr.GuideStepId)()
  local GuideStep = ((TableData.gTable).BaseGuideStepData)[tonumber(sID)]
  if GuideStep and GuideStep.req_severs == 1 and GuideStep.ctrl_id and GuideStep.ctrl_id > 0 then
    local mMsgId = BtnCorrespondMsgID[GuideStep.ctrl_id]
    if mMsgId == msgID then
      UIMgr:SendWindowMessage((WinResConfig.GuideWindow).name, (WindowMsgEnum.GuideWindow).GUIDE_CURRENT_STEP_OVER)
    end
  end
end

-- DECOMPILER ERROR at PC98: Confused about usage of register: R8 in 'UnsetPending'

GuideMgr.GuideLog = function(content, ...)
  -- function num : 0_27 , upvalues : _ENV
  loge("新手引导错误日志:" .. content)
end

local fingerState = {"left_down", "left_up", "right_up", "right_down"}
-- DECOMPILER ERROR at PC107: Confused about usage of register: R9 in 'UnsetPending'

GuideMgr.InitMildGuide = function(...)
  -- function num : 0_28 , upvalues : _ENV, MindGuideData
  local BaseGuideRemindData = (Util.Copy)((TableData.gTable).BaseGuideRemindData)
  for _,v in pairs(BaseGuideRemindData) do
    local mWindowName = ((TableData.gTable).BaseWindowNameData)[tonumber(v.window_name)]
    if mWindowName then
      MindGuideData[mWindowName.window_name] = v
    end
  end
end

local timer, timer2, mCurrentFinger = nil, nil, nil
-- DECOMPILER ERROR at PC111: Confused about usage of register: R12 in 'UnsetPending'

GuideMgr.MildGuideTrigger = function(winName, ctrl, offSet, waitTime, LimitTime, ...)
  -- function num : 0_29 , upvalues : timer, MindGuideData, _ENV
  if timer then
    timer:stop()
  end
  local guideData = MindGuideData[winName]
  if guideData == nil then
    return 
  end
  if winName == (WinResConfig.BattleUIWindow).name then
    return 
  end
  if not waitTime then
    waitTime = 0
  end
  ;
  (SimpleTimer.setTimeout)(waitTime, function(...)
    -- function num : 0_29_0 , upvalues : winName, _ENV, guideData, ctrl, offSet, waitTime, LimitTime, timer
    if winName == (WinResConfig.GuideWindow).name then
      return 
    end
    local mLevel = (ActorData.GetLevel)()
    local lvStr = split(guideData.level_range, ":")
    if tonumber(lvStr[2]) < mLevel or mLevel < tonumber(lvStr[1]) then
      return 
    end
    local isOpen = UIMgr:IsWindowOpen((WinResConfig.GuidePictureWindow).name)
    local isPlay = (GuideMgr.IsPlayPictureGuide)(winName)
    if isOpen or isPlay then
      UIMgr:SetOnHideComplete((WinResConfig.GuidePictureWindow).name, function(...)
      -- function num : 0_29_0_0 , upvalues : _ENV, winName, ctrl, offSet, waitTime, LimitTime
      (GuideMgr.MildGuideTrigger)(winName, ctrl, offSet, waitTime, LimitTime)
    end
)
      return 
    else
      if UIMgr:IsWindowOpen((WinResConfig.GuideWindow).name) then
        UIMgr:SetOnHideComplete((WinResConfig.GuideWindow).name, function(...)
      -- function num : 0_29_0_1 , upvalues : _ENV, winName, ctrl, offSet, waitTime, LimitTime
      (GuideMgr.MildGuideTrigger)(winName, ctrl, offSet, waitTime, LimitTime)
    end
)
        return 
      end
    end
    timer = (SimpleTimer.setTimeout)((math.max)(guideData.wait_time - waitTime, 0), function(...)
      -- function num : 0_29_0_2 , upvalues : ctrl, _ENV, guideData, offSet, LimitTime
      local clickCtr = ctrl
      if clickCtr == nil then
        clickCtr = (GuideMgr.GetCtrInfer)(guideData.ctrl_id)
      end
      if clickCtr == nil or (clickCtr.displayObject).gameObject == nil then
        return 
      end
      local mPos = offSet
      if mPos == nil then
        mPos = guideData.guide_eff_offset
      end
      ;
      (GuideMgr.AddMildGuideFinger)(clickCtr, mPos, guideData.finger_path, guideData.finger_direction, LimitTime)
    end
)
  end
)
end

-- DECOMPILER ERROR at PC114: Confused about usage of register: R12 in 'UnsetPending'

GuideMgr.AddMildGuideFinger = function(clickCtr, OffsetPos, fingerPath, direction, LimitTime, ...)
  -- function num : 0_30 , upvalues : _ENV, mCurrentFinger, fingerState
  if UIMgr:IsWindowOpen((WinResConfig.GuideWindow).name) then
    return 
  end
  ;
  (GuideMgr.CloseMildGuide)()
  local mCom = UIMgr:CreateObject("Guide", "Hand")
  clickCtr:AddChild(mCom)
  mCurrentFinger = mCom
  local posStr = split(OffsetPos, ":")
  local mPos = Vector2(tonumber(posStr[1]), tonumber(posStr[2]))
  local loader = mCom:GetChild("HandLoader")
  local spineName = "handpooint"
  if fingerPath and (Util.StringIsNullOrEmpty)(fingerPath) then
    spineName = fingerPath
  end
  ;
  (Util.ShowUIModel)(spineName, loader, nil, false, function(model, ...)
    -- function num : 0_30_0 , upvalues : _ENV, LimitTime, fingerState, direction, loader, mCom
    if UIMgr:IsWindowOpen((WinResConfig.GuideWindow).name) then
      (GuideMgr.CloseMildGuide)()
      return 
    end
    if LimitTime and LimitTime > 0 then
      (GuideMgr.SetAnimationPlayTimes)(model.gameObject, fingerState[direction], LimitTime, function(...)
      -- function num : 0_30_0_0 , upvalues : _ENV
      (GuideMgr.CloseMildGuide)()
    end
)
    else
      ;
      (SkeletonAnimationUtil.SetAnimation)(model.gameObject, 0, fingerState[direction], true)
    end
    ;
    (SkeletonAnimationUtil.ClearAllEvent)(model.gameObject)
    ;
    (SkeletonAnimationUtil.AddEvent)(model.gameObject, function(trackEntry, event, ...)
      -- function num : 0_30_0_1 , upvalues : loader, mCom, _ENV
      if (event.Data).Name == "trigger" and loader and mCom then
        local holder = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_GUIDE_POINT, true, mCom, Vector2(loader.width, loader.height / 2))
      end
    end
)
  end
)
  mCom.xy = mPos
end

-- DECOMPILER ERROR at PC117: Confused about usage of register: R12 in 'UnsetPending'

GuideMgr.SetAnimationPlayTimes = function(sa, aniName, time, func, ...)
  -- function num : 0_31 , upvalues : _ENV
  time = time - 1
  ;
  (SkeletonAnimationUtil.SetAnimation)(sa, 0, aniName, false, function(...)
    -- function num : 0_31_0 , upvalues : time, func, _ENV, sa, aniName
    if time <= 0 then
      func()
      return 
    end
    ;
    (GuideMgr.SetAnimationPlayTimes)(sa, aniName, time, func)
  end
)
end

-- DECOMPILER ERROR at PC120: Confused about usage of register: R12 in 'UnsetPending'

GuideMgr.CloseMildGuide = function(...)
  -- function num : 0_32 , upvalues : mCurrentFinger, timer
  if mCurrentFinger ~= nil then
    mCurrentFinger:Dispose()
    mCurrentFinger = nil
  end
  if timer then
    timer:stop()
    timer = nil
  end
end

local mFightMild = {}
local mPlayPos = -1
-- DECOMPILER ERROR at PC125: Confused about usage of register: R14 in 'UnsetPending'

GuideMgr.AddFightMildGuide = function(clickCtr, pos, ...)
  -- function num : 0_33 , upvalues : MindGuideData, _ENV, mFightMild
  local guideData = MindGuideData[(WinResConfig.BattleUIWindow).name]
  if guideData == nil then
    return 
  end
  local mLevel = (ActorData.GetLevel)()
  local lvStr = split(guideData.level_range, ":")
  if tonumber(lvStr[2]) < mLevel or mLevel < tonumber(lvStr[1]) then
    return 
  end
  loge("增加pos:  " .. pos .. "弱引导")
  ;
  (table.insert)(mFightMild, {Ctr = clickCtr, mPos = pos, data = guideData})
  ;
  (GuideMgr.CheckFightMild)()
end

-- DECOMPILER ERROR at PC128: Confused about usage of register: R14 in 'UnsetPending'

GuideMgr.RemoveFightMildGuide = function(pos, ...)
  -- function num : 0_34 , upvalues : _ENV, mFightMild
  for i,v in ipairs(mFightMild) do
    if v.mPos == pos then
      (table.remove)(mFightMild, i)
      loge("删除pos:  " .. pos .. "弱引导")
      ;
      (GuideMgr.CheckFightMild)()
      break
    end
  end
end

-- DECOMPILER ERROR at PC131: Confused about usage of register: R14 in 'UnsetPending'

GuideMgr.ClearFightMildGuide = function(...)
  -- function num : 0_35 , upvalues : mFightMild
  mFightMild = {}
end

-- DECOMPILER ERROR at PC134: Confused about usage of register: R14 in 'UnsetPending'

GuideMgr.CheckFightMild = function(...)
  -- function num : 0_36 , upvalues : mFightMild, _ENV, mPlayPos
  local FightMild = mFightMild[1]
  if FightMild == nil then
    (GuideMgr.CloseMildGuide)()
  else
    if mPlayPos ~= FightMild.mPos then
      local data = FightMild.data
      ;
      (GuideMgr.AddMildGuideFinger)(FightMild.Ctr, data.guide_eff_offset, data.finger_path, data.finger_direction)
      mPlayPos = FightMild.mPos
      loge("播放pos:  " .. mPlayPos .. "弱引导")
    end
  end
end

-- DECOMPILER ERROR at PC137: Confused about usage of register: R14 in 'UnsetPending'

GuideMgr.ResetPlayPos = function(...)
  -- function num : 0_37 , upvalues : mPlayPos
  mPlayPos = -1
end

-- DECOMPILER ERROR at PC140: Confused about usage of register: R14 in 'UnsetPending'

GuideMgr.InitPictureGuideData = function(...)
  -- function num : 0_38 , upvalues : _ENV, PictureGuideData, Self
  local NameData = (Util.Copy)((TableData.gTable).BaseWindowNameData)
  for _,v in pairs(NameData) do
    if not (Util.StringIsNullOrEmpty)(v.pic_path) and not (Util.StringIsNullOrEmpty)(v.window_name) then
      PictureGuideData[v.window_name] = v
    end
  end
  Self.PictureListID = {}
end

-- DECOMPILER ERROR at PC143: Confused about usage of register: R14 in 'UnsetPending'

GuideMgr.AddPictureGuideID = function(ID, ...)
  -- function num : 0_39 , upvalues : _ENV, Self
  if not (GuideMgr.IsPlayPictureID)(ID) then
    (table.insert)(Self.PictureListID, ID)
  end
end

-- DECOMPILER ERROR at PC146: Confused about usage of register: R14 in 'UnsetPending'

GuideMgr.IsPlayPictureID = function(ID, ...)
  -- function num : 0_40 , upvalues : _ENV, Self
  for _,v in ipairs(Self.PictureListID) do
    if ID == v then
      return true
    end
  end
  return false
end

-- DECOMPILER ERROR at PC149: Confused about usage of register: R14 in 'UnsetPending'

GuideMgr.PictureGuidePlayOver = function(id, ...)
  -- function num : 0_41 , upvalues : _ENV
  (GuideMgr.AddPictureGuideID)(id)
  ;
  (GuideService.ReqPictureNewHand)(true, id)
end

-- DECOMPILER ERROR at PC152: Confused about usage of register: R14 in 'UnsetPending'

GuideMgr.IsPlayPictureGuide = function(winName, ...)
  -- function num : 0_42 , upvalues : PictureGuideData, _ENV
  local NameData = PictureGuideData[winName]
  if NameData == nil then
    return false
  end
  local isPlay = (GuideMgr.IsPlayPictureID)(NameData.id)
  return not isPlay
end

-- DECOMPILER ERROR at PC155: Confused about usage of register: R14 in 'UnsetPending'

GuideMgr.PictureTriggerGuide = function(winName, ...)
  -- function num : 0_43 , upvalues : _ENV, PictureGuideData
  if not (GuideMgr.IsPlayPictureGuide)(winName) then
    return 
  end
  local NameData = PictureGuideData[winName]
  if UIMgr:IsWindowOpen((WinResConfig.GuideWindow).name) then
    UIMgr:SetOnHideComplete((WinResConfig.GuideWindow).name, function(...)
    -- function num : 0_43_0 , upvalues : _ENV, NameData
    OpenWindow((WinResConfig.GuidePictureWindow).name, UILayer.Guide, NameData.id)
  end
)
  else
    OpenWindow((WinResConfig.GuidePictureWindow).name, UILayer.Guide, NameData.id)
  end
end

-- DECOMPILER ERROR at PC158: Confused about usage of register: R14 in 'UnsetPending'

GuideMgr.ClearAllGuideData = function(...)
  -- function num : 0_44 , upvalues : Self, PictureGuideData, GuideProcessData, DungeonProcessData, MindGuideData, _ENV
  Self.IsDungeon = nil
  PictureGuideData = {}
  GuideProcessData = {}
  DungeonProcessData = {}
  MindGuideData = {}
  PictureGuideData = {}
  ;
  (GuideMgr.CloseMildGuide)()
  ;
  (GuideMgr.ClearFightMildGuide)()
  Self.CallBack = {}
  Self.PictureListID = {}
end


