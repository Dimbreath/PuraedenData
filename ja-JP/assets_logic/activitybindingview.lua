-- params : ...
-- function num : 0 , upvalues : _ENV
require("Activity_BindingByName")
local ActivityBindingView = {}
local uis = {}
ActivityBindingView.OnInit = function(obj, ...)
  -- function num : 0_0 , upvalues : uis, _ENV, ActivityBindingView
  uis = GetActivity_BindingUis(obj)
  ;
  (ActivityBindingView.UpdateBtn)()
  ;
  (ActivityBindingView.SetEvent)()
end

ActivityBindingView.UpdateBtn = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  do
    if Game.useSDK == true then
      local isGuest = (SuperSDKUtil.IsGuest)()
      if isGuest == true then
        ChangeController(uis.c1Ctr, 0)
      else
        ChangeController(uis.c1Ctr, 1)
      end
    end
    loge("是否已经领取：")
    loge(tostring((ActorData.GetBindRewardGet)()))
    if (ActorData.GetBindRewardGet)() == true then
      ChangeController(uis.c1Ctr, 2)
    end
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.PassWordBtn).visible = false
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.SDKBtn).x = 731
  end
end

ActivityBindingView.SetEvent = function(...)
  -- function num : 0_2 , upvalues : uis, ActivityBindingView, _ENV
  ((uis.PassWordBtn).onClick):Set(ActivityBindingView.OnClickPass)
  ;
  ((uis.SDKBtn).onClick):Set(ActivityBindingView.OnClickSDK)
  ;
  ((uis.GetBtn).onClick):Set(ActivityBindingView.OnClickGet)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.PassWordBtn).text = (PUtil.get)(20000495)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.SDKBtn).text = (PUtil.get)(20000497)
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.GetBtn).text = (PUtil.get)(20000496)
  local accountBtn = (uis.root):GetChild("AccountTipsBtn")
  accountBtn.text = (PUtil.get)(20000508)
  ;
  (accountBtn.onClick):Set(function(...)
    -- function num : 0_2_0 , upvalues : _ENV
    OpenWindow((WinResConfig.AccountTipsWindow).name, UILayer.HUD1)
  end
)
end

ActivityBindingView.OnClickPass = function(...)
  -- function num : 0_3 , upvalues : _ENV
  OpenWindow((WinResConfig.ActivityPassWordWindow).name, UILayer.HUD)
end

ActivityBindingView.OnClickSDK = function(...)
  -- function num : 0_4 , upvalues : _ENV
  if Game.useSDK == true then
    local isGuest = (SuperSDKUtil.IsGuest)()
    if isGuest == true then
      (SuperSDKUtil.BindAccount)()
    end
  end
end

ActivityBindingView.OnClickGet = function(...)
  -- function num : 0_5 , upvalues : _ENV
  if Game.useSDK == true and (ActorData.GetBindRewardGet)() ~= true then
    (LoginService.ReqGetBindReward)()
  end
end

ActivityBindingView.OnClose = function(...)
  -- function num : 0_6 , upvalues : uis
  uis = nil
end

ActivityBindingView.HandleMessage = function(msgId, para, ...)
  -- function num : 0_7 , upvalues : _ENV, ActivityBindingView
  loge("绑定界面刷新：" .. msgId)
  if msgId == 1 then
    (ActivityBindingView.UpdateBtn)()
  end
end

return ActivityBindingView

