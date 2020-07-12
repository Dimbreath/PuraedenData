-- params : ...
-- function num : 0 , upvalues : _ENV
require("Share_ShareMainByName")
local ShareMainWindow = {}
local uis, contentPane, bridge, argTable, screenShot, shotBtn, logo, code, path = nil, nil, nil, nil, nil, nil, nil, nil, nil
ShareMainWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, bridge, argTable, uis, shotBtn, logo, code, path
  bridgeObj:SetView((WinResConfig.ShareMainWindow).package, (WinResConfig.ShareMainWindow).comName)
  contentPane = bridgeObj.contentPane
  bridge = bridgeObj
  argTable = bridgeObj.argTable
  uis = GetShare_ShareMainUis(contentPane)
  if argTable[1] then
    shotBtn = argTable[1]
  end
  if argTable[2] then
    logo = argTable[2]
  end
  if argTable[3] then
    code = argTable[3]
  end
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.PreserveBtn).visible = false
  path = ((CS.ScreenShotManager).Instance):GetPhotoPath()
  local tex = ((CS.ScreenShotManager).Instance):GetShoot()
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R2 in 'UnsetPending'

  if tex then
    ((uis.Shot).ShotLoader).fill = (FairyGUI.FillType).ScaleNoBorder
    -- DECOMPILER ERROR at PC55: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((uis.Shot).ShotLoader).texture = tex
  end
  ;
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.ShareMainWindow).name)
  end
)
  ;
  ((uis.FacebookBtn).onClick):Set(function(...)
    -- function num : 0_0_1 , upvalues : _ENV, path
    (SuperSDKUtil.SendShare)(path, SuperSDKConst.SHARE_PLATFORM_FACEBOOK)
  end
)
  contentPane:Center()
  ;
  ((uis.LineBtn).onClick):Set(function(...)
    -- function num : 0_0_2 , upvalues : _ENV, path
    (SuperSDKUtil.SendShare)(path, SuperSDKConst.SHARE_PLATFORM_LINE)
  end
)
  ;
  ((uis.TwitterBtn).onClick):Set(function(...)
    -- function num : 0_0_3 , upvalues : _ENV, path
    (SuperSDKUtil.SendShare)(path, SuperSDKConst.SHARE_PLATFORM_TWITTER)
  end
)
end

ShareMainWindow.OnClose = function(...)
  -- function num : 0_1 , upvalues : shotBtn, logo, code, contentPane, bridge, argTable, _ENV
  if shotBtn ~= nil then
    shotBtn.visible = true
  end
  if logo ~= nil then
    logo.visible = false
  end
  if code ~= nil then
    code.visible = false
  end
  shotBtn = nil
  logo = nil
  code = nil
  contentPane = nil
  bridge = nil
  argTable = nil
  ;
  ((CS.ScreenShotManager).Instance):ClearTexture()
  ;
  ((CS.ScreenShotManager).Instance):HideOrShowBackGroundCamera(true)
end

return ShareMainWindow

