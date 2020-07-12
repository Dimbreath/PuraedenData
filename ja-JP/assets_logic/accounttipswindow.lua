-- params : ...
-- function num : 0 , upvalues : _ENV
require("Activity_AccountTipsWindowByName")
local AccountTipsWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
AccountTipsWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, AccountTipsWindow
  bridgeObj:SetView((WinResConfig.AccountTipsWindow).package, (WinResConfig.AccountTipsWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetActivity_AccountTipsWindowUis(contentPane)
  uis = uis.AccountTips
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.TitleTxt).text = (PUtil.get)(20000503)
  ;
  (AccountTipsWindow.InitBtn)()
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R1 in 'UnsetPending'

  if Application.platform == RuntimePlatform.Android then
    (uis.WordTxt).text = (PUtil.get)(20000505)
  else
    -- DECOMPILER ERROR at PC50: Confused about usage of register: R1 in 'UnsetPending'

    if Application.platform == RuntimePlatform.IPhonePlayer then
      (uis.WordTxt).text = (PUtil.get)(20000509)
    else
      -- DECOMPILER ERROR at PC57: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (uis.WordTxt).text = (PUtil.get)(20000505)
    end
  end
end

AccountTipsWindow.InitBtn = function(...)
  -- function num : 0_1 , upvalues : uis, _ENV
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_1_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.AccountTipsWindow).name)
  end
)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.BattleOutBtn).text = (PUtil.get)(20000502)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.SureBtn).text = (PUtil.get)(20000016)
  ;
  ((uis.BattleOutBtn).onClick):Set(function(...)
    -- function num : 0_1_1 , upvalues : _ENV
    if Game.useSDK == true then
      (SuperSDKUtil.OpenCustomServer)()
    end
  end
)
  ;
  ((uis.SureBtn).onClick):Set(function(...)
    -- function num : 0_1_2 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.AccountTipsWindow).name)
  end
)
end

AccountTipsWindow.OnShown = function(...)
  -- function num : 0_2
end

AccountTipsWindow.OnHide = function(...)
  -- function num : 0_3
end

AccountTipsWindow.OnClose = function(...)
  -- function num : 0_4 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

AccountTipsWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_5
end

return AccountTipsWindow

