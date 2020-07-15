-- params : ...
-- function num : 0 , upvalues : _ENV
local a = (os.clock)()
local CS = CS
local require = require
log = (CS.Debugger).Log
loge = (CS.Debugger).LogError
logw = (CS.Debugger).LogWarning
;
(math.randomseed)((os.time)())
Game = {resolutionRatioMax = 10000, resolutionRatioMin = 5500, defaultBattleFrame = "0", defaultPlotCharacterType = 2, lua_name = ".lua", testPackage = true, enableGM = false, jumpOverture = false, jumpNewHand = false, ruleAndPrivacy = "RuleAndPrivacy1", timeZone = 9}
local Game = Game
DesignScreen = {width = 1334, height = 750}
ld = function(folder_name, callBack, ...)
  -- function num : 0_0 , upvalues : _ENV, require
  if folder_name == nil then
    print("传入的module name 为空")
    return 
  end
  local lua_str = folder_name .. "ScriptList"
  if (package.loaded)[lua_str] ~= nil then
    if callBack then
      callBack()
    end
    return 
  end
  if lua_str then
    local modul = require(lua_str)
    if modul == nil then
      loge("没有加载到对应的模块，模块名字：" .. folder_name)
    else
      if callBack then
        callBack()
      end
    end
  end
end

SystemInfo = (CS.UnityEngine).SystemInfo
Time = (CS.UnityEngine).Time
UpdateMgr = require("UpdateManager")
PlayerPrefs = (CS.UnityEngine).PlayerPrefs
Vector2 = (CS.UnityEngine).Vector2
Vector3 = (CS.UnityEngine).Vector3
Application = (CS.UnityEngine).Application
RuntimePlatform = (CS.UnityEngine).RuntimePlatform
FairyGUI = CS.FairyGUI
UIPackage = FairyGUI.UIPackage
SDKUtil = CS.SDKUtil
CSBaseConfig = (CS.BaseConfig).Singleton
Net = require("Net")
require("UIHelper")
SimpleTimer = require("SimpleTimer")
TableData = require("TableData")
Util = require("Util")
require("GlobalConfig")
ResolutionHandler = require("ResolutionHandler")
local LoadCSVar = function(...)
  -- function num : 0_1 , upvalues : _ENV, CS
  Camera = (CS.UnityEngine).Camera
  KeyCode = (CS.UnityEngine).KeyCode
  Input = (CS.UnityEngine).Input
  GRoot = FairyGUI.GRoot
  ResHelper = CS.ResHelper
  Umath = (CS.UnityEngine).Mathf
  LeanTween = CS.LeanTween
  LeanTweenType = CS.LeanTweenType
  SkeletonAnimationUtil = CS.SkeletonAnimationUtil
  CSLuaUtil = CS.LuaUtil
  Screen = (CS.UnityEngine).Screen
  GameObject = (CS.UnityEngine).GameObject
  RedDotManager = (CS.RedDotManager).Singleton
  PostManager = (CS.PostManager).Instance
end

collectgarbage("setpause", 100)
collectgarbage("setstepmul", 500)
local LoadScript = function(...)
  -- function num : 0_2 , upvalues : require, _ENV
  require("PrintTable")
  require("EventID")
  Const = require("Const")
  LuaTime = require("LuaTime")
  LuaEffect = require("LuaEffect")
  LuaSound = require("LuaSound")
  AudioManager = require("AudioManager")
  MessageMgr = require("MessageMgr")
  CommonWinMgr = require("CommonWinMgr")
  EventHelper = require("EventHelper")
  Json = require("Json")
end

local InitSound = function(...)
  -- function num : 0_3 , upvalues : _ENV, CS
  local UIConfig = FairyGUI.UIConfig
  local NAudioClip = FairyGUI.NAudioClip
  local AudioMgr = (CS.AudioAssetManager).Singleton
  local LuaSound = LuaSound
  UIConfig.fmod = true
  if UIConfig.fmod == true then
    UIConfig.buttonSoundFMOD = LuaSound.COMMON_BTN_CLICK
    UIConfig.buttonCheckSoundFMOD = LuaSound.COMMON_SELECT_CLICK
    UIConfig.buttonRadioSoundFMOD = LuaSound.COMMON_TAB_CLICK
  else
    local ac = AudioMgr:GetAudioClip(LuaSound.COMMON_BTN_CLICK)
    if ac ~= nil then
      UIConfig.buttonSound = NAudioClip(ac)
    end
    local ac = AudioMgr:GetAudioClip(LuaSound.COMMON_SELECT_CLICK)
    if ac ~= nil then
      UIConfig.buttonCheckSound = NAudioClip(ac)
    end
    local ac = AudioMgr:GetAudioClip(LuaSound.COMMON_TAB_CLICK)
    if ac ~= nil then
      UIConfig.buttonRadioSound = NAudioClip(ac)
    end
  end
end

local InitCamera = function(...)
  -- function num : 0_4 , upvalues : _ENV, Game
  local GameObject = GameObject
  local backGroundCamera = (GameObject.Find)("GameBackgroundCamera")
  if backGroundCamera then
    backGroundCamera:SetActive(false)
  end
  local skillCamera = (GameObject.Find)("SkillCamera")
  Game.skillCamera = skillCamera
  ;
  (Util.SetCameraActive)(skillCamera, false)
  local skillRoleCamera = (GameObject.Find)("SkillRoleCamera")
  Game.skillRoleCamera = skillRoleCamera
  local skillBgCamera = (GameObject.Find)("SkillBgCamera")
  Game.skillBgCamera = skillBgCamera
  ;
  (Util.SetCameraActive)(skillBgCamera, false)
  local battleCamera = (GameObject.Find)("BattleCamera")
  Game.battleCamera = battleCamera
  ;
  (Util.SetCameraActive)(battleCamera, false)
  local component = battleCamera:GetComponent("Camera")
  component.enabled = true
  local battleRightCamera = (GameObject.Find)("BattleRightCamera")
  Game.battleRightCamera = battleRightCamera
  ;
  (Util.SetCameraActive)(battleRightCamera, false)
  local mainCamera = (GameObject.Find)("MainCamera")
  Game.mainCamera = mainCamera
  ;
  (mainCamera.gameObject):SetActive(false)
  Game.uiCamera = (GameObject.FindWithTag)("UICamera")
end

local LoadLuaScript = function(...)
  -- function num : 0_5 , upvalues : _ENV, Game
  UIMgr:LoadPackage("Tool")
  UIMgr:LoadPackage("CardHeadIconSquare")
  UIMgr:LoadPackage("CardHeadSliver")
  UIMgr:LoadPackage("ItemIcon")
  UIMgr:LoadPackage("ArtText")
  UIMgr:LoadPackage("UiArtNumber")
  UIMgr:LoadPackage("Guide")
  UIMgr:LoadPackage("UIBackground495x225")
  UIMgr:LoadPackage("UIBackground990x450")
  UIMgr:LoadPackage("Message")
  UIMgr:LoadPackage("LotteryLines")
  local wh = Screen.width / Screen.height
  Game.isPad = wh < 1.35
  Game.useSDK = SDKUtil.useSDK
  ld("Actor")
  ld("Pay")
  if Game.useSDK == true then
    ld("SuperSDK")
    ;
    (SuperSDKMgr.InitSDKCallback)()
    ;
    (SuperSDKData.Init)()
    local userId = (PlayerPrefs.GetString)("OSDK_USER_ID", "")
    print("获取 OSDK_USER_ID：", userId)
    if userId == "" then
      (SuperSDKUtil.GuestLogin)()
    else
      (SuperSDKUtil.Login)()
    end
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

local isAlreadyPlayVoice = false
local LoadAfterLoginShow = function(...)
  -- function num : 0_6 , upvalues : LoadCSVar, LoadScript, LoadLuaScript, InitSound, InitCamera, Game, _ENV, isAlreadyPlayVoice
  LoadCSVar()
  LoadScript()
  LoadLuaScript()
  InitSound()
  InitCamera()
  ;
  (Game.EnlargeTextTexture)()
  local GTween = FairyGUI.GTween
  ;
  ((GTween.DelayedCall)(0.5)):OnComplete(function(...)
    -- function num : 0_6_0 , upvalues : _ENV
    (ActorService.OnInitDirtyWordData)()
  end
)
  if isAlreadyPlayVoice ~= true then
    local delayTime = tonumber((((TableData.gTable).BaseFixedData)[72010050]).array_value)
    if delayTime then
      (LeanTween.delayedCall)(delayTime / 1000, ActorMgr.PlayEnterSound)
      isAlreadyPlayVoice = true
    end
  end
end

local OpenLoginWindow = function(...)
  -- function num : 0_7 , upvalues : _ENV, LoadAfterLoginShow
  UIMgr:LoadPackage("CommonResource")
  ld("Login", function(...)
    -- function num : 0_7_0 , upvalues : _ENV, LoadAfterLoginShow
    UIMgr:SetOnShownComplete((WinResConfig.LoginWindow).name, function(...)
      -- function num : 0_7_0_0 , upvalues : LoadAfterLoginShow, _ENV
      LoadAfterLoginShow()
      ld("SuperSDK")
      ;
      (SuperSDKUtil.SendAppsflyerStart)()
      ;
      (SuperSDKUtil.SendReportCustomData)()
      loge("=======================" .. Application.identifier .. " " .. Application.version)
      if Application.platform == RuntimePlatform.Android and Application.identifier == "jp.co.yoozoo.projectred" then
        (MessageMgr.OpenSoloConfirmWindow)("\nこのアプリは「レッド：プライドオブエデン」の先行プレイ版です。\nこの度の先行プレイは 2020 年 6 月 13 日 18:00 をもって終了とさせていただきました。\nGooglePlay / App Storeまで正式版をご予約いただければ幸いです。\n正式版リリースは 2020 年 7 月リリース予定。ご期待ください。\n\n下記のボタンをタップすると、Android 版をご予約いただけます。", function(...)
        -- function num : 0_7_0_0_0 , upvalues : _ENV
        (Application.OpenURL)("https://play.google.com/store/apps/details?id=jp.co.yoozoo.projectyellow")
      end
, "お知らせ", "予約へ")
      end
      ld("RedDot")
      ld("Activity")
      ld("Announcement", function(...)
        -- function num : 0_7_0_0_1 , upvalues : _ENV
        (AnnouncementMgr.OpenAnnouncement)(true)
      end
)
    end
)
    ;
    (LoginMgr.OpenLogin)()
  end
)
end

local Init = function(...)
  -- function num : 0_8 , upvalues : _ENV, OpenLoginWindow
  InitScreenResolution()
  OpenLoginWindow()
end

Game.EnlargeTextTexture = function(...)
  -- function num : 0_9 , upvalues : _ENV
  local strTable = {}
  local wordConfig = (TableData.gTable).BaseClientWordData
  for i = 1, 10000 do
    if wordConfig[i] then
      (table.insert)(strTable, wordConfig[i])
    end
  end
  local textHand = ((FairyGUI.UIObjectFactory).NewObject)((FairyGUI.ObjectType).Text)
  textHand.text = (table.concat)(strTable)
  textHand:Dispose()
end

Game.SetMainFramerate = function(...)
  -- function num : 0_10 , upvalues : _ENV
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  if (Util.GetPlayerSetting)(PlayerPrefsKeyName.SETTING_FRAME, "0") == "0" then
    Application.targetFrameRate = Const.LowFramerate
  else
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

    Application.targetFrameRate = Const.HighFramerate
  end
end

local SendStartUpMsg = function(...)
  -- function num : 0_11 , upvalues : Game, _ENV, require, CS
  if Game.testPackage ~= true then
    return 
  end
  ld("Login")
  require("PrintTable")
  local Json = require("Json")
  local _, platform = (LoginMgr.GetPlatform)()
  local formData = {platform = platform, deviceId = SystemInfo.deviceUniqueIdentifier}
  loge("发送启动时发送日志记录：")
  loge("formData :" .. PrintTable(formData))
  local url = GetAuthUrl() .. "/startup"
  ;
  ((CS.WWWManager).Singleton):PostWebRequestForm(url, formData, function(...)
    -- function num : 0_11_0
  end
, function(str, ...)
    -- function num : 0_11_1 , upvalues : Json, _ENV
    local result_table = (Json.decode)(str)
    PrintTable(result_table)
    if (result_table.code ~= "success" or result_table.code == "auth_fail") then
    end
  end
)
end

IsNetworkError = function(...)
  -- function num : 0_12 , upvalues : _ENV, CS
  do return Application.internetReachability == ((CS.UnityEngine).NetworkReachability).NotReachable end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

InitScreenResolution = function(...)
  -- function num : 0_13 , upvalues : CS, _ENV, Game
  local launch = (CS.Launch).Singleton
  local value = (PlayerPrefs.GetString)(PlayerPrefsKeyName.SETTING_QUALITY, "nil")
  local processorCount = SystemInfo.processorCount
  local systemMemorySize = SystemInfo.systemMemorySize
  if Application.platform == RuntimePlatform.Android then
    Game.resolutionRatioMin = 5500
    if systemMemorySize < 4000 then
      Game.defaultBattleFrame = "1"
      Game.defaultPlotCharacterType = 2
      if value == "nil" then
        value = "0"
      end
    else
      Game.defaultBattleFrame = "0"
      Game.defaultPlotCharacterType = 2
      if value == "nil" then
        value = "1"
      end
    end
    ;
    (PlayerPrefs.SetString)(PlayerPrefsKeyName.SETTING_QUALITY, value)
  else
    if Application.platform == RuntimePlatform.IPhonePlayer then
      Game.resolutionRatioMin = 6600
      if systemMemorySize < 2000 then
        Game.defaultBattleFrame = "1"
        Game.defaultPlotCharacterType = 2
        if value == "nil" then
          value = "0"
        end
      else
        Game.defaultBattleFrame = "0"
        Game.defaultPlotCharacterType = 2
        if value == "nil" then
          value = "1"
        end
      end
      ;
      (PlayerPrefs.SetString)(PlayerPrefsKeyName.SETTING_QUALITY, value)
    else
      Game.defaultBattleFrame = "0"
      Game.defaultPlotCharacterType = 2
      value = "1"
    end
  end
  if value ~= "nil" then
    value = tonumber(value)
    if value == 0 then
      launch:SetHResolution(Game.resolutionRatioMin)
    else
      launch:SetHResolution(Game.resolutionRatioMax)
    end
  end
end

InitPostBloomIntensity = function(...)
  -- function num : 0_14
end

GetAuthUrl = function(...)
  -- function num : 0_15 , upvalues : _ENV, CS
  local authUrl = CSBaseConfig.AuthServerUrl
  local serverList = (CS.ServerList).Singleton
  if serverList and serverList.AuthServerUrl and serverList.AuthServerUrl ~= "" then
    authUrl = serverList.AuthServerUrl
  end
  return authUrl
end

Init()
SendStartUpMsg()

