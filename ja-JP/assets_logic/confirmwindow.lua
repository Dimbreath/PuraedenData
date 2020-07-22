-- params : ...
-- function num : 0 , upvalues : _ENV
require("Message_popPanelsmallWindowByName")
local ConfirmWindow = {}
local uis, contentPane, _bridge, _args, _inAnim, _outAnim, _btnCtrl, _costCtrl, _noMoreTipsCtrl = nil, nil, nil, nil, nil, nil, nil, nil, nil
local _costUI = {}
ConfirmWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _bridge
  _bridge = bridgeObj
end

ConfirmWindow.Init = function(contentPanel, ...)
  -- function num : 0_1 , upvalues : contentPane, uis, _ENV, ConfirmWindow
  contentPane = contentPanel
  contentPane.fairyBatching = true
  contentPane:Center()
  uis = GetMessage_popPanelsmallWindowUis(contentPane)
  uis = uis.popPanelsmall
  ;
  (ConfirmWindow.InitVariable)()
  ;
  (ConfirmWindow.InitButtonEvent)()
  ;
  (LuaSound.PlaySound)(LuaSound.COMMON_WARNING, SoundBank.OTHER)
  ld("Guide")
  ;
  (GuideMgr.SetGuideShow)(false)
end

ConfirmWindow.SetArgTable = function(args, ...)
  -- function num : 0_2 , upvalues : _bridge, contentPane, _args, _inAnim, _outAnim
  _bridge.contentPane = args.content
  contentPane = args.content
  _args = args.argTable
  _args.Content = _args[1]
  _args.ConfirmFunc = _args[2]
  _args.Title = _args[3]
  _args.CancelFunc = _args[4]
  _args.ConfirmText = _args[5]
  _args.CancelText = _args[6]
  _args.BothBtn = _args[7] or false
  _args.HaveClose = _args[8] or false
  _args.NoMoreTips = _args[9] or false
  _inAnim = contentPane:GetTransition("in")
  _outAnim = contentPane:GetTransition("out")
end

ConfirmWindow.InitVariable = function(...)
  -- function num : 0_3 , upvalues : uis, _inAnim, _outAnim, _btnCtrl, _costCtrl, _noMoreTipsCtrl, _costUI
  ((uis.root):GetChild("BindingDiamondGrp")).visible = false
  _inAnim = ((uis.root).parent):GetTransition("in")
  _outAnim = ((uis.root).parent):GetTransition("out")
  _btnCtrl = (uis.root):GetController("c1")
  _costCtrl = (uis.root):GetController("c2")
  _noMoreTipsCtrl = (uis.root):GetController("c3")
  local ui = {}
  ui.Loader = uis.BindingDiamondLoader
  ui.Text = uis.BindingDiamondTxt
  _costUI[1] = ui
  ui = {}
  ui.Loader = uis.DiamondLoader
  ui.Text = uis.DiamondTxt
  _costUI[2] = ui
end

ConfirmWindow.InitText = function(...)
  -- function num : 0_4 , upvalues : uis, _args, _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  (uis.WordTxt).text = _args.Content
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

  if (Util.StringIsNullOrEmpty)(_args.Title) then
    (uis.titilenameTxt).text = ((TableData.gTable).BaseClientWordData)[60000003]
  else
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.titilenameTxt).text = _args.Title
  end
  if (Util.StringIsNullOrEmpty)(_args.ConfirmText) then
    ((uis.ChallengeBtn):GetChild("title")).text = ((TableData.gTable).BaseClientWordData)[60000004]
  else
    ;
    ((uis.ChallengeBtn):GetChild("title")).text = _args.ConfirmText
  end
  if (Util.StringIsNullOrEmpty)(_args.CancelText) then
    ((uis.CancleBtn):GetChild("title")).text = ((TableData.gTable).BaseClientWordData)[60000005]
  else
    ;
    ((uis.CancleBtn):GetChild("title")).text = _args.CancelText
  end
  -- DECOMPILER ERROR at PC68: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.SpendTipsTxt).text = (PUtil.get)(60000416)
end

ConfirmWindow.InitButtonEvent = function(...)
  -- function num : 0_5 , upvalues : uis, ConfirmWindow
  ((uis.CloseBtn).onClick):Set(ConfirmWindow.ClickCancelBtn)
  ;
  ((uis.CancleBtn).onClick):Set(ConfirmWindow.ClickCancelBtn)
  ;
  ((uis.ChallengeBtn).onClick):Set(ConfirmWindow.ClickConfirmBtn)
  ;
  ((uis.SpendTipsBtn).onClick):Set(ConfirmWindow.ClickNoMoreTipsBtn)
end

ConfirmWindow.InitUIStatus = function(...)
  -- function num : 0_6 , upvalues : _args, uis, _noMoreTipsCtrl
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

  if _args.HaveClose then
    (uis.CloseBtn).visible = true
  else
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.CloseBtn).visible = false
  end
  if _args.NoMoreTips then
    _noMoreTipsCtrl.selectedIndex = 1
  else
    _noMoreTipsCtrl.selectedIndex = 0
  end
end

ConfirmWindow.InitEvent = function(...)
  -- function num : 0_7
end

ConfirmWindow.RemoveEvent = function(...)
  -- function num : 0_8
end

ConfirmWindow.InitCost = function(...)
  -- function num : 0_9
end

ConfirmWindow.OnShowUp = function(...)
  -- function num : 0_10 , upvalues : ConfirmWindow, _args, _btnCtrl, _bridge
  (ConfirmWindow.InitText)()
  ;
  (ConfirmWindow.InitUIStatus)()
  ;
  (ConfirmWindow.InitEvent)()
  if _args.BothBtn then
    _btnCtrl.selectedIndex = 0
  else
    _btnCtrl.selectedIndex = 1
  end
  _bridge:Show()
end

ConfirmWindow.SetOneCost = function(cost, ui, ...)
  -- function num : 0_11 , upvalues : _ENV
  local url, text = nil, nil
  if cost ~= nil then
    local costInfo = split(cost, ":")
    local configData = (Util.GetConfigDataByID)(tonumber(costInfo[2]))
    url = (Util.GetItemUrl)(configData.icon)
    text = costInfo[3]
  end
  do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (ui.Loader).url = url
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (ui.Text).text = text
  end
end

ConfirmWindow.OnCloseDone = function(...)
  -- function num : 0_12 , upvalues : _bridge, contentPane, _ENV
  _bridge:RemoveChild(contentPane)
  ;
  (MessageMgr.RecycleConfirmWin)(contentPane)
end

ConfirmWindow.ClickCancelBtn = function(...)
  -- function num : 0_13 , upvalues : _args, ConfirmWindow
  local param = _args.CancelFunc
  _args.CancelFunc = nil
  ;
  (ConfirmWindow.CloseWindow)(param)
end

ConfirmWindow.ClickConfirmBtn = function(...)
  -- function num : 0_14 , upvalues : _args, ConfirmWindow
  local param = _args.ConfirmFunc
  _args.ConfirmFunc = nil
  ;
  (ConfirmWindow.CloseWindow)(param)
end

ConfirmWindow.ClickNoMoreTipsBtn = function(...)
  -- function num : 0_15 , upvalues : uis, _ENV
  if (uis.SpendTipsBtn).selected then
    (Util.SetPlayerSetting)(PlayerPrefsKeyName.LOGIN_TIMESTAMP, LoginMgr.curLoginTimestamp)
  else
    ;
    (Util.SetPlayerSetting)(PlayerPrefsKeyName.LOGIN_TIMESTAMP, "")
  end
end

ConfirmWindow.CloseWindow = function(func, ...)
  -- function num : 0_16 , upvalues : _ENV, _outAnim
  if (MessageMgr.GetLeftConfirmAmount)() <= 1 then
    (MessageMgr.CloseConfirm)(nil, function(...)
    -- function num : 0_16_0 , upvalues : func, _ENV
    if func ~= nil and type(func) == "function" then
      func()
    end
  end
)
  else
    _outAnim:Play(function(...)
    -- function num : 0_16_1 , upvalues : _ENV, func
    (MessageMgr.CloseConfirm)()
    if func ~= nil and type(func) == "function" then
      func()
    end
  end
)
  end
end

ConfirmWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_17 , upvalues : _ENV, ConfirmWindow, _inAnim
  if msgId == (WindowMsgEnum.MessageWindow).E_Msg_INIT_CONFIRM then
    (ConfirmWindow.Init)(para)
  else
    if msgId == (WindowMsgEnum.MessageWindow).E_Msg_CHANGE_CONFIRM_ARG then
      (ConfirmWindow.SetArgTable)(para)
    else
      if msgId == (WindowMsgEnum.MessageWindow).E_Msg_SHOW_CONFIRM then
        (ConfirmWindow.OnShowUp)()
      else
        if msgId == (WindowMsgEnum.MessageWindow).E_Msg_CLOSE_CONFIRM then
          (ConfirmWindow.OnCloseDone)()
        else
          if msgId == (WindowMsgEnum.MessageWindow).E_MSG_POP_UP_CONFIRM then
            _inAnim:Play()
          else
            if msgId == (WindowMsgEnum.MessageWindow).E_MSG_CLOSE_CANCEL then
              (ConfirmWindow.ClickCancelBtn)()
            end
          end
        end
      end
    end
  end
end

return ConfirmWindow

