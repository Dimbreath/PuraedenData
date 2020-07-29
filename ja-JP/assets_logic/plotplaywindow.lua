-- params : ...
-- function num : 0 , upvalues : _ENV
require("PlotDungeon_PlotPlayWindowByName")
require("PlotDungeon_PlotSkipBtnByName")
local PlotPlayWindow = {}
UIMgr = (CS.UIManager).Singleton
GTween = FairyGUI.GTween
local contentPane = nil
local uis = {}
local argTable = nil
local currentStageBox = 0
local currentChapter = 0
local ChapterObjS = {}
local tempPop, ToolsTxt, ToolsBtn, inputTxt, currentSelect = nil, nil, nil, nil, nil
local stageList = {}
local toolsStageID = 0
local toolsState = 1
local ChapterInfoList = {}
local canClick = true
PlotPlayWindow.OnInit = function(bridge, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, canClick, currentChapter, uis, PlotPlayWindow, currentStageBox, tempPop, ToolsTxt, ToolsBtn, inputTxt
  bridge:SetView((WinResConfig.PlotPlayWindow).package, (WinResConfig.PlotPlayWindow).comName)
  contentPane = bridge.contentPane
  argTable = bridge.argTable
  canClick = true
  currentChapter = (PlotDungeonMgr.GetSelectChapter)()
  local UIConfig = FairyGUI.UIConfig
  UIConfig.depthSupportForPaintingMode = true
  uis = GetPlotDungeon_PlotPlayWindowUis(contentPane)
  ;
  (PlotPlayWindow.InitAssetStrip)()
  ;
  (PlotPlayWindow.InitChapterInfo)()
  ;
  ((uis.RightBtn).onClick):Add(function(...)
    -- function num : 0_0_0 , upvalues : canClick, _ENV, currentChapter, PlotPlayWindow
    if not canClick then
      return 
    end
    local chapterData = ((TableData.gTable).BaseChapterData)[tonumber(currentChapter)]
    local nextID = chapterData.next
    local nextData = ((TableData.gTable).BaseChapterData)[tonumber(nextID)]
    if (Util.CheckCondition)(nextData.open_condition) and (PlotDungeonMgr.ChapterIsOpen)(nextID) then
      (PlotPlayWindow.CreateChapter)(nextID, true)
      ;
      (PlotPlayWindow.PlayPageTurning)(true, currentChapter, nextID)
    end
  end
)
  ;
  ((uis.LeftBtn).onClick):Add(function(...)
    -- function num : 0_0_1 , upvalues : canClick, _ENV, currentChapter, PlotPlayWindow
    if not canClick then
      return 
    end
    local chapterData = ((TableData.gTable).BaseChapterData)[tonumber(currentChapter)]
    ;
    (PlotPlayWindow.CreateChapter)(chapterData.pre, true)
    ;
    (PlotPlayWindow.PlayPageTurning)(false, currentChapter, chapterData.pre)
  end
)
  ;
  (PlotPlayWindow.CreateChapter)(currentChapter)
  ;
  ((uis.BoxBtn).onClick):Set(function(...)
    -- function num : 0_0_2 , upvalues : _ENV, currentStageBox
    local stage = ((TableData.gTable).BaseStageData)[currentStageBox]
    if not stage then
      return 
    end
    local boxState = (PlotDungeonMgr.GetAppendixState)(currentStageBox)
    if boxState == AppendixBoxState.NoCondition then
      local btnData = {}
      btnData.btnTxt = (PUtil.get)(30)
      btnData.fun = function(...)
      -- function num : 0_0_2_0 , upvalues : _ENV
      UIMgr:CloseWindow((WinResConfig.RewardDisplayWindow).name)
    end

      ;
      (MessageMgr.OpenRewardWindow)(stage.ext_reward, btnData, stage.id, (PUtil.get)(20000044), (PUtil.get)(20000043, stage.remark))
    else
      do
        if boxState == AppendixBoxState.Unclaimed then
          local btnData = {}
          btnData.btnTxt = (PUtil.get)(20000010)
          btnData.fun = function(...)
      -- function num : 0_0_2_1 , upvalues : _ENV, stage
      (PlotDungeonService.ReqGetAppendixBox)(stage.id)
    end

          ;
          (MessageMgr.OpenRewardWindow)(stage.ext_reward, btnData, stage.id, (PUtil.get)(20000045))
        end
      end
    end
  end
)
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((uis.PlotDungeonGrp).Scroll).root).visible = false
  ;
  (PlotPlayWindow.InitFunctionControl)()
  ;
  ((uis.CGBtn).onClick):Set(function(...)
    -- function num : 0_0_3 , upvalues : _ENV
    (HandBookService.OnReqCGList)(true)
  end
)
  if false then
    (UpdateMgr.AddUpdateHandler)(PlotPlayWindow.Update)
    tempPop = UIMgr:CreateObject("Tool", "TempTools")
    ChangeUIController(tempPop, "c1", 1)
    tempPop.draggable = true
    ToolsTxt = tempPop:GetChild("n1")
    ToolsBtn = tempPop:GetChild("btn")
    inputTxt = tempPop:GetChild("inputtxt")
    ;
    (PlotPlayWindow.InitToolsSlider)()
  end
end

PlotPlayWindow.Update = function(...)
  -- function num : 0_1 , upvalues : _ENV, ToolsTxt, tempPop
  if (Input.GetKey)(KeyCode.Z) and (Input.GetKeyDown)(KeyCode.C) then
    ToolsTxt.text = ""
    ;
    (GRoot.inst):ShowPopup(tempPop)
  end
end

PlotPlayWindow.InitToolsSlider = function(...)
  -- function num : 0_2 , upvalues : tempPop, PlotPlayWindow, _ENV, ToolsBtn, inputTxt, currentSelect, stageList, toolsStageID
  local width = tempPop:GetChild("width")
  ;
  (width.onChanged):Set(function(...)
    -- function num : 0_2_0 , upvalues : width, PlotPlayWindow
    local value = width.value * 4 - 100
    local grp = (PlotPlayWindow.GetExpressionGrp)()
    grp.x = value
    ;
    (PlotPlayWindow.SetToolsValue)()
  end
)
  local height = tempPop:GetChild("height")
  ;
  (height.onChanged):Set(function(...)
    -- function num : 0_2_1 , upvalues : height, PlotPlayWindow
    local value = height.value * 2 - 100
    local grp = (PlotPlayWindow.GetExpressionGrp)()
    grp.y = value
    ;
    (PlotPlayWindow.SetToolsValue)()
  end
)
  local scale = tempPop:GetChild("scale")
  ;
  (scale.onChanged):Set(function(...)
    -- function num : 0_2_2 , upvalues : scale, PlotPlayWindow, _ENV
    local value = scale.value / 20
    local grp = (PlotPlayWindow.GetExpressionGrp)()
    grp.scale = Vector2(value, value)
    ;
    (PlotPlayWindow.SetToolsValue)()
  end
)
  local btn1 = tempPop:GetChild("pass")
  ;
  (btn1.onClick):Set(function(...)
    -- function num : 0_2_3 , upvalues : PlotPlayWindow
    (PlotPlayWindow.SetStateAni)(2)
  end
)
  local btn2 = tempPop:GetChild("challenge")
  ;
  (btn2.onClick):Set(function(...)
    -- function num : 0_2_4 , upvalues : PlotPlayWindow
    (PlotPlayWindow.SetStateAni)(0)
  end
)
  local btn3 = tempPop:GetChild("notChallenge")
  ;
  (btn3.onClick):Set(function(...)
    -- function num : 0_2_5 , upvalues : PlotPlayWindow
    (PlotPlayWindow.SetStateAni)(1)
  end
)
  ;
  (ToolsBtn.onClick):Set(function(...)
    -- function num : 0_2_6 , upvalues : _ENV, inputTxt, currentSelect, stageList, toolsStageID, PlotPlayWindow
    local stageID = tonumber(inputTxt.text)
    currentSelect = stageList[stageID]
    if not currentSelect then
      print("没找到.." .. stageID .. "啊睿哥")
      return 
    end
    toolsStageID = stageID
    inputTxt.text = ""
    ;
    (PlotPlayWindow.SetToolsValue)()
  end
)
end

PlotPlayWindow.SetStateAni = function(index, ...)
  -- function num : 0_3 , upvalues : currentSelect, _ENV, toolsState, PlotPlayWindow
  if currentSelect == nil then
    print("先选择一个关卡啊睿哥")
    return 
  end
  toolsState = index
  local objModel = GetPlotDungeon_PlotSkipBtnUis(currentSelect)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (objModel.c1Ctr).selectedIndex = index
  local obj = ((objModel.CardQLoader).Model).gameObject
  if index == 2 then
    (SkeletonAnimationUtil.SetAnimation)(obj, 0, BattleCardState.DIE, false)
    local time = (SkeletonAnimationUtil.GetAnimationTime)(obj, BattleCardState.DIE)
    ;
    (SkeletonAnimationUtil.JumpToTime)(obj, 0, time, false, true)
  else
    do
      ;
      (SkeletonAnimationUtil.SetAnimation)(obj, 0, BattleCardState.IDLE, true)
      ;
      (PlotPlayWindow.SetToolsValue)()
    end
  end
end

PlotPlayWindow.GetExpressionGrp = function(...)
  -- function num : 0_4 , upvalues : _ENV, currentSelect, toolsState
  local objModel = (GetPlotDungeon_PlotSkipBtnUis(currentSelect))
  local obj = nil
  if toolsState == 2 then
    obj = (objModel.ClearGrp).root
  else
    if toolsState == 0 then
      obj = (objModel.NowGrp).root
    else
      obj = (objModel.LockGrp).root
    end
  end
  return obj
end

PlotPlayWindow.SetToolsValue = function(...)
  -- function num : 0_5 , upvalues : currentSelect, PlotPlayWindow, ToolsTxt, toolsStageID, toolsState
  if currentSelect == nil then
    return 
  end
  local obj = (PlotPlayWindow.GetExpressionGrp)()
  ToolsTxt.text = "关卡ID:.." .. toolsStageID .. "状态.. :" .. toolsState .. "\n" .. "PositionX: " .. obj.x .. "\n" .. "PositionY: " .. obj.y .. "\n" .. " scale " .. (obj.scale).x
end

PlotPlayWindow.PlayRollAni = function(forward, ...)
  -- function num : 0_6 , upvalues : _ENV, uis
  if forward then
    PlayUITrans(((uis.PlotDungeonGrp).MapGrp).root, "Left")
  else
    PlayUITrans(((uis.PlotDungeonGrp).MapGrp).root, "Right")
  end
end

PlotPlayWindow.InitFunctionControl = function(...)
  -- function num : 0_7 , upvalues : _ENV, uis
  local winName = (WinResConfig.PlotPlayWindow).name
  local RegisterGuideAndControl = GuideData.RegisterGuideAndControl
  local ControlID = ControlID
  RegisterGuideAndControl(ControlID.PlotDungeon_Stage, (((uis.PlotDungeonGrp).MapGrp).root):GetChildAt(0), winName)
  RegisterGuideAndControl(ControlID.PlotDungeon_OneBox, uis.BoxBtn, winName)
  RegisterGuideAndControl(ControlID.PlotDungeon_Close, (uis.AssetStrip).CloseBtn, winName)
end

PlotPlayWindow.PlayPageTurning = function(forward, lastChapter, Chapter, ...)
  -- function num : 0_8 , upvalues : canClick, _ENV, ChapterObjS, uis, PlotPlayWindow, currentChapter
  canClick = false
  ;
  (LuaSound.PlaySound)(LuaSound.DUNGEON_SHOW, SoundBank.OTHER)
  local lastChapter = tonumber(lastChapter)
  local Chapter = tonumber(Chapter)
  local lastObj = ChapterObjS[lastChapter]
  local CurrentObj = ChapterObjS[Chapter]
  CurrentObj.reversedMask = true
  local maskObj = lastObj:GetChild("PictureImage")
  local currentMaskObj = CurrentObj:GetChild("PictureImage")
  local maskWidth = maskObj.width
  local Transition = nil
  if forward then
    Transition = ((uis.PlotDungeonGrp).root):GetTransition("Left")
    maskObj:SetPivot(1, 0)
    currentMaskObj:SetPivot(1, 0)
  else
    Transition = ((uis.PlotDungeonGrp).root):GetTransition("Right")
    maskObj:SetPivot(0, 1)
    currentMaskObj:SetPivot(0, 1)
  end
  ;
  (PlotPlayWindow.PlayRollAni)(forward)
  local waitTimeA = 0
  local waitTimeB = 0
  if forward then
    waitTimeA = 0.05
  else
    waitTimeA = 0.05
  end
  if forward then
    OpenPlotPlay(Chapter, PlotPlayTriggerType.CHAPTER_UNLOCK, function(...)
    -- function num : 0_8_0 , upvalues : PlotPlayWindow, currentChapter
    (PlotPlayWindow.CheckPassProcess)(currentChapter)
  end
)
  end
  ;
  (SimpleTimer.setTimeout)(waitTimeA, function(...)
    -- function num : 0_8_1 , upvalues : maskObj, _ENV, maskWidth, uis, lastObj, CurrentObj, currentMaskObj, currentChapter, Chapter, PlotPlayWindow, ChapterObjS, lastChapter, canClick
    if maskObj == nil then
      return 
    end
    local gt = (GTween.To)(maskWidth, 0, 1)
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (((uis.PlotDungeonGrp).Scroll).root).visible = true
    gt:SetEase(5)
    gt:OnUpdate(function(...)
      -- function num : 0_8_1_0 , upvalues : lastObj, _ENV, CurrentObj, maskObj, gt, currentMaskObj
      for i = 1, 5 do
        local btn = lastObj:GetChild("0" .. i .. "_Btn")
        ;
        (Util.SetModelClip)(btn:GetChild("CardQLoader"), lastObj)
        local btn2 = CurrentObj:GetChild("0" .. i .. "_Btn")
        ;
        (Util.SetModelClip)(btn2:GetChild("CardQLoader"), CurrentObj)
      end
      maskObj.width = (gt.value).x
      currentMaskObj.width = (gt.value).x
    end
)
    gt:OnComplete(function(...)
      -- function num : 0_8_1_1 , upvalues : CurrentObj, currentMaskObj, maskWidth, uis, lastObj, currentChapter, Chapter, _ENV, PlotPlayWindow, ChapterObjS, lastChapter, canClick
      CurrentObj.reversedMask = false
      currentMaskObj.width = maskWidth
      local grp = ((uis.PlotDungeonGrp).MapGrp).root
      grp:RemoveChild(lastObj)
      currentChapter = Chapter
      ;
      (PlotDungeonMgr.SetSelectChapter)(currentChapter)
      ;
      (PlotPlayWindow.CheckRedDot)()
      ;
      (PlotPlayWindow.CheckNextChapterInfo)()
      for i = 1, 5 do
        local btn = lastObj:GetChild("0" .. i .. "_Btn")
        ;
        (Util.SetModelClip)(btn:GetChild("CardQLoader"), lastObj, false)
        local btn = CurrentObj:GetChild("0" .. i .. "_Btn")
        ;
        (Util.SetModelClip)(btn:GetChild("CardQLoader"), CurrentObj, false)
      end
      ;
      (PlotPlayWindow.RecycleLoader)(ChapterObjS[lastChapter])
      ;
      (ChapterObjS[lastChapter]):Dispose()
      ChapterObjS[lastChapter] = nil
      canClick = true
    end
)
  end
)
  Transition:Play()
end

PlotPlayWindow.RecycleLoader = function(obj, ...)
  -- function num : 0_9 , upvalues : _ENV
  for i = 1, 5 do
    local btn = obj:GetChild("0" .. i .. "_Btn")
    local mLoader = btn:GetChild("CardQLoader")
    ;
    (Util.RecycleUIModel)(mLoader)
  end
end

PlotPlayWindow.CreateChapter = function(chapterId, hide, ...)
  -- function num : 0_10 , upvalues : _ENV, ChapterObjS, PlotPlayWindow, uis
  local chapterID = tonumber(chapterId)
  local chapterData = ((TableData.gTable).BaseChapterData)[chapterID]
  local res = split(chapterData.bg_res, ":")
  local Dungeon = UIMgr:CreateObject(res[1], res[2])
  ChapterObjS[chapterID] = Dungeon
  ;
  (PlotPlayWindow.RefreshStageList)(chapterID)
  ;
  (((uis.PlotDungeonGrp).MapGrp).root):AddChildAt(Dungeon, 0)
  if hide then
    Dungeon.reversedMask = true
    for i = 1, 5 do
      local btn2 = Dungeon:GetChild("0" .. i .. "_Btn")
      ;
      (Util.SetModelClip)(btn2:GetChild("CardQLoader"), Dungeon)
    end
  end
  do
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (uis.RightBtn).visible = tostring(chapterData.next) ~= "0"
    -- DECOMPILER ERROR at PC65: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (uis.LeftBtn).visible = tostring(chapterData.pre) ~= "0"
    -- DECOMPILER ERROR at PC68: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (uis.StoryNumberTxt).text = chapterData.name
    ;
    (PlotPlayWindow.CheckRedDot)()
    ;
    (PlotPlayWindow.CheckNextChapterInfo)()
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

PlotPlayWindow.RefreshStageList = function(chapterId, ignorePass, ...)
  -- function num : 0_11 , upvalues : _ENV, ChapterObjS, stageList, PlotPlayWindow
  (GuideMgr.CloseMildGuide)()
  local chapterId = tonumber(chapterId)
  local chapterData = ((TableData.gTable).BaseChapterData)[chapterId]
  local StagesStr = split(chapterData.stages, ":")
  local chapterObj = ChapterObjS[chapterId]
  stageList = {}
  for i = 1, 5 do
    local btn = chapterObj:GetChild("0" .. i .. "_Btn")
    ;
    (PlotPlayWindow.RefreshBtnState)(btn, StagesStr[i])
    stageList[tonumber(StagesStr[i])] = btn
  end
  ;
  (PlotPlayWindow.RefreshChapterBox)(chapterId)
  if ignorePass then
    return 
  end
end

PlotPlayWindow.CheckPassProcess = function(chapterId, ...)
  -- function num : 0_12 , upvalues : _ENV, currentStageBox, currentChapter
  local stage = ((TableData.gTable).BaseStageData)[currentStageBox]
  if not stage then
    return 
  end
  local chapterID = chapterId or currentChapter
  local boxState = (PlotDungeonMgr.GetAppendixState)(currentStageBox)
  if boxState == AppendixBoxState.Unclaimed and (Util.IsPrepareLevelUpWindow)() and not (FunctionControlMgr.IsPrepareFunctionOpenWindow)() then
    UIMgr:SetOnHideComplete((WinResConfig.PlayerLevelUpWindow).name, function(...)
    -- function num : 0_12_0 , upvalues : _ENV, chapterID, currentStageBox
    OpenWindow((WinResConfig.PlotChapterFinshWindow).name, UILayer.HUD1, chapterID, currentStageBox)
  end
)
  end
  OpenWindow((WinResConfig.PlotChapterFinshWindow).name, UILayer.HUD1, chapterID, currentStageBox)
end

PlotPlayWindow.RefreshChapterBox = function(chapterId, ...)
  -- function num : 0_13 , upvalues : uis, currentStageBox, _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (uis.BoxBtn).visible = false
  currentStageBox = 0
  local ChapterData = ((TableData.gTable).BaseChapterData)[chapterId]
  if ChapterData then
    local stages = split(ChapterData.stages, ":")
    for _,v in ipairs(stages) do
      local boxState = (PlotDungeonMgr.GetAppendixState)(v)
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R9 in 'UnsetPending'

      if boxState == AppendixBoxState.NoCondition or boxState == AppendixBoxState.Unclaimed then
        (uis.BoxBtn).visible = true
        currentStageBox = tonumber(v)
        ;
        ((uis.BoxBtn):GetChild("RedDot")).visible = boxState == AppendixBoxState.Unclaimed
        return 
      end
    end
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

PlotPlayWindow.PlayDieAni = function(stageID, ...)
  -- function num : 0_14 , upvalues : _ENV, currentChapter, ChapterObjS
  local stageData = ((TableData.gTable).BaseStageData)[stageID]
  if not stageData or stageData.type ~= StageType.FIGHT then
    return 
  end
  local chapterData = ((TableData.gTable).BaseChapterData)[currentChapter]
  local StagesStr = split(chapterData.stages, ":")
  local chapterObj = ChapterObjS[currentChapter]
  for i = 1, 5 do
    if stageID == tonumber(StagesStr[i]) then
      local btn = chapterObj:GetChild("0" .. i .. "_Btn")
      local objModel = GetPlotDungeon_PlotSkipBtnUis(btn)
      if stageData.type == StageType.FIGHT then
        (SkeletonAnimationUtil.SetAnimation)(((objModel.CardQLoader).Model).gameObject, 0, BattleCardState.DIE, false)
      end
    end
  end
end

PlotPlayWindow.RefreshBtnState = function(btnObj, stageId, ...)
  -- function num : 0_15 , upvalues : _ENV, PlotPlayWindow
  local stageId = tonumber(stageId)
  local stageData = ((TableData.gTable).BaseStageData)[stageId]
  local objModel = GetPlotDungeon_PlotSkipBtnUis(btnObj)
  local unlockType = stageData.unlock_type
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R6 in 'UnsetPending'

  if unlockType and unlockType > 0 and not (PlotDungeonMgr.IsPassDungeon)(stageId) then
    (objModel.c3Ctr).selectedIndex = 1
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R6 in 'UnsetPending'

    if unlockType == 1 then
      ((objModel.Message_A).c1Ctr).selectedIndex = 1
    else
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((objModel.Message_A).c1Ctr).selectedIndex = 0
    end
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((objModel.Message_A).WordTxt).text = stageData.unlock_des
  else
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (objModel.c3Ctr).selectedIndex = 0
  end
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R6 in 'UnsetPending'

  if stageData.type == StageType.FIGHT then
    (objModel.c2Ctr).selectedIndex = 0
    local fashionId = tonumber(stageData.monster_icon)
    do
      (Util.RecycleUIModel)(objModel.CardQLoader)
      ;
      (Util.CreateMiniModel)(objModel.CardQLoader, fashionId, function(obj, ...)
    -- function num : 0_15_0 , upvalues : _ENV, stageId, btnObj, fashionId
    (SkeletonAnimationUtil.SetFlip)(obj, true, false)
    if (PlotDungeonMgr.IsPassDungeon)(stageId) then
      (SkeletonAnimationUtil.SetAnimation)(obj, 0, BattleCardState.DIE, false, nil, true)
      local time = (SkeletonAnimationUtil.GetAnimationTime)(obj, BattleCardState.DIE)
      ;
      (SkeletonAnimationUtil.JumpToTime)(obj, 0, time, false, true)
    else
      do
        if (PlotDungeonMgr.IsCanChallenge)(stageId, false) then
          (SkeletonAnimationUtil.SetAnimation)(obj, 0, BattleCardState.IDLE, true, nil, true)
          ;
          (GuideMgr.MildGuideTrigger)((WinResConfig.PlotPlayWindow).name, btnObj, "0:95", 0.5)
        else
          ;
          (SkeletonAnimationUtil.SetAnimation)(obj, 0, BattleCardState.IDLE, true, nil, true)
          ;
          (SkeletonAnimationUtil.JumpToTime)(obj, 0, 0.1, false, true)
        end
        local fashionData = ((TableData.gTable).BaseFashionData)[fashionId]
        local scale = fashionData.scale / 10000
        ;
        (CSLuaUtil.SetGOScale)(obj, scale, scale, scale)
      end
    end
  end
)
      local stageData = ((TableData.gTable).BaseFashionData)[fashionId]
      local offSet = (Util.ParseConfigStr)(stageData.offset_state)
      local offSet_scale = (Util.ParseConfigStr)(stageData.offset_scale)
      -- DECOMPILER ERROR at PC78: Confused about usage of register: R10 in 'UnsetPending'

      if (PlotDungeonMgr.IsPassDungeon)(stageId) then
        (objModel.c1Ctr).selectedIndex = 2
        for _,v in ipairs(offSet) do
          -- DECOMPILER ERROR at PC101: Confused about usage of register: R15 in 'UnsetPending'

          if tonumber(v[1]) == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_HAS then
            ((objModel.ClearGrp).root).xy = Vector2(tonumber(v[2]), tonumber(v[3]))
          end
        end
        for _,v in ipairs(offSet_scale) do
          -- DECOMPILER ERROR at PC128: Confused about usage of register: R15 in 'UnsetPending'

          if tonumber(v[1]) == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_HAS then
            ((objModel.ClearGrp).root).scale = Vector2(tonumber(v[2]) / 10000, tonumber(v[2]) / 10000)
          end
        end
      else
        do
          -- DECOMPILER ERROR at PC140: Confused about usage of register: R10 in 'UnsetPending'

          if (PlotDungeonMgr.IsCanChallenge)(stageId, false) then
            (objModel.c1Ctr).selectedIndex = 0
            for _,v in ipairs(offSet) do
              -- DECOMPILER ERROR at PC163: Confused about usage of register: R15 in 'UnsetPending'

              if tonumber(v[1]) == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_CAN then
                ((objModel.NowGrp).root).xy = Vector2(tonumber(v[2]), tonumber(v[3]))
              end
            end
            for _,v in ipairs(offSet_scale) do
              -- DECOMPILER ERROR at PC190: Confused about usage of register: R15 in 'UnsetPending'

              if tonumber(v[1]) == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_CAN then
                ((objModel.NowGrp).root).scale = Vector2(tonumber(v[2]) / 10000, tonumber(v[2]) / 10000)
              end
            end
          else
            do
              -- DECOMPILER ERROR at PC195: Confused about usage of register: R10 in 'UnsetPending'

              ;
              (objModel.c1Ctr).selectedIndex = 1
              for _,v in ipairs(offSet) do
                -- DECOMPILER ERROR at PC218: Confused about usage of register: R15 in 'UnsetPending'

                if tonumber(v[1]) == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_NOT then
                  ((objModel.LockGrp).root).xy = Vector2(tonumber(v[2]), tonumber(v[3]))
                end
              end
              for _,v in ipairs(offSet_scale) do
                -- DECOMPILER ERROR at PC245: Confused about usage of register: R15 in 'UnsetPending'

                if tonumber(v[1]) == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_NOT then
                  ((objModel.LockGrp).root).scale = Vector2(tonumber(v[2]) / 10000, tonumber(v[2]) / 10000)
                end
              end
            end
          end
          do
            -- DECOMPILER ERROR at PC257: Confused about usage of register: R6 in 'UnsetPending'

            if (PlotDungeonMgr.IsPassDungeon)(stageId) then
              (objModel.c1Ctr).selectedIndex = 2
            else
              -- DECOMPILER ERROR at PC267: Confused about usage of register: R6 in 'UnsetPending'

              if (PlotDungeonMgr.IsCanChallenge)(stageId, false) then
                (objModel.c1Ctr).selectedIndex = 0
              else
                -- DECOMPILER ERROR at PC270: Confused about usage of register: R6 in 'UnsetPending'

                ;
                (objModel.c1Ctr).selectedIndex = 1
              end
            end
            ;
            (Util.RecycleUIModel)(objModel.CardQLoader)
            -- DECOMPILER ERROR at PC276: Confused about usage of register: R6 in 'UnsetPending'

            ;
            (objModel.c2Ctr).selectedIndex = 1
            do
              local model = (objModel.CardQLoader).Model
              if model == nil then
                (Util.ShowUIModel)("paper", objModel.CardQLoader, nil, true, function(paper, ...)
    -- function num : 0_15_1 , upvalues : model, PlotPlayWindow, stageId, btnObj
    model = paper
    ;
    (PlotPlayWindow.SetPaperAni)(stageId, paper, btnObj)
  end
)
              else
                ;
                (PlotPlayWindow.SetPaperAni)(stageId, model.gameObject, btnObj)
              end
              -- DECOMPILER ERROR at PC298: Confused about usage of register: R6 in 'UnsetPending'

              ;
              (objModel.NumberTxt).text = stageData.remark
              ;
              (btnObj.onClick):Set(function(...)
    -- function num : 0_15_2 , upvalues : _ENV, stageId
    (PlotDungeonMgr.OnClickStage)(stageId, false)
  end
)
            end
          end
        end
      end
    end
  end
end

PlotPlayWindow.SetPaperAni = function(stageId, paper, btnObj, ...)
  -- function num : 0_16 , upvalues : _ENV
  if (PlotDungeonMgr.IsPassDungeon)(stageId) then
    (SkeletonAnimationUtil.SetAnimation)(paper, 0, "end", true)
  else
    if (PlotDungeonMgr.IsCanChallenge)(stageId, false) then
      (SkeletonAnimationUtil.SetAnimation)(paper, 0, "open", false, function(...)
    -- function num : 0_16_0 , upvalues : _ENV, paper
    (SkeletonAnimationUtil.SetAnimation)(paper, 0, "loop", true)
  end
)
      ;
      (GuideMgr.MildGuideTrigger)((WinResConfig.PlotPlayWindow).name, btnObj, "5:100", 0.5)
    else
      ;
      (SkeletonAnimationUtil.SetAnimation)(paper, 0, "close", true)
    end
  end
end

PlotPlayWindow.IsShowArrow = function(...)
  -- function num : 0_17 , upvalues : _ENV, currentChapter, uis
  local chapterData = ((TableData.gTable).BaseChapterData)[tonumber(currentChapter)]
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.RightBtn).visible = tostring(chapterData.next) ~= "0"
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.LeftBtn).visible = tostring(chapterData.pre) ~= "0"
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

PlotPlayWindow.SetTransition = function(obj, ...)
  -- function num : 0_18
  local cnt = obj.numChildren
  for i = 0, cnt - 1 do
    local obj = (obj:GetChildAt(i)).asCom
    if obj then
      local tran = obj:GetTransition("in")
      if tran then
        tran.invalidateBatchingEveryFrame = true
      end
    end
  end
end

PlotPlayWindow.OnShown = function(...)
  -- function num : 0_19 , upvalues : _ENV, PlotPlayWindow, currentChapter
  OpenPlotPlay((PlotDungeonMgr.GetSelectChapter)(), PlotPlayTriggerType.CHAPTER_UNLOCK, function(...)
    -- function num : 0_19_0 , upvalues : PlotPlayWindow, currentChapter
    (PlotPlayWindow.CheckPassProcess)(currentChapter)
  end
)
end

PlotPlayWindow.OnHide = function(...)
  -- function num : 0_20
end

PlotPlayWindow.InitAssetStrip = function(...)
  -- function num : 0_21 , upvalues : _ENV, uis, canClick
  local m = {}
  m.windowName = (WinResConfig.PlotPlayWindow).name
  m.Tip = (PUtil.get)(20000034)
  m.model = uis.AssetStrip
  m.closeToWindow = (WinResConfig.AdventureWindow).name
  m.activityIds = (Util.GetActivityIds)(76000001)
  m.isSelfClose = true
  m.BackBtnFun = function(...)
    -- function num : 0_21_0 , upvalues : canClick, _ENV
    if canClick == false then
      return 
    end
    UIMgr:CloseWindow((WinResConfig.PlotPlayWindow).name)
  end

  m.CloseBtnFun = function(...)
    -- function num : 0_21_1 , upvalues : canClick, _ENV
    if canClick == false then
      return 
    end
    UIMgr:CloseToWindow((WinResConfig.AdventureWindow).name)
  end

  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

PlotPlayWindow.CheckRedDot = function(...)
  -- function num : 0_22 , upvalues : uis, PlotPlayWindow
  ((uis.RightBtn):GetChild("RedDot")).visible = (PlotPlayWindow.JudgeIsRedDot)(true)
  ;
  ((uis.LeftBtn):GetChild("RedDot")).visible = (PlotPlayWindow.JudgeIsRedDot)(false)
end

PlotPlayWindow.InitChapterInfo = function(...)
  -- function num : 0_23 , upvalues : ChapterInfoList, _ENV
  if #ChapterInfoList <= 0 then
    local ChapterData = (TableData.gTable).BaseChapterData
    for _,v in pairs(ChapterData) do
      if v.type == DungeonType.BasicDungeon and v.unlock_id and v.unlock_id > 0 then
        (table.insert)(ChapterInfoList, v)
      end
    end
    ;
    (table.sort)(ChapterInfoList, function(a, b, ...)
    -- function num : 0_23_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  end
end

PlotPlayWindow.GetNextChapterOpen = function(...)
  -- function num : 0_24 , upvalues : _ENV, ChapterInfoList, currentChapter
  for _,v in ipairs(ChapterInfoList) do
    if currentChapter < v.id then
      local stageS = split(v.stages, ":")
      for _,v2 in ipairs(stageS) do
        local StageData = ((TableData.gTable).BaseStageData)[tonumber(v2)]
        local unlockType = StageData.unlock_type
        if unlockType and unlockType == 2 and not (PlotDungeonMgr.IsPassDungeon)(tonumber(v2)) then
          return v
        end
      end
    end
  end
end

PlotPlayWindow.CheckNextChapterInfo = function(...)
  -- function num : 0_25 , upvalues : PlotPlayWindow, uis, _ENV
  local nextInfoChapter = (PlotPlayWindow.GetNextChapterOpen)()
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  if nextInfoChapter ~= nil then
    ((uis.Message_B).root).visible = true
    ;
    (Util.SetShowHeadFrame)(((uis.Message_B).HeadFrame).root, nextInfoChapter.unlock_id, false)
    local str = split(nextInfoChapter.unlock_des, ":")
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((uis.Message_B).Word_01_Txt).text = (PUtil.get)(tonumber(str[1]))
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((uis.Message_B).Word_02_Txt).text = (PUtil.get)(tonumber(str[2]))
    ;
    (((uis.Message_B).root).onClick):Set(function(...)
    -- function num : 0_25_0 , upvalues : _ENV, nextInfoChapter
    OpenWindow((WinResConfig.CardDetailsWindow).name, UILayer.HUD, nextInfoChapter.unlock_id)
  end
)
  else
    do
      -- DECOMPILER ERROR at PC46: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((uis.Message_B).root).visible = false
    end
  end
end

PlotPlayWindow.JudgeIsRedDot = function(isRight, ...)
  -- function num : 0_26 , upvalues : _ENV, currentChapter
  local redDotList = (RedDotMgr.StoryPlotData)()
  if isRight then
    for _,v in ipairs(redDotList) do
      if currentChapter < v then
        return true
      end
    end
  else
    do
      for _,v in ipairs(redDotList) do
        if v < currentChapter then
          return true
        end
      end
      do
        return false
      end
    end
  end
end

PlotPlayWindow.OnClose = function(...)
  -- function num : 0_27 , upvalues : PlotPlayWindow, ChapterObjS, currentChapter, _ENV, uis, contentPane, argTable
  (PlotPlayWindow.RecycleLoader)(ChapterObjS[currentChapter])
  ChapterObjS = {}
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.PlotPlayWindow).name)
  ;
  (GuideData.AbolishControlRefer)((WinResConfig.PlotPlayWindow).name)
  uis = nil
  contentPane = nil
  argTable = {}
end

PlotPlayWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_28 , upvalues : _ENV, PlotPlayWindow, currentChapter, uis
  if msgId == (WindowMsgEnum.PlotPlayWindow).E_MSG_ENEMY_REFRESH then
    loge("界面刷新")
    ;
    (PlotPlayWindow.RefreshStageList)(currentChapter, para)
    if para then
      (GuideMgr.CheckIsTriggerGuide)((WinResConfig.PlotPlayWindow).name)
    end
  else
    if msgId == (WindowMsgEnum.PlotPlayWindow).E_MSG_CHECK_RED_DOT then
      (PlotPlayWindow.CheckRedDot)()
    else
      if msgId == (WindowMsgEnum.PlotPlayWindow).E_MSG_PLAY_DIE then
        (SimpleTimer.setTimeout)(0, function(...)
    -- function num : 0_28_0 , upvalues : PlotPlayWindow, para
    (PlotPlayWindow.PlayDieAni)(para)
  end
)
      else
        if msgId == (WindowMsgEnum.PlotPlayWindow).E_MSG_NEXT_CHAPTER and (uis.RightBtn).visible then
          ((uis.RightBtn).onClick):Call()
        end
      end
    end
  end
  if msgId == (WindowMsgEnum.PlotPlayWindow).E_MSG_CHECK_PASS_PROCESS then
    (PlotPlayWindow.CheckPassProcess)()
  end
end

return PlotPlayWindow

