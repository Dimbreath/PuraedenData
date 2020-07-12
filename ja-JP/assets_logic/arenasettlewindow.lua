-- params : ...
-- function num : 0 , upvalues : _ENV
require("Arena_EndByName")
local ArenaSettleWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
ArenaSettleWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, ArenaSettleWindow
  bridgeObj:SetView((WinResConfig.ArenaSettleWindow).package, (WinResConfig.ArenaSettleWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  argTable.Data = argTable[1]
  uis = GetArena_EndUis(contentPane)
  ;
  (ArenaSettleWindow.InitVariable)()
  ;
  (ArenaSettleWindow.InitText)()
  ;
  (ArenaSettleWindow.InitButtonEvent)()
  ;
  (ArenaSettleWindow.InitUIEffect)()
end

ArenaSettleWindow.InitVariable = function(...)
  -- function num : 0_1
end

ArenaSettleWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.MaxTxt).text = (PUtil.get)(60000420)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.NowTxt).text = (PUtil.get)(60000421)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.TouchTxt).text = (PUtil.get)(20000224)
end

ArenaSettleWindow.InitButtonEvent = function(...)
  -- function num : 0_3 , upvalues : uis, ArenaSettleWindow
  ((uis.TouchScreenBtn).onClick):Set(ArenaSettleWindow.ClickCloseBtn)
end

ArenaSettleWindow.InitUIEffect = function(...)
  -- function num : 0_4 , upvalues : uis, _ENV
  local title = uis.Decorate_01_Image
  local pos = Vector2(title.x + title.width * 0.5, title.y + title.height * 0.5)
  ;
  (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_UNLOCK, true, uis.root, pos)
  ;
  (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_CHARACTER_LEVEL_UP, false, uis.root, Vector2((GRoot.inst).width / 2, (GRoot.inst).height * 1 / 2))
end

ArenaSettleWindow.InitEvent = function(...)
  -- function num : 0_5
end

ArenaSettleWindow.RemoveEvent = function(...)
  -- function num : 0_6
end

ArenaSettleWindow.OnShown = function(...)
  -- function num : 0_7 , upvalues : ArenaSettleWindow
  (ArenaSettleWindow.InitEvent)()
  ;
  (ArenaSettleWindow.Init)()
end

ArenaSettleWindow.OnHide = function(...)
  -- function num : 0_8
end

ArenaSettleWindow.Init = function(...)
  -- function num : 0_9 , upvalues : uis, argTable, _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.Number).NumberTxt).text = (argTable.Data).rank
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.MaxNumberTxt).text = (PUtil.get)(60000422, (argTable.Data).maxRank)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.NowNumberTxt).text = (PUtil.get)(60000422, (argTable.Data).rank)
end

ArenaSettleWindow.ClickCloseBtn = function(...)
  -- function num : 0_10 , upvalues : argTable, _ENV
  local arg = argTable
  UIMgr:CloseWindow((WinResConfig.ArenaSettleWindow).name)
  if (((arg.Data).tempMonthReward ~= nil and #(arg.Data).tempMonthReward ~= 0) or ((arg.Data).tempMonthCareerReward ~= nil and #(arg.Data).tempMonthCareerReward ~= 0) or ((arg.Data).tempDayCareerReward == nil or #(arg.Data).tempDayCareerReward == 0)) then
    OpenWindow((WinResConfig.ArenaNewSeasonWindow).name, UILayer.HUD, arg.Data)
  else
    OpenWindow((WinResConfig.ArenaSettleRewardWindow).name, UILayer.HUD, arg.Data)
  end
end

ArenaSettleWindow.OnClose = function(...)
  -- function num : 0_11 , upvalues : ArenaSettleWindow, uis, contentPane, argTable
  (ArenaSettleWindow.RemoveEvent)()
  uis = nil
  contentPane = nil
  argTable = {}
end

ArenaSettleWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_12
end

return ArenaSettleWindow

