-- params : ...
-- function num : 0 , upvalues : _ENV
require("Expedition_ExpeditionChoiceByName")
require("Expedition_ChoiceTipsByName")
local ExpeditionChoiceWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local OpenExpedition, mData = nil, nil
local currentIndex = 0
local bgSfxName = {"FX_ui_yuanzhengrukou_1", "FX_ui_yuanzhengrukou_2", "FX_ui_yuanzhengrukou_3"}
local mHolder = nil
ExpeditionChoiceWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, mHolder, uis, ExpeditionChoiceWindow, OpenExpedition, currentIndex, mData
  bridgeObj:SetView((WinResConfig.ExpeditionChoiceWindow).package, (WinResConfig.ExpeditionChoiceWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  mHolder = nil
  uis = GetExpedition_ExpeditionChoiceUis(contentPane)
  ;
  (ExpeditionChoiceWindow.InitAssetStrip)()
  OpenExpedition = argTable[1]
  currentIndex = 0
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.c1Ctr).selectedIndex = 0
  mData = (ExpeditionChoiceWindow.InitExpedition)()
  ;
  (ExpeditionChoiceWindow.SetBgSfxAndName)()
  ;
  (ExpeditionChoiceWindow.InitBtnEvent)()
end

ExpeditionChoiceWindow.SetBgSfxAndName = function(...)
  -- function num : 0_1 , upvalues : bgSfxName, currentIndex, _ENV, mHolder, uis
  local sfxName = bgSfxName[currentIndex + 1]
  ;
  (LuaEffect.DestroyEffect)(mHolder)
  mHolder = (LuaEffect.AddUIEffect)(sfxName, false, true)
  mHolder.xy = Vector2((GRoot.inst).width / 2, (GRoot.inst).height / 2)
  ;
  (uis.root):AddChildAt(mHolder, 4)
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.ChoiceTips).c1Ctr).selectedIndex = currentIndex
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.LeftBtn).visible = currentIndex > 0
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.RightBtn).visible = currentIndex < 2
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

ExpeditionChoiceWindow.InitBtnEvent = function(...)
  -- function num : 0_2 , upvalues : uis, ExpeditionChoiceWindow, currentIndex, _ENV, mData
  ((uis.RightBtn).onClick):Set(function(...)
    -- function num : 0_2_0 , upvalues : ExpeditionChoiceWindow, currentIndex, uis, _ENV
    if (ExpeditionChoiceWindow.CheckIsUnlock)(true) then
      currentIndex = currentIndex + 1
      -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (uis.c1Ctr).selectedIndex = currentIndex
      ;
      (ExpeditionChoiceWindow.SetBgSfxAndName)()
      ;
      (Util.SetOnClickDelay)(0.1)
    end
  end
)
  ;
  ((uis.LeftBtn).onClick):Set(function(...)
    -- function num : 0_2_1 , upvalues : ExpeditionChoiceWindow, currentIndex, uis, _ENV
    if (ExpeditionChoiceWindow.CheckIsUnlock)(false) then
      currentIndex = currentIndex - 1
      -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (uis.c1Ctr).selectedIndex = currentIndex
      ;
      (ExpeditionChoiceWindow.SetBgSfxAndName)()
      ;
      (Util.SetOnClickDelay)(0.1)
    end
  end
)
  ;
  ((uis.EffectLoader).onClick):Set(function(...)
    -- function num : 0_2_2 , upvalues : _ENV, mData, currentIndex
    OpenWindow((WinResConfig.ExpeditionEnterWindow).name, UILayer.HUD, (mData[currentIndex + 1]).id, currentIndex + 1)
  end
)
end

ExpeditionChoiceWindow.CheckIsUnlock = function(right, ...)
  -- function num : 0_3 , upvalues : currentIndex, ExpeditionChoiceWindow, mData, _ENV
  local index = currentIndex
  if right then
    index = index + 1
  else
    index = index - 1
  end
  local sweepNum = (ExpeditionChoiceWindow.GetSweepTime)((mData[index + 1]).id)
  if sweepNum then
    return true
  else
    ;
    (Util.CheckCondition)((mData[index + 1]).open_condition)
    return false
  end
end

ExpeditionChoiceWindow.InitFunctionControl = function(...)
  -- function num : 0_4 , upvalues : _ENV, uis
  local winName = (WinResConfig.ExpeditionChoiceWindow).name
  local RegisterGuideAndControl = GuideData.RegisterGuideAndControl
  local ControlID = ControlID
  RegisterGuideAndControl(ControlID.Expedition_MapChoose, uis.ChoiceTipsList, winName)
end

ExpeditionChoiceWindow.InitExpedition = function(...)
  -- function num : 0_5 , upvalues : _ENV
  local ExpeditionData = (TableData.gTable).BaseExpeditionData
  local Data = {}
  for _,v in pairs(ExpeditionData) do
    (table.insert)(Data, v)
  end
  ;
  (table.sort)(Data, function(a, b, ...)
    -- function num : 0_5_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return Data
end

ExpeditionChoiceWindow.GetSweepTime = function(id, ...)
  -- function num : 0_6 , upvalues : _ENV, OpenExpedition
  for _,v in pairs(OpenExpedition) do
    if v.expeditionId == tonumber(id) then
      return v.sweepNum
    end
  end
  return 
end

ExpeditionChoiceWindow.ItemRenderer = function(index, obj, ...)
  -- function num : 0_7 , upvalues : _ENV, mData, ExpeditionChoiceWindow
  local model = GetExpedition_ChoiceTipsUis(obj)
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (model.c1Ctr).selectedIndex = index
  local data = mData[index + 1]
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (model.WordTxt).text = data.remark
  local sweepNum = (ExpeditionChoiceWindow.GetSweepTime)(data.id)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R5 in 'UnsetPending'

  if sweepNum then
    (model.c2Ctr).selectedIndex = 0
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (model.SweepNumberTxt).text = (PUtil.get)(20000105, sweepNum)
    ;
    (obj.onClick):Set(function(...)
    -- function num : 0_7_0 , upvalues : _ENV, data, index
    OpenWindow((WinResConfig.ExpeditionEnterWindow).name, UILayer.HUD, data.id, index + 1)
  end
)
  else
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (model.c2Ctr).selectedIndex = 1
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (model.SweepNumberTxt).visible = false
  end
end

ExpeditionChoiceWindow.OnShown = function(...)
  -- function num : 0_8
end

ExpeditionChoiceWindow.OnHide = function(...)
  -- function num : 0_9
end

ExpeditionChoiceWindow.OnClose = function(...)
  -- function num : 0_10 , upvalues : _ENV, contentPane, argTable, OpenExpedition, mData
  (CommonWinMgr.RemoveAssets)((WinResConfig.ExpeditionChoiceWindow).name)
  contentPane = nil
  argTable = {}
  OpenExpedition = nil
  mData = nil
end

ExpeditionChoiceWindow.InitAssetStrip = function(...)
  -- function num : 0_11 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.ExpeditionChoiceWindow).name
  m.Tip = (PUtil.get)(20000104)
  m.model = uis.AssetStripGrp
  m.activityIds = (Util.GetActivityIds)(76000040)
  m.closeToWindow = (WinResConfig.AdventureWindow).name
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

ExpeditionChoiceWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_12
end

return ExpeditionChoiceWindow

