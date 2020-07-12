-- params : ...
-- function num : 0 , upvalues : _ENV
require("Message_popPanelByName")
require("Message_popPanelWindowByName")
RewardDisplayWindow = {}
local uis, wData, btnFuc, title, tips = nil, nil, nil, nil, nil
-- DECOMPILER ERROR at PC11: Confused about usage of register: R5 in 'UnsetPending'

RewardDisplayWindow.OnInit = function(bridge, ...)
  -- function num : 0_0 , upvalues : _ENV, uis, wData, btnFuc, title, tips
  bridge:SetView((WinResConfig.RewardDisplayWindow).package, (WinResConfig.RewardDisplayWindow).comName)
  uis = GetMessage_popPanelWindowUis(bridge.contentPane)
  uis = uis.popPanel
  wData = (MessageMgr.GetRewardData)()
  ;
  (RewardDisplayWindow.InitList)()
  ;
  (RewardDisplayWindow.InitButton)()
  ;
  ((uis.TouchScreenBtn).onClick):Set(function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.RewardDisplayWindow).name)
  end
)
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

  if tips then
    (uis.LockTxt).visible = true
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.LockTxt).text = tips
  else
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.LockTxt).visible = false
  end
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R1 in 'UnsetPending'

  if (uis.ItemList).numItems > 4 then
    (uis.c1Ctr).selectedIndex = 1
  else
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.c1Ctr).selectedIndex = 0
  end
  ;
  (RewardDisplayWindow.InitFunctionControl)()
  ;
  (LuaSound.PlaySound)(LuaSound.COMMON_POP_WIN, SoundBank.OTHER)
end

-- DECOMPILER ERROR at PC14: Confused about usage of register: R5 in 'UnsetPending'

RewardDisplayWindow.InitFunctionControl = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local winName = (WinResConfig.RewardDisplayWindow).name
  local RegisterGuideAndControl = GuideData.RegisterGuideAndControl
  local ControlID = ControlID
  RegisterGuideAndControl(ControlID.RewardGet_GetBtn, uis.ChallengeBtn, winName)
end

-- DECOMPILER ERROR at PC17: Confused about usage of register: R5 in 'UnsetPending'

RewardDisplayWindow.InitList = function(...)
  -- function num : 0_2 , upvalues : _ENV, wData, uis
  local configs = (Util.ParseConfigStr)(wData)
  for _,v in ipairs(configs) do
    local Frame = (Util.CreateFrame)(v[2], false, v[3])
    ;
    (uis.ItemList):AddChild(Frame)
  end
end

-- DECOMPILER ERROR at PC20: Confused about usage of register: R5 in 'UnsetPending'

RewardDisplayWindow.InitButton = function(...)
  -- function num : 0_3 , upvalues : btnFuc, uis
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  if btnFuc then
    (uis.ChallengeBtn).text = btnFuc.btnTxt
    if btnFuc.fun then
      ((uis.ChallengeBtn).onClick):Set(btnFuc.fun)
    else
      -- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (uis.ChallengeBtn).grayed = true
      -- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (uis.ChallengeBtn).touchable = false
    end
  end
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R5 in 'UnsetPending'

RewardDisplayWindow.OnShown = function(...)
  -- function num : 0_4
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R5 in 'UnsetPending'

RewardDisplayWindow.OnHide = function(...)
  -- function num : 0_5
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R5 in 'UnsetPending'

RewardDisplayWindow.OnClose = function(...)
  -- function num : 0_6 , upvalues : uis, wData, btnFuc, _ENV, title, tips
  uis = nil
  wData = nil
  btnFuc = nil
  ;
  (GuideData.AbolishControlRefer)((WinResConfig.RewardDisplayWindow).name)
  title = nil
  tips = nil
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R5 in 'UnsetPending'

RewardDisplayWindow.HandleMessage = function(msgId, state, ...)
  -- function num : 0_7 , upvalues : _ENV, uis
  local windowMsgEnum = WindowMsgEnum.MessageWindow
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  if msgId == windowMsgEnum.E_MSG_REWARD_REFRESH then
    if state then
      (uis.ChallengeBtn).text = (PUtil.get)(20000011)
      -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (uis.ChallengeBtn).grayed = true
      -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (uis.ChallengeBtn).touchable = false
    else
      loge("领取失败")
    end
  end
  if msgId == 2 then
  end
end

return RewardDisplayWindow

