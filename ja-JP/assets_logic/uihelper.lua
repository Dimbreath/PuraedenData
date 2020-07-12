-- params : ...
-- function num : 0 , upvalues : _ENV
UIMgr = (CS.UIManager).Singleton
UILayer = CS.UILayer
local LuaWins = {}
require("LuaWinRegister")
local csWinConfig = CS.WinResConfig
RegisterAllLuaWindowType()
setmetatable(WinResConfig, {__index = function(t, k, ...)
  -- function num : 0_0 , upvalues : csWinConfig
  local info = csWinConfig[k]
  if info ~= nil then
    local value = {package = info.package, comName = info.comName}
    t[k] = value
    return value
  end
end
})
CreateUIPage = function(cfg, ...)
  -- function num : 0_1 , upvalues : _ENV
  return UIMgr:CreateUIPage(cfg.package, cfg.resName)
end

NewLuaWindow = function(name, ...)
  -- function num : 0_2 , upvalues : LuaWins, _ENV
  if LuaWins[name] ~= nil then
    if (LuaWins[name]).ReInitData ~= nil then
      ((LuaWins[name]).ReInitData)()
    end
    return LuaWins[name]
  else
    loge("准备加载lua窗口类：" .. name)
    LuaWins[name] = require(name)
    if LuaWins[name] ~= nil then
      return LuaWins[name]
    else
      loge("没有找到lua窗口类:" .. name)
    end
  end
end

OpenWindow = function(uiName, layer, ...)
  -- function num : 0_3 , upvalues : _ENV
  OpenWindowWithFullArg(uiName, layer, true, 0, true, false, 0, ...)
end

OpenWindowByDelayClose = function(uiName, layer, delay, ...)
  -- function num : 0_4 , upvalues : _ENV
  OpenWindowWithFullArg(uiName, layer, true, 0, true, false, delay, ...)
end

OpenWindowWithOpen = function(uiName, layer, isOpenFromClose, ...)
  -- function num : 0_5 , upvalues : _ENV
  OpenWindowWithFullArg(uiName, layer, true, 0, true, isOpenFromClose, 0, ...)
end

OpenWindowWithFullArg = function(uiName, layer, isCloseOnCloseAll, sortingOrder, isFront, isOpenFromClose, delay, ...)
  -- function num : 0_6 , upvalues : _ENV
  if UIMgr:IsWindowOpen(uiName) == false then
    local packageS = nil
    for k,v in pairs(WindowLoadPackages) do
      if k == uiName then
        packageS = v
      end
    end
    if packageS then
      UIMgr:SetNeedLoadPackage(uiName, packageS)
    end
    UIMgr:OpenWindow(uiName, layer, isCloseOnCloseAll, sortingOrder, isFront, isOpenFromClose or false, delay, {...})
    return true
  else
    do
      do return false end
    end
  end
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

UIMgr.AddPkg = function(name, ...)
  -- function num : 0_7 , upvalues : _ENV
  if WinResConfig[name] then
    UIMgr:LoadPackage((WinResConfig[name]).package)
  end
end

-- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

UIMgr.RemovePkg = function(name, ...)
  -- function num : 0_8 , upvalues : _ENV
  if WinResConfig[name] then
    UIMgr:RemovePackage((WinResConfig[name]).package)
  end
end

ClearLuaWins = function(...)
  -- function num : 0_9 , upvalues : _ENV, LuaWins
  for k,v in pairs(package.loaded) do
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

    if LuaWins[k] ~= nil then
      (package.loaded)[k] = nil
      LuaWins[k] = nil
    end
  end
end

MessageWindow = {conformDelegate = nil, cancelDelegate = nil, title = "", content = "", windowType = 0}
ShowMsgWindow = function(title, content, windowType, conformDelegate, cancelDelegate, ...)
  -- function num : 0_10 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R5 in 'UnsetPending'

  MessageWindow.conformDelegate = conformDelegate
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R5 in 'UnsetPending'

  MessageWindow.cancelDelegate = cancelDelegate
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R5 in 'UnsetPending'

  MessageWindow.title = title
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R5 in 'UnsetPending'

  MessageWindow.content = content
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R5 in 'UnsetPending'

  MessageWindow.windowType = windowType
  OpenWindow((WinResConfig.MsgWindow).name, UILayer.Popup)
end

ShowErrorTip = function(content, ...)
  -- function num : 0_11 , upvalues : _ENV
  OpenWindow((WinResConfig.ErrorTipWindow).name, UILayer.Notice)
  UIMgr:SendWindowMessage((WinResConfig.ErrorTipWindow).name, 1, content)
end

SetLoaderTexture = function(aLoader, t2D, ...)
  -- function num : 0_12 , upvalues : _ENV
  if aLoader ~= nil then
    aLoader.texture = (FairyGUI.NTexture)(t2D)
  else
    loge("error, aLoader is nil")
  end
end

ReLoadWindowScript = function(scptName, ...)
  -- function num : 0_13 , upvalues : _ENV, LuaWins
  local isOpen = UIMgr:IsWindowOpen(scptName)
  local layer = UIMgr:GetOpenWindowLayer(scptName)
  local sortingOrder = UIMgr:GetOpenWindowSortingOrder(scptName)
  UIMgr:CloseWindow(scptName)
  LuaWins[scptName] = nil
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (package.loaded)[scptName] = nil
  LuaWins[scptName] = require(scptName)
  if isOpen then
    UIMgr:OpenWindow(scptName, layer, false, sortingOrder)
  end
end

PlayUITrans = function(com, transName, callBack, delayTime, times, startTime, endTime, ignoreEngineTimeScale, reverse, ...)
  -- function num : 0_14
  if com then
    local trans = com:GetTransition(transName)
    if trans then
      if ignoreEngineTimeScale == false then
        trans.ignoreEngineTimeScale = false
      end
      trans:Play(not startTime or not endTime or 1, not times and delayTime or 0, startTime, endTime, function(...)
    -- function num : 0_14_0 , upvalues : callBack
    if callBack then
      callBack()
    end
  end
)
    end
    trans:PlayReverse(not reverse or 1, not times and delayTime or 0, function(...)
    -- function num : 0_14_1 , upvalues : callBack
    if callBack then
      callBack()
    end
  end
)
    trans:Play(times or 1, delayTime or 0, function(...)
    -- function num : 0_14_2 , upvalues : callBack
    if callBack then
      callBack()
    end
  end
)
    return trans
  end
end

DisposeTrans = function(com, transName, ...)
  -- function num : 0_15
  if com then
    local trans = com:GetTransition(transName)
    if trans then
      trans:Dispose()
    end
  end
end

GetTransitionDuration = function(com, transName, ...)
  -- function num : 0_16
  if com then
    local trans = com:GetTransition(transName)
    if trans then
      return trans._totalDuration
    end
  end
end

ChangeUIController = function(com, controllerName, selectIndex, ...)
  -- function num : 0_17
  if not controllerName then
    local controller = com:GetController(not com or "c1")
    controller:SetSelectedIndex(not controller or selectIndex or 0)
  end
end

ChangeController = function(controller, selectIndex, ...)
  -- function num : 0_18
  controller:SetSelectedIndex(not controller or selectIndex or 0)
end

GetFormatedCount = function(count, ...)
  -- function num : 0_19 , upvalues : _ENV
  if count >= 10000000000 then
    return (math.floor)(count / 1000000000) .. "B"
  else
    if count >= 100000000 then
      return (math.floor)(count / 1000000) .. "M"
    else
      if count >= 1000000 then
        return (math.floor)(count / 1000) .. "K"
      else
        return count
      end
    end
  end
end

SetCardStar = function(star, ...)
  -- function num : 0_20 , upvalues : _ENV
  local starList = {}
  local args = {...}
  for i = 1, #args do
    local temp = args[i]
    temp.visible = false
    ;
    (table.insert)(starList, temp)
  end
  for k,v in pairs(starList) do
    if k <= star then
      v.visible = true
    end
  end
end

OpenPlotPlay = function(triggerID, triggerType, callback, notShowSwitchBtn, ...)
  -- function num : 0_21 , upvalues : _ENV
  ld("PlotPlay", function(...)
    -- function num : 0_21_0 , upvalues : _ENV, triggerID, triggerType, callback, notShowSwitchBtn
    (PlotPlayMgr.Play)(triggerID, triggerType, callback, notShowSwitchBtn)
  end
)
end

SendActivityWindowMessage = function(viewName, msgID, param, ...)
  -- function num : 0_22 , upvalues : _ENV
  UIMgr:SendWindowMessage((WinResConfig.ActivityMainWindow).name, (WindowMsgEnum.ActivityMainWindow).INFORM_CHILD_VIEW, {viewName, msgID, param})
end

GuideSetDelayShow = function(ui, ...)
  -- function num : 0_23 , upvalues : _ENV
  if (GuideMgr.IsInMainGuide)() then
    ui.alpha = 0
    ;
    (SimpleTimer.setTimeout)(Const.GuideDelayTime, function(...)
    -- function num : 0_23_0 , upvalues : ui
    ui.alpha = 1
  end
)
  end
end


