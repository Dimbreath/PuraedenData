-- params : ...
-- function num : 0 , upvalues : _ENV
require("Arena_SumByName")
local ArenaSettleRewardWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
ArenaSettleRewardWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, ArenaSettleRewardWindow
  bridgeObj:SetView((WinResConfig.ArenaSettleRewardWindow).package, (WinResConfig.ArenaSettleRewardWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  argTable.Data = argTable[1]
  uis = GetArena_SumUis(contentPane)
  ;
  (ArenaSettleRewardWindow.InitVariable)()
  ;
  (ArenaSettleRewardWindow.InitText)()
  ;
  (ArenaSettleRewardWindow.InitButtonEvent)()
  ;
  (ArenaSettleRewardWindow.InitUIEffect)()
end

ArenaSettleRewardWindow.InitVariable = function(...)
  -- function num : 0_1
end

ArenaSettleRewardWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.TouchTxt).text = (PUtil.get)(20000224)
end

ArenaSettleRewardWindow.InitButtonEvent = function(...)
  -- function num : 0_3 , upvalues : uis, ArenaSettleRewardWindow
  ((uis.TouchScreenBtn).onClick):Set(ArenaSettleRewardWindow.ClickCloseBtn)
end

ArenaSettleRewardWindow.InitUIEffect = function(...)
  -- function num : 0_4 , upvalues : uis, _ENV
  local title = uis.Decorate_01_Image
  local pos = Vector2(title.x + title.width * 0.5, title.y + title.height * 0.5)
  ;
  (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_UNLOCK, true, uis.root, pos)
  ;
  (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_CHARACTER_LEVEL_UP, false, uis.root, Vector2((GRoot.inst).width / 2, (GRoot.inst).height * 1 / 2))
end

ArenaSettleRewardWindow.InitEvent = function(...)
  -- function num : 0_5
end

ArenaSettleRewardWindow.RemoveEvent = function(...)
  -- function num : 0_6
end

ArenaSettleRewardWindow.OnShown = function(...)
  -- function num : 0_7 , upvalues : ArenaSettleRewardWindow
  (ArenaSettleRewardWindow.InitEvent)()
  ;
  (ArenaSettleRewardWindow.Init)()
end

ArenaSettleRewardWindow.OnHide = function(...)
  -- function num : 0_8
end

ArenaSettleRewardWindow.Init = function(...)
  -- function num : 0_9 , upvalues : uis, ArenaSettleRewardWindow, _ENV, argTable
  (uis.SumTipsList):RemoveChildrenToPool()
  ;
  (ArenaSettleRewardWindow.InitRewards)((PUtil.get)(60000423), (argTable.Data).tempMonthCareerReward)
  ;
  (ArenaSettleRewardWindow.InitRewards)((PUtil.get)(60000424), (argTable.Data).tempMonthReward)
  ;
  (ArenaSettleRewardWindow.InitRewards)((PUtil.get)(60000425), (argTable.Data).tempDayCareerReward)
end

ArenaSettleRewardWindow.InitRewards = function(text, rewards, ...)
  -- function num : 0_10 , upvalues : _ENV, uis
  if rewards == nil or #rewards <= 0 then
    return 
  end
  ;
  (Util.MajorSort)(rewards)
  local panel = (uis.SumTipsList):AddItemFromPool()
  ;
  (panel:GetChild("WordTxt")).text = text
  local list = panel:GetChild("FractionRewardList")
  list:SetVirtual()
  list.itemRenderer = function(index, item, ...)
    -- function num : 0_10_0 , upvalues : _ENV, rewards
    (Util.SetItemFrame)(item, (rewards[index + 1]).id, (rewards[index + 1]).value)
  end

  list.numItems = #rewards
end

ArenaSettleRewardWindow.OnClose = function(...)
  -- function num : 0_11 , upvalues : ArenaSettleRewardWindow, uis, contentPane, argTable
  (ArenaSettleRewardWindow.RemoveEvent)()
  uis = nil
  contentPane = nil
  argTable = {}
end

ArenaSettleRewardWindow.ClickCloseBtn = function(...)
  -- function num : 0_12 , upvalues : argTable, _ENV
  local arg = argTable
  UIMgr:CloseWindow((WinResConfig.ArenaSettleRewardWindow).name)
  OpenWindow((WinResConfig.ArenaNewSeasonWindow).name, UILayer.HUD, arg.Data)
end

ArenaSettleRewardWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_13
end

return ArenaSettleRewardWindow

