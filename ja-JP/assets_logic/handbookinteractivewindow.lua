-- params : ...
-- function num : 0 , upvalues : _ENV
require("PlotPlay_PlotPlayPanelByName")
local HandBookInteractiveWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local cardID = 0
local inLevel = 0
local force = false
local isPlaying = false
local _typingEffect, voiceList = nil, nil
HandBookInteractiveWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, cardID, inLevel, uis, force, HandBookInteractiveWindow, _typingEffect, voiceList
  bridgeObj:SetView((WinResConfig.HandBookInteractiveWindow).package, (WinResConfig.HandBookInteractiveWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  cardID = argTable[1]
  inLevel = argTable[2]
  uis = GetPlotPlay_PlotPlayPanelUis(contentPane)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.c1Ctr).selectedIndex = 1
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

  if inLevel then
    ((uis.AssetStripGrp).root).visible = false
    force = (HandBookMgr.GetUpIntimacyForcePlaySfx)(cardID, inLevel)
  else
    ;
    (HandBookInteractiveWindow.InitAssetStrip)()
  end
  local oneCard = (CardData.GetCardData)(cardID)
  ;
  (Util.CreateShowModel)(oneCard.fashionId, (uis.CardShow_01_Grp).CharacterLoader)
  -- DECOMPILER ERROR at PC55: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.CardShow_01_Grp).root).xy = Vector2(DesignScreen.width / 2, 0)
  contentPane:SetChildIndex(uis.BlankBtn, 1)
  ;
  ((uis.BlankBtn).onClick):Set(HandBookInteractiveWindow.OnClickScreen)
  for i = 2, 5 do
    (contentPane:GetChild("CardShow_0" .. i .. "_Grp")).visible = false
  end
  _typingEffect = (FairyGUI.TypingEffect)((uis.TalkWordGrp).talkTxt)
  voiceList = nil
  -- DECOMPILER ERROR at PC88: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.Mask_02_Image).visible = false
  ;
  ((uis.root):GetChild("Mask_01_Image")).visible = false
  ;
  ((uis.root):GetChild("Mask_03_Image")).visible = false
  -- DECOMPILER ERROR at PC101: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.CutGrp).root).visible = false
end

HandBookInteractiveWindow.GetLevelUpTxt = function(...)
  -- function num : 0_1 , upvalues : _ENV, cardID, inLevel
  local RoleData = ((TableData.gTable).BaseHandbookRoleData)[cardID]
  local txtS = (Util.ParseConfigStr)(RoleData.voice_id)
  local voidID = 0
  for _,v in ipairs(txtS) do
    if tonumber(v[1]) <= inLevel and inLevel <= tonumber(v[2]) then
      voidID = tonumber(v[3])
      break
    end
  end
  do
    local RoleData = ((TableData.gTable).BaseHandbookRoleDetailData)[voidID]
    return RoleData.remark
  end
end

HandBookInteractiveWindow.GetRandomTxt = function(...)
  -- function num : 0_2 , upvalues : voiceList, HandBookInteractiveWindow, _ENV
  if not voiceList then
    voiceList = (HandBookInteractiveWindow.GetUnlockVoice)()
  end
  local num = (math.random)(1, #voiceList)
  local RoleData = ((TableData.gTable).BaseHandbookRoleDetailData)[voiceList[num]]
  return RoleData.remark
end

HandBookInteractiveWindow.GetUnlockVoice = function(...)
  -- function num : 0_3 , upvalues : _ENV, cardID
  local RoleData = ((TableData.gTable).BaseHandbookRoleData)[cardID]
  local txtS = (Util.ParseConfigStr)(RoleData.voice)
  local intimacyLv = ((CardData.GetCardData)(cardID)).intimacyLv
  local quality = ((CardData.GetCardData)(cardID)).quality
  local voiceList = {}
  for _,v in ipairs(txtS) do
    -- DECOMPILER ERROR at PC40: Unhandled construct in 'MakeBoolean' P1

    if tonumber(v[2]) == 1 and tonumber(v[3]) <= intimacyLv then
      (table.insert)(voiceList, tonumber(v[1]))
    end
    if tonumber(v[2]) == 2 and tonumber(v[3]) <= quality then
      (table.insert)(voiceList, tonumber(v[1]))
    end
  end
  return voiceList
end

HandBookInteractiveWindow.OnShown = function(...)
  -- function num : 0_4 , upvalues : _ENV, uis, cardID, inLevel, HandBookInteractiveWindow, force, isPlaying, _typingEffect
  local texture = (ResHelper.LoadTexture)("92000006")
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  if texture ~= nil then
    (uis.backsceneLoader).texture = (FairyGUI.NTexture)(texture)
  end
  local oneCard = (CardData.GetCardData)(cardID)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

  if inLevel then
    (((uis.TalkWordGrp).CardName_01_Grp).characternameTxt).text = oneCard.name
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((uis.TalkWordGrp).talkTxt).text = (HandBookInteractiveWindow.GetLevelUpTxt)()
    local title = (uis.CardShow_01_Grp).root
    local pos = Vector2(title.x, title.y)
    ;
    (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_UNLOCK, true, uis.root, pos)
    if force then
      (SimpleTimer.setTimeout)(5, function(...)
    -- function num : 0_4_0 , upvalues : HandBookInteractiveWindow
    (HandBookInteractiveWindow.OpenUpWin)()
  end
)
    end
  else
    do
      ;
      (HandBookInteractiveWindow.IsShowTalkBG)(false)
      ;
      (((uis.CardShow_01_Grp).CharacterLoader).onClick):Set(function(...)
    -- function num : 0_4_1 , upvalues : isPlaying, HandBookInteractiveWindow, uis, oneCard, _typingEffect
    isPlaying = not isPlaying
    if isPlaying then
      (HandBookInteractiveWindow.IsShowTalkBG)(true)
      -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (((uis.TalkWordGrp).CardName_01_Grp).characternameTxt).text = oneCard.name
      -- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

      ;
      ((uis.AssetStripGrp).root).visible = false
      -- DECOMPILER ERROR at PC21: Confused about usage of register: R0 in 'UnsetPending'

      ;
      ((uis.TalkWordGrp).talkTxt).text = (HandBookInteractiveWindow.GetRandomTxt)()
      _typingEffect:Start()
      _typingEffect:PrintAll(0.04, 0.6)
    else
      ;
      (HandBookInteractiveWindow.OnShowTexTOver)()
    end
  end
)
    end
  end
end

HandBookInteractiveWindow.IsShowTalkBG = function(Show, ...)
  -- function num : 0_5 , upvalues : uis
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  (((uis.TalkWordGrp).CardName_01_Grp).root).visible = Show
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.TalkWordGrp).talkGrp).visible = Show
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.TalkWordGrp).arowGrp).visible = Show
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.TalkWordGrp).talkTxt).visible = Show
end

HandBookInteractiveWindow.OpenUpWin = function(...)
  -- function num : 0_6 , upvalues : _ENV, cardID, inLevel
  OpenWindow((WinResConfig.HandBookIntimacyUpWindow).name, UILayer.HUD, cardID, inLevel)
end

HandBookInteractiveWindow.OnClickScreen = function(...)
  -- function num : 0_7 , upvalues : inLevel, force, HandBookInteractiveWindow, isPlaying
  if inLevel and not force then
    (HandBookInteractiveWindow.OpenUpWin)()
  end
  if isPlaying then
    (HandBookInteractiveWindow.OnShowTexTOver)()
  end
end

HandBookInteractiveWindow.OnShowTexTOver = function(...)
  -- function num : 0_8 , upvalues : isPlaying, uis, _typingEffect
  isPlaying = false
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.AssetStripGrp).root).visible = true
  _typingEffect:Cancel()
  _typingEffect:FastPrint(0.002)
end

HandBookInteractiveWindow.OnHide = function(...)
  -- function num : 0_9
end

HandBookInteractiveWindow.OnClose = function(...)
  -- function num : 0_10 , upvalues : _ENV, uis, contentPane, argTable, isPlaying
  (Util.RecycleUIModel)((uis.CardShow_01_Grp).CharacterLoader)
  uis = nil
  contentPane = nil
  argTable = {}
  isPlaying = false
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.HandBookInteractiveWindow).name)
end

HandBookInteractiveWindow.InitAssetStrip = function(...)
  -- function num : 0_11 , upvalues : _ENV, cardID, uis
  local m = {}
  m.windowName = (WinResConfig.HandBookInteractiveWindow).name
  local data = (CardData.GetCardData)(cardID)
  m.Tip = data.name
  m.model = uis.AssetStripGrp
  m.moneyTypes = {}
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.AssetStripGrp).CloseBtn).visible = false
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

HandBookInteractiveWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_12
end

return HandBookInteractiveWindow

