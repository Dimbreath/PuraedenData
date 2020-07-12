-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_TowerBattleWinByName")
local TowerBattleWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
TowerBattleWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, TowerBattleWindow
  bridgeObj:SetView((WinResConfig.TowerBattleWindow).package, (WinResConfig.TowerBattleWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetBattle_TowerBattleWinUis(contentPane)
  ;
  (TowerBattleWindow.InitVariable)()
  ;
  (TowerBattleWindow.InitText)()
  ;
  (TowerBattleWindow.InitButtonEvent)()
  ;
  (TowerBattleWindow.InitUIEffect)()
end

TowerBattleWindow.InitVariable = function(...)
  -- function num : 0_1 , upvalues : uis
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

  (uis.RepeatBtn).visible = false
end

TowerBattleWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.DateBtn).text = (PUtil.get)(20000023)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.ConfirmBtn).text = (PUtil.get)(30)
end

TowerBattleWindow.InitButtonEvent = function(...)
  -- function num : 0_3 , upvalues : uis, TowerBattleWindow
  ((uis.DateBtn).onClick):Add(TowerBattleWindow.ClickReviewBtn)
  ;
  ((uis.ConfirmBtn).onClick):Add(TowerBattleWindow.ClickCloseBtn)
end

TowerBattleWindow.InitUIEffect = function(...)
  -- function num : 0_4 , upvalues : uis, _ENV
  local title = (uis.root):GetChild("n9")
  local pos = Vector2(title.x + title.width * 0.5, title.y + title.height * 0.5)
  ;
  (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_UNLOCK, true, uis.root, pos)
end

TowerBattleWindow.InitEvent = function(...)
  -- function num : 0_5
end

TowerBattleWindow.RemoveEvent = function(...)
  -- function num : 0_6
end

TowerBattleWindow.OnShown = function(...)
  -- function num : 0_7 , upvalues : TowerBattleWindow
  (TowerBattleWindow.InitEvent)()
  ;
  (TowerBattleWindow.Init)()
end

TowerBattleWindow.OnHide = function(...)
  -- function num : 0_8 , upvalues : TowerBattleWindow
  (TowerBattleWindow.RemoveEvent)()
end

TowerBattleWindow.Init = function(...)
  -- function num : 0_9 , upvalues : _ENV, uis, TowerBattleWindow
  (Util.CreateSelfShowModel)(uis.CharacterLoader)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.LuckNumberTxt).text = TowerData.CurrentLucky
  ;
  (TowerBattleWindow.RefreshReward)()
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.DateBtn).visible = UIMgr:IsWindowOpen((WinResConfig.BattleUIWindow).name)
end

TowerBattleWindow.RefreshReward = function(...)
  -- function num : 0_10 , upvalues : argTable, uis, _ENV
  local count = #argTable[1]
  local data = nil
  ;
  (uis.ItemList):RemoveChildrenToPool()
  local frame = nil
  for i = 1, count do
    data = (argTable[1])[i]
    frame = (Util.SetFrame)(data.Id, data.Amount, uis.ItemList, false, data.First)
    if frame ~= nil then
      (uis.ItemList):AddChild(frame)
    end
  end
  count = #argTable[2]
  ;
  (uis.OtherItemList):RemoveChildrenToPool()
  for i = 1, count do
    data = (argTable[2])[i]
    frame = (Util.SetFrame)(data.Id, data.Amount, uis.OtherItemList)
    if frame ~= nil then
      (uis.OtherItemList):AddChild(frame)
    end
  end
end

TowerBattleWindow.ClickReviewBtn = function(...)
  -- function num : 0_11 , upvalues : _ENV
  (CommonWinMgr.OpenBattleDataWindow)((BattleResultCount.GetBattleDamageData)())
end

TowerBattleWindow.ClickCloseBtn = function(...)
  -- function num : 0_12 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.TowerBattleWindow).name)
  if UIMgr:IsWindowOpen((WinResConfig.BattleUIWindow).name) then
    (BattleMgr.CloseBattle)()
  end
end

TowerBattleWindow.OnClose = function(...)
  -- function num : 0_13 , upvalues : _ENV, uis, contentPane, argTable
  (Util.RecycleUIModel)(uis.CharacterLoader)
  uis = nil
  contentPane = nil
  argTable = {}
end

TowerBattleWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_14
end

return TowerBattleWindow

