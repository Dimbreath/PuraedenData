-- params : ...
-- function num : 0 , upvalues : _ENV
require("Arena_OpenByName")
local ArenaNewSeasonWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
ArenaNewSeasonWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, ArenaNewSeasonWindow
  bridgeObj:SetView((WinResConfig.ArenaNewSeasonWindow).package, (WinResConfig.ArenaNewSeasonWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetArena_OpenUis(contentPane)
  ;
  (ArenaNewSeasonWindow.InitVariable)()
  ;
  (ArenaNewSeasonWindow.InitText)()
  ;
  (ArenaNewSeasonWindow.InitButtonEvent)()
  ;
  (ArenaNewSeasonWindow.InitUIEffect)()
end

ArenaNewSeasonWindow.InitVariable = function(...)
  -- function num : 0_1
end

ArenaNewSeasonWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.WordTxt).text = (PUtil.get)(60000426)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.TouchTxt).text = (PUtil.get)(20000224)
end

ArenaNewSeasonWindow.InitButtonEvent = function(...)
  -- function num : 0_3 , upvalues : uis, ArenaNewSeasonWindow
  ((uis.TouchScreenBtn).onClick):Set(ArenaNewSeasonWindow.ClickCloseBtn)
end

ArenaNewSeasonWindow.InitUIEffect = function(...)
  -- function num : 0_4 , upvalues : uis, _ENV
  local title = uis.Decorate_14_Image
  local pos = Vector2(title.x + title.width * 0.5, title.y + title.height * 0.5)
  ;
  (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_UNLOCK, true, uis.root, pos)
  ;
  (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_CHARACTER_LEVEL_UP, false, uis.root, Vector2((GRoot.inst).width / 2, (GRoot.inst).height * 1 / 2))
end

ArenaNewSeasonWindow.InitEvent = function(...)
  -- function num : 0_5
end

ArenaNewSeasonWindow.RemoveEvent = function(...)
  -- function num : 0_6
end

ArenaNewSeasonWindow.OnShown = function(...)
  -- function num : 0_7 , upvalues : ArenaNewSeasonWindow
  (ArenaNewSeasonWindow.InitEvent)()
  ;
  (ArenaNewSeasonWindow.Init)()
end

ArenaNewSeasonWindow.OnHide = function(...)
  -- function num : 0_8
end

ArenaNewSeasonWindow.Init = function(...)
  -- function num : 0_9 , upvalues : _ENV, uis
  local year = (math.floor)((os.date)("%Y", ((ArenaData.BaseData).seasonSettleTime).bTime * 0.001))
  local month = (math.floor)((os.date)("%m", ((ArenaData.BaseData).seasonSettleTime).bTime * 0.001))
  local day = (math.floor)((os.date)("%d", ((ArenaData.BaseData).seasonSettleTime).bTime * 0.001))
  month = month - 1
  if month == 0 then
    month = 12
    year = year - 1
  end
  local finish = (os.date)("%Y/%m/%d", (((ArenaData.BaseData).seasonSettleTime).bTime + ((ArenaData.BaseData).seasonSettleTime).durationTime) * 0.001)
  -- DECOMPILER ERROR at PC64: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (uis.TimeTxt).text = year .. "/" .. month .. "/" .. day .. "-" .. finish
end

ArenaNewSeasonWindow.OnClose = function(...)
  -- function num : 0_10 , upvalues : ArenaNewSeasonWindow, uis, contentPane, argTable
  (ArenaNewSeasonWindow.RemoveEvent)()
  uis = nil
  contentPane = nil
  argTable = {}
end

ArenaNewSeasonWindow.ClickCloseBtn = function(...)
  -- function num : 0_11 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.ArenaNewSeasonWindow).name)
end

ArenaNewSeasonWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_12
end

return ArenaNewSeasonWindow

