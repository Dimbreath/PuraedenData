-- params : ...
-- function num : 0 , upvalues : _ENV
require("Land_LandByName")
require("Land_LandTestByName")
Vector2 = (CS.UnityEngine).Vector2
local LoginWindow = {}
local uis, contentPane, NameTxt = nil, nil, nil
local LoginMgr = LoginMgr
local bgConfig = {
day = {
{"Day_1", -5555}
, 
{"Day_2", -2500}
, 
{"Day_3", 5555}
}
, 
night = {
{"Night_1", -5555}
, 
{"Night_2", -2500}
, 
{"Night_3", 5555}
, 
{"Night_4", 8000}
}
}
local bgList = {}
local lastX, lastY = nil, nil
LoginWindow.ShowBg = function(...)
  -- function num : 0_0 , upvalues : LoginWindow, _ENV, bgConfig, contentPane, bgList
  (LoginWindow.StartBgMove)()
  local Config = nil
  local hour = tonumber((os.date)("%H"))
  local isNight = hour < 8
  if isNight == true then
    Config = bgConfig.night
  else
    Config = bgConfig.day
  end
  for _,v in ipairs(Config) do
    local resPath = v[1]
    local ratio = v[2]
    local pic = UIMgr:CreateObject("LandPic", resPath)
    contentPane:AddChildAt(pic, 0)
    pic:Center()
    ;
    (table.insert)(bgList, {bg = pic, ratio = ratio})
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

LoginWindow.BgMove = function(gyro, ...)
  -- function num : 0_1 , upvalues : lastX, lastY, _ENV, bgList
  local eulerAngles = gyro.rotationRateUnbiased
  if lastX == nil or lastY == nil then
    lastX = eulerAngles.x
    lastY = eulerAngles.y
    return 
  end
  if (math.abs)(eulerAngles.x) < 0.2 and (math.abs)(eulerAngles.y) < 0.2 then
    return 
  end
  for _,bgInfo in ipairs(bgList) do
    local bg = bgInfo.bg
    local ratio = bgInfo.ratio
    local targetX = bg.x + eulerAngles.y * ratio / 10000
    local targetY = bg.y + eulerAngles.x * ratio / 10000
    bg.x = targetX
    bg.y = targetY
  end
  lastX = eulerAngles.x
  lastY = eulerAngles.y
end

LoginWindow.StartBgMove = function(...)
  -- function num : 0_2 , upvalues : _ENV, LoginWindow
  ((CS.InputGyroscope).Singleton):AddAction(LoginWindow.BgMove)
end

LoginWindow.StopBgMove = function(...)
  -- function num : 0_3 , upvalues : _ENV, LoginWindow
  ((CS.InputGyroscope).Singleton):RemoveAction(LoginWindow.BgMove)
end

local bgConfigTemp = {
{bg = "Day_1", icon = "Day_2"}
, 
{bg = "Evening_1", icon = "Evening_2"}
, 
{bg = "CBTNight_1", icon = "CBTNight_2"}
}
LoginWindow.ShowBgTemp = function(...)
  -- function num : 0_4 , upvalues : _ENV, bgConfigTemp, contentPane
  local hour = (tonumber((os.date)("%H")))
  local index = nil
  if hour >= 6 and hour < 16 then
    index = 1
  else
    if hour >= 16 and hour < 21 then
      index = 2
    else
      index = 3
    end
  end
  local config = bgConfigTemp[index]
  local picIcon = UIMgr:CreateObject("LandPic", config.icon)
  contentPane:AddChildAt(picIcon, 0)
  picIcon:Center()
  local LuaEffect = require("LuaEffect")
  ResHelper = CS.ResHelper
  local effect = (LuaEffect.AddUIEffect)("FX_testloading_dis", false)
  effect:SetXY(DesignScreen.width / 2 + (ResolutionHandler.AdaptOffset).X, DesignScreen.height / 2 + (ResolutionHandler.AdaptOffset).Y)
  contentPane:AddChildAt(effect, 0)
  local picBg = UIMgr:CreateObject("LandPic", config.bg)
  contentPane:AddChildAt(picBg, 0)
  picBg:Center()
end

LoginWindow.ReInitData = function(...)
  -- function num : 0_5
end

LoginWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_6 , upvalues : LoginMgr, _ENV, contentPane, uis, LoginWindow
  LoginMgr.lastOnlineHour = nil
  ResHelper = CS.ResHelper
  ;
  (ResHelper.ClearAllCache)()
  LoginMgr.canTouch = true
  bridgeObj:SetView((WinResConfig.LoginWindow).package, (WinResConfig.LoginWindow).comName)
  contentPane = bridgeObj.contentPane
  contentPane:Center()
  uis = GetLand_LandUis(contentPane)
  ;
  (LoginWindow.ShowBg)()
  ;
  (LoginWindow.InitVersionAndAccount)()
  ;
  (LoginWindow.ShowTestLogin)()
  ;
  (LoginWindow.InitBtn)()
  LoginMgr.directLogin = false
  ld("Overture", function(...)
    -- function num : 0_6_0 , upvalues : _ENV
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

    OvertureMgr.isPlaying = false
  end
)
  ld("Guide", function(...)
    -- function num : 0_6_1 , upvalues : _ENV
    UIMgr:SendWindowMessage((WinResConfig.GuideWindow).name, (WindowMsgEnum.GuideWindow).GUIDE_FINISH)
  end
)
  ld("Announcement", function(...)
    -- function num : 0_6_2 , upvalues : _ENV
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

    AnnouncementData.AutoShowAnnouncement = true
  end
)
  local ResendPak = require("ResendPak")
  ;
  (ResendPak.ClearResendPak)()
  ;
  (SimpleTimer.setTimeout)(0.01, function(...)
    -- function num : 0_6_3 , upvalues : _ENV
    (SuperSDKUtil.OpenLoginPage)()
    if LuaSound then
      local hour = (tonumber((os.date)("%H")))
      local index = nil
      if hour >= 6 and hour < 18 then
        (LuaSound.LoadAndPlayBGM)(1010007)
      else
        ;
        (LuaSound.LoadAndPlayBGM)(1010008)
      end
    end
  end
)
end

LoginWindow.ShowTestLogin = function(...)
  -- function num : 0_7 , upvalues : _ENV, contentPane, NameTxt, LoginWindow
  if Game.testPackage == true then
    return 
  end
  local ui = UIMgr:CreateObject((WinResConfig.LoginWindow).package, "LandTest")
  if ui == nil then
    return 
  end
  ui:SetXY(0, 200)
  contentPane:AddChild(ui)
  local uis = GetLand_LandTestUis(ui)
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.NameTxt).text = (PlayerPrefs.GetString)(PlayerPrefsKeyName.LOGIN_ACCOUNT_SAVE, tostring((math.ceil)((math.random)(10, 10000))))
  NameTxt = uis.NameTxt
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.LinkStartBtn).text = (urlList.aliyun).btnName
  ;
  ((uis.LinkStartBtn).onClick):Add(function(...)
    -- function num : 0_7_0 , upvalues : LoginWindow, _ENV
    (LoginWindow.onClickLoginBtn)(urlList.aliyun)
  end
)
  -- DECOMPILER ERROR at PC59: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.LinkStart4Btn).text = (urlList.dashixiong).btnName
  ;
  ((uis.LinkStart4Btn).onClick):Add(function(...)
    -- function num : 0_7_1 , upvalues : LoginWindow, _ENV
    (LoginWindow.onClickLoginBtn)(urlList.dashixiong)
  end
)
  -- DECOMPILER ERROR at PC69: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.LinkStart3Btn).text = (urlList.ershixiong).btnName
  ;
  ((uis.LinkStart3Btn).onClick):Add(function(...)
    -- function num : 0_7_2 , upvalues : LoginWindow, _ENV
    (LoginWindow.onClickLoginBtn)(urlList.ershixiong)
  end
)
  -- DECOMPILER ERROR at PC79: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.LinkStart2Btn).text = (urlList.gangdezong).btnName
  ;
  ((uis.LinkStart2Btn).onClick):Add(function(...)
    -- function num : 0_7_3 , upvalues : LoginWindow, _ENV
    (LoginWindow.onClickLoginBtn)(urlList.gangdezong)
  end
)
  -- DECOMPILER ERROR at PC89: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.LinkStart1Btn).text = (urlList.shaowei).btnName
  ;
  ((uis.LinkStart1Btn).onClick):Add(function(...)
    -- function num : 0_7_4 , upvalues : LoginWindow, _ENV
    (LoginWindow.onClickLoginBtn)(urlList.shaowei)
  end
)
  -- DECOMPILER ERROR at PC99: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.LinkStart5Btn).text = (urlList.shaojun).btnName
  ;
  ((uis.LinkStart5Btn).onClick):Add(function(...)
    -- function num : 0_7_5 , upvalues : LoginWindow, _ENV
    (LoginWindow.onClickLoginBtn)(urlList.shaojun)
  end
)
  -- DECOMPILER ERROR at PC109: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.LinkStart6Btn).text = (urlList.ershixiong_linux).btnName
  ;
  ((uis.LinkStart6Btn).onClick):Add(function(...)
    -- function num : 0_7_6 , upvalues : LoginWindow, _ENV
    (LoginWindow.onClickLoginBtn)(urlList.ershixiong_linux)
  end
)
  -- DECOMPILER ERROR at PC119: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.LinkStart7Btn).text = (urlList.cehua).btnName
  ;
  ((uis.LinkStart7Btn).onClick):Add(function(...)
    -- function num : 0_7_7 , upvalues : LoginWindow, _ENV
    (LoginWindow.onClickLoginBtn)(urlList.cehua)
  end
)
end

LoginWindow.InitBg = function(...)
  -- function num : 0_8 , upvalues : uis
  local PicLoader = uis.PicLoader
end

LoginWindow.InitVersionAndAccount = function(...)
  -- function num : 0_9 , upvalues : _ENV, uis
  local launch = (CS.Launch).Singleton
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.VersionTxt).text = "VER  " .. Application.version .. "." .. launch.resVersion
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.IDTxt).text = ""
end

LoginWindow.InitBtn = function(...)
  -- function num : 0_10 , upvalues : uis, _ENV, LoginWindow
  local SetBtn = uis.SetBtn
  SetBtn.text = (PUtil.get)(40002050)
  ;
  (SetBtn.onClick):Set(LoginWindow.onClickSetBtn)
  local mBtn = (uis.root):GetChild("ServiceBtn")
  mBtn.text = (PUtil.get)(20000501)
  ;
  (mBtn.onClick):Set(function(...)
    -- function num : 0_10_0 , upvalues : _ENV
    OpenWindow((WinResConfig.AccountTipsWindow).name, UILayer.HUD1)
  end
)
  if Game.testPackage == true then
    ((uis.TouchBtn).onClick):Set(function(...)
    -- function num : 0_10_1 , upvalues : _ENV, LoginWindow
    local authUrl = GetAuthUrl()
    if authUrl then
      (LoginWindow.onClickLoginBtn)({url = authUrl})
    end
  end
)
  end
end

LoginWindow.onClickSetBtn = function(...)
  -- function num : 0_11 , upvalues : _ENV
  local winName = (WinResConfig.LoginSetWindow).name
  if UIMgr:IsWindowOpen(winName) ~= true then
    OpenWindow(winName, UILayer.HUD)
  end
end

LoginWindow.CheckRuleAndPrivacy = function(...)
  -- function num : 0_12 , upvalues : _ENV
  local record = (PlayerPrefs.GetString)(Game.ruleAndPrivacy, "false")
  if record == "false" then
    OpenWindow((WinResConfig.PactWindow).name, UILayer.HUD)
    return false
  end
  return true
end

LoginWindow.onClickLoginBtn = function(urlInfo, ...)
  -- function num : 0_13 , upvalues : LoginWindow, LoginMgr, _ENV
  local check = (LoginWindow.CheckRuleAndPrivacy)()
  if check == false then
    return 
  end
  if LoginMgr.canTouch == false then
    return 
  end
  LoginMgr.canTouch = false
  ;
  (ActorData.InitActorData)()
  ld("Guide", function(...)
    -- function num : 0_13_0 , upvalues : _ENV
    (GuideMgr.ClearAllGuideData)()
    ;
    (GuideMgr.InitBaseGuideProcessData)()
  end
)
  local launch = (CS.Launch).Singleton
  ;
  (MessageMgr.ClearAll)()
  LoginMgr.selectUrlInfo = urlInfo
  LoginMgr.tempNameTxt = nil
  launch:DownloadWithLogin(function(...)
    -- function num : 0_13_1 , upvalues : _ENV, LoginMgr, urlInfo, LoginWindow
    if Game.useSDK == true then
      if (SuperSDKData.AlreadyLogin)() == true then
        (LoginMgr.StartLogin)(urlInfo)
      else
        LoginMgr.directLogin = true
        local userId = (PlayerPrefs.GetString)("OSDK_USER_ID", "")
        print("获取 OSDK_USER_ID：", userId)
        if userId == "" then
          (SuperSDKUtil.GuestLogin)()
        else
          ;
          (SuperSDKUtil.Login)()
        end
        LoginMgr.canTouch = true
      end
    else
      do
        ;
        (LoginMgr.StartLogin)(urlInfo, (LoginWindow.GetNameTxt)())
      end
    end
  end
)
end

LoginWindow.GetNameTxt = function(...)
  -- function num : 0_14 , upvalues : _ENV, NameTxt
  if Game.testPackage == true then
    if Game.useSDK == true then
      return ""
    else
      return (PlayerPrefs.GetString)(PlayerPrefsKeyName.LOGIN_ACCOUNT_SAVE, tostring((math.ceil)((math.random)(10, 10000))))
    end
  else
    return NameTxt and NameTxt.text or ""
  end
end

LoginWindow.OnShown = function(...)
  -- function num : 0_15
end

LoginWindow.OnHide = function(...)
  -- function num : 0_16
end

LoginWindow.OnClose = function(...)
  -- function num : 0_17 , upvalues : _ENV, LoginWindow, bgList, lastX, lastY, LoginMgr, uis, contentPane, NameTxt
  if LuaSound then
    (LuaSound.StopBGM)()
  end
  ;
  (LoginWindow.StopBgMove)()
  bgList = {}
  lastX = nil
  LoginMgr.canTouch = true
  uis = nil
  contentPane = nil
  NameTxt = nil
end

LoginWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_18
  if msgId ~= 1 or msgId == 2 then
  end
end

return LoginWindow

