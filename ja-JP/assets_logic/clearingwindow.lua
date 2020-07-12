-- params : ...
-- function num : 0 , upvalues : _ENV
require("PlotDungeon_ClearingPanelByName")
require("PlotDungeon_PropClenNormalListByName")
require("PlotDungeon_ClearingPanelWindowByName")
local ClearingWindow = {}
local uis = nil
local m = {}
local m2 = {}
local m3 = {}
local SweepData = {}
local timer1, timer2 = nil, nil
local timerList = {}
local debrisData = {}
local surplus = 0
local AimItemNum = 0
local clearItem = false
local itemListData = {}
local aimItemId = 0
local aimItemNum = 0
local isExternalData = false
ClearingWindow.OnInit = function(bridge, ...)
  -- function num : 0_0 , upvalues : _ENV, uis, timerList, SweepData, isExternalData, aimItemId, aimItemNum, itemListData, clearItem, ClearingWindow, surplus
  bridge:SetView((WinResConfig.ClearingWindow).package, (WinResConfig.ClearingWindow).comName)
  uis = GetPlotDungeon_ClearingPanelWindowUis(bridge.contentPane)
  timerList = {}
  uis = uis.ClearingPanel
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.describeTxt).visible = false
  if (bridge.argTable)[1] then
    SweepData = (bridge.argTable)[1]
    isExternalData = true
  else
    SweepData = (PlotDungeonMgr.GetSweepData)()
    isExternalData = false
  end
  aimItemId = SweepData.aimItemId
  aimItemNum = SweepData.aimNum
  itemListData = {}
  clearItem = false
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.confirmBtn).text = (PUtil.get)(20000016)
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.sweep1Btn).text = (PUtil.get)(20000004)
  -- DECOMPILER ERROR at PC59: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.sweep10Btn).text = (PUtil.get)(20000014)
  -- DECOMPILER ERROR at PC65: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.sweep50Btn).text = (PUtil.get)(20000015)
  local StageData = nil
  if not isExternalData then
    StageData = ((TableData.gTable).BaseStageData)[SweepData.stageId]
  end
  -- DECOMPILER ERROR at PC82: Confused about usage of register: R2 in 'UnsetPending'

  if StageData then
    (uis.PlotImageLoader).url = (Util.GetItemUrl)(StageData.battle_banner_show)
  end
  -- DECOMPILER ERROR at PC87: Confused about usage of register: R2 in 'UnsetPending'

  if isExternalData then
    (uis.c1Ctr).selectedIndex = 2
    -- DECOMPILER ERROR at PC89: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (uis.c2Ctr).selectedIndex = 3
  else
    -- DECOMPILER ERROR at PC95: Confused about usage of register: R2 in 'UnsetPending'

    if SweepData.isFastWeep then
      (uis.c1Ctr).selectedIndex = 1
      ;
      (ClearingWindow.SetBtnActive)(false, false)
      ;
      (ClearingWindow.InitDebrisList)()
      -- DECOMPILER ERROR at PC103: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (uis.c2Ctr).selectedIndex = 3
    else
      -- DECOMPILER ERROR at PC114: Confused about usage of register: R2 in 'UnsetPending'

      if (PlotDungeonMgr.GetStageChapterType)(SweepData.stageId) == DungeonType.HeroDungeon then
        (uis.c2Ctr).selectedIndex = 0
        -- DECOMPILER ERROR at PC116: Confused about usage of register: R2 in 'UnsetPending'

        ;
        (uis.c1Ctr).selectedIndex = 2
        ;
        ((uis.sweep1Btn).onClick):Add(function(...)
    -- function num : 0_0_0 , upvalues : ClearingWindow, _ENV, SweepData
    if (ClearingWindow.TimerIsRunIng)() then
      (PlotDungeonMgr.StartSweep)(SweepData.stageId, 1, nil)
    end
  end
)
      else
        -- DECOMPILER ERROR at PC127: Confused about usage of register: R2 in 'UnsetPending'

        if not SweepData.aimItemId then
          (uis.c1Ctr).selectedIndex = 2
        end
        ;
        (ClearingWindow.SetBtnShow)()
        local SweepFun = function(time, ...)
    -- function num : 0_0_1 , upvalues : _ENV, uis, SweepData, surplus
    (Util.SetOnClickDelay)(0.1)
    ;
    ((uis.itemList).scrollPane):ScrollBottom()
    if SweepData.aimItemId and surplus > 0 then
      (PlotDungeonMgr.StartSweep)(SweepData.stageId, time, SweepData.aimItemId, surplus)
    else
      ;
      (PlotDungeonMgr.StartSweep)(SweepData.stageId, time)
    end
  end

        do
          ((uis.sweep1Btn).onClick):Add(function(...)
    -- function num : 0_0_2 , upvalues : ClearingWindow, SweepFun
    if (ClearingWindow.TimerIsRunIng)() then
      SweepFun(1)
    end
  end
)
          ;
          ((uis.sweep10Btn).onClick):Add(function(...)
    -- function num : 0_0_3 , upvalues : ClearingWindow, SweepFun
    if (ClearingWindow.TimerIsRunIng)() then
      SweepFun(10)
    end
  end
)
          ;
          ((uis.sweep50Btn).onClick):Add(function(...)
    -- function num : 0_0_4 , upvalues : ClearingWindow, SweepFun
    if (ClearingWindow.TimerIsRunIng)() then
      SweepFun(50)
    end
  end
)
        end
      end
    end
  end
  do
    -- DECOMPILER ERROR at PC162: Confused about usage of register: R2 in 'UnsetPending'

    if SweepData.aimItemId and not SweepData.isFastWeep and (PlotDungeonMgr.GetStageChapterType)(SweepData.stageId) == DungeonType.BasicDungeon then
      (uis.c1Ctr).selectedIndex = 0
      ;
      (ClearingWindow.InitAimGrp)()
    end
    ;
    (ClearingWindow.InitConfirmCloseBtn)()
    -- DECOMPILER ERROR at PC172: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (uis.itemList).defaultItem = (Util.GetResUrl)("PlotDungeon:PropClenNormalList")
    ;
    (uis.itemList):SetVirtual()
    -- DECOMPILER ERROR at PC178: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (uis.itemList).itemRenderer = ClearingWindow.ItemRenderer
    ;
    (ClearingWindow.RefreshWindow)()
    ;
    (ClearingWindow.InitFunctionControl)()
    -- DECOMPILER ERROR at PC188: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (uis.titleTxt).text = (PUtil.get)(20000398)
    -- DECOMPILER ERROR at PC194: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (uis.NumberTxt).text = (PUtil.get)(20000399)
    -- DECOMPILER ERROR at PC200: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (uis.ExplainTxt).text = (PUtil.get)(20000444)
    -- DECOMPILER ERROR at PC206: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (uis.vitalityTxt).text = (PUtil.get)(20000006)
  end
end

ClearingWindow.SetBtnShow = function(...)
  -- function num : 0_1 , upvalues : SweepData, uis, _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

  if SweepData.isFastWeep then
    (uis.c2Ctr).selectedIndex = 3
  else
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

    if (FunctionControlMgr.GetFunctionState)(ControlID.Clear_SweepFiftyBtn) then
      (uis.c2Ctr).selectedIndex = 2
    else
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R0 in 'UnsetPending'

      if (FunctionControlMgr.GetFunctionState)(ControlID.StageDetail_SweepTenBtn) then
        (uis.c2Ctr).selectedIndex = 1
      else
        -- DECOMPILER ERROR at PC27: Confused about usage of register: R0 in 'UnsetPending'

        ;
        (uis.c2Ctr).selectedIndex = 0
      end
    end
  end
end

ClearingWindow.InitFunctionControl = function(...)
  -- function num : 0_2 , upvalues : _ENV, uis
  local winName = (WinResConfig.ClearingWindow).name
  local RegisterGuideAndControl = GuideData.RegisterGuideAndControl
  local ControlID = ControlID
  RegisterGuideAndControl(ControlID.StageDetail_SweepTenBtn, uis.sweep10Btn, winName)
  RegisterGuideAndControl(ControlID.Clear_SweepFiftyBtn, uis.sweep50Btn, winName)
  RegisterGuideAndControl(ControlID.StageDetail_SweepOneBtn, uis.sweep1Btn, winName)
end

ClearingWindow.SetBtnActive = function(first, second, ...)
  -- function num : 0_3 , upvalues : uis
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (uis.sweep1Btn).visible = false
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.sweep10Btn).visible = first
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.sweep50Btn).visible = second
end

ClearingWindow.InitDebrisList = function(...)
  -- function num : 0_4 , upvalues : debrisData, _ENV, SweepData
  debrisData = {}
  for _,v in ipairs(SweepData.debrisS) do
    local CardData = ((TableData.gTable).BaseCardData)[v]
    local debrisId = (split(CardData.recruit_cost, ":"))[2]
    debrisData[tonumber(debrisId)] = 0
  end
end

ClearingWindow.TimerListIsRun = function(...)
  -- function num : 0_5 , upvalues : _ENV, timerList
  for _,v in ipairs(timerList) do
    if v:IsRunIng() then
      return true
    end
  end
  return false
end

ClearingWindow.TimerListStop = function(...)
  -- function num : 0_6 , upvalues : _ENV, timerList
  for _,v in ipairs(timerList) do
    if v:IsRunIng() then
      v:stop()
    end
  end
end

ClearingWindow.SetRootClick = function(...)
  -- function num : 0_7 , upvalues : ClearingWindow, timer2
  if (ClearingWindow.TimerListIsRun)() then
    (ClearingWindow.TimerListStop)()
    timer2:start()
  end
end

ClearingWindow.InitConfirmCloseBtn = function(...)
  -- function num : 0_8 , upvalues : uis, ClearingWindow, _ENV
  ((uis.confirmBtn).onClick):Add(function(...)
    -- function num : 0_8_0 , upvalues : ClearingWindow, _ENV
    if (ClearingWindow.TimerIsRunIng)() then
      UIMgr:CloseWindow((WinResConfig.ClearingWindow).name)
      if UIMgr:IsWindowOpen((WinResConfig.GetWayWindow).name) then
        UIMgr:CloseWindow((WinResConfig.GetWayWindow).name)
      end
    end
  end
)
  ;
  ((GRoot.inst).onClick):Add(ClearingWindow.SetRootClick)
  ;
  ((uis.CloseBtn).onClick):Add(function(...)
    -- function num : 0_8_1 , upvalues : ClearingWindow, _ENV
    if (ClearingWindow.TimerIsRunIng)() then
      UIMgr:CloseWindow((WinResConfig.ClearingWindow).name)
      if UIMgr:IsWindowOpen((WinResConfig.GetWayWindow).name) then
        UIMgr:CloseWindow((WinResConfig.GetWayWindow).name)
      end
    end
  end
)
end

ClearingWindow.TimerIsRunIng = function(...)
  -- function num : 0_9 , upvalues : timer2, ClearingWindow
  do return (not timer2:IsRunIng() and not (ClearingWindow.TimerListIsRun)()) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

ClearingWindow.InitAimGrp = function(...)
  -- function num : 0_10 , upvalues : SweepData, _ENV, uis, AimItemNum
  if SweepData.aimItemId then
    local aim = (Util.CreateFrame)(SweepData.aimItemId, false, 1)
    ;
    (uis.item2List):AddChild(aim)
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.itemnameTxt).text = ((Util.GetConfigDataByID)(SweepData.aimItemId)).name
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.describeTxt).UBBEnabled = true
    AimItemNum = 0
  else
    do
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (uis.AimGrp).visible = false
    end
  end
end

ClearingWindow.SetAimSweepNum = function(getItem, ...)
  -- function num : 0_11 , upvalues : aimItemId, _ENV, AimItemNum, SweepData, uis, surplus, aimItemNum
  if aimItemId == nil or aimItemId <= 0 then
    return 
  end
  for _,v2 in pairs(getItem) do
    if v2.id == aimItemId then
      AimItemNum = AimItemNum + 1
    end
  end
  do
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

    if SweepData.aimItemId == nil or SweepData.aimItemId <= 0 then
      (uis.describeTxt).text = (PUtil.get)(20000278, AimItemNum)
      return 
    end
    surplus = aimItemNum - AimItemNum
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.describeTxt).visible = true
    -- DECOMPILER ERROR at PC50: Confused about usage of register: R1 in 'UnsetPending'

    if surplus > 0 then
      (uis.describeTxt).text = (PUtil.get)(20000096, AimItemNum, surplus)
    else
      -- DECOMPILER ERROR at PC58: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (uis.describeTxt).text = (PUtil.get)(20000097, AimItemNum)
    end
  end
end

local count = 0
local startPlay = true
ClearingWindow.RefreshWindow = function(...)
  -- function num : 0_12 , upvalues : uis, _ENV, SweepData, timerList, clearItem, itemListData, count, startPlay, aimItemId, ClearingWindow, timer2
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  (uis.vitalitynumberTxt).text = (ActorData.GetAssetCount)(AssetType.PHYSICAL)
  local sweepData = SweepData.getItems
  timerList = {}
  if clearItem then
    itemListData = sweepData
    count = 0
    ;
    (uis.itemList):ScrollToView(0)
  else
    count = #itemListData
    for _,v in ipairs(sweepData) do
      (table.insert)(itemListData, v)
    end
  end
  do
    startPlay = true
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.itemList).numItems = #itemListData
    local lineCount = 3
    if (aimItemId and aimItemId > 0) or SweepData.isFastWeep then
      lineCount = 2
    end
    -- DECOMPILER ERROR at PC54: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((uis.itemList).scrollPane).touchEffect = false
    for i = 1, #sweepData do
      local timer0 = (SimpleTimer.setTimeout)((i - 1) * 0.5, function(...)
    -- function num : 0_12_0 , upvalues : _ENV, count, lineCount, uis, ClearingWindow, itemListData, startPlay
    local scollIndex = (math.max)(0, count - lineCount + 1)
    ;
    (uis.itemList):ScrollToView(scollIndex, true, true)
    local index = (uis.itemList):ItemIndexToChildIndex(count)
    if index < (uis.itemList).numChildren then
      local obj = (uis.itemList):GetChildAt(index)
      obj.visible = true
      count = count + 1
      ;
      (ClearingWindow.SetAimSweepNum)((itemListData[count]).items)
      PlayUITrans(obj, "up", function(...)
      -- function num : 0_12_0_0 , upvalues : itemListData, count, ClearingWindow, uis, startPlay
      if #itemListData == count then
        (ClearingWindow.CheckIsUplevel)()
        -- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

        ;
        ((uis.itemList).scrollPane).touchEffect = true
        startPlay = false
      end
    end
)
    end
  end
)
      ;
      (table.insert)(timerList, timer0)
    end
    timer2 = (SimpleTimer.new)(0.05, #itemListData - count, function(...)
    -- function num : 0_12_1 , upvalues : uis, _ENV, count, lineCount, ClearingWindow, itemListData, timer2, startPlay
    (uis.itemList):ScrollToView((math.max)(0, count - lineCount + 1), false, true)
    local index = (uis.itemList):ItemIndexToChildIndex(count)
    local obj = (uis.itemList):GetChildAt(index)
    obj.visible = true
    count = count + 1
    ;
    (ClearingWindow.SetAimSweepNum)((itemListData[count]).items)
    if #itemListData <= count then
      timer2:stop()
      ;
      (ClearingWindow.CheckIsUplevel)()
      -- DECOMPILER ERROR at PC42: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((uis.itemList).scrollPane).touchEffect = true
      startPlay = false
    end
  end
)
  end
end

ClearingWindow.CheckIsUplevel = function(...)
  -- function num : 0_13 , upvalues : _ENV
  if (Util.IsPrepareLevelUpWindow)() then
    (Util.SetOnClickDelay)(0.5)
    ;
    (SimpleTimer.setTimeout)(0.5, function(...)
    -- function num : 0_13_0 , upvalues : _ENV
    OpenWindow((WinResConfig.PlayerLevelUpWindow).name, UILayer.HUD1)
  end
)
  end
end

ClearingWindow.ItemRenderer = function(index, obj, ...)
  -- function num : 0_14 , upvalues : itemListData, _ENV, startPlay, ClearingWindow, count
  local data = itemListData[index + 1]
  if not data then
    return 
  end
  local model = GetPlotDungeon_PropClenNormalListUis(obj)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

  if not data.exp or data.exp <= 0 then
    (model.expiconImage).visible = false
  end
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R4 in 'UnsetPending'

  if not data.money or data.money <= 0 then
    (model.goldiconImage).visible = false
  end
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (model.expnumberTxt).text = data.exp
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (model.goldnumberTxt).text = data.money
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (model.NumberTxt).text = (PUtil.get)(20000017, index + 1)
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (model.ItemList).numItems = 0
  local itemData = (Util.MajorSort)(data.items)
  for _,v in ipairs(itemData) do
    local id = v.id
    local number = v.Num
    if id ~= AssetType.GOLD then
      local Frame = (Util.CreateFrame)(id, v.isGet, number)
      ;
      (model.ItemList):AddChild(Frame)
      if startPlay then
        (ClearingWindow.AddDebrisToList)(id)
      end
    end
  end
  obj.visible = index < count
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ClearingWindow.AddDebrisToList = function(id, ...)
  -- function num : 0_15 , upvalues : debrisData, uis, _ENV
  if debrisData[id] then
    debrisData[id] = debrisData[id] + 1
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.Heroitem2List).numItems = 0
    for k,v in pairs(debrisData) do
      if v > 0 then
        local debris = (Util.CreateHeadDebris)(k, v)
        ;
        (uis.Heroitem2List):AddChild(debris)
      end
    end
  end
end

ClearingWindow.OnShown = function(...)
  -- function num : 0_16
end

ClearingWindow.OnHide = function(...)
  -- function num : 0_17
end

ClearingWindow.OnClose = function(...)
  -- function num : 0_18 , upvalues : ClearingWindow, _ENV, SweepData, uis, timer2, debrisData
  (ClearingWindow.CheckIsUplevel)()
  ;
  (GuideData.AbolishControlRefer)((WinResConfig.ClearingWindow).name)
  ;
  ((GRoot.inst).onClick):Remove(ClearingWindow.SetRootClick)
  SweepData = {}
  uis = nil
  ;
  (ClearingWindow.TimerListStop)()
  timer2:stop()
  timer2 = nil
  debrisData = {}
  UIMgr:SendWindowMessage((WinResConfig.CardWindow).name, (WindowMsgEnum.CardWindow).E_MSG_CARD_SWEEP_END)
  UIMgr:SendWindowMessage("CardListWindow", (WindowMsgEnum.CardWindow).E_MSG_GETWAY_CLOESED, {})
end

ClearingWindow.HandleMessage = function(msgId, ...)
  -- function num : 0_19 , upvalues : _ENV, ClearingWindow, timer2, SweepData
  if msgId == (WindowMsgEnum.ClearingWindow).E_MSG_REWARD_REFRESH then
    (ClearingWindow.TimerListStop)()
    timer2:stop()
    SweepData = (PlotDungeonMgr.GetSweepData)()
    ;
    (ClearingWindow.RefreshWindow)()
  end
end

return ClearingWindow

