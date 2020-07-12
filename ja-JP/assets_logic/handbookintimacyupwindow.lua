-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_IntimacyUpByName")
local HandBookIntimacyUpWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local cardID = 0
local intimacyLevel = 0
local func = nil
HandBookIntimacyUpWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, cardID, intimacyLevel, func, uis
  bridgeObj:SetView((WinResConfig.HandBookIntimacyUpWindow).package, (WinResConfig.HandBookIntimacyUpWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  cardID = argTable[1]
  intimacyLevel = argTable[2]
  func = argTable[3]
  uis = GetHandBook_IntimacyUpUis(contentPane)
  ;
  ((uis.TouchScreenBtn).onClick):Set(function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.HandBookInteractiveWindow).name)
    UIMgr:CloseWindow((WinResConfig.HandBookIntimacyUpWindow).name)
  end
)
end

HandBookIntimacyUpWindow.OnShown = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis, contentPane, cardID, intimacyLevel, HandBookIntimacyUpWindow
  (Util.PlayUIEffect)(uis, contentPane, 1)
  local oneCard = (CardData.GetCardData)(cardID)
  local data = (HandBookMgr.GetCardIntimacyData)(cardID, intimacyLevel)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.IntimacyGetPeachGrp).c1Ctr).selectedIndex = data.rank
  ;
  (((uis.IntimacyGetPeachGrp).root):GetChild("n5")).text = intimacyLevel
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.PowerNumberTxt).text = (ActorData.GetFc)()
  local stageNum = (HandBookIntimacyUpWindow.UnLockCardStage)()
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R3 in 'UnsetPending'

  if stageNum then
    (uis.GetTxt).text = (PUtil.get)(20000149, oneCard.name, stageNum)
  else
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (uis.GetTxt).visible = false
  end
end

HandBookIntimacyUpWindow.UnLockCardStage = function(...)
  -- function num : 0_2 , upvalues : _ENV, cardID, intimacyLevel
  local stageList = ((HandBookMgr.GetCardStageList)(cardID))
  local num = nil
  for i,v in ipairs(stageList) do
    local condition = split(v.open_condition, ":")
    if tonumber(condition[1]) == Const.IntimacyConditionID and tonumber(condition[3]) == intimacyLevel then
      num = i
    end
  end
  return num
end

HandBookIntimacyUpWindow.OnHide = function(...)
  -- function num : 0_3
end

HandBookIntimacyUpWindow.OnClose = function(...)
  -- function num : 0_4 , upvalues : func, uis, contentPane, argTable
  if func then
    func()
  end
  uis = nil
  contentPane = nil
  argTable = {}
end

HandBookIntimacyUpWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_5
end

return HandBookIntimacyUpWindow

