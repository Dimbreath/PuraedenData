-- params : ...
-- function num : 0 , upvalues : _ENV
HomeMgr = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

HomeMgr.OpenHome = function(...)
  -- function num : 0_0 , upvalues : _ENV
  local isOpen = UIMgr:IsWindowOpen("HomeWindow")
  -- DECOMPILER ERROR at PC19: Unhandled construct in 'MakeBoolean' P1

  if isOpen == true and UIMgr:IsWindowOpen((WinResConfig.LoadingWindow).name) == true then
    UIMgr:CloseWindow((WinResConfig.LoadingWindow).name)
  end
  UIMgr:SendWindowMessage((WinResConfig.HomeWindow).name, (WindowMsgEnum.HomeWindow).E_MSG_RESET_TASK_SPINE)
  OpenWindow("HomeWindow", UILayer.HUD)
  if Game.useSDK == true then
    (SuperSDKUtil.SendOpenHomePage)()
  end
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

HomeMgr.PreLoadCardSpine = function(createGameObject, ...)
  -- function num : 0_1
end


