-- params : ...
-- function num : 0 , upvalues : _ENV
require("Land_PactWindowByName")
local PactWindow = {}
local uis, contentPane = nil, nil
PactWindow.ReInitData = function(...)
  -- function num : 0_0
end

PactWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_1 , upvalues : _ENV, contentPane, uis, PactWindow
  bridgeObj:SetView((WinResConfig.PactWindow).package, (WinResConfig.PactWindow).comName)
  contentPane = bridgeObj.contentPane
  contentPane:Center()
  uis = GetLand_PactWindowUis(contentPane)
  ;
  (PactWindow.InitText)()
  ;
  (PactWindow.InitBtn)()
end

PactWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  local pack = uis.Pact
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (pack.NameTxt).text = (PUtil.get)(40002030)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((pack.PactWordA).WordTxt).text = (PUtil.get)(89102006)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((pack.PactWordB).WordTxt).text = (PUtil.get)(89102007)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (pack.Explain_A_Btn).text = (PUtil.get)(40002031)
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (pack.Explain_B_Btn).text = (PUtil.get)(40002032)
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (pack.CancelBtn).text = (PUtil.get)(40002033)
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (pack.SureBtn).text = (PUtil.get)(40002034)
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (pack.ChoiceWordTxt).text = (PUtil.get)(40002044)
end

PactWindow.InitBtn = function(...)
  -- function num : 0_3 , upvalues : uis, PactWindow, _ENV
  local pack = uis.Pact
  ;
  ((pack.CloseBtn).onClick):Set(PactWindow.onClickClose)
  ;
  ((pack.CancelBtn).onClick):Set(PactWindow.onClickClose)
  local confirm = (PlayerPrefs.GetString)(Game.ruleAndPrivacy, "false") == "true"
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

  if confirm then
    (pack.ChoiceBtn).touchable = false
    ChangeUIController(pack.root, "c1", 1)
    ;
    ((pack.SureBtn).onClick):Set(function(...)
    -- function num : 0_3_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.PactWindow).name)
  end
)
  else
    ChangeUIController(pack.root, "c1", 0)
    ;
    ((pack.SureBtn).onClick):Set(function(...)
    -- function num : 0_3_1 , upvalues : pack, _ENV
    if (pack.ChoiceBtn).selected == true then
      (PlayerPrefs.SetString)(Game.ruleAndPrivacy, "true")
      UIMgr:CloseWindow((WinResConfig.PactWindow).name)
    end
  end
)
  end
  ;
  ((pack.Explain_A_Btn).onClick):Set(function(...)
    -- function num : 0_3_2 , upvalues : _ENV
    OpenWindow((WinResConfig.ExplainWindow).name, UILayer.HUD1, (PUtil.get)(89102004), (PUtil.get)(40002031))
  end
)
  ;
  ((pack.Explain_B_Btn).onClick):Set(function(...)
    -- function num : 0_3_3 , upvalues : _ENV
    OpenWindow((WinResConfig.ExplainWindow).name, UILayer.HUD1, (PUtil.get)(89102002), (PUtil.get)(40002032))
  end
)
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

PactWindow.onClickClose = function(...)
  -- function num : 0_4 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.PactWindow).name)
end

PactWindow.OnShown = function(...)
  -- function num : 0_5
end

PactWindow.OnHide = function(...)
  -- function num : 0_6
end

PactWindow.OnClose = function(...)
  -- function num : 0_7 , upvalues : uis, contentPane
  uis = nil
  contentPane = nil
end

PactWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_8
  if msgId ~= 1 or msgId == 2 then
  end
end

return PactWindow

