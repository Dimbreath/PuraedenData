-- params : ...
-- function num : 0 , upvalues : _ENV
require("Message_BuyTipsMessageWindowByName")
local BuyTipsMessageWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _costCtrl = nil
local _costUI = {}
BuyTipsMessageWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, BuyTipsMessageWindow
  bridgeObj:SetView((WinResConfig.BuyTipsMessageWindow).package, (WinResConfig.BuyTipsMessageWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetMessage_BuyTipsMessageWindowUis(contentPane)
  ;
  (BuyTipsMessageWindow.InitVariable)()
  ;
  (BuyTipsMessageWindow.InitText)()
  ;
  (BuyTipsMessageWindow.InitButtonEvent)()
  ;
  (LuaSound.PlaySound)(LuaSound.COMMON_POP_WIN, SoundBank.OTHER)
end

BuyTipsMessageWindow.InitVariable = function(...)
  -- function num : 0_1 , upvalues : uis, _costUI, _costCtrl
  local ui = {}
  ui.Loader = (uis.TipsMessage).BindingDiamondLoader
  ui.Text = (uis.TipsMessage).BindingDiamondTxt
  _costUI[1] = ui
  ui = {}
  ui.Loader = (uis.TipsMessage).DiamondLoader
  ui.Text = (uis.TipsMessage).DiamondTxt
  _costUI[2] = ui
  _costCtrl = ((uis.TipsMessage).root):GetController("c1")
  _costCtrl.selectedIndex = 0
end

BuyTipsMessageWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.TipsMessage).titilenameTxt).text = (PUtil.get)(60000486)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.TipsMessage).BuyBtn).text = (PUtil.get)(60000045)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.TipsMessage).Word_01_Txt).text = (PUtil.get)(60000046)
end

BuyTipsMessageWindow.InitButtonEvent = function(...)
  -- function num : 0_3 , upvalues : uis, BuyTipsMessageWindow
  (((uis.TipsMessage).CloseBtn).onClick):Add(BuyTipsMessageWindow.ClickCloseBtn)
  ;
  (((uis.TipsMessage).BuyBtn).onClick):Add(BuyTipsMessageWindow.ClickBuyBtn)
  ;
  (((uis.TipsMessage).MaxBtn).onClick):Add(BuyTipsMessageWindow.ClickMaxBtn)
  ;
  (((uis.TipsMessage).AddBtn).onClick):Add(BuyTipsMessageWindow.ClickIncreaseBtn)
  ;
  (((uis.TipsMessage).MinBtn).onClick):Add(BuyTipsMessageWindow.Click10TimesBtn)
  ;
  (((uis.TipsMessage).ReduceBtn).onClick):Add(BuyTipsMessageWindow.ClickDecreaseBtn)
end

BuyTipsMessageWindow.InitEvent = function(...)
  -- function num : 0_4
end

BuyTipsMessageWindow.RemoveEvent = function(...)
  -- function num : 0_5
end

BuyTipsMessageWindow.OnShown = function(...)
  -- function num : 0_6 , upvalues : BuyTipsMessageWindow
  (BuyTipsMessageWindow.InitEvent)()
  ;
  (BuyTipsMessageWindow.Init)()
end

BuyTipsMessageWindow.OnHide = function(...)
  -- function num : 0_7 , upvalues : BuyTipsMessageWindow
  (BuyTipsMessageWindow.RemoveEvent)()
end

BuyTipsMessageWindow.Init = function(...)
  -- function num : 0_8 , upvalues : uis, argTable, BuyTipsMessageWindow
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.TipsMessage).NumberTxt).text = argTable[1]
  ;
  (BuyTipsMessageWindow.InitTimes)(argTable[2])
  ;
  (BuyTipsMessageWindow.SetCostResources)(argTable[3])
end

BuyTipsMessageWindow.InitTimes = function(times, ...)
  -- function num : 0_9 , upvalues : uis
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((uis.TipsMessage).ChangeNumberTxt).text = times
end

BuyTipsMessageWindow.SetCostResources = function(cost, ...)
  -- function num : 0_10 , upvalues : BuyTipsMessageWindow, _ENV, _costUI
  (BuyTipsMessageWindow.SetOneCost)((cost.cost)[1], cost.statue ~= BuyTimesStatue.NotEnough, _costUI[1])
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BuyTipsMessageWindow.SetOneCost = function(cost, enough, ui, ...)
  -- function num : 0_11 , upvalues : _ENV
  local url, text = nil, nil
  do
    if cost ~= nil then
      local ConfigData = (Util.GetConfigDataByID)(cost.Type)
      url = (Util.GetItemUrl)(ConfigData.icon)
      text = cost.Amount
    end
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (ui.Loader).url = url
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R5 in 'UnsetPending'

    if enough == false then
      (ui.Text).text = "[color=" .. Const.RedColor .. "]" .. text .. "[/color]"
    else
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (ui.Text).text = text
    end
  end
end

BuyTipsMessageWindow.OnClose = function(...)
  -- function num : 0_12 , upvalues : uis, contentPane
  uis = nil
  contentPane = nil
end

BuyTipsMessageWindow.ClickIncreaseBtn = function(...)
  -- function num : 0_13 , upvalues : _ENV
  (MessageMgr.IncreaseBuyTime)(true)
end

BuyTipsMessageWindow.Click10TimesBtn = function(...)
  -- function num : 0_14 , upvalues : _ENV
  (MessageMgr.Increase10BuyTime)()
end

BuyTipsMessageWindow.ClickDecreaseBtn = function(...)
  -- function num : 0_15 , upvalues : _ENV
  (MessageMgr.DecreaseBuyTime)()
end

BuyTipsMessageWindow.ClickMaxBtn = function(...)
  -- function num : 0_16 , upvalues : _ENV
  (MessageMgr.MaxBuyTime)()
end

BuyTipsMessageWindow.ClickBuyBtn = function(...)
  -- function num : 0_17 , upvalues : _ENV
  if (MessageMgr.TryBuyTimes)() then
    UIMgr:CloseWindow((WinResConfig.BuyTipsMessageWindow).name)
  end
end

BuyTipsMessageWindow.ClickCloseBtn = function(...)
  -- function num : 0_18 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.BuyTipsMessageWindow).name)
end

BuyTipsMessageWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_19 , upvalues : _ENV, BuyTipsMessageWindow
  if msgId == (WindowMsgEnum.MessageWindow).E_Msg_REFRESH_BUY_TIMES then
    (BuyTipsMessageWindow.InitTimes)(para)
  else
    if msgId == (WindowMsgEnum.MessageWindow).E_Msg_REFRESH_BUY_COSTS then
      (BuyTipsMessageWindow.SetCostResources)(para)
    end
  end
end

return BuyTipsMessageWindow

