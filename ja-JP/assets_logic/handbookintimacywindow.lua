-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_IntimacyByName")
require("HandBook_IntimacyHeadByName")
require("HandBook_IntimacyUseItemByName")
require("HandBook_IntimacySoundBtnByName")
require("HandBook_IntimacyGetTipsByName")
GTween = FairyGUI.GTween
local HandBookIntimacyWindow = {}
local FxManager = (require("FxManager"))
local uis, contentPane = nil, nil
local argTable = {}
local currentID, cardListData, selectGrp, voiceDataS, oneCardData = nil, nil, nil, nil, nil
local isCanClickItem = true
local currentAudioId = 0
local gtAni, AttrPanel = nil, nil
local PrefabList = {}
local soundMinHeight = 20
local soundMaxHeight = 50
local soundSingleTimeMin = 250
local soundSingleTimeMax = 500
local isPlayListSound = false
HandBookIntimacyWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, currentID, uis, HandBookIntimacyWindow, isPlayListSound
  bridgeObj:SetView((WinResConfig.HandBookIntimacyWindow).package, (WinResConfig.HandBookIntimacyWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  currentID = tonumber(argTable[1])
  uis = GetHandBook_IntimacyUis(contentPane)
  ;
  (HandBookIntimacyWindow.InitAssetStrip)()
  isPlayListSound = false
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.CardHeadList).itemRenderer = HandBookIntimacyWindow.CardListRenderer
  ;
  (HandBookIntimacyWindow.InitRightBtn)()
  ;
  (((uis.CardHeadList).scrollPane).onScroll):Set(function(...)
    -- function num : 0_0_0 , upvalues : uis
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

    (uis.LeftBtn).visible = not ((uis.CardHeadList).scrollPane).isLeftMost
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.RightBtn).visible = not ((uis.CardHeadList).scrollPane).isRightMost
  end
)
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((uis.IntimacyPanelGep).IntimacySound).SoundList).itemRenderer = HandBookIntimacyWindow.SoundRenderer
  ;
  (((uis.IntimacyPanelGep).IntimacySound).SoundList):SetBeginAnim(false, "up", 0.05, 0.05)
  ;
  (((uis.IntimacyPanelGep).IntimacySound).SoundList):SetVirtual()
  ;
  (HandBookIntimacyWindow.RefreshCardInformation)(true, true)
  ;
  (HandBookIntimacyWindow.RefreshCardList)()
  ;
  ((((uis.IntimacyPanelGep).IntimacyGetGrp).TipsBtn).onClick):Set(function(...)
    -- function num : 0_0_1 , upvalues : HandBookIntimacyWindow
    (HandBookIntimacyWindow.OpenAttrPanel)()
  end
)
  ;
  (LuaSound.PlaySound)(LuaSound.COMMON_PANEL_IN, SoundBank.OTHER)
  -- DECOMPILER ERROR at PC81: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((uis.IntimacyPanelGep).IntimacyCardInfo).TitleTxt).text = (PUtil.get)(20000358)
  -- DECOMPILER ERROR at PC89: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((uis.IntimacyPanelGep).IntimacySound).TitleTxt).text = (PUtil.get)(20000360)
end

local currentPlayModel = nil
HandBookIntimacyWindow.SoundRenderer = function(index, obj, ...)
  -- function num : 0_1 , upvalues : _ENV, voiceDataS, oneCardData, currentPlayModel, HandBookIntimacyWindow, currentID
  local model = GetHandBook_IntimacySoundBtnUis(obj)
  local content = model.WordTxt
  local data = voiceDataS[index + 1]
  local dataID = tonumber(data[1])
  local lockType = tonumber(data[2])
  local lockValue = tonumber(data[3])
  local DesData = ((TableData.gTable).BaseHandbookRoleDetailData)[dataID]
  if lockType == 1 then
    local intimacyLv = oneCardData.intimacyLv
    if intimacyLv < lockValue then
      content.text = (PUtil.get)(20000145, lockValue)
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R10 in 'UnsetPending'

      ;
      (model.c1Ctr).selectedIndex = 1
    else
      content.text = DesData.name
      -- DECOMPILER ERROR at PC36: Confused about usage of register: R10 in 'UnsetPending'

      ;
      (model.c1Ctr).selectedIndex = 0
    end
  else
    do
      do
        if lockType == 2 then
          local qualityLv = oneCardData.quality
          if qualityLv < lockValue then
            content.text = (PUtil.get)(20000146, lockValue)
            -- DECOMPILER ERROR at PC50: Confused about usage of register: R10 in 'UnsetPending'

            ;
            (model.c1Ctr).selectedIndex = 1
          else
            content.text = DesData.name
            -- DECOMPILER ERROR at PC55: Confused about usage of register: R10 in 'UnsetPending'

            ;
            (model.c1Ctr).selectedIndex = 0
          end
        end
        -- DECOMPILER ERROR at PC57: Confused about usage of register: R9 in 'UnsetPending'

        ;
        (model.c2Ctr).selectedIndex = 0
        ;
        (obj.onClick):Set(function(...)
    -- function num : 0_1_0 , upvalues : model, _ENV, currentPlayModel, HandBookIntimacyWindow, obj, currentID, dataID
    if (model.c1Ctr).selectedIndex == 1 then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000432))
    else
      if (model.c2Ctr).selectedIndex == 0 then
        if currentPlayModel ~= nil then
          ChangeUIController(currentPlayModel, "c2", 0)
          ;
          (HandBookIntimacyWindow.CloseSoundGT)()
        end
        currentPlayModel = obj
        ;
        (HandBookIntimacyWindow.PlayVoice)(currentID, dataID, true, function(...)
      -- function num : 0_1_0_0 , upvalues : model, HandBookIntimacyWindow
      -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

      (model.c2Ctr).selectedIndex = 0
      ;
      (HandBookIntimacyWindow.CloseSoundGT)()
    end
)
        -- DECOMPILER ERROR at PC35: Confused about usage of register: R0 in 'UnsetPending'

        ;
        (model.c2Ctr).selectedIndex = 1
      end
    end
  end
)
      end
    end
  end
end

HandBookIntimacyWindow.PlaySoundEffect = function(time, ...)
  -- function num : 0_2 , upvalues : currentPlayModel, _ENV, HandBookIntimacyWindow
  local soundBar = currentPlayModel:GetChild("SoundPlayBar")
  local gt = (GTween.To)(0, 100, time)
  gt:SetEase((FairyGUI.EaseType).Linear)
  gt:OnUpdate(function(...)
    -- function num : 0_2_0 , upvalues : soundBar, gt
    soundBar.value = (gt.value).x
  end
)
  local soundStrip = currentPlayModel:GetChild("SoundStrip")
  local numCount = soundStrip.numChildren
  for i = 1, numCount do
    local obj = soundStrip:GetChild("Strip_" .. i)
    ;
    (HandBookIntimacyWindow.PlaySingeStripEffect)(obj)
  end
end

local counter = 1
HandBookIntimacyWindow.PlaySingeStripEffect = function(obj, ...)
  -- function num : 0_3 , upvalues : soundMinHeight, counter, _ENV, soundMaxHeight, HandBookIntimacyWindow
  obj.height = soundMinHeight
  counter = 1
  local upHeight = (math.random)(obj.height, soundMaxHeight)
  ;
  (HandBookIntimacyWindow.PlayAniMotion)(obj, upHeight)
end

local soundListGT = {}
HandBookIntimacyWindow.CloseSoundGT = function(...)
  -- function num : 0_4 , upvalues : _ENV, soundListGT
  for _,v in ipairs(soundListGT) do
    if v then
      v:Kill(false)
    end
  end
  soundListGT = {}
end

HandBookIntimacyWindow.PlayAniMotion = function(obj, endValue, ...)
  -- function num : 0_5 , upvalues : counter, _ENV, soundSingleTimeMin, soundSingleTimeMax, soundListGT, soundMinHeight, soundMaxHeight, HandBookIntimacyWindow
  counter = counter + 1
  local time = (math.random)(soundSingleTimeMin, soundSingleTimeMax)
  local gt = (GTween.To)(obj.height, endValue, time / 1000)
  ;
  (table.insert)(soundListGT, gt)
  gt:SetEase((FairyGUI.EaseType).Linear)
  gt:OnUpdate(function(...)
    -- function num : 0_5_0 , upvalues : obj, gt
    obj.height = (gt.value).x
  end
)
  gt:OnComplete(function(...)
    -- function num : 0_5_1 , upvalues : counter, _ENV, endValue, soundMinHeight, soundMaxHeight, HandBookIntimacyWindow, obj
    local eValue = 0
    if counter % 2 == 0 then
      local reduceNum = (math.random)(1, (math.max)(2, endValue - soundMinHeight))
      eValue = endValue - reduceNum
    else
      do
        do
          local addNum = (math.random)(1, (math.max)(2, soundMaxHeight - endValue))
          eValue = endValue + addNum
          ;
          (HandBookIntimacyWindow.PlayAniMotion)(obj, eValue)
        end
      end
    end
  end
)
end

HandBookIntimacyWindow.InitRightBtn = function(...)
  -- function num : 0_6 , upvalues : uis, _ENV, currentID, HandBookIntimacyWindow
  (((uis.IntimacyPanelGep).Button_01_Btn):GetChild("NameTxt")).text = (PUtil.get)(20000140)
  ;
  (((uis.IntimacyPanelGep).Button_02_Btn):GetChild("NameTxt")).text = (PUtil.get)(20000141)
  ;
  (((uis.IntimacyPanelGep).Button_03_Btn):GetChild("NameTxt")).text = (PUtil.get)(20000142)
  ;
  (((uis.IntimacyPanelGep).Button_02_Btn).onClick):Set(function(...)
    -- function num : 0_6_0 , upvalues : _ENV, currentID, uis, HandBookIntimacyWindow
    (RedDotMgr.RemoveIntimacyInfoRedDot)(currentID, true, false)
    ;
    (((uis.IntimacyPanelGep).Button_02_Btn):GetChild("RedDot")).visible = false
    local index = (HandBookIntimacyWindow.GetCardIndex)()
    ;
    (HandBookIntimacyWindow.CardListRenderer)(index, (uis.CardHeadList):GetChildAt(index))
    ;
    (HandBookIntimacyWindow.PlayPlayerInfoAni)()
    ;
    (HandBookIntimacyWindow.CloseVoice)()
  end
)
  ;
  (((uis.IntimacyPanelGep).Button_03_Btn).onClick):Set(function(...)
    -- function num : 0_6_1 , upvalues : _ENV, currentID, uis, HandBookIntimacyWindow
    (RedDotMgr.RemoveIntimacyInfoRedDot)(currentID, false, true)
    ;
    (((uis.IntimacyPanelGep).Button_03_Btn):GetChild("RedDot")).visible = false
    local index = (HandBookIntimacyWindow.GetCardIndex)()
    ;
    (HandBookIntimacyWindow.CardListRenderer)(index, (uis.CardHeadList):GetChildAt(index))
    ;
    (HandBookIntimacyWindow.RefreshCardVoice)()
  end
)
  ;
  (((uis.IntimacyPanelGep).Button_01_Btn).onClick):Set(function(...)
    -- function num : 0_6_2 , upvalues : HandBookIntimacyWindow, uis
    (HandBookIntimacyWindow.CloseVoice)()
    local grp = ((uis.IntimacyPanelGep).IntimacyGetGrp).root
    local mHolder = grp:GetChild("mSfx")
    if mHolder ~= nil then
      mHolder.visible = false
    end
  end
)
end

HandBookIntimacyWindow.OnShown = function(...)
  -- function num : 0_7 , upvalues : HandBookIntimacyWindow, uis, _ENV
  (HandBookIntimacyWindow.SetBottomArrowVisible)(not ((uis.CardHeadList).scrollPane).isLeftMost, not ((uis.CardHeadList).scrollPane).isRightMost)
  ;
  (GuideMgr.PictureTriggerGuide)((WinResConfig.HandBookIntimacyWindow).name)
end

HandBookIntimacyWindow.RefreshCardInfo = function(...)
  -- function num : 0_8 , upvalues : uis, _ENV, currentID, HandBookIntimacyWindow
  local list = ((uis.IntimacyPanelGep).IntimacyCardInfo).InfoList
  list.numItems = 0
  local RoleData = ((TableData.gTable).BaseHandbookRoleData)[currentID]
  local basicInfo = RoleData.remark
  local info = (Util.ParseConfigStr)(basicInfo)
  local objA = UIMgr:CreateObject("HandBook", "IntimacyCardInfo_A")
  local infoList = objA:GetChild("TipsList")
  ;
  (objA:GetChild("ShuXingNameTxt")).text = (PUtil.get)(20000359)
  infoList.numItems = 0
  local height = 0
  for _,v in ipairs(info) do
    local content = UIMgr:CreateObject("HandBook", "IntimacyCardInfo_A_Tips")
    ;
    (content:GetChild("NameTxt")).text = v[1]
    ;
    (content:GetChild("NumberTxt")).text = v[2]
    infoList:AddChild(content)
    height = height + content.height
  end
  infoList.height = height
  list:AddChild(objA)
  local infoStory = RoleData.story
  local storyInfo = (Util.ParseConfigStr)(infoStory)
  local oneCard = (CardData.GetCardData)(currentID)
  for i,v in ipairs(storyInfo) do
    local infoID = tonumber(v[1])
    local lockType = tonumber(v[2])
    local lockValue = tonumber(v[3])
    local objA = UIMgr:CreateObject("HandBook", "IntimacyCardInfo_B")
    ;
    (objA:GetChild("ShuXingNameTxt")).text = (PUtil.get)(20000143, i)
    local content = objA:GetChild("WordTxt")
    if lockType == 1 then
      local intimacyLv = oneCard.intimacyLv
      if intimacyLv < lockValue then
        content.text = (PUtil.get)(20000145, lockValue)
        objA.grayed = true
      else
        local DesData = ((TableData.gTable).BaseHandbookRoleDetailData)[infoID]
        content.text = DesData.remark
        objA.grayed = false
      end
    else
      do
        if lockType == 2 then
          local qualityLv = oneCard.quality
          if qualityLv < lockValue then
            content.text = (PUtil.get)(20000146, lockValue)
            objA.grayed = true
          else
            local DesData = ((TableData.gTable).BaseHandbookRoleDetail)[infoID]
            content.text = DesData.remark
            objA.grayed = false
          end
        end
        do
          do
            list:AddChild(objA)
            -- DECOMPILER ERROR at PC145: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC145: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC145: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC145: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  local selectIn = ((uis.IntimacyPanelGep).c1Ctr).selectedIndex
  if selectIn == 1 then
    (RedDotMgr.RemoveIntimacyInfoRedDot)(currentID, true, false)
    ;
    (((uis.IntimacyPanelGep).Button_02_Btn):GetChild("RedDot")).visible = false
    local index = (HandBookIntimacyWindow.GetCardIndex)()
    ;
    (HandBookIntimacyWindow.CheckHeadRedDot)(index)
  else
    do
      if selectIn == 2 then
        (RedDotMgr.RemoveIntimacyInfoRedDot)(currentID, false, true)
        ;
        (((uis.IntimacyPanelGep).Button_03_Btn):GetChild("RedDot")).visible = false
        local index = (HandBookIntimacyWindow.GetCardIndex)()
        ;
        (HandBookIntimacyWindow.CheckHeadRedDot)(index)
        ;
        (HandBookIntimacyWindow.RefreshCardVoice)()
      end
    end
  end
end

HandBookIntimacyWindow.PlayPlayerInfoAni = function(...)
  -- function num : 0_9 , upvalues : uis, _ENV
  local InfoList = ((uis.IntimacyPanelGep).IntimacyCardInfo).InfoList
  local child = {}
  for i = 1, InfoList.numItems - 1 do
    local obj = InfoList:GetChildAt(i)
    obj.visible = false
    ;
    (table.insert)(child, obj)
  end
  local num = 0
  ;
  ((SimpleTimer.new)(0.05, #child, function(...)
    -- function num : 0_9_0 , upvalues : num, child, _ENV
    num = num + 1
    local obj = child[num]
    PlayUITrans(obj, "up")
    obj.visible = true
    obj = obj:GetChild("Item")
    local posY = obj.y
    obj.y = posY + 20
    local gt = (GTween.To)(posY + 20, posY, 0.25)
    gt:OnUpdate(function(...)
      -- function num : 0_9_0_0 , upvalues : obj, gt
      obj.y = (gt.value).x
    end
)
  end
)):start()
end

HandBookIntimacyWindow.RefreshCardVoice = function(...)
  -- function num : 0_10 , upvalues : _ENV, currentID, voiceDataS, oneCardData, uis
  local RoleData = ((TableData.gTable).BaseHandbookRoleData)[currentID]
  local voiceInfo = RoleData.voice
  voiceDataS = (Util.ParseConfigStr)(voiceInfo)
  ;
  (table.sort)(voiceDataS, function(a, b, ...)
    -- function num : 0_10_0 , upvalues : _ENV
    local tableDataA = ((TableData.gTable).BaseHandbookRoleDetailData)[tonumber(a[1])]
    local tableDataB = ((TableData.gTable).BaseHandbookRoleDetailData)[tonumber(b[1])]
    local sortA = tableDataA.sort or 0
    local sortB = tableDataB.sort or 0
    do return sortA < sortB end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  oneCardData = (CardData.GetCardData)(currentID)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((uis.IntimacyPanelGep).IntimacySound).SoundList).numItems = #voiceDataS
end

HandBookIntimacyWindow.OnHide = function(...)
  -- function num : 0_11
end

HandBookIntimacyWindow.GetCardIndex = function(...)
  -- function num : 0_12 , upvalues : _ENV, cardListData, currentID
  for i,v in ipairs(cardListData) do
    if v.cardId == currentID then
      return i - 1
    end
  end
end

HandBookIntimacyWindow.CheckHeadRedDot = function(index, ...)
  -- function num : 0_13 , upvalues : uis, _ENV, currentID
  local mIndex = (uis.CardHeadList):ItemIndexToChildIndex(index)
  local obj = (uis.CardHeadList):GetChildAt(mIndex)
  local redDot = (Util.GetPlayerSetting)(PlayerPrefsKeyName.INTIMACY_RED_DOT .. currentID, "")
  redDot = split(redDot, ":")
  ;
  (obj:GetChild("RedDot")).visible = false
  if redDot and #redDot > 1 and (tonumber(redDot[1]) == 1 or tonumber(redDot[2]) == 1) then
    (obj:GetChild("RedDot")).visible = true
  end
end

HandBookIntimacyWindow.CardListRenderer = function(index, obj, ...)
  -- function num : 0_14 , upvalues : cardListData, _ENV, currentID, selectGrp, uis, isCanClickItem, gtAni, HandBookIntimacyWindow
  local data = cardListData[index + 1]
  local cardID = data.cardId
  local model = GetHandBook_IntimacyHeadUis(obj)
  local oneCard = (CardData.GetCardData)(cardID)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (model.IconLoader).url = (CardMgr.GetHeadIconSquareUrl)(oneCard)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (model.NumberTxt).text = data.stageCmp .. "/" .. (HandBookMgr.GetCardMaxNumStage)(cardID)
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (model.NumberTxt).visible = data.stageCmp > 0
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (model.LevelTxt).text = oneCard.intimacyLv
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((model.ChoiceHeadGrp).root).visible = cardID == currentID
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (model.c1Ctr).selectedIndex = oneCard.intelligence - 1
  local redDot = (Util.GetPlayerSetting)(PlayerPrefsKeyName.INTIMACY_RED_DOT .. cardID, "")
  redDot = split(redDot, ":")
  ;
  (obj:GetChild("RedDot")).visible = false
  if redDot and #redDot > 1 and (tonumber(redDot[1]) == 1 or tonumber(redDot[2]) == 1) then
    (obj:GetChild("RedDot")).visible = true
  end
  if cardID == currentID then
    selectGrp = (model.ChoiceHeadGrp).root
    -- DECOMPILER ERROR at PC90: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (uis.CardHeadList).selectedIndex = index
  end
  ;
  (obj.onClick):Set(function(...)
    -- function num : 0_14_0 , upvalues : cardID, currentID, isCanClickItem, gtAni, HandBookIntimacyWindow
    if cardID ~= currentID and isCanClickItem then
      if gtAni then
        gtAni:Kill()
      end
      ;
      (HandBookIntimacyWindow.OnClickHead)(cardID)
    end
  end
)
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

HandBookIntimacyWindow.OnClickHead = function(cardID, ...)
  -- function num : 0_15 , upvalues : _ENV, HandBookIntimacyWindow
  (HandBookService.OnReqIntimacyInfo)(cardID)
  ;
  (HandBookIntimacyWindow.CloseVoice)()
end

HandBookIntimacyWindow.RefreshCardList = function(...)
  -- function num : 0_16 , upvalues : cardListData, _ENV, uis, currentID
  cardListData = (HandBookMgr.CGCopySummaryData)()
  ;
  (table.sort)(cardListData, function(a, b, ...)
    -- function num : 0_16_0 , upvalues : _ENV
    local aIntimacy = ((CardData.GetCardData)(a.cardId)).intimacyLv
    local bIntimacy = ((CardData.GetCardData)(b.cardId)).intimacyLv
    local aIntelligence = ((CardData.GetCardData)(a.cardId)).intelligence
    local bIntelligence = ((CardData.GetCardData)(b.cardId)).intelligence
    local aCmp = a.stageCmp
    local bCmp = b.stageCmp
    do return bIntimacy * 100000000000 + bCmp * 1000000 + bIntelligence * 10000 - b.cardId / 1000 < aIntimacy * 100000000000 + aCmp * 1000000 + aIntelligence * 10000 - a.cardId / 1000 end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.CardHeadList).numItems = #cardListData
  local index = 0
  for i,v in ipairs(cardListData) do
    if v.cardId == currentID then
      index = i - 1
    end
  end
  index = (Umath.Min)(#cardListData - 1, index + 4)
  ;
  (uis.CardHeadList):ScrollToView(index)
end

HandBookIntimacyWindow.SetBottomArrowVisible = function(left, right, ...)
  -- function num : 0_17 , upvalues : uis
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (uis.LeftBtn).visible = left
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.RightBtn).visible = right
end

HandBookIntimacyWindow.RefreshCardInformation = function(isInit, refreshCard, NoItem, ...)
  -- function num : 0_18 , upvalues : _ENV, currentID, uis, FxManager, HandBookIntimacyWindow
  local data = (HandBookMgr.IntimacyCardData)()
  currentID = data.cardId
  local oneCard = (CardData.GetCardData)(currentID)
  if refreshCard then
    local fashionConfig = (CardData.GetFashionConfig)(oneCard)
    ;
    (Util.RecycleUIModel)(uis.PictureLoader)
    local obj = (Util.CreateShowModel)(fashionConfig.id, uis.PictureLoader)
    FxManager:SetShutterEffect(obj, (uis.PictureLoader).image)
  end
  do
    ;
    ((uis.PictureLoader).onClick):Set(function(...)
    -- function num : 0_18_0 , upvalues : HandBookIntimacyWindow, currentID, _ENV
    local voiceList = (HandBookIntimacyWindow.GetUnlockVoice)(currentID)
    local length = #voiceList
    if length > 0 then
      local num = (math.random)(1, length)
      ;
      (HandBookIntimacyWindow.PlayVoice)(currentID, voiceList[num], false)
    end
  end
)
    local cardData = ((TableData.gTable).BaseCardData)[currentID]
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (uis.CardNameLoader).url = (Util.GetItemUrl)(cardData.name_pic)
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (uis.CVNameLoader).url = (Util.GetItemUrl)(cardData.cv_pic)
    ;
    (HandBookIntimacyWindow.RefreshRightIntimacyInfo)(true, NoItem)
    if not isInit and not NoItem then
      (HandBookIntimacyWindow.SetSelectState)()
    end
    ;
    (HandBookIntimacyWindow.CheckTabRedDot)()
  end
end

HandBookIntimacyWindow.CheckTabRedDot = function(...)
  -- function num : 0_19 , upvalues : _ENV, currentID, uis
  local redDot = (Util.GetPlayerSetting)(PlayerPrefsKeyName.INTIMACY_RED_DOT .. currentID, "")
  redDot = split(redDot, ":")
  ;
  (((uis.IntimacyPanelGep).Button_01_Btn):GetChild("RedDot")).visible = false
  if tonumber(redDot[1]) ~= 1 then
    (((uis.IntimacyPanelGep).Button_02_Btn):GetChild("RedDot")).visible = not redDot or #redDot <= 1
    ;
    (((uis.IntimacyPanelGep).Button_03_Btn):GetChild("RedDot")).visible = tonumber(redDot[2]) == 1
    ;
    (((uis.IntimacyPanelGep).Button_02_Btn):GetChild("RedDot")).visible = false
    ;
    (((uis.IntimacyPanelGep).Button_03_Btn):GetChild("RedDot")).visible = false
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end

HandBookIntimacyWindow.CloseVoice = function(isFinish, ...)
  -- function num : 0_20 , upvalues : currentAudioId, _ENV, uis, PrefabList
  do
    if currentAudioId > 0 then
      local AudioMgr = (CS.AudioAssetManager).Singleton
      AudioMgr:RemoveSound(currentAudioId, false)
    end
    if uis == nil then
      return 
    end
    do
      for i,v in ipairs(PrefabList) do
        local inTran = v:GetTransition("in")
        if inTran.playing then
          inTran:Stop()
          if isFinish then
            PlayUITrans(v, "out", function(...)
    -- function num : 0_20_0 , upvalues : v
    v:Dispose()
  end
, 0.3)
          else
            PlayUITrans(v, "out", function(...)
    -- function num : 0_20_1 , upvalues : v
    v:Dispose()
  end
)
          end
        else
          PlayUITrans(v, "out", function(...)
    -- function num : 0_20_2 , upvalues : v
    v:Dispose()
  end
)
        end
      end
    end
    PrefabList = {}
  end
end

HandBookIntimacyWindow.PlayVoice = function(cardID, DetailID, showEffect, func, ...)
  -- function num : 0_21 , upvalues : _ENV, isPlayListSound, HandBookIntimacyWindow, currentAudioId, PrefabList, uis
  local RoleData = ((TableData.gTable).BaseHandbookRoleDetailData)[tonumber(DetailID)]
  if RoleData == nil then
    return 
  end
  if not showEffect and isPlayListSound then
    return 
  end
  ;
  (HandBookIntimacyWindow.CloseVoice)()
  currentAudioId = (LuaSound.AudioMgrPlaySound)(RoleData.voice_path, false, function(...)
    -- function num : 0_21_0 , upvalues : func, HandBookIntimacyWindow, showEffect, isPlayListSound
    if func then
      func()
    end
    ;
    (HandBookIntimacyWindow.CloseVoice)(true)
    if showEffect then
      isPlayListSound = false
    end
  end
)
  if showEffect and currentAudioId > 0 then
    local AudioMgr = (CS.AudioAssetManager).Singleton
    local time = AudioMgr:GetClipTime(currentAudioId)
    ;
    (HandBookIntimacyWindow.PlaySoundEffect)(time)
    isPlayListSound = true
  end
  do
    local fashionID = ((CardData.GetCardData)(cardID)).fashionId
    local mXy = (Util.ParseConfigStr)(RoleData.bubble_id)
    local mPosX = 0
    local mPosY = 0
    local direction = 0
    for _,v in ipairs(mXy) do
      if tonumber(v[1]) == fashionID then
        direction = v[2]
        mPosX = tonumber(v[3])
        mPosY = tonumber(v[4])
        break
      end
    end
    do
      local talkPrefab = nil
      if direction == 1 then
        talkPrefab = UIMgr:CreateObject("CommonResource", "TalkLeft")
      else
        talkPrefab = UIMgr:CreateObject("CommonResource", "TalkRight")
      end
      ;
      (table.insert)(PrefabList, talkPrefab)
      talkPrefab.name = "talkPrefab"
      talkPrefab.touchable = false
      ;
      (uis.root):AddChildAt(talkPrefab, (uis.root).numChildren)
      local loader = uis.PictureLoader
      talkPrefab.xy = Vector2(mPosX + loader.x, tonumber(mPosY + loader.y))
      ;
      (talkPrefab:GetChild("TalkTxt")).text = RoleData.remark
      ;
      (talkPrefab:GetTransition("in")).invalidateBatchingEveryFrame = true
      PlayUITrans(talkPrefab, "in")
    end
  end
end

HandBookIntimacyWindow.GetUnlockVoice = function(cardID, ...)
  -- function num : 0_22 , upvalues : _ENV
  local RoleData = ((TableData.gTable).BaseHandbookRoleData)[cardID]
  local txtS = (Util.ParseConfigStr)(RoleData.voice)
  local intimacyLv = ((CardData.GetCardData)(cardID)).intimacyLv
  local quality = ((CardData.GetCardData)(cardID)).quality
  local voiceList = {}
  for _,v in ipairs(txtS) do
    local RoleData = ((TableData.gTable).BaseHandbookRoleDetailData)[tonumber(v[1])]
    -- DECOMPILER ERROR at PC49: Unhandled construct in 'MakeBoolean' P1

    -- DECOMPILER ERROR at PC49: Unhandled construct in 'MakeBoolean' P1

    if RoleData.type == 1 and tonumber(v[2]) == 1 and tonumber(v[3]) <= intimacyLv then
      (table.insert)(voiceList, tonumber(v[1]))
    end
    if tonumber(v[2]) == 2 and tonumber(v[3]) <= quality then
      (table.insert)(voiceList, tonumber(v[1]))
    end
  end
  return voiceList
end

HandBookIntimacyWindow.RefreshRightIntimacyInfo = function(isInit, noItem, ...)
  -- function num : 0_23 , upvalues : _ENV, uis, HandBookIntimacyWindow
  local data = (HandBookMgr.IntimacyCardData)()
  local intimacyLevel = data.lv
  local IntimacyUp = (HandBookMgr.GetCardIntimacyData)(data.cardId, intimacyLevel)
  local intimacyInfoCom = (uis.IntimacyPanelGep).IntimacyGetGrp
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (intimacyInfoCom.TitleTxt).text = (PUtil.get)(20000150)
  if isInit then
    (Util.RecycleUIModel)(((uis.IntimacyPanelGep).IntimacyGetGrp).CardQLoader)
    ;
    (Util.CreateMiniModel)(((uis.IntimacyPanelGep).IntimacyGetGrp).CardQLoader, ((CardData.GetCardData)(data.cardId)).fashionId, nil, true)
    if not noItem then
      (HandBookIntimacyWindow.RefreshIntimacyItem)()
    end
    ;
    (HandBookIntimacyWindow.SetIntimacyLevelInfo)(IntimacyUp.rank, intimacyLevel, data.exp, IntimacyUp.next_exp)
  else
    ;
    (HandBookIntimacyWindow.PlayProgressAni)(intimacyInfoCom, intimacyLevel, data.exp, IntimacyUp.type)
  end
  ;
  (HandBookIntimacyWindow.RefreshCardInfo)()
end

HandBookIntimacyWindow.RefreshIntimacyItem = function(...)
  -- function num : 0_24 , upvalues : uis, _ENV, HandBookIntimacyWindow
  local intimacyInfoCom = (uis.IntimacyPanelGep).IntimacyGetGrp
  local data = (HandBookMgr.IntimacyCardData)()
  local ConsumeIds = Const.IntimacyItemIDs
  local items = split(ConsumeIds, ":")
  local intimacyLevel = data.lv
  local IntimacyUp = (HandBookMgr.GetCardIntimacyData)(data.cardId, intimacyLevel)
  for i = 1, 5 do
    local model = (intimacyInfoCom.root):GetChild("Item_0" .. i .. "_Grp")
    local useNum = 0
    local itemID = tonumber(items[i])
    for _,v in ipairs(data.IntimacyPropList) do
      if itemID == v.propId then
        useNum = v.usedNum
      end
    end
    ;
    (HandBookIntimacyWindow.SetIntimacyItem)(model, itemID, useNum, IntimacyUp.next_exp > 0)
  end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

HandBookIntimacyWindow.OpenAttrPanel = function(...)
  -- function num : 0_25 , upvalues : AttrPanel, _ENV, uis, HandBookIntimacyWindow, currentID
  if AttrPanel == nil then
    AttrPanel = UIMgr:CreateObject("HandBook", "IntimacyGetTipsWindow")
    AttrPanel.visible = false
    ;
    (uis.root):AddChild(AttrPanel)
    AttrPanel.xy = Vector2((GRoot.inst).width * 1 / 6, (GRoot.inst).height * 5 / 13)
  end
  local model = GetHandBook_IntimacyGetTipsUis(AttrPanel:GetChild("IntimacyGetTips"))
  ;
  ((AttrPanel:GetChild("TouchScreenBtn")).onClick):Set(function(...)
    -- function num : 0_25_0 , upvalues : AttrPanel
    AttrPanel.visible = false
  end
)
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (model.Attribute_01_List).numItems = 0
  local ATTACK, DEFENCE, HP = (HandBookMgr.GetIntimacyAddAttr)(AttributeType.ATTACK, AttributeType.DEFENCE, AttributeType.HP)
  local ack = (HandBookIntimacyWindow.CreateAttrContent)((PUtil.get)(6), ATTACK)
  local def = (HandBookIntimacyWindow.CreateAttrContent)((PUtil.get)(1), DEFENCE)
  local hp = (HandBookIntimacyWindow.CreateAttrContent)((PUtil.get)(35), HP)
  ;
  (model.Attribute_01_List):AddChild(ack)
  ;
  (model.Attribute_01_List):AddChild(hp)
  ;
  (model.Attribute_01_List):AddChild(def)
  -- DECOMPILER ERROR at PC90: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (model.Word_01_Txt).text = (PUtil.get)(20000357)
  -- DECOMPILER ERROR at PC92: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (model.Attribute_02_List).numItems = 0
  local intimacyLv = ((CardData.GetCardData)(currentID)).intimacyLv
  local maxLv = (HandBookMgr.GetCardIntimacyMaxLevel)(currentID)
  -- DECOMPILER ERROR at PC110: Confused about usage of register: R9 in 'UnsetPending'

  if maxLv <= intimacyLv + 1 then
    (model.Word_02_Txt).text = (PUtil.get)(20000256)
  else
    -- DECOMPILER ERROR at PC118: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (model.Word_02_Txt).text = (PUtil.get)(20000248, intimacyLv + 1)
    local att1, def1, hp1 = (HandBookMgr.GetCardIntimacyAttr)(currentID, intimacyLv, AttributeType.ATTACK, AttributeType.DEFENCE, AttributeType.HP)
    local att2, def2, hp2 = (HandBookMgr.GetCardIntimacyAttr)(currentID, intimacyLv + 1, AttributeType.ATTACK, AttributeType.DEFENCE, AttributeType.HP)
    local ack3 = (HandBookIntimacyWindow.CreateAttrContent)((PUtil.get)(6), att2 - att1)
    local def3 = (HandBookIntimacyWindow.CreateAttrContent)((PUtil.get)(1), def2 - def1)
    local hp3 = (HandBookIntimacyWindow.CreateAttrContent)((PUtil.get)(35), hp2 - hp1)
    ;
    (model.Attribute_02_List):AddChild(ack3)
    ;
    (model.Attribute_02_List):AddChild(hp3)
    ;
    (model.Attribute_02_List):AddChild(def3)
  end
  do
    AttrPanel.visible = true
  end
end

HandBookIntimacyWindow.CreateAttrContent = function(name, value, ...)
  -- function num : 0_26 , upvalues : _ENV
  local attr = UIMgr:CreateObject("HandBook", "IntimacyGetTipsAttribute")
  ;
  (attr:GetChild("NameTxt")).text = name
  ;
  (attr:GetChild("NumberTxt")).text = value
  return attr
end

HandBookIntimacyWindow.SetAttrValue = function(refer, value, ...)
  -- function num : 0_27
  if value then
    refer.text = value
  else
    refer.text = 0
  end
end

HandBookIntimacyWindow.SetIntimacyLevelInfo = function(rank, level, exp, maxExp, ...)
  -- function num : 0_28 , upvalues : uis, _ENV
  if uis == nil then
    return 
  end
  local intimacyInfoCom = (uis.IntimacyPanelGep).IntimacyGetGrp
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((intimacyInfoCom.IntimacyGetPeachGrp).c1Ctr).selectedIndex = rank
  ;
  (((intimacyInfoCom.IntimacyGetPeachGrp).root):GetChild("n5")).text = level
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R5 in 'UnsetPending'

  if maxExp == 0 then
    (intimacyInfoCom.ExpTxt).text = (PUtil.get)(20000256)
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (intimacyInfoCom.ExpProgressBar).value = 100
  else
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (intimacyInfoCom.ExpTxt).text = exp .. "/" .. maxExp
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (intimacyInfoCom.ExpProgressBar).value = exp / maxExp * 100
  end
end

HandBookIntimacyWindow.PlayProgressAni = function(intimacyInfoCom, level, exp, type, ...)
  -- function num : 0_29 , upvalues : _ENV, HandBookIntimacyWindow, gtAni
  local formerLevel = (((intimacyInfoCom.IntimacyGetPeachGrp).root):GetChild("n5")).text
  local formerData = (HandBookMgr.GetCardIntimacyDataByType)(type, tonumber(formerLevel))
  local formerExp = (intimacyInfoCom.ExpProgressBar).value
  local formerTotal = (HandBookIntimacyWindow.GetTotalIntimacy)(type, tonumber(formerLevel), formerData.next_exp * (formerExp / 100))
  local currentTotal = (HandBookIntimacyWindow.GetTotalIntimacy)(type, level, exp)
  local upData = {}
  local IntimacyUpData = (TableData.gTable).BaseIntimacyUpData
  for _,v in pairs(IntimacyUpData) do
    if v.type == type then
      (table.insert)(upData, v)
    end
  end
  ;
  (table.sort)(upData, function(a, b, ...)
    -- function num : 0_29_0
    do return a.level < b.level end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  gtAni = (GTween.To)(formerTotal, currentTotal, 0.25)
  gtAni:OnUpdate(function(...)
    -- function num : 0_29_1 , upvalues : _ENV, gtAni, HandBookIntimacyWindow, upData, level, formerLevel
    local value = (Umath.Ceil)((gtAni.value).x)
    ;
    (HandBookIntimacyWindow.SetProgressBar)(upData, value, level, tonumber(formerLevel) < level)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

HandBookIntimacyWindow.SetProgressBar = function(update, TotalExp, finallyLevel, uplevel, ...)
  -- function num : 0_30 , upvalues : _ENV, currentID, isCanClickItem, uis, HandBookIntimacyWindow
  local level = 0
  local exp = 0
  local nextExp = 0
  local rank = 0
  local isIn = false
  for i,v in ipairs(update) do
    exp = exp + v.next_exp
    if TotalExp < exp then
      exp = exp - v.next_exp
      level = i - 1
      nextExp = v.next_exp
      rank = v.rank
      isIn = true
      break
    end
  end
  do
    local remainExp = (Umath.CeilToInt)(TotalExp - (exp))
    if not isIn then
      local maxLv = (HandBookMgr.GetCardIntimacyMaxLevel)(currentID)
      local IntimacyData = (HandBookMgr.GetCardIntimacyData)(currentID, maxLv)
      level = maxLv
      remainExp = IntimacyData.next_exp
      nextExp = IntimacyData.next_exp
      rank = IntimacyData.rank
    end
    do
      if (finallyLevel == level and uplevel) or nextExp == 0 then
        isCanClickItem = true
        local intimacyInfoCom = (uis.IntimacyPanelGep).IntimacyGetGrp
        local formerLevel = (((intimacyInfoCom.IntimacyGetPeachGrp).root):GetChild("n5")).text
        if tonumber(formerLevel) < finallyLevel then
          (HandBookIntimacyWindow.OpenIntimacyUpWindow)(finallyLevel)
        end
      end
      do
        ;
        (HandBookIntimacyWindow.SetIntimacyLevelInfo)(rank, level, remainExp, nextExp)
      end
    end
  end
end

HandBookIntimacyWindow.OpenIntimacyUpWindow = function(lv, ...)
  -- function num : 0_31 , upvalues : HandBookIntimacyWindow, currentID
  (HandBookIntimacyWindow.RefreshCardInformation)(false, false, true)
  local DetailID = (HandBookIntimacyWindow.GetLevelUpDetailID)(currentID, lv)
  ;
  (HandBookIntimacyWindow.PlayVoice)(currentID, DetailID, false)
  ;
  (HandBookIntimacyWindow.PlayEffectSpine)(currentID, lv)
end

HandBookIntimacyWindow.GetLevelUpDetailID = function(cardID, inLevel, ...)
  -- function num : 0_32 , upvalues : _ENV
  local RoleData = ((TableData.gTable).BaseHandbookRoleData)[cardID]
  local txtS = (Util.ParseConfigStr)(RoleData.voice_id)
  for _,v in ipairs(txtS) do
    if tonumber(v[1]) <= inLevel and inLevel <= tonumber(v[2]) then
      return tonumber(v[3])
    end
  end
end

HandBookIntimacyWindow.PlayEffectSpine = function(cardId, lv, ...)
  -- function num : 0_33 , upvalues : _ENV, uis
  local IntimacyUp = ((HandBookMgr.GetCardIntimacyData)(cardId, lv))
  -- DECOMPILER ERROR at PC5: Overwrote pending register: R3 in 'AssignReg'

  local effectName = .end
  if IntimacyUp.rank == 0 then
    effectName = UIEffectEnum.UI_HANDBOOK_SPINE_01
  else
    if IntimacyUp.rank == 1 then
      effectName = UIEffectEnum.UI_HANDBOOK_SPINE_02
    else
      effectName = UIEffectEnum.UI_HANDBOOK_SPINE_03
    end
  end
  local grp = (uis.AssetStripGrp).root
  local holder = (LuaEffect.AddUIEffect)(effectName, true, true)
  holder:SetXY(620, 200)
  grp:AddChild(holder)
  ;
  (LuaSound.PlaySound)(LuaSound.HANDBOOK_INTIMACY_LEVELUP, SoundBank.OTHER)
end

HandBookIntimacyWindow.PlayIntimacyUpSfx = function(...)
  -- function num : 0_34 , upvalues : uis, _ENV, HandBookIntimacyWindow
  local grp = ((uis.IntimacyPanelGep).IntimacyGetGrp).root
  local mHolder = grp:GetChild("mSfx")
  if mHolder == nil then
    local pos = Vector2(250, 190)
    local holder = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_HANDBOOK_INTIMACY_UP, false, grp, pos, nil, nil, false)
    holder.name = "mSfx"
  else
    do
      mHolder.visible = false
      mHolder.visible = true
      ;
      (HandBookIntimacyWindow.PlayEffectsSlider)()
      ;
      (LuaSound.PlaySound)(LuaSound.CARD_USE_EXP_ITEM, SoundBank.OTHER)
    end
  end
end

HandBookIntimacyWindow.PlayEffectsSlider = function(...)
  -- function num : 0_35 , upvalues : uis, _ENV
  local grp = ((uis.IntimacyPanelGep).IntimacyGetGrp).ExpProgressBar
  local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_HANDBOOK_EXP_UP, true, true)
  holder:SetXY(grp.width / 2, grp.height / 2)
  grp:AddChild(holder)
end

HandBookIntimacyWindow.GetTotalIntimacy = function(type, level, exp, ...)
  -- function num : 0_36 , upvalues : _ENV
  local total = 0
  local IntimacyUpData = (TableData.gTable).BaseIntimacyUpData
  for _,v in pairs(IntimacyUpData) do
    if v.level < level and v.type == type then
      total = total + v.next_exp
    end
  end
  return total + exp
end

local _gestureDic = {}
local remainTime = 0
HandBookIntimacyWindow.SetIntimacyItem = function(obj, itemId, useNum, showLimit, ...)
  -- function num : 0_37 , upvalues : _ENV, HandBookIntimacyWindow, remainTime, currentID
  local model = GetHandBook_IntimacyUseItemUis(obj)
  local propData = ((TableData.gTable).BasePropData)[itemId]
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (model.ItemOneTxt).text = "+" .. propData.effect_value
  local maxTime = (HandBookIntimacyWindow.GetItemUseMaxTime)(itemId)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (model.limitNumberTxt).visible = showLimit
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R7 in 'UnsetPending'

  if maxTime then
    if maxTime - useNum <= 0 then
      (model.limitNumberTxt).text = (PUtil.get)(20000064, maxTime - useNum, maxTime)
    else
      -- DECOMPILER ERROR at PC38: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (model.limitNumberTxt).text = (PUtil.get)(20000151, maxTime - useNum, maxTime)
    end
  else
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (model.limitNumberTxt).text = "[color=#008000]" .. (PUtil.get)(20000263) .. "[/color]"
  end
  local haveNum = (ActorData.GetPropsByID)(itemId)
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (model.NumberTxt).text = haveNum
  -- DECOMPILER ERROR at PC58: Confused about usage of register: R8 in 'UnsetPending'

  if haveNum == 0 then
    (model.NumberTxt).visible = false
  else
    -- DECOMPILER ERROR at PC61: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (model.NumberTxt).visible = true
  end
  -- DECOMPILER ERROR at PC67: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (model.PlusImage).visible = haveNum == 0
  local iconLoader = (model.root):GetChild("ItemIcon")
  iconLoader.url = (Util.GetItemUrl)(propData.icon)
  if haveNum > 0 then
    iconLoader.color = Const.WhiteColorRGB
  else
    iconLoader.color = ((CS.UnityEngine).Color).gray
  end
  ;
  (iconLoader.onClick):Set(function(...)
    -- function num : 0_37_0 , upvalues : haveNum, _ENV, itemId, HandBookIntimacyWindow, maxTime, useNum
    if haveNum == 0 then
      (Util.ShowGetWay)(itemId)
    else
      ;
      (HandBookIntimacyWindow.OnClickIntimacyItem)(itemId, maxTime, useNum)
    end
  end
)
  local LongPressAdd = (HandBookIntimacyWindow.GetGesture)(iconLoader)
  LongPressAdd.once = false
  LongPressAdd.trigger = 0.2
  LongPressAdd.interval = 0.15
  local speed = 1
  local timer = nil
  local IntimacyLv = 0
  local IntimacyExp = 0
  local haveNum = (ActorData.GetPropsByID)(itemId)
  local totalUseNum = 0
  ;
  (LongPressAdd.onBegin):Set(function(...)
    -- function num : 0_37_1 , upvalues : _ENV, IntimacyLv, IntimacyExp, totalUseNum, speed, maxTime, remainTime, useNum
    local data = (HandBookMgr.IntimacyCardData)()
    IntimacyLv = data.lv
    IntimacyExp = data.exp
    totalUseNum = 0
    speed = 1
    if maxTime then
      remainTime = maxTime - useNum
    else
      remainTime = -1000
    end
    ;
    ((FairyGUI.Stage).inst):CancelClick(0)
  end
)
  ;
  (LongPressAdd.onAction):Set(function(...)
    -- function num : 0_37_2 , upvalues : speed, _ENV, timer, LongPressAdd, currentID, IntimacyLv, IntimacyExp, haveNum, remainTime, maxTime, model, HandBookIntimacyWindow, totalUseNum, itemId
    speed = speed * 1.1
    local time = (Umath.Clamp)((math.floor)(speed), 1, 5)
    timer = (SimpleTimer.setInterval)(LongPressAdd.interval / time, time, function(...)
      -- function num : 0_37_2_0 , upvalues : _ENV, currentID, IntimacyLv, IntimacyExp, haveNum, remainTime, maxTime, model, HandBookIntimacyWindow, totalUseNum, itemId, LongPressAdd, timer
      local isNotMax = true
      local maxLv = (HandBookMgr.GetCardIntimacyMaxLevel)(currentID)
      if maxLv <= IntimacyLv then
        local IntimacyData = (HandBookMgr.GetCardIntimacyData)(currentID, IntimacyLv)
        if IntimacyExp >= IntimacyData.next_exp then
          do
            isNotMax = not IntimacyData
            isNotMax = false
            if haveNum > 0 and (remainTime > 0 or remainTime == -1000) and isNotMax then
              if maxTime then
                remainTime = remainTime - 1
                -- DECOMPILER ERROR at PC50: Confused about usage of register: R2 in 'UnsetPending'

                if remainTime <= 0 then
                  (model.limitNumberTxt).text = (PUtil.get)(20000064, remainTime, maxTime)
                else
                  -- DECOMPILER ERROR at PC59: Confused about usage of register: R2 in 'UnsetPending'

                  (model.limitNumberTxt).text = (PUtil.get)(20000151, remainTime, maxTime)
                end
              end
              -- DECOMPILER ERROR at PC66: Confused about usage of register: R2 in 'UnsetPending'

              ;
              (model.NumberTxt).text = tonumber((model.NumberTxt).text) - 1
              ;
              (HandBookIntimacyWindow.PlayIntimacyUpSfx)()
              totalUseNum = totalUseNum + 1
              haveNum = haveNum - 1
              IntimacyExp = (HandBookIntimacyWindow.SimulationUseItem)(itemId, IntimacyLv, IntimacyExp)
            else
              LongPressAdd:Cancel()
              timer:stop()
              if totalUseNum > 0 then
                (HandBookService.OnReqUseIntimacyItem)(itemId, currentID, totalUseNum)
                loge("使用了..........................." .. totalUseNum)
              end
            end
            -- DECOMPILER ERROR: 8 unprocessed JMP targets
          end
        end
      end
    end
)
  end
)
  ;
  (LongPressAdd.onEnd):Set(function(...)
    -- function num : 0_37_3 , upvalues : timer, totalUseNum, _ENV, itemId, currentID
    timer:stop()
    if totalUseNum > 0 then
      (HandBookService.OnReqUseIntimacyItem)(itemId, currentID, totalUseNum)
      loge("使用了..........................." .. totalUseNum)
    end
  end
)
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

HandBookIntimacyWindow.SimulationUseItem = function(itemID, lv, exp, ...)
  -- function num : 0_38 , upvalues : _ENV, currentID, uis, HandBookIntimacyWindow
  local propData = ((TableData.gTable).BasePropData)[itemID]
  local addIntimacy = tonumber(propData.effect_value)
  local IntimacyUp = (HandBookMgr.GetCardIntimacyData)(currentID, lv)
  local nextExp = IntimacyUp.next_exp
  local mExp = 0
  local mLv = 0
  if nextExp <= exp + addIntimacy then
    mLv = lv + 1
    mExp = exp + addIntimacy - nextExp
  else
    mExp = exp + addIntimacy
    mLv = lv
  end
  local intimacyInfoCom = (uis.IntimacyPanelGep).IntimacyGetGrp
  ;
  (HandBookIntimacyWindow.PlayProgressAni)(intimacyInfoCom, mLv, mExp, IntimacyUp.type)
  return mExp, mLv
end

HandBookIntimacyWindow.GetGesture = function(item, ...)
  -- function num : 0_39 , upvalues : _gestureDic, _ENV
  if _gestureDic[item.uid] == nil then
    _gestureDic[item.uid] = (FairyGUI.LongPressGesture)(item)
  end
  return _gestureDic[item.uid]
end

HandBookIntimacyWindow.OnClickIntimacyItem = function(itemId, maxTime, useNum, ...)
  -- function num : 0_40 , upvalues : _ENV, currentID, isCanClickItem, HandBookIntimacyWindow
  local oneCard = (CardData.GetCardData)(currentID)
  local upData = (HandBookMgr.GetCardIntimacyData)(currentID, oneCard.intimacyLv)
  local maxLV = (HandBookMgr.GetCardIntimacyMaxLevel)(currentID)
  local data = (HandBookMgr.IntimacyCardData)()
  if oneCard.intimacyLv == maxLV and upData.next_exp <= data.exp then
    (MessageMgr.SendCenterTips)((PUtil.get)(20000257, oneCard.name))
  else
    if maxTime and maxTime - useNum == 0 then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000258, oneCard.name))
    else
      if isCanClickItem then
        (HandBookIntimacyWindow.PlayIntimacyUpSfx)()
        ;
        (HandBookService.OnReqUseIntimacyItem)(itemId, currentID)
      end
    end
  end
end

HandBookIntimacyWindow.CheckIsContentLevelUp = function(value, ...)
  -- function num : 0_41 , upvalues : _ENV
  local data = (HandBookMgr.IntimacyCardData)()
  local intimacyLevel = data.lv
  local IntimacyUp = (HandBookMgr.GetCardIntimacyData)(data.cardId, intimacyLevel)
  do return IntimacyUp.next_exp <= data.exp + value end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

HandBookIntimacyWindow.GetItemUseMaxTime = function(itemId, ...)
  -- function num : 0_42 , upvalues : _ENV, currentID
  local cardData = ((TableData.gTable).BaseCardData)[currentID]
  local maxStr = cardData.intimacy_prop_num
  local conS = (Util.ParseConfigStr)(maxStr)
  for _,v in ipairs(conS) do
    if tonumber(v[1]) == itemId then
      return tonumber(v[2])
    end
  end
end

HandBookIntimacyWindow.GetListIndex = function(id, ...)
  -- function num : 0_43 , upvalues : _ENV, cardListData
  for i,v in ipairs(cardListData) do
    if v.cardId == id then
      return i
    end
  end
end

HandBookIntimacyWindow.SetSelectState = function(...)
  -- function num : 0_44 , upvalues : uis, HandBookIntimacyWindow, currentID, selectGrp
  local grp = ((uis.CardHeadList):GetChildAt((HandBookIntimacyWindow.GetListIndex)(currentID) - 1)):GetChild("ChoiceHeadGrp")
  grp.visible = true
  if selectGrp then
    selectGrp.visible = false
  end
  selectGrp = grp
end

HandBookIntimacyWindow.OnClose = function(...)
  -- function num : 0_45 , upvalues : _ENV, uis, isCanClickItem, contentPane, argTable, AttrPanel, currentPlayModel, PrefabList, HandBookIntimacyWindow
  (Util.RecycleUIModel)(uis.PictureLoader)
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.HandBookIntimacyWindow).name)
  isCanClickItem = true
  uis = nil
  contentPane = nil
  argTable = {}
  if AttrPanel ~= nil then
    AttrPanel:Dispose()
    AttrPanel = nil
  end
  currentPlayModel = nil
  PrefabList = {}
  ;
  (HandBookIntimacyWindow.CloseSoundGT)()
  ;
  (HandBookIntimacyWindow.CloseVoice)()
end

HandBookIntimacyWindow.InitAssetStrip = function(...)
  -- function num : 0_46 , upvalues : _ENV, uis, currentID
  local m = {}
  m.windowName = (WinResConfig.HandBookIntimacyWindow).name
  m.closeToWindow = (WinResConfig.HandBookMainWindow).name
  m.Tip = (PUtil.get)(20000150)
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  m.model = uis.AssetStripGrp
  m.BackBtnFun = function(...)
    -- function num : 0_46_0 , upvalues : _ENV, currentID
    (RedDotMgr.RemoveIntimacyInfoRedDot)(currentID, true, true)
    UIMgr:CloseWindow((WinResConfig.HandBookIntimacyWindow).name)
    ;
    (HandBookService.OnReqCGCopySummary)((HandBookMgr.CardPlotWinType).Intimacy)
  end

  m.CloseBtnFun = function(...)
    -- function num : 0_46_1 , upvalues : _ENV, currentID
    (RedDotMgr.RemoveIntimacyInfoRedDot)(currentID, true, true)
    UIMgr:CloseToWindow((WinResConfig.HandBookMainWindow).name)
  end

  m.isSelfClose = true
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

HandBookIntimacyWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_47 , upvalues : _ENV, HandBookIntimacyWindow, uis
  if msgId ~= (WindowMsgEnum.HandBookIntimacyWindow).SHOW_HEAD_LIST or msgId == (WindowMsgEnum.HandBookIntimacyWindow).SHOW_CARD_INFORMATION then
    (HandBookIntimacyWindow.RefreshCardInformation)(false, true)
  else
    if msgId == (WindowMsgEnum.HandBookIntimacyWindow).SHOW_CARD_LEVEL_INFORMATION then
      (HandBookIntimacyWindow.RefreshRightIntimacyInfo)(false)
      local index = (HandBookIntimacyWindow.GetCardIndex)()
      ;
      (HandBookIntimacyWindow.CardListRenderer)(index, (uis.CardHeadList):GetChildAt(index))
      ;
      (HandBookIntimacyWindow.CheckTabRedDot)()
    else
      do
        if msgId == (WindowMsgEnum.HandBookIntimacyWindow).REFRESH_INTIMACY_ITEM then
          (HandBookIntimacyWindow.RefreshIntimacyItem)()
        end
        if msgId == (WindowMsgEnum.NETBrokenReconnect).E_MSG_RECONNECT_Ok then
          (HandBookIntimacyWindow.RefreshRightIntimacyInfo)(false)
          local index = (HandBookIntimacyWindow.GetCardIndex)()
          ;
          (HandBookIntimacyWindow.CardListRenderer)(index, (uis.CardHeadList):GetChildAt(index))
        end
      end
    end
  end
end

return HandBookIntimacyWindow

