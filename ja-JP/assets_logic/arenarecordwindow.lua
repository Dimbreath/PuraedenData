-- params : ...
-- function num : 0 , upvalues : _ENV
require("Arena_RecordWindowByName")
local ArenaRecordWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
ArenaRecordWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, ArenaRecordWindow
  bridgeObj:SetView((WinResConfig.ArenaRecordWindow).package, (WinResConfig.ArenaRecordWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetArena_RecordWindowUis(contentPane)
  uis = uis.Record
  ;
  (ArenaRecordWindow.InitVariable)()
  ;
  (ArenaRecordWindow.InitText)()
  ;
  (ArenaRecordWindow.InitButtonEvent)()
end

ArenaRecordWindow.InitVariable = function(...)
  -- function num : 0_1 , upvalues : uis, ArenaRecordWindow
  (uis.BattleInformationList):SetVirtual()
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.BattleInformationList).itemRenderer = ArenaRecordWindow.RefreshRecordItem
  ;
  (uis.BattleInformationList):SetBeginAnim()
end

ArenaRecordWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.ButtonBtn).text = (PUtil.get)(30)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.RecordTxt).text = (PUtil.get)(60000471)
end

ArenaRecordWindow.InitButtonEvent = function(...)
  -- function num : 0_3 , upvalues : uis, ArenaRecordWindow
  ((uis.ButtonBtn).onClick):Add(ArenaRecordWindow.ClickCloseBtn)
  ;
  ((uis.CloseBtn).onClick):Add(ArenaRecordWindow.ClickCloseBtn)
end

ArenaRecordWindow.InitEvent = function(...)
  -- function num : 0_4
end

ArenaRecordWindow.RemoveEvent = function(...)
  -- function num : 0_5
end

ArenaRecordWindow.OnShown = function(...)
  -- function num : 0_6 , upvalues : ArenaRecordWindow
  (ArenaRecordWindow.InitEvent)()
  ;
  (ArenaRecordWindow.Init)()
end

ArenaRecordWindow.OnHide = function(...)
  -- function num : 0_7 , upvalues : ArenaRecordWindow
  (ArenaRecordWindow.RemoveEvent)()
end

ArenaRecordWindow.Init = function(...)
  -- function num : 0_8 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

  (uis.BattleInformationList).numItems = #ArenaData.CombatRecords
end

ArenaRecordWindow.RefreshRecordItem = function(index, item, ...)
  -- function num : 0_9 , upvalues : _ENV
  local data = (ArenaData.CombatRecords)[index + 1]
  ;
  (item:GetController("c1")).selectedIndex = (data.statue + 1) % 4
  ;
  (item:GetChild("HeadLoader")).url = (Util.GetHeadIconByFashionId)(data.fashionHead, HeadIconType.ROUND)
  ;
  (item:GetChild("BattleTxt")).text = (PUtil.get)(60000235)
  ;
  (item:GetChild("LvNumTxt")).text = "Lv." .. data.level
  ;
  (item:GetChild("PlayerNameTxt")).text = data.name
  ;
  (item:GetChild("NumberTxt")).text = (ArenaData.GetFC)(data)
  ;
  (item:GetChild("TimeTxt")).text = (LuaTime.GetLeftTimeStr)((math.floor)(data.timestamp * 0.001))
  local list = item:GetChild("CardHeadList")
  if data.isPlayer then
    (table.sort)(((data.cardGroups)[1]).teamCard, function(x, y, ...)
    -- function num : 0_9_0
    do return x.posIndex < y.posIndex end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  end
  list:RemoveChildrenToPool()
  local count = #((data.cardGroups)[1]).teamCard
  local subItem = nil
  for i = 1, count do
    subItem = list:AddItemFromPool()
    ;
    (Util.SetHeadFrame)(subItem, ((((data.cardGroups)[1]).teamCard)[i]).cardInfo, not data.isPlayer)
  end
  local dataBtn = item:GetChild("DataBtn")
  local replayBtn = item:GetChild("RePlayBtn")
  dataBtn.text = (PUtil.get)(60000066)
  replayBtn.text = (PUtil.get)(60000067)
  ;
  (dataBtn.onClick):Set(function(...)
    -- function num : 0_9_1 , upvalues : _ENV, data
    (ArenaMgr.TryShowBattleData)(data.battleindex)
  end
)
  ;
  (replayBtn.onClick):Set(function(...)
    -- function num : 0_9_2 , upvalues : _ENV, data
    (ArenaMgr.TryReplayBattle)(data.battleindex)
  end
)
end

ArenaRecordWindow.ClickCloseBtn = function(...)
  -- function num : 0_10 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.ArenaRecordWindow).name)
end

ArenaRecordWindow.OnClose = function(...)
  -- function num : 0_11 , upvalues : uis, contentPane
  uis = nil
  contentPane = nil
end

ArenaRecordWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_12
end

return ArenaRecordWindow

