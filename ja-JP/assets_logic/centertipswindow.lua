-- params : ...
-- function num : 0 , upvalues : _ENV
require("Message_CenterTipsByName")
CenterTipsWindow = {}
local contentPane, uis, transition = nil, nil, nil
-- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

CenterTipsWindow.OnInit = function(bridge, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, uis, transition
  bridge:SetView((WinResConfig.CenterTipsWindow).package, (WinResConfig.CenterTipsWindow).comName)
  contentPane = bridge.contentPane
  uis = GetMessage_CenterTipsUis(contentPane)
  print(contentPane)
  transition = contentPane:GetTransition("centertipsani")
end

-- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

CenterTipsWindow.PlayTransition = function(...)
  -- function num : 0_1 , upvalues : transition, _ENV
  transition:Stop()
  ;
  (CenterTipsWindow.ShowTips)()
end

-- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

CenterTipsWindow.ShowTips = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV, transition
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

  (uis.centertipsTxt).text = (MessageMgr.GetCenterTipsContent)()
  transition:Play(function(...)
    -- function num : 0_2_0 , upvalues : _ENV
    UIMgr:HideWindow((WinResConfig.CenterTipsWindow).name)
  end
)
end

-- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

CenterTipsWindow.OnShown = function(...)
  -- function num : 0_3 , upvalues : _ENV
  (CenterTipsWindow.ShowTips)()
end

-- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'

CenterTipsWindow.OnHide = function(...)
  -- function num : 0_4
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

CenterTipsWindow.OnClose = function(...)
  -- function num : 0_5 , upvalues : transition, uis, contentPane
  transition = nil
  uis = nil
  contentPane = nil
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'

CenterTipsWindow.HandleMessage = function(msgId, ...)
  -- function num : 0_6 , upvalues : _ENV
  if msgId == 1 then
    (CenterTipsWindow.PlayTransition)()
  end
  if msgId == 2 then
  end
end

return CenterTipsWindow

