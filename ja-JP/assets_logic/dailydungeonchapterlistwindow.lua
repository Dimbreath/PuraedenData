-- params : ...
-- function num : 0 , upvalues : _ENV
require("DailyDungeon_ChapterListByName")
local DailyDungeonChapterListWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local bgList = {}
local lastX, lastY = nil, nil
DailyDungeonChapterListWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, DailyDungeonChapterListWindow
  bridgeObj:SetView((WinResConfig.DailyDungeonChapterListWindow).package, (WinResConfig.DailyDungeonChapterListWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetDailyDungeon_ChapterListUis(contentPane)
  ;
  (DailyDungeonChapterListWindow.InitAssetStrip)()
  ;
  (DailyDungeonChapterListWindow.UpdatePanel)()
  ;
  (DailyDungeonChapterListWindow.InitFunctionControl)()
  ;
  (DailyDungeonChapterListWindow.StartBgMove)()
  ;
  (LuaSound.PlaySound)(LuaSound.COMMON_SLIDE_2, SoundBank.OTHER)
end

DailyDungeonChapterListWindow.UpdatePanel = function(...)
  -- function num : 0_1 , upvalues : _ENV, bgList, DailyDungeonChapterListWindow
  local typeTable = {
{type = PlayType.RoleExpDungeon, ctrIndex = 2}
, 
{type = PlayType.CoinDungeon, ctrIndex = 1}
, 
{type = PlayType.EquipmentExpDungeon, ctrIndex = 3}
}
  bgList = {}
  for index,info in ipairs(typeTable) do
    (DailyDungeonChapterListWindow.UpdateOneDungeonByType)(info.type, info.ctrIndex)
  end
end

DailyDungeonChapterListWindow.UpdateOneDungeonByType = function(type, index, ...)
  -- function num : 0_2 , upvalues : DailyDungeonChapterListWindow, _ENV, bgList
  local clickFuncTable = {DailyDungeonChapterListWindow.onClickGoldGrp, DailyDungeonChapterListWindow.onClickCardExpGrp, DailyDungeonChapterListWindow.onClickEquipMaterial}
  local functionID = {ControlID.Daily_Gold, ControlID.Daily_Medical, ControlID.Daily_Crystal}
  local bgName = {"GoldImage", "ExpImage", "EquipImage"}
  local trialData = (DailyDungeonData.GetTrialDataByType)(type)
  local trialHand = (DailyDungeonChapterListWindow.GetTrialHandByType)(type)
  local trialConfig = (DailyDungeonData.GetTrialConfigByType)(type)
  if trialData and trialHand and trialConfig then
    ChangeUIController(trialHand.root, "c1", index - 1)
    ChangeUIController((trialHand.ChoiceBg).root, "c1", index - 1)
    ChangeUIController((trialHand.ChoiceCard).root, "c1", index - 1)
    local hand = (trialHand.ChoiceBg)[bgName[index]]
    local parent = (trialHand.ChoiceBg).root
    ;
    (table.insert)(bgList, {bg = (trialHand.ChoiceBg)[bgName[index]], card = (trialHand.ChoiceCard)[bgName[index]], oriPos = Vector2(hand.x, hand.y), off = Vector2((parent.width - hand.width) / 2, (parent.height - hand.height) / 2)})
    ;
    ((trialHand.root).onClick):Add(clickFuncTable[index])
    local basePlayConfig = (TableData.GetBasePlayConfigByType)(type)
    if basePlayConfig then
      local remainTime = (trialData.trial).num
      local totalTime = basePlayConfig.free_times
      ;
      (DailyDungeonChapterListWindow.UpdateChallengeTime)(type, remainTime, totalTime)
    end
    do
      local functionState = (FunctionControlMgr.GetFunctionState)(functionID[index], false)
      if functionState then
        ChangeUIController(trialHand.root, "c2", 0)
      else
        ChangeUIController(trialHand.root, "c2", 1)
      end
    end
  end
end

DailyDungeonChapterListWindow.StartBgMove = function(...)
  -- function num : 0_3 , upvalues : _ENV, DailyDungeonChapterListWindow
  ((CS.InputGyroscope).Singleton):AddAction(DailyDungeonChapterListWindow.BgMove)
end

DailyDungeonChapterListWindow.StopBgMove = function(...)
  -- function num : 0_4 , upvalues : _ENV, DailyDungeonChapterListWindow
  ((CS.InputGyroscope).Singleton):RemoveAction(DailyDungeonChapterListWindow.BgMove)
end

DailyDungeonChapterListWindow.BgMove = function(gyro, ...)
  -- function num : 0_5 , upvalues : _ENV, lastX, lastY, bgList
  local eulerAngles = gyro.rotationRateUnbiased
  print("eulerAngles:", eulerAngles)
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
    local card = bgInfo.card
    local oriPos = bgInfo.oriPos
    local off = bgInfo.off
    local targetX = bg.x + eulerAngles.y / 3
    local targetY = bg.y + eulerAngles.x / 3
    if targetX < oriPos.x + off.x then
      targetX = oriPos.x + off.x
    end
    if oriPos.x - off.x < targetX then
      targetX = oriPos.x - off.x
    end
    card.x = card.x - (targetX - bg.x) * 1.5
    bg.x = targetX
    if targetY < oriPos.y + off.y then
      targetY = oriPos.y + off.y
    end
    if oriPos.y - off.y < targetY then
      targetY = oriPos.y - off.y
    end
    card.y = card.y - (targetY - bg.y) * 1.5
    bg.y = targetY
  end
  lastX = eulerAngles.x
  lastY = eulerAngles.y
end

DailyDungeonChapterListWindow.UpdateChallengeTime = function(type, remainTime, totalTime, ...)
  -- function num : 0_6 , upvalues : DailyDungeonChapterListWindow, _ENV
  local trialHand = (DailyDungeonChapterListWindow.GetTrialHandByType)(type)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

  if trialHand then
    (trialHand.TipsTxt).text = (PUtil.get)(40002016)
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R4 in 'UnsetPending'

    if remainTime <= 0 then
      (trialHand.NumberTxt).color = Const.LackColorRGB
    end
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (trialHand.NumberTxt).text = remainTime
  end
end

DailyDungeonChapterListWindow.InitFunctionControl = function(...)
  -- function num : 0_7 , upvalues : _ENV, uis
  local winName = (WinResConfig.DailyDungeonChapterListWindow).name
  local RegisterGuideAndControl = GuideData.RegisterGuideAndControl
  local ControlID = ControlID
  RegisterGuideAndControl(ControlID.Daily_Gold, (uis.GoldGrp).root, winName)
  RegisterGuideAndControl(ControlID.Daily_Medical, (uis.CardExpGrp).root, winName)
  RegisterGuideAndControl(ControlID.Daily_Crystal, (uis.EquipMaterial).root, winName)
end

DailyDungeonChapterListWindow.GetTrialHandByType = function(type, ...)
  -- function num : 0_8 , upvalues : _ENV, uis
  if type == PlayType.CoinDungeon then
    return uis.GoldGrp
  else
    if type == PlayType.RoleExpDungeon then
      return uis.CardExpGrp
    else
      if type == PlayType.EquipmentExpDungeon then
        return uis.EquipMaterial
      end
    end
  end
end

DailyDungeonChapterListWindow.onClickGoldGrp = function(...)
  -- function num : 0_9 , upvalues : _ENV
  (DailyDungeonMgr.OpenDailyDungeonDifficulty)(PlayType.CoinDungeon)
end

DailyDungeonChapterListWindow.onClickCardExpGrp = function(...)
  -- function num : 0_10 , upvalues : _ENV
  (DailyDungeonMgr.OpenDailyDungeonDifficulty)(PlayType.RoleExpDungeon)
end

DailyDungeonChapterListWindow.onClickEquipMaterial = function(...)
  -- function num : 0_11 , upvalues : _ENV
  (DailyDungeonMgr.OpenDailyDungeonDifficulty)(PlayType.EquipmentExpDungeon)
end

DailyDungeonChapterListWindow.OnShown = function(...)
  -- function num : 0_12
end

DailyDungeonChapterListWindow.OnHide = function(...)
  -- function num : 0_13
end

DailyDungeonChapterListWindow.OnClose = function(...)
  -- function num : 0_14 , upvalues : DailyDungeonChapterListWindow, bgList, lastX, lastY, uis, contentPane, _ENV
  (DailyDungeonChapterListWindow.StopBgMove)()
  bgList = {}
  lastX = nil
  uis = nil
  contentPane = nil
  ;
  (GuideData.AbolishControlRefer)((WinResConfig.DailyDungeonChapterListWindow).name)
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.DailyDungeonChapterListWindow).name)
end

DailyDungeonChapterListWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_15
end

DailyDungeonChapterListWindow.InitAssetStrip = function(...)
  -- function num : 0_16 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.DailyDungeonChapterListWindow).name
  m.Tip = (PUtil.get)(40002000)
  m.model = uis.AssetStripGrp
  m.closeToWindow = (WinResConfig.AdventureWindow).name
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

return DailyDungeonChapterListWindow

