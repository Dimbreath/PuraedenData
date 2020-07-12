-- params : ...
-- function num : 0 , upvalues : _ENV
require("GetWay_TicketWindowByName")
local TicketWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local itemID = -1
local itemData = {}
TicketWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, itemID, itemData, uis, TicketWindow
  bridgeObj:SetView((WinResConfig.TicketWindow).package, (WinResConfig.TicketWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  itemID = tonumber(argTable[1])
  itemData = ((TableData.gTable).BasePropData)[itemID]
  if itemData == nil or itemData.type ~= PropItemType.COMPOUND_DEBRIS then
    loge(itemID .. "不是合成碎片")
    return 
  end
  uis = GetGetWay_TicketWindowUis(contentPane)
  uis = uis.Ticket
  ;
  (TicketWindow.InitInvariable)()
  ;
  (TicketWindow.InitBtn)()
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.ChangeNumberTxt).text = 1
end

TicketWindow.InitInvariable = function(...)
  -- function num : 0_1 , upvalues : _ENV, itemData, uis, itemID
  local effect = split(itemData.effect_value, ":")
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.WordTxt).text = (PUtil.get)(20000241, effect[2])
  local leftNum = (ActorData.GetPropsByID)(itemID)
  local rightNum = (ActorData.GetPropsByID)(tonumber(effect[1]))
  ;
  (Util.SetItemFrame)((uis.Item_01_Grp).root, itemID, leftNum)
  ;
  (Util.SetItemFrame)((uis.Item_02_Grp).root, tonumber(effect[1]), rightNum)
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (uis.titilenameTxt).text = (PUtil.get)(20000393)
end

TicketWindow.InitBtn = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV, TicketWindow, itemID, itemData
  ((uis.SureBtn):GetChild("title")).text = (PUtil.get)(20000244)
  ;
  ((uis.ReduceBtn).onClick):Set(function(...)
    -- function num : 0_2_0 , upvalues : TicketWindow
    (TicketWindow.AddNum)(-1)
  end
)
  ;
  ((uis.AddBtn).onClick):Set(function(...)
    -- function num : 0_2_1 , upvalues : TicketWindow
    (TicketWindow.AddNum)(1, true)
  end
)
  ;
  ((uis.Add10Btn).onClick):Set(function(...)
    -- function num : 0_2_2 , upvalues : TicketWindow
    (TicketWindow.AddNum)(10, true)
  end
)
  ;
  ((uis.MaxBtn).onClick):Set(function(...)
    -- function num : 0_2_3 , upvalues : _ENV, itemID, TicketWindow
    local totalNum = (ActorData.GetPropsByID)(itemID)
    ;
    (TicketWindow.AddNum)(totalNum, true)
  end
)
  ;
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_2_4 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.TicketWindow).name)
  end
)
  ;
  ((uis.SureBtn).onClick):Set(function(...)
    -- function num : 0_2_5 , upvalues : _ENV, uis, itemData, itemID
    local Num = tonumber((uis.ChangeNumberTxt).text)
    local effect = split(itemData.effect_value, ":")
    local consumeNum = Num * tonumber(effect[2])
    local OwnNum = (ActorData.GetPropsByID)(tonumber(itemID))
    if consumeNum <= OwnNum then
      ld("Bag")
      ;
      (BagService.ReqUseProp)(itemID, (ActorData.GetItemObjectIndex)(itemID), consumeNum)
      UIMgr:CloseWindow((WinResConfig.TicketWindow).name)
    else
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(20000243))
    end
  end
)
end

TicketWindow.AddNum = function(num, showTips, ...)
  -- function num : 0_3 , upvalues : _ENV, itemData, uis, itemID
  local effect = split(itemData.effect_value, ":")
  local formerNum = tonumber((uis.ChangeNumberTxt).text)
  local afterNum = formerNum + num
  local consumeNum = afterNum * tonumber(effect[2])
  local OwnNum = (ActorData.GetPropsByID)(itemID)
  local getMaxNum = (math.tointeger)((math.floor)(OwnNum / tonumber(effect[2])))
  if getMaxNum <= 0 then
    return 
  end
  afterNum = (Umath.Clamp)(afterNum, 1, getMaxNum)
  if formerNum == afterNum and showTips and getMaxNum > 0 then
    (MessageMgr.SendCenterTips)((PUtil.get)(20000242))
  end
  -- DECOMPILER ERROR at PC55: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (uis.ChangeNumberTxt).text = (math.tointeger)(afterNum)
end

TicketWindow.OnShown = function(...)
  -- function num : 0_4
end

TicketWindow.OnHide = function(...)
  -- function num : 0_5
end

TicketWindow.OnClose = function(...)
  -- function num : 0_6 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

TicketWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_7
end

return TicketWindow

