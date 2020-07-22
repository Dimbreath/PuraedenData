-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_BattleUIWindowByName")
require("Battle_BattleCharctorCompByName")
require("Battle_CharctorCompByName")
require("Battle_AssistGrpByName")
require("Battle_BattleWaveByName")
require("Battle_BattleCirclePByName")
require("Battle_BattleCircleEByName")
require("Battle_AssitLeftGrpByName")
require("Battle_AssitRightGrpByName")
local BattleUIWindow = {cardComp = "CharctorComp"}
local uis, contentPane, battleUIWindowObjectPool, orderBackLineImage = nil, nil, nil, nil
local cardCompList = {}
local orderHeadOriScale = 0.7
local orderHeadMaxScale = 1
local orderHeadList = {}
local leftDamageTimer, rightDamageTimer = nil, nil
local leftSkillInfoList = {}
local rightSkillInfoList = {}
local skillInfoListMaxLength = 6
local skillInfoLast = 3
local maxBossHp = nil
local isPlayingUniqueSkill = false
BattleUIWindow.ReInitData = function(...)
  -- function num : 0_0
end

BattleUIWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_1 , upvalues : _ENV, contentPane, BattleUIWindow
  bridgeObj:SetView((WinResConfig.BattleUIWindow).package, (WinResConfig.BattleUIWindow).comName)
  contentPane = bridgeObj.contentPane
  contentPane:Center()
  ;
  (BattleUIWindow.ShowPanel)()
  ;
  (GuideMgr.ResetPlayPos)()
end

BattleUIWindow.InitFunctionControl = function(...)
  -- function num : 0_2 , upvalues : _ENV, uis, BattleUIWindow
  local winName = (WinResConfig.BattleUIWindow).name
  ;
  (GuideData.AbolishControlRefer)(winName)
  local RegisterGuideAndControl = GuideData.RegisterGuideAndControl
  local ControlID = ControlID
  RegisterGuideAndControl(ControlID.Fight_SpeedUp, uis.SpeedBtn, winName)
  if BattleData.battleType == (ProtoEnum.E_BATTLE_TYPE).ARENA then
    local lock = (uis.AutoBtn):GetChild("LockGrp")
    if lock then
      lock.visible = false
    end
  else
    do
      RegisterGuideAndControl(ControlID.Fight_AutoFight, uis.AutoBtn, winName)
      local headInfo = (BattleUIWindow.GetHead)(1)
      if headInfo then
        RegisterGuideAndControl(ControlID.Fight_Head_1, headInfo.cardComp, winName)
      end
      RegisterGuideAndControl(ControlID.Fight_Stop, uis.StopBtn, winName)
      RegisterGuideAndControl(ControlID.Fight_Setting, uis.SettingBtn, winName)
    end
  end
end

BattleUIWindow.GetHead = function(index, ...)
  -- function num : 0_3 , upvalues : _ENV, cardCompList
  local keyTable = {}
  for posIndex,_ in pairs(cardCompList) do
    (table.insert)(keyTable, posIndex)
  end
  ;
  (table.sort)(keyTable, function(a, b, ...)
    -- function num : 0_3_0
    do return a < b end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  if cardCompList[keyTable[index]] then
    return cardCompList[keyTable[index]]
  else
    return {}
  end
end

BattleUIWindow.ShowPanel = function(...)
  -- function num : 0_4 , upvalues : BattleUIWindow, _ENV, battleUIWindowObjectPool, uis, contentPane, orderBackLineImage
  (BattleUIWindow.ClearCardCampList)()
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  Time.timeScale = BattleSpeedList[BattleConfig.speedIndex]
  if not battleUIWindowObjectPool then
    battleUIWindowObjectPool = ((CS.FairyGUI).GObjectPool)(((CS.Launch).Singleton).transform)
    uis = GetBattle_BattleUIWindowUis(contentPane)
    orderBackLineImage = uis.OrderBackLineImage
    local bossBloodGrp = uis.BossBloodGrp
    if bossBloodGrp then
      bossBloodGrp.visible = false
    end
    PlayUITrans(contentPane, "inok", nil, 0, 1, 0, 0, false)
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.LeftToTalDamage).root).visible = false
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.RightToTalDamage).root).visible = false
    orderBackLineImage.visible = false
    ;
    (BattleMgr.SetTestHpTxt)(uis.OneSelfTxt, uis.EnemyTxt)
    -- DECOMPILER ERROR at PC60: Confused about usage of register: R1 in 'UnsetPending'

    if Game.testPackage == true then
      if uis.OneSelfTxt then
        (uis.OneSelfTxt).visible = false
      end
      -- DECOMPILER ERROR at PC65: Confused about usage of register: R1 in 'UnsetPending'

      if uis.EnemyTxt then
        (uis.EnemyTxt).visible = false
      end
    end
    ;
    (BattleUIWindow.CreateSelfCardComp)()
    OpenPlotPlay(BattleData.stageId, PlotPlayTriggerType.ENTER_BATTLE, function(...)
    -- function num : 0_4_0 , upvalues : _ENV, BattleUIWindow
    if BattleData.soundId then
      (LuaSound.LoadAndPlayBGM)(BattleData.soundId)
    end
    ;
    (BattleUIWindow.UpdateRoundNum)(1)
    ;
    (BattleUIWindow.UpdateWaveNum)()
    ;
    (BattleUIWindow.InitTopButton)()
    ;
    (BattleUIWindow.Init)()
  end
, BattleData.battleType == (ProtoEnum.E_BATTLE_TYPE).CG)
    ;
    (BattleUIWindow.InitFunctionControl)()
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
end

BattleUIWindow.Init = function(...)
  -- function num : 0_5 , upvalues : BattleUIWindow, _ENV
  (BattleUIWindow.ShowPlayBattleStart)()
  ;
  (BattlePlay.CreateAllCard)()
  ;
  (BattlePlay.ShowCardEnter)()
end

BattleUIWindow.ChangeWaveUpdateInfo = function(...)
  -- function num : 0_6 , upvalues : BattleUIWindow, _ENV, contentPane, uis, orderBackLineImage, orderHeadList
  (BattleUIWindow.PlaySelfCompEnd)()
  PlayUITrans(contentPane, "close", function(...)
    -- function num : 0_6_0 , upvalues : uis
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

    if uis and uis.SkillCard and (uis.SkillCard).CardList then
      ((uis.SkillCard).CardList).visible = false
    end
  end
, nil, nil, nil, nil, false)
  orderBackLineImage.visible = false
  PlayUITrans(contentPane, "BossBloodOut")
  ;
  (BattleUIWindow.CloseBossHpTimer)()
  for i,v in pairs(orderHeadList) do
    if v.head then
      (v.head):Dispose()
    end
  end
  orderHeadList = {}
  ;
  (BattleUIWindow.UpdateRoundNum)(1)
  ;
  (BattleUIWindow.UpdateWaveNum)()
end

BattleUIWindow.ShowPlayBattleStart = function(...)
  -- function num : 0_7 , upvalues : _ENV, contentPane
  (SimpleTimer.setTimeout)(0.2, function(...)
    -- function num : 0_7_0 , upvalues : _ENV, contentPane
    local battleStart = UIMgr:CreateObject((WinResConfig.BattleUIWindow).package, "BattleStart")
    if battleStart then
      contentPane:AddChildAt(battleStart, 0)
      battleStart:Center()
      PlayUITrans(battleStart, "in", function(...)
      -- function num : 0_7_0_0 , upvalues : contentPane, battleStart, _ENV
      contentPane:RemoveChild(battleStart, true)
      ;
      (BattlePlay.PlayAfterCardEnter)()
    end
)
    end
  end
)
end

BattleUIWindow.ShowPlayWaveStart = function(waveNum, ...)
  -- function num : 0_8 , upvalues : BattleUIWindow, uis, _ENV, contentPane
  (BattleUIWindow.PlaySelfCompStart)()
  ;
  (BattleUIWindow.CreateOrderLine)()
  ;
  (BattleUIWindow.UpdateSettingUI)()
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  if uis and uis.SkillCard and (uis.SkillCard).CardList then
    ((uis.SkillCard).CardList).visible = true
  end
  PlayUITrans(contentPane, "inok", nil, nil, nil, nil, nil, false)
  if BattleData.enemyMaxWave > 1 then
    local battleWave = UIMgr:CreateObject((WinResConfig.BattleUIWindow).package, "BattleWave")
    do
      if battleWave then
        contentPane:AddChildAt(battleWave, 0)
        battleWave:Center()
        local uis = GetBattle_BattleWaveUis(battleWave)
        -- DECOMPILER ERROR at PC54: Confused about usage of register: R3 in 'UnsetPending'

        if uis and uis.WaveNumberTxt then
          (uis.WaveNumberTxt).text = waveNum
          PlayUITrans(battleWave, "in", function(...)
    -- function num : 0_8_0 , upvalues : contentPane, battleWave, _ENV
    contentPane:RemoveChild(battleWave, true)
    ;
    (BattleData.SetBattleState)(BattleState.BOSS_SHOW_BEGIN)
  end
)
        end
      end
    end
  else
    do
      ;
      (BattleData.SetBattleState)(BattleState.BOSS_SHOW_BEGIN)
    end
  end
end

local NeedShowBoss = function(monsterConfig, ...)
  -- function num : 0_9 , upvalues : _ENV
  if monsterConfig then
    local id = monsterConfig.id
    local boss_show_round = monsterConfig.boss_show_round
    if boss_show_round == 0 then
      return true
    else
      if boss_show_round == 1 then
        local haveShow = (Util.GetPlayerSetting)("_BOSS_SHOW_" .. id, "")
        if haveShow == "" then
          (Util.SetPlayerSetting)("_BOSS_SHOW_" .. id, "1")
          return true
        end
      end
    end
  end
  do
    return false
  end
end

BattleUIWindow.ShowPlayBossCome = function(...)
  -- function num : 0_10 , upvalues : _ENV, contentPane, NeedShowBoss, BattleUIWindow, uis
  local bossId = BattleData.curWaveBossId
  local bossConfig = (TableData.GetBaseMonsterData)(bossId)
  if bossConfig then
    local bossCome = UIMgr:CreateObject((WinResConfig.BattleUIWindow).package, "BossCome")
    do
      if bossCome then
        contentPane:AddChildAt(bossCome, 0)
        bossCome:Center()
        PlayUITrans(bossCome, "in", function(...)
    -- function num : 0_10_0 , upvalues : contentPane, bossCome, bossConfig, NeedShowBoss, BattleUIWindow, _ENV
    contentPane:RemoveChild(bossCome, true)
    if bossConfig.show_texture and NeedShowBoss(bossConfig) == true then
      (BattleUIWindow.ShowBossTips)(bossConfig, function(...)
      -- function num : 0_10_0_0 , upvalues : _ENV
      (BattleData.SetBattleState)(BattleState.ROUND_START)
    end
)
    else
      ;
      (BattleData.SetBattleState)(BattleState.ROUND_START)
    end
  end
)
      end
      local bossBloodGrp = uis.BossBloodGrp
      if bossBloodGrp then
        bossBloodGrp.visible = true
        PlayUITrans(contentPane, "BossBloodIn")
      end
    end
  end
end

BattleUIWindow.ShowBossTips = function(bossConfig, callback, ...)
  -- function num : 0_11 , upvalues : _ENV, contentPane, BattleUIWindow
  local boss_show_type = bossConfig.boss_show_type
  local boss_show_sound = bossConfig.boss_show_sound
  local resStrTable = split(boss_show_type, ":")
  local bossTips = UIMgr:CreateObject(resStrTable[1], resStrTable[2])
  if bossTips then
    contentPane:AddChild(bossTips)
    bossTips:Center()
    local bg = bossTips:GetChild("BlackBgAni")
    if bg then
      bg.x = (bg.width - contentPane.width) / 2
      bg.width = contentPane.width
      bg.height = contentPane.height
    end
    local image = bossTips:GetChild("RedImage")
    if image then
      image.x = (image.width - contentPane.width) / 2
      image.width = contentPane.width
    end
    ;
    (BattleUIWindow.UpdateBossTipsInfo)(bossTips)
    ;
    (PlayUITrans(bossTips, "in", function(...)
    -- function num : 0_11_0 , upvalues : bossTips, BattleUIWindow, callback
    local TouchScreenBtn = bossTips:GetChild("TouchScreenBtn")
    if TouchScreenBtn then
      (TouchScreenBtn.onClick):Set(function(...)
      -- function num : 0_11_0_0 , upvalues : TouchScreenBtn, BattleUIWindow, bossTips, callback
      TouchScreenBtn.touchable = false
      ;
      (BattleUIWindow.ClearBossTips)(bossTips, callback)
    end
)
    end
  end
)).invalidateBatchingEveryFrame = true
    if boss_show_sound then
      (AudioManager.PlayBubbleVoice)(tonumber(boss_show_sound))
    end
  end
end

BattleUIWindow.UpdateBossTipsInfo = function(bossTips, ...)
  -- function num : 0_12 , upvalues : _ENV
  local bossId = BattleData.curWaveBossId
  local bossConfig = (TableData.GetBaseMonsterData)(bossId)
  if bossConfig then
    local nameTxt = (bossTips:GetChild("BossName")):GetChild("NameTxt")
    nameTxt.text = bossConfig.boss_show_name
    local bossCV = (bossTips:GetChild("BossCV")):GetChild("CVNameTxt")
    bossCV.text = bossConfig.boss_cv
    local CardLoader = (bossTips:GetChild("BossPic")):GetChild("CardLoader")
    local strList = split(bossConfig.show_texture, ":")
    ;
    (Util.ShowUIModel)(strList[1], CardLoader)
    if strList[2] then
      (AudioManager.PlayBubbleVoice)(tonumber(strList[2]))
    end
  end
end

BattleUIWindow.ClearBossTips = function(bossTips, callback, ...)
  -- function num : 0_13 , upvalues : _ENV, contentPane
  if bossTips then
    (PlayUITrans(bossTips, "out", function(...)
    -- function num : 0_13_0 , upvalues : bossTips, _ENV, contentPane, callback
    local CardLoader = (bossTips:GetChild("BossPic")):GetChild("CardLoader")
    ;
    (Util.RecycleUIModel)(CardLoader, true)
    contentPane:RemoveChild(bossTips, true)
    if callback then
      callback()
    end
  end
)).invalidateBatchingEveryFrame = true
  end
end

local bossBloodBar = {
[0] = {"yellow", "BossBloodYellowProgressBar"}
, 
[1] = {"red", "BossBloodRedProgressBar"}
, 
[2] = {"green", "BossBloodGreenProgressBar"}
, 
[3] = {"blue", "BossBloodBlueProgressBar"}
, 
[4] = {"orange", "BossBloodOrangeProgressBar"}
, 
[5] = {"yellow", "BossBloodYellowProgressBar"}
, 
[6] = {"red", "BossBloodRedProgressBar"}
, 
[7] = {"green", "BossBloodGreenProgressBar"}
, 
[8] = {"blue", "BossBloodBlueProgressBar"}
, 
[9] = {"orange", "BossBloodOrangeProgressBar"}
}
local bossHpMaxIndex = 46
local bossHpBarList = {}
local moveIndex = 0
local nowBossHp = 0
maxBossHp = 0
local curBarHpIndex = 0
local curBarHpValue = 0
local bossHpMoveSpeed = 0
local hpChangeTimer = nil
local displayBossHp = 0
local displayCurBarHp = 0
local displayCurBarMaxHp = 0
local displayHpTimerLoop = 40
local isBossDead = false
BattleUIWindow.InitBossHp = function(...)
  -- function num : 0_14 , upvalues : isBossDead, uis
  isBossDead = false
  local bossBloodComp = (uis.BossBlood).root
  if bossBloodComp then
    bossBloodComp:RemoveChildren()
  end
end

BattleUIWindow.UpdateBossInfo = function(...)
  -- function num : 0_15 , upvalues : _ENV, uis
  local bossId = BattleData.curWaveBossId
  local bossConfig = (TableData.GetBaseMonsterData)(bossId)
  if bossConfig then
    local card = (BattleData.GetCardInfoById)(bossId)
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (uis.BossNameTxt).text = bossConfig.name
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (uis.BossHeadCircleIconLoader).url = (CardMgr.GetHeadIconRound)({fashionId = card:GetFashionId()})
  end
end

BattleUIWindow.UpdateBossHp = function(hpChangeTable, ...)
  -- function num : 0_16 , upvalues : _ENV, BattleUIWindow, bossHpMaxIndex, curBarHpIndex, curBarHpValue, displayCurBarHp, displayCurBarMaxHp, bossHpBarList, maxBossHp, nowBossHp, displayBossHp
  if hpChangeTable == nil then
    return 
  end
  local maxHp = hpChangeTable.maxHp
  local lastHp = hpChangeTable.lastHp
  local nowHp = hpChangeTable.nowHp
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

  if BattleMgr.BossInited == false then
    BattleMgr.BossInited = true
    ;
    (BattleUIWindow.InitBossHp)()
    ;
    (BattleUIWindow.UpdateBossInfo)()
    bossHpMaxIndex = BattleData.curWaveBossHpBarCount or bossHpMaxIndex
    local tempTotalHp = 0
    for i = 1, bossHpMaxIndex do
      local perBarHp = 0
      if i ~= bossHpMaxIndex then
        perBarHp = (math.floor)(maxHp / bossHpMaxIndex)
      else
        perBarHp = maxHp - tempTotalHp
      end
      tempTotalHp = tempTotalHp + (perBarHp)
      local curMin = tempTotalHp - (perBarHp) + 1
      local curMax = tempTotalHp
      if curMin <= nowHp and nowHp <= curMax then
        curBarHpIndex = i
        curBarHpValue = nowHp - curMin
        displayCurBarHp = curBarHpValue
        displayCurBarMaxHp = perBarHp
      end
      bossHpBarList[i] = {perBarHp = perBarHp, barMinHp = curMin, barMaxHp = curMax}
    end
    maxBossHp = maxHp
    nowBossHp = nowHp
    displayBossHp = nowHp
    ;
    (BattleUIWindow.SetBossIndex)(curBarHpIndex, true)
  else
    do
      ;
      (BattleUIWindow.SetBossHpValue)(nowHp)
    end
  end
end

BattleUIWindow.CheckNeedBossHp = function(curBarHpIndex, isInit, ...)
  -- function num : 0_17 , upvalues : bossHpBarList, BattleUIWindow, uis, displayCurBarHp, displayCurBarMaxHp
  if curBarHpIndex then
    for i = -1, 1 do
      local index = curBarHpIndex - i
      if index > 0 and bossHpBarList[index] then
        local oneBloodComp, colorBlood = nil, nil
        if (bossHpBarList[index]).bloodComp then
          oneBloodComp = (BattleUIWindow.CreateOneBossBloodComp)(index)
          -- DECOMPILER ERROR at PC24: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (bossHpBarList[index]).bloodComp = oneBloodComp
          -- DECOMPILER ERROR at PC26: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (bossHpBarList[index]).colorBlood = colorBlood
          do
            do
              local bossBloodComp = (uis.BossBlood).root
              if i >= 0 then
                bossBloodComp:AddChildAt(oneBloodComp, 0)
                colorBlood.value = 100
              else
                if i < 0 then
                  bossBloodComp:AddChild(oneBloodComp)
                  colorBlood.value = 0
                end
              end
              if isInit == true and index == curBarHpIndex then
                colorBlood.value = 100 * displayCurBarHp / displayCurBarMaxHp
              end
              -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
end

BattleUIWindow.SetBossHpValue = function(nowHp, ...)
  -- function num : 0_18 , upvalues : nowBossHp, curBarHpIndex, curBarHpValue, bossHpBarList, BattleUIWindow, hpChangeTimer, _ENV
  local value = nowBossHp
  local lastBarIndex = curBarHpIndex
  local lastBarValue = curBarHpValue
  local cValue = nowHp
  for i = 1, #bossHpBarList do
    if (bossHpBarList[i]).perBarHp < cValue then
      cValue = cValue - (bossHpBarList[i]).perBarHp
    else
      curBarHpIndex = i
      curBarHpValue = cValue
      break
    end
  end
  do
    -- DECOMPILER ERROR at PC30: Unhandled construct in 'MakeBoolean' P1

    if lastBarIndex == curBarHpIndex and curBarHpValue < lastBarValue then
      (BattleUIWindow.AddWhiteProgressBar)(lastBarIndex, lastBarValue)
    end
    if lastBarIndex < curBarHpIndex then
      for i = curBarHpIndex, lastBarIndex do
        if i == lastBarIndex then
          (BattleUIWindow.AddWhiteProgressBar)(i, lastBarValue)
        else
          ;
          (BattleUIWindow.AddWhiteProgressBar)(i, (bossHpBarList[i]).perBarHp)
        end
      end
      do
        nowBossHp = nowHp
        if hpChangeTimer == nil then
          hpChangeTimer = (SimpleTimer.setInterval)(0.02, -1, function(...)
    -- function num : 0_18_0 , upvalues : BattleUIWindow
    (BattleUIWindow.UpdateHpBar)()
  end
)
        end
      end
    end
  end
end

BattleUIWindow.UpdateHpBar = function(...)
  -- function num : 0_19 , upvalues : nowBossHp, displayBossHp, _ENV, BattleUIWindow, bossHpMoveSpeed, displayHpTimerLoop, displayCurBarHp, displayCurBarMaxHp, maxBossHp, isBossDead, contentPane, bossHpBarList
  local needChangeHp = nowBossHp - displayBossHp
  if (math.abs)(needChangeHp) < 1 then
    (BattleUIWindow.CloseBossHpTimer)()
    displayBossHp = nowBossHp
    return 
  end
  if needChangeHp > 0 then
    if bossHpMoveSpeed < needChangeHp / displayHpTimerLoop then
      bossHpMoveSpeed = needChangeHp / displayHpTimerLoop
    end
    if displayCurBarMaxHp <= displayCurBarHp + bossHpMoveSpeed then
      bossHpMoveSpeed = displayCurBarMaxHp - displayCurBarHp + 1
    end
    if nowBossHp < displayBossHp + bossHpMoveSpeed then
      bossHpMoveSpeed = nowBossHp - displayBossHp
    end
  else
    if needChangeHp < 0 then
      if needChangeHp / displayHpTimerLoop < bossHpMoveSpeed then
        bossHpMoveSpeed = needChangeHp / displayHpTimerLoop
      end
      if displayCurBarHp + bossHpMoveSpeed < 0 then
        bossHpMoveSpeed = -displayCurBarHp
      end
      if displayBossHp + bossHpMoveSpeed < nowBossHp then
        bossHpMoveSpeed = nowBossHp - displayBossHp
      end
    end
  end
  local value = displayBossHp + bossHpMoveSpeed
  if value < 0 then
    bossHpMoveSpeed = -displayBossHp
    value = 0
  end
  if maxBossHp < value then
    value = maxBossHp
  end
  displayBossHp = value
  if displayBossHp <= 0 and isBossDead == false then
    isBossDead = true
    PlayUITrans(contentPane, "BossBloodOut", nil, 0.4)
    ;
    (BattleUIWindow.CloseBossHpTimer)()
  end
  local moveIndex = nil
  local val = value
  for i = 1, #bossHpBarList do
    if (bossHpBarList[i]).perBarHp < val then
      val = val - (bossHpBarList[i]).perBarHp
    else
      moveIndex = i
      local barInfo = bossHpBarList[i]
      do
        do
          if barInfo then
            local colorBlood = barInfo.colorBlood
            if colorBlood then
              colorBlood.value = 100 * (val) / barInfo.perBarHp
            end
            displayCurBarMaxHp = (bossHpBarList[moveIndex]).perBarHp
            displayCurBarHp = val
          end
          do break end
          -- DECOMPILER ERROR at PC135: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC135: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC135: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  if moveIndex then
    (BattleUIWindow.SetBossIndex)(moveIndex)
    if moveIndex < #bossHpBarList then
      for i = moveIndex + 1, #bossHpBarList do
        local barInfo = bossHpBarList[i]
        if barInfo then
          local colorBlood = barInfo.colorBlood
          if colorBlood then
            colorBlood.value = 0
          end
        end
      end
    end
    do
      if moveIndex - 1 > 0 then
        for i = 1, moveIndex - 1 do
          local barInfo = bossHpBarList[i]
          if barInfo then
            local colorBlood = barInfo.colorBlood
            if colorBlood then
              colorBlood.value = 100
            end
          end
        end
      end
    end
  end
end

BattleUIWindow.SetBossIndex = function(index, isInit, ...)
  -- function num : 0_20 , upvalues : moveIndex, BattleUIWindow
  moveIndex = index
  ;
  (BattleUIWindow.CheckNeedBossHp)(moveIndex, isInit)
  ;
  (BattleUIWindow.UpdateTopHpBar)(moveIndex)
end

BattleUIWindow.UpdateTopHpBar = function(moveIndex, ...)
  -- function num : 0_21 , upvalues : uis
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  if moveIndex > 1 then
    (uis.BossBloodNumberTxt).text = "x" .. moveIndex
  else
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.BossBloodNumberTxt).text = ""
  end
end

BattleUIWindow.AddWhiteProgressBar = function(index, value, ...)
  -- function num : 0_22 , upvalues : bossHpBarList, _ENV
  local bloodInfo = bossHpBarList[index]
  if bloodInfo then
    local bloodComp = bloodInfo.bloodComp
    if bloodComp then
      local colorBlood = bloodInfo.colorBlood
      do
        local whiteBar = UIMgr:CreateObject("Battle", "BossBloodWhiteProgressBar")
        if whiteBar then
          whiteBar.value = 100 * value / bloodInfo.perBarHp
          local index = bloodComp:GetChildIndex(colorBlood)
          bloodComp:AddChildAt(whiteBar, index)
          PlayUITrans(whiteBar, "out", function(...)
    -- function num : 0_22_0 , upvalues : whiteBar
    if whiteBar then
      whiteBar:Dispose()
    end
  end
)
        end
      end
    end
  end
end

BattleUIWindow.CreateOneBossBloodComp = function(bloodBarIndex, ...)
  -- function num : 0_23 , upvalues : _ENV, bossBloodBar, battleUIWindowObjectPool
  local comp = (FairyGUI.GComponent)()
  local index = bloodBarIndex % 10
  local bloodConfig = bossBloodBar[index]
  local colorBlood = battleUIWindowObjectPool:GetObject(UIMgr:GetItemUrl("Battle", bloodConfig[2]))
  colorBlood.value = 100
  comp.width = colorBlood.width
  comp.height = colorBlood.height
  comp:AddChild(colorBlood)
  return comp, colorBlood
end

BattleUIWindow.InitTopButton = function(...)
  -- function num : 0_24 , upvalues : uis, _ENV, BattleUIWindow
  local settingBtn = uis.SettingBtn
  local speedBtn = uis.SpeedBtn
  local autoBtn = uis.AutoBtn
  local stopBtn = uis.StopBtn
  local skipBtn = uis.SkipBtn
  if BattleData.battleType == (ProtoEnum.E_BATTLE_TYPE).ARENA then
    skipBtn.visible = true
  else
    skipBtn.visible = false
  end
  ;
  (settingBtn.onClick):Add(BattleUIWindow.OnClickSettingBtn)
  ;
  (speedBtn.onClick):Add(BattleUIWindow.OnClickSpeedBtn)
  ;
  (autoBtn.onClick):Add(BattleUIWindow.OnClickAutoBtn)
  ;
  (stopBtn.onClick):Add(BattleUIWindow.OnClickStopBtn)
  ;
  (skipBtn.onClick):Add(BattleUIWindow.OnClickSkipBtn)
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R5 in 'UnsetPending'

  if BattleData.autoBattle == true then
    BattleConfig.autoBattle = true
  end
  ;
  (BattleUIWindow.UpdateAutoBtn)()
  ;
  (BattleUIWindow.UpdateStopBtn)()
  ;
  (BattleUIWindow.UpdateSpeedBtn)()
  if OvertureMgr.isPlaying == true then
    settingBtn.visible = false
    speedBtn.visible = false
    autoBtn.visible = false
    stopBtn.visible = false
  end
end

BattleUIWindow.OnClickSkipBtn = function(...)
  -- function num : 0_25 , upvalues : _ENV
  if BattleData.battleType == (ProtoEnum.E_BATTLE_TYPE).ARENA then
    local saveTimeScale = Time.timeScale
    do
      -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

      Time.timeScale = 0
      ;
      (MessageMgr.OpenConfirmWindow)((PUtil.get)(40002060), function(...)
    -- function num : 0_25_0 , upvalues : _ENV
    if BattleData.Replay == true then
      (BattleMgr.CloseBattle)()
    else
      ;
      (SimpleTimer.StopAllTimer)()
      ;
      (LeanTween.cancelAll)()
      local allCardList = BattleData.allCardList
      if allCardList then
        for _,v in ipairs(allCardList) do
          v:Destroy()
        end
      end
      do
        -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

        Time.timeScale = 1
        -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

        BattleData.damageDataTable = BattleData.saveChallengeSummarizeData
        ;
        (BattleData.SetBattleState)(BattleState.BATTLE_OVER)
      end
    end
  end
, function(...)
    -- function num : 0_25_1 , upvalues : _ENV, saveTimeScale
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    Time.timeScale = saveTimeScale
  end
, nil, (PUtil.get)(40002061), (PUtil.get)(40002062), false, UILayer.HUD)
    end
  end
end

BattleUIWindow.OnClickSettingBtn = function(...)
  -- function num : 0_26 , upvalues : _ENV
  if BattleData.battleType == (ProtoEnum.E_BATTLE_TYPE).ARENA then
    OpenWindow((WinResConfig.SystemSetWindow).name, UILayer.HUD, SystemSetType.Arena, BattleData.Replay)
  else
    OpenWindow((WinResConfig.SystemSetWindow).name, UILayer.HUD, SystemSetType.Battle)
  end
end

BattleUIWindow.OnClickSpeedBtn = function(...)
  -- function num : 0_27 , upvalues : _ENV, BattleUIWindow
  local speedIndex = BattleConfig.speedIndex
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  if BattleSpeedList[speedIndex + 1] then
    BattleConfig.speedIndex = speedIndex + 1
  else
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

    BattleConfig.speedIndex = 1
  end
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

  if Time.timeScale == 0 then
    BattleMgr.saveTimeScale = BattleSpeedList[BattleConfig.speedIndex]
  else
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

    Time.timeScale = BattleSpeedList[BattleConfig.speedIndex]
  end
  ;
  (Util.SetPlayerSetting)(PlayerPrefsKeyName.BATTLE_SPEED_INDEX .. BattleData.battleType, BattleConfig.speedIndex)
  ;
  (BattleUIWindow.UpdateSpeedBtn)()
end

BattleUIWindow.UpdateSpeedBtn = function(...)
  -- function num : 0_28 , upvalues : uis, _ENV
  local speedBtn = uis.SpeedBtn
  if speedBtn then
    ChangeUIController(speedBtn, "c1", BattleConfig.speedIndex - 1)
  end
end

BattleUIWindow.OnClickAutoBtn = function(...)
  -- function num : 0_29 , upvalues : _ENV, BattleUIWindow
  if BattleData.autoBattle == true or BattleConfig.lockAuto == true then
    (MessageMgr.SendCenterTips)((PUtil.get)(40001002))
    return 
  end
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R0 in 'UnsetPending'

  if BattleConfig.autoBattle == false then
    BattleConfig.autoBattle = true
  else
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R0 in 'UnsetPending'

    BattleConfig.autoBattle = false
  end
  ;
  (Util.SetPlayerSetting)(PlayerPrefsKeyName.BATTLE_AUTO .. BattleData.battleType, BattleConfig.autoBattle and 1 or 0)
  ;
  (BattleUIWindow.UpdateAutoBtn)()
end

BattleUIWindow.UpdateAutoBtn = function(...)
  -- function num : 0_30 , upvalues : uis, _ENV
  local autoBtn = uis.AutoBtn
  if autoBtn then
    if BattleConfig.autoBattle == true then
      ChangeUIController(autoBtn, "c1", 1)
    else
      ChangeUIController(autoBtn, "c1", 0)
    end
  end
end

BattleUIWindow.OnClickStopBtn = function(...)
  -- function num : 0_31 , upvalues : _ENV, BattleUIWindow
  if Time.timeScale == 0 then
    (BattleMgr.ContinueBattle)()
  else
    ;
    (BattleMgr.PauseBattle)()
  end
  ;
  (BattleUIWindow.UpdateStopBtn)()
end

BattleUIWindow.UpdateStopBtn = function(...)
  -- function num : 0_32 , upvalues : uis, _ENV
  local stopBtn = uis.StopBtn
  if stopBtn then
    if Time.timeScale == 0 then
      ChangeUIController(stopBtn, "button", 1)
    else
      ChangeUIController(stopBtn, "button", 0)
    end
  end
end

BattleUIWindow.CreateSelfCardComp = function(...)
  -- function num : 0_33 , upvalues : _ENV, uis, cardCompList, BattleUIWindow
  if not (BattleData.GetSelfTeam)() then
    local selfCardList = {}
  end
  local cardList = (uis.SkillCard).CardList
  cardList:RemoveChildrenToPool()
  ChangeController((uis.SkillCard).c1Ctr, #selfCardList - 1)
  for i,v in ipairs(selfCardList) do
    local cardComp = nil
    if cardCompList[v:GetPosIndex()] then
      cardComp = (cardCompList[v:GetPosIndex()]).cardComp
    else
      cardComp = UIMgr:CreateObject((WinResConfig.BattleUIWindow).package, BattleUIWindow.cardComp)
      cardList:AddChild(cardComp)
      local cardUis = GetBattle_CharctorCompUis(cardComp)
      local shieldBar = (cardUis.root):GetChild("BottomDefenseBar")
      if shieldBar then
        shieldBar.value = 0
        shieldBar.visible = false
      end
      cardCompList[v:GetPosIndex()] = {cardComp = cardComp, cardUis = cardUis, cardUid = v:GetCardUid()}
      local loader = cardUis.HeadIconLoader
      loader.url = (CardMgr.GetHeadIconBattle)({id = v:GetCardId(), quality = v:GetQuality(), fashionId = v:GetFashionId()})
      cardComp.visible = false
    end
  end
end

BattleUIWindow.PlaySelfCompStart = function(...)
  -- function num : 0_34 , upvalues : _ENV, cardCompList
  if not (BattleData.GetSelfTeam)() then
    local selfCardList = {}
  end
  for i,v in ipairs(selfCardList) do
    local cardComp = (cardCompList[v:GetPosIndex()]).cardComp
    if cardComp then
      cardComp.visible = true
      PlayUITrans(cardComp, "battle_headicon_start")
    end
  end
end

BattleUIWindow.PlaySelfCompEnd = function(...)
  -- function num : 0_35 , upvalues : _ENV, cardCompList
  if not (BattleData.GetSelfTeam)() then
    local selfCardList = {}
  end
  for i,v in ipairs(selfCardList) do
    local cardCompInfo = cardCompList[v:GetPosIndex()]
    if cardCompInfo then
      local cardComp = cardCompInfo.cardComp
      if cardComp then
        PlayUITrans(cardComp, "battle_headicon_end")
      end
    end
  end
end

BattleUIWindow.UpdateCardHp = function(info, ...)
  -- function num : 0_36 , upvalues : _ENV, cardCompList, BattleUIWindow
  if info then
    local posIndex = info.posIndex
    local targetValue = info.targetValue
    local card = (BattleData.GetCardInfoByPos)(posIndex)
    local cardCompInfo = cardCompList[posIndex]
    if cardCompInfo then
      local cardUis = cardCompInfo.cardUis
      local bloodProgressBar = (cardUis.root):GetChild("BottomHpBar")
      bloodProgressBar:TweenValue(targetValue, 0.3)
      if targetValue <= 0 then
        ChangeUIController(cardUis.root, "c2", 0)
        -- DECOMPILER ERROR at PC28: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (cardUis.root).grayed = true
        ;
        ((cardCompInfo.cardComp).onClick):Clear()
        ;
        (BattleUIWindow.RemoveSkillEffect)(cardCompInfo.cardUis, card)
        local effect = (cardUis.root):GetChild("DanderMaxEffect1")
        if effect then
          effect:RemoveFromParent()
          effect:Dispose()
        end
        local effect = (cardUis.root):GetChild("DanderMaxEffect2")
        if effect then
          effect:RemoveFromParent()
          effect:Dispose()
        end
        ;
        (GuideMgr.RemoveFightMildGuide)(posIndex)
        local energyProgressBar = (cardUis.root):GetChild("BottomAngerBar")
        energyProgressBar.value = 0
      end
    end
  end
end

BattleUIWindow.UpdateCardShield = function(info, ...)
  -- function num : 0_37 , upvalues : cardCompList
  if info then
    local posIndex = info.posIndex
    local value = info.value
    local visible = info.visible
    local cardCompInfo = cardCompList[posIndex]
    if cardCompInfo then
      local cardUis = cardCompInfo.cardUis
      local bar = (cardUis.root):GetChild("BottomDefenseBar")
      if visible == true then
        bar.visible = true
        bar.value = value
      else
        bar.visible = false
      end
    end
  end
end

BattleUIWindow.UpdateCardRage = function(info, ...)
  -- function num : 0_38 , upvalues : cardCompList, _ENV, BattleUIWindow
  if info then
    local posIndex = info.posIndex
    do
      local value = info.targetValue
      local removeFullRage = info.removeFullRage
      local cardCompInfo = cardCompList[posIndex]
      if cardCompInfo then
        local cardComp = cardCompInfo.cardComp
        local cardUis = cardCompInfo.cardUis
        local energyProgressBar = (cardUis.root):GetChild("BottomAngerBar")
        energyProgressBar:TweenValue(value, 0.3)
        -- DECOMPILER ERROR at PC31: Unhandled construct in 'MakeBoolean' P1

        if value >= 100 and ((cardUis.root):GetController("c1")).selectedIndex == 0 then
          ChangeUIController(cardUis.root, "c1", 1)
          local cardUid = cardCompInfo.cardUid
          local battleCard = (BattleData.GetCardInfoByUid)(cardUid)
          local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_ANGER, true)
          if holder then
            (cardUis.root):AddChildAt(holder, 0)
            holder:SetXY((cardUis.root).width / 2, (cardUis.root).height / 2 + 34)
            holder.name = "DanderMaxEffect1"
          end
          if BattleConfig.autoBattle == false and (BattleBuff.IsForbiddenSkill)(battleCard) ~= true then
            (GuideMgr.AddFightMildGuide)(cardUis.root, posIndex)
          end
          ;
          (cardComp.onClick):Set(function(...)
    -- function num : 0_38_0 , upvalues : _ENV, battleCard, posIndex, BattleUIWindow, cardUis, cardComp
    if BattleConfig.autoBattle == true then
      return 
    end
    if battleCard then
      if battleCard:IsDead() == true then
        return 
      end
      if (BattleBuff.IsForbiddenSkill)(battleCard) == true then
        return 
      end
      local isSuccess = (BattleData.AddSkillAtk)(battleCard, true)
      if isSuccess then
        (GuideMgr.RemoveFightMildGuide)(posIndex)
        ;
        (BattleUIWindow.ShowSkillEffect)(cardUis, battleCard)
        ;
        (cardComp.onClick):Clear()
      end
    end
  end
)
        end
      end
      do
        ChangeUIController(cardUis.root, "c1", 0)
        ;
        (GuideMgr.RemoveFightMildGuide)(posIndex)
        local effect = (cardUis.root):GetChild("DanderMaxEffect1")
        if effect then
          effect:RemoveFromParent()
          effect:Dispose()
        end
        local effect = (cardUis.root):GetChild("DanderMaxEffect2")
        if effect then
          effect:RemoveFromParent()
          effect:Dispose()
        end
        local cardUid = cardCompInfo.cardUid
        local battleCard = (BattleData.GetCardInfoByUid)(cardUid)
        if removeFullRage == true then
          (BattleUIWindow.RemoveSkillEffect)(cardUis, battleCard)
        end
        ;
        (cardComp.onClick):Clear()
      end
    end
  end
end

BattleUIWindow.UpdateBottomHead = function(info, ...)
  -- function num : 0_39 , upvalues : cardCompList, _ENV
  if info then
    local posIndex = info.posIndex
    local cardCompInfo = cardCompList[posIndex]
    if cardCompInfo then
      local cardUis = cardCompInfo.cardUis
      local cardUid = cardCompInfo.cardUid
      local battleCard = (BattleData.GetCardInfoByUid)(cardUid)
      if (BattleBuff.IsForbiddenSkill)(battleCard) == true then
        ChangeUIController(cardUis.root, "c2", 1)
      else
        ChangeUIController(cardUis.root, "c2", 0)
      end
    end
  end
end

BattleUIWindow.PlaySkillEffect = function(card, ...)
  -- function num : 0_40 , upvalues : cardCompList, BattleUIWindow
  local posIndex = card:GetPosIndex()
  local info = cardCompList[posIndex]
  if info then
    local cardUis = info.cardUis
    ;
    (BattleUIWindow.ShowSkillEffect)(cardUis, card)
  end
end

local leftHeadOriPos, rightHeadOriPos = nil, nil
BattleUIWindow.CreateOrderLine = function(...)
  -- function num : 0_41 , upvalues : uis, _ENV, battleUIWindowObjectPool, orderHeadOriScale, contentPane, orderHeadList, leftHeadOriPos, rightHeadOriPos
  local orderBackLineImage = uis.OrderBackLineImage
  local orderBackLineImageX = orderBackLineImage.x
  local orderBackLineImageY = orderBackLineImage.y
  local orderBackLineImageWidth = orderBackLineImage.width
  local orderBackLineImageHeight = orderBackLineImage.height
  local orderBackLineImageCenterX = orderBackLineImageX + orderBackLineImageWidth / 2
  local headWidth, headHeight = nil, nil
  local cardsLeft = (BattleData.GetCardsByCamp)(BattleCardCamp.LEFT)
  for _,v in ipairs(cardsLeft) do
    local circleUrl = UIMgr:GetItemUrl("Battle", "BattleCircleP")
    local url = (CardMgr.GetHeadIconRound)({id = v:GetCardId(), quality = v:GetQuality(), fashionId = v:GetFashionId()})
    local orderCardHead = battleUIWindowObjectPool:GetObject(circleUrl)
    local CircleHeadLoader = (GetBattle_BattleCirclePUis(orderCardHead)).CircleHeadLoader
    CircleHeadLoader.url = url
    if not headWidth then
      headWidth = orderCardHead.width * orderHeadOriScale
    end
    if not headHeight then
      headHeight = orderCardHead.height * orderHeadOriScale
    end
    contentPane:AddChild(orderCardHead)
    orderCardHead.scale = Vector2(orderHeadOriScale, orderHeadOriScale)
    orderCardHead:SetXY(orderBackLineImageCenterX - headWidth - 1, orderBackLineImageY + orderBackLineImageHeight - headHeight)
    orderHeadList[v:GetPosIndex()] = {battleCard = v, head = orderCardHead}
    if not leftHeadOriPos then
      do
        leftHeadOriPos = orderCardHead.xy
        -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  local cardsRight = (BattleData.GetCardsByCamp)(BattleCardCamp.RIGHT)
  for _,v in ipairs(cardsRight) do
    local circleUrl = UIMgr:GetItemUrl("Battle", "BattleCircleE")
    local url = (CardMgr.GetHeadIconRound)({id = v:GetCardId(), quality = v:GetQuality(), fashionId = v:GetFashionId()})
    local orderCardHead = battleUIWindowObjectPool:GetObject(circleUrl)
    local CircleHeadLoader = (GetBattle_BattleCircleEUis(orderCardHead)).CircleHeadLoader
    CircleHeadLoader.url = url
    contentPane:AddChild(orderCardHead)
    orderCardHead.scale = Vector2(orderHeadOriScale, orderHeadOriScale)
    orderCardHead:SetXY(orderBackLineImageCenterX + 1, orderBackLineImageY + orderBackLineImageHeight - headHeight)
    orderHeadList[v:GetPosIndex()] = {battleCard = v, head = orderCardHead}
    if not rightHeadOriPos then
      do
        rightHeadOriPos = orderCardHead.xy
        -- DECOMPILER ERROR at PC143: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC143: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
end

BattleUIWindow.UpdateOrderLine = function(...)
  -- function num : 0_42 , upvalues : orderHeadList, _ENV, uis, BattleUIWindow, orderHeadMaxScale
  if orderHeadList then
    local waitAtkCards = (BattleData.GetOrderCard)()
    do
      local allCardsNum = #waitAtkCards
      local orderBackLineImage = uis.OrderBackLineImage
      local orderBackLineImageX = orderBackLineImage.x
      local orderBackLineImageY = orderBackLineImage.y
      local orderBackLineImageHeight = orderBackLineImage.height
      for i,v in ipairs(waitAtkCards) do
        local targetY = orderBackLineImageY + i * (orderBackLineImageHeight / (allCardsNum + 5))
        do
          if i == 1 then
            targetY = orderBackLineImageY
          end
          local posIndex = v:GetPosIndex()
          local orderHeadInfo = orderHeadList[posIndex]
          local head = orderHeadInfo.head
          head.sortingOrder = allCardsNum - i
          local tweener = head:TweenMoveY(targetY, 0.2)
          if i == 1 then
            tweener:OnComplete(function(...)
    -- function num : 0_42_0 , upvalues : BattleUIWindow, head, _ENV, orderBackLineImageX, orderBackLineImageY, orderHeadMaxScale
    if (BattleUIWindow.IsWindowOpen)() == true and head then
      local time = 0.1
      head:TweenMove(Vector2(orderBackLineImageX - head.width / 2, orderBackLineImageY - head.height / 2), time)
      head:TweenScale(Vector2(orderHeadMaxScale, orderHeadMaxScale), time)
    end
  end
)
          end
        end
      end
    end
  end
end

BattleUIWindow.RefreshOrderCard = function(posIndex, ...)
  -- function num : 0_43 , upvalues : uis, _ENV, battleUIWindowObjectPool, orderHeadOriScale, contentPane, orderHeadList, leftHeadOriPos, rightHeadOriPos, BattleUIWindow
  local orderBackLineImage = uis.OrderBackLineImage
  local orderBackLineImageX = orderBackLineImage.x
  local orderBackLineImageY = orderBackLineImage.y
  local orderBackLineImageWidth = orderBackLineImage.width
  local orderBackLineImageHeight = orderBackLineImage.height
  local orderBackLineImageCenterX = orderBackLineImageX + orderBackLineImageWidth / 2
  local headWidth, headHeight = nil, nil
  local card = (BattleData.GetCardInfoByPos)(posIndex)
  if card:GetCampFlag() == BattleCardCamp.LEFT then
    local circleUrl = UIMgr:GetItemUrl("Battle", "BattleCircleP")
    local url = (CardMgr.GetHeadIconRound)({id = card:GetCardId(), quality = card:GetQuality(), fashionId = card:GetFashionId()})
    local orderCardHead = battleUIWindowObjectPool:GetObject(circleUrl)
    local CircleHeadLoader = (GetBattle_BattleCirclePUis(orderCardHead)).CircleHeadLoader
    CircleHeadLoader.url = url
    if not headWidth then
      headWidth = orderCardHead.width * orderHeadOriScale
    end
    if not headHeight then
      headHeight = orderCardHead.height * orderHeadOriScale
    end
    contentPane:AddChild(orderCardHead)
    orderCardHead.scale = Vector2(orderHeadOriScale, orderHeadOriScale)
    orderCardHead:SetXY(orderBackLineImageCenterX - headWidth - 1, orderBackLineImageY + orderBackLineImageHeight - headHeight)
    orderHeadList[posIndex] = {battleCard = card, head = orderCardHead}
    if not leftHeadOriPos then
      do
        leftHeadOriPos = orderCardHead.xy
        if card:GetCampFlag() == BattleCardCamp.RIGHT then
          local circleUrl = UIMgr:GetItemUrl("Battle", "BattleCircleE")
          local url = (CardMgr.GetHeadIconRound)({id = card:GetCardId(), quality = card:GetQuality(), fashionId = card:GetFashionId()})
          local orderCardHead = battleUIWindowObjectPool:GetObject(circleUrl)
          local CircleHeadLoader = (GetBattle_BattleCircleEUis(orderCardHead)).CircleHeadLoader
          CircleHeadLoader.url = url
          if not headWidth then
            headWidth = orderCardHead.width * orderHeadOriScale
          end
          if not headHeight then
            headHeight = orderCardHead.height * orderHeadOriScale
          end
          contentPane:AddChild(orderCardHead)
          orderCardHead.scale = Vector2(orderHeadOriScale, orderHeadOriScale)
          orderCardHead:SetXY(orderBackLineImageCenterX + 1, orderBackLineImageY + orderBackLineImageHeight - headHeight)
          orderHeadList[posIndex] = {battleCard = card, head = orderCardHead}
          if not rightHeadOriPos then
            do
              rightHeadOriPos = orderCardHead.xy
              ;
              (BattleUIWindow.UpdateActionUI)()
            end
          end
        end
      end
    end
  end
end

BattleUIWindow.ResetOrderCard = function(posIndex, ...)
  -- function num : 0_44 , upvalues : orderHeadList, BattleUIWindow, _ENV, leftHeadOriPos, rightHeadOriPos, orderHeadOriScale
  if orderHeadList then
    local curAtkHeadInfo = orderHeadList[posIndex]
    if curAtkHeadInfo then
      local head = curAtkHeadInfo.head
      do
        local battleCard = curAtkHeadInfo.battleCard
        if battleCard:GetHp() <= 0 and head then
          orderHeadList[posIndex] = nil
          ;
          (head:TweenFade(0, 0.5)):OnComplete(function(...)
    -- function num : 0_44_0 , upvalues : BattleUIWindow, head
    if (BattleUIWindow.IsWindowOpen)() == true and head then
      head.visible = false
      head:Dispose()
    end
  end
)
          return 
        end
        local camp = (BattleData.GetCampByPosIndex)(posIndex)
        if camp == BattleCardCamp.LEFT then
          head:SetXY(leftHeadOriPos.x, leftHeadOriPos.y)
        else
          if camp == BattleCardCamp.RIGHT then
            head:SetXY(rightHeadOriPos.x, rightHeadOriPos.y)
          end
        end
        head:SetScale(orderHeadOriScale, orderHeadOriScale)
        head.sortingOrder = 0
      end
    end
  end
end

BattleUIWindow.ShowDamagePanel = function(param, ...)
  -- function num : 0_45 , upvalues : _ENV, uis, leftDamageTimer, BattleUIWindow, rightDamageTimer
  local camp, damage, isCrit = param.camp, param.totalDamage, param.isCrit
  local damagePanel = nil
  local interval = 0.02
  local loopTime = 30
  local waitTime = 50
  local perDamage = damage / loopTime
  if camp == BattleCardCamp.LEFT then
    damagePanel = uis.RightToTalDamage
    if leftDamageTimer then
      leftDamageTimer:stop()
      leftDamageTimer = nil
    end
    leftDamageTimer = (SimpleTimer.setInterval)(interval, loopTime + waitTime, function(timer, count, ...)
    -- function num : 0_45_0 , upvalues : loopTime, BattleUIWindow, damagePanel, _ENV, perDamage, damage, isCrit
    if count <= loopTime then
      (BattleUIWindow.UpdateTotalDamagePanel)(damagePanel, (math.min)((math.ceil)(perDamage * count), damage), isCrit)
    end
  end
, function(...)
    -- function num : 0_45_1 , upvalues : BattleUIWindow, damagePanel, leftDamageTimer
    (BattleUIWindow.HideDamagePanel)(damagePanel)
    leftDamageTimer = nil
  end
)
  else
    if camp == BattleCardCamp.RIGHT then
      damagePanel = uis.LeftToTalDamage
      if rightDamageTimer then
        rightDamageTimer:stop()
        rightDamageTimer = nil
      end
      rightDamageTimer = (SimpleTimer.setInterval)(interval, loopTime + waitTime, function(timer, count, ...)
    -- function num : 0_45_2 , upvalues : loopTime, BattleUIWindow, damagePanel, _ENV, perDamage, isCrit
    if count <= loopTime then
      (BattleUIWindow.UpdateTotalDamagePanel)(damagePanel, (math.ceil)(perDamage * count), isCrit)
    end
  end
, function(...)
    -- function num : 0_45_3 , upvalues : BattleUIWindow, damagePanel, rightDamageTimer
    (BattleUIWindow.HideDamagePanel)(damagePanel)
    rightDamageTimer = nil
  end
)
    end
  end
  if damagePanel and (damagePanel.root).visible == false then
    local trans = (damagePanel.root):GetTransition("in")
    trans:Play()
  end
end

BattleUIWindow.UpdateTotalDamagePanel = function(damagePanel, damage, isCrit, ...)
  -- function num : 0_46 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  if damagePanel then
    (damagePanel.root).visible = true
    local c1Ctr = damagePanel.c1Ctr
    local critTxt = damagePanel.CritArtTxt
    local normalTxt = damagePanel.NormalArtTxt
    if isCrit then
      ChangeController(c1Ctr, 0)
      critTxt.text = (math.ceil)(damage)
    else
      ChangeController(c1Ctr, 1)
      normalTxt.text = (math.ceil)(damage)
    end
  end
end

BattleUIWindow.HideDamagePanel = function(damagePanel, ...)
  -- function num : 0_47 , upvalues : BattleUIWindow
  if damagePanel then
    local trans = (damagePanel.root):GetTransition("out")
    trans:Play(function(...)
    -- function num : 0_47_0 , upvalues : damagePanel, BattleUIWindow
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

    if damagePanel and (BattleUIWindow.IsWindowOpen)() == true then
      (damagePanel.root).visible = false
    end
  end
)
  end
end

BattleUIWindow.IsWindowOpen = function(...)
  -- function num : 0_48 , upvalues : _ENV
  do return UIMgr:IsWindowOpen("BattleUIWindow") == true end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BattleUIWindow.AddSkillInfoPanel = function(param, ...)
  -- function num : 0_49 , upvalues : _ENV, battleUIWindowObjectPool, contentPane, uis, leftSkillInfoList, skillInfoListMaxLength, BattleUIWindow, skillInfoLast, rightSkillInfoList
  local atkCard = param.atkCard
  local skillType = param.skillType
  if atkCard and skillType and skillType == BattleSkillType.SMALL then
    local skillInfoHand = nil
    do
      (atkCard:GetCampFlag())
      local camp = nil
      local url, startY, startX, assitUis = nil, nil, nil, nil
      if camp == BattleCardCamp.LEFT then
        url = UIMgr:GetItemUrl("Battle", "AssitLeftGrp")
      else
        if camp == BattleCardCamp.RIGHT then
          url = UIMgr:GetItemUrl("Battle", "AssitRightGrp")
        end
      end
      local iconUrl = (CardMgr.GetHeadIconSkillBanner)({id = atkCard:GetCardId(), quality = atkCard:GetQuality()})
      skillInfoHand = battleUIWindowObjectPool:GetObject(url)
      if skillInfoHand then
        skillInfoHand:RemoveFromParent()
        contentPane:AddChild(skillInfoHand)
        if camp == BattleCardCamp.LEFT then
          assitUis = (GetBattle_AssitLeftGrpUis(skillInfoHand)).n0
          if skillType == BattleSkillType.ASSIST then
            ChangeController(assitUis.c1Ctr, 3)
          else
            if skillType == BattleSkillType.SMALL then
              ChangeController(assitUis.c1Ctr, 1)
            end
          end
          local leftText = uis.LeftSkillTxt
          startX = leftText.x
          startY = leftText.y
        else
          do
            if camp == BattleCardCamp.RIGHT then
              assitUis = (GetBattle_AssitRightGrpUis(skillInfoHand)).n0
              if skillType == BattleSkillType.ASSIST then
                ChangeController(assitUis.c1Ctr, 2)
              else
                if skillType == BattleSkillType.SMALL then
                  ChangeController(assitUis.c1Ctr, 0)
                end
              end
              local rightTxt = uis.RightSkillTxt
              startX = rightTxt.x
              startY = rightTxt.y
            end
            do
              skillInfoHand:SetXY(startX, startY)
              local trans = skillInfoHand:GetTransition("in")
              trans:Play()
              -- DECOMPILER ERROR at PC125: Confused about usage of register: R11 in 'UnsetPending'

              ;
              (assitUis.AssitHeadLoader).url = iconUrl
              local timer = nil
              if camp == BattleCardCamp.LEFT then
                for i,v in ipairs(leftSkillInfoList) do
                  local hand = v.hand
                  if skillInfoListMaxLength <= i then
                    (BattleUIWindow.RemoveSkillInfoPanel)(v)
                    leftSkillInfoList[i] = nil
                  else
                    hand:TweenMoveY(hand.y - hand.height, 0.2)
                  end
                end
                ;
                (table.insert)(leftSkillInfoList, 1, {hand = skillInfoHand, timer = timer})
                timer = (SimpleTimer.setTimeout)(skillInfoLast, function(...)
    -- function num : 0_49_0 , upvalues : BattleUIWindow, skillInfoHand, timer, leftSkillInfoList
    (BattleUIWindow.RemoveSkillInfoPanel)({hand = skillInfoHand, timer = timer})
    leftSkillInfoList[#leftSkillInfoList] = nil
  end
)
              else
                if camp == BattleCardCamp.RIGHT then
                  for i,v in ipairs(rightSkillInfoList) do
                    local hand = v.hand
                    if skillInfoListMaxLength <= i then
                      (BattleUIWindow.RemoveSkillInfoPanel)(v)
                      rightSkillInfoList[i] = nil
                    else
                      hand:TweenMoveY(hand.y - hand.height, 0.2)
                    end
                  end
                  ;
                  (table.insert)(rightSkillInfoList, 1, {hand = skillInfoHand, timer = timer})
                  timer = (SimpleTimer.setTimeout)(skillInfoLast, function(...)
    -- function num : 0_49_1 , upvalues : BattleUIWindow, skillInfoHand, timer, rightSkillInfoList
    (BattleUIWindow.RemoveSkillInfoPanel)({hand = skillInfoHand, timer = timer})
    rightSkillInfoList[#rightSkillInfoList] = nil
  end
)
                end
              end
            end
          end
        end
      end
    end
  end
end

BattleUIWindow.RemoveSkillInfoPanel = function(skillInfo, ...)
  -- function num : 0_50 , upvalues : battleUIWindowObjectPool
  if skillInfo and battleUIWindowObjectPool then
    local timer = skillInfo.timer
    do
      if timer then
        timer:stop()
      end
      local skillInfoHand = skillInfo.hand
      if skillInfoHand then
        local trans = skillInfoHand:GetTransition("out")
        if trans then
          trans:Play(function(...)
    -- function num : 0_50_0 , upvalues : skillInfoHand, battleUIWindowObjectPool
    if skillInfoHand and battleUIWindowObjectPool then
      battleUIWindowObjectPool:ReturnObject(skillInfoHand)
    end
  end
)
        end
      end
    end
  end
end

BattleUIWindow.ShowSkillCard = function(param, ...)
  -- function num : 0_51 , upvalues : _ENV, uis
  if param then
    local posIndex = param.posIndex
    do
      local callBack = param.callBack
      local fashionId = param.fashionId
      local card = (BattleData.GetCardInfoByPos)(posIndex)
      local picShow = uis.PicShow
      local isRight = card:GetCampFlag() == BattleCardCamp.RIGHT
      if isRight then
        picShow = uis.ReversePicShow
      end
      local bgMove = picShow.BgMove
      local cardMove = picShow.CardMove
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (picShow.root).visible = true
      local loader = cardMove.CardLoader
      ;
      (Util.RecycleUIModel)(loader)
      ;
      (Util.CreateShowModel)(fashionId, loader, true, nil, nil, nil, {isRight = isRight})
      ;
      (Util.SetModelClip)(loader, cardMove.root, true)
      ;
      (LuaSound.PlaySound)(LuaSound.BATTLE_BIG_SKILL, SoundBank.OTHER)
      ;
      (AudioManager.PlayBattleVoice)(card:GetFashionId(), CVAudioType.UniqueSkillBubble)
      PlayUITrans(picShow.root, "Pic", function(...)
    -- function num : 0_51_0 , upvalues : picShow, loader, _ENV, callBack
    -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

    if picShow then
      (picShow.root).visible = false
    end
    if loader then
      (Util.RecycleUIModel)(loader)
    end
    callBack()
  end
)
      PlayUITrans(bgMove.root, "Bg")
      PlayUITrans(cardMove.root, "Card")
    end
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

BattleUIWindow.ShowSkillEffect = function(cardUis, battleCard, ...)
  -- function num : 0_52 , upvalues : _ENV
  if cardUis then
    if battleCard.isWaitPlayWaitUniqueSkillEffect == true then
      return 
    end
    if battleCard.isHeadUp == true then
      return 
    end
    local trans = (cardUis.root):GetTransition("battle_headicon_up")
    if trans then
      trans:Play()
      battleCard.isHeadUp = true
    end
    battleCard:PlayWaitUniqueSkillEffect()
    local effect = (cardUis.root):GetChild("DanderMaxEffect1")
    if effect then
      effect:RemoveFromParent()
      effect:Dispose()
    end
    local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_ANGER_BIG, true)
    if holder then
      (cardUis.root):AddChildAt(holder, 0)
      holder:SetXY((cardUis.root).width / 2, (cardUis.root).height / 2 + 28)
      holder.name = "DanderMaxEffect2"
    end
  end
end

BattleUIWindow.RemoveSkillEffect = function(cardUis, battleCard, ...)
  -- function num : 0_53
  if cardUis then
    do
      if battleCard.isHeadUp == true then
        local trans = (cardUis.root):GetTransition("battle_headicon_down")
        if trans then
          trans:Play()
          battleCard.isHeadUp = false
        end
        battleCard:RemoveWaitUniqueSkillEffect()
      end
      local effect = (cardUis.root):GetChild("DanderMaxEffect2")
      if effect then
        effect:RemoveFromParent()
        effect:Dispose()
      end
    end
  end
end

BattleUIWindow.UpdateWaveNum = function(waveTxt, ...)
  -- function num : 0_54 , upvalues : _ENV, uis
  if not waveTxt then
    waveTxt = BattleData.enemyCurWave .. "/" .. BattleData.enemyMaxWave
  end
  local waveNum = uis.WaveTxt
  waveNum.text = waveTxt
end

BattleUIWindow.UpdateRoundNum = function(curRound, ...)
  -- function num : 0_55 , upvalues : uis, _ENV
  local roundNum = uis.RoundNumTxt
  local maxRound = BattleData.maxRound
  roundNum.text = curRound .. "/" .. maxRound
end

BattleUIWindow.UpdateSkillUIState = function(visible, param, ...)
  -- function num : 0_56 , upvalues : contentPane, _ENV
  local interval = 0
  if visible == true then
    interval = param.interval
  end
  contentPane.touchable = visible
  contentPane.visible = visible
  if interval > 0 then
    local GTween = FairyGUI.GTween
    do
      local gt = (GTween.To)(0, 1, interval)
      gt:OnUpdate(function(...)
    -- function num : 0_56_0 , upvalues : contentPane, gt
    if contentPane then
      contentPane.alpha = (gt.value).x
    end
  end
)
    end
  end
end

BattleUIWindow.UpdateSettingUI = function(...)
  -- function num : 0_57 , upvalues : BattleUIWindow, _ENV
  (BattleUIWindow.UpdateActionUI)()
  local allCard = (BattleData.GetAliveCards)()
  for _,v in ipairs(allCard) do
    v:UpdateHeadInfoVisible()
  end
end

BattleUIWindow.UpdateActionUI = function(...)
  -- function num : 0_58 , upvalues : _ENV, isPlayingUniqueSkill, orderBackLineImage, orderHeadList
  local visible = false
  if (BattleConfig.IsHideBattleSpeed)() == false and isPlayingUniqueSkill == false then
    visible = true
  end
  orderBackLineImage.visible = visible
  for _,v in pairs(orderHeadList) do
    local head = v.head
    head.visible = visible
  end
end

BattleUIWindow.OnHide = function(...)
  -- function num : 0_59
end

BattleUIWindow.CloseBossHpTimer = function(...)
  -- function num : 0_60 , upvalues : hpChangeTimer
  if hpChangeTimer then
    hpChangeTimer:stop()
    hpChangeTimer = nil
  end
end

BattleUIWindow.ClearCardCampList = function(...)
  -- function num : 0_61 , upvalues : _ENV, cardCompList
  for _,v in pairs(cardCompList) do
    local cardUis = v.cardUis
    ;
    (cardUis.HeadIconLoader):Dispose()
  end
  cardCompList = {}
end

BattleUIWindow.OnClose = function(...)
  -- function num : 0_62 , upvalues : BattleUIWindow, _ENV, orderHeadList, moveIndex, nowBossHp, maxBossHp, curBarHpIndex, curBarHpValue, bossHpMoveSpeed, displayBossHp, displayCurBarHp, displayCurBarMaxHp, orderBackLineImage, leftSkillInfoList, rightSkillInfoList, isPlayingUniqueSkill, battleUIWindowObjectPool, uis, contentPane
  (BattleUIWindow.CloseBossHpTimer)()
  for _,v in pairs(orderHeadList) do
    if v.head then
      (v.head):Dispose()
    end
  end
  moveIndex = 0
  nowBossHp = 0
  maxBossHp = 0
  curBarHpIndex = 0
  curBarHpValue = 0
  bossHpMoveSpeed = 0
  displayBossHp = 0
  displayCurBarHp = 0
  displayCurBarMaxHp = 0
  orderBackLineImage = nil
  orderHeadList = {}
  leftSkillInfoList = {}
  rightSkillInfoList = {}
  isPlayingUniqueSkill = false
  if battleUIWindowObjectPool then
    battleUIWindowObjectPool:Clear()
    battleUIWindowObjectPool = nil
  end
  ;
  (BattleUIWindow.ClearCardCampList)()
  uis = nil
  contentPane = nil
  ;
  (GuideData.AbolishControlRefer)((WinResConfig.BattleUIWindow).name)
end

BattleUIWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_63 , upvalues : _ENV, BattleUIWindow
  local windowMsgEnum = WindowMsgEnum.BattleUIWindow
  if msgId == windowMsgEnum.E_MSG_UPDATE_ROUND then
    (BattleUIWindow.UpdateRoundNum)(para)
  else
    if msgId == windowMsgEnum.E_MSG_UPDATE_WAVE then
      (BattleUIWindow.UpdateWaveNum)(para)
    else
      if msgId == windowMsgEnum.E_MSG_UPDATE_CARD_HP then
        (BattleUIWindow.UpdateCardHp)(para)
      else
        if msgId == windowMsgEnum.E_MSG_UPDATE_CARD_SHIELD then
          (BattleUIWindow.UpdateCardShield)(para)
        else
          if msgId == windowMsgEnum.E_MSG_UPDATE_CARD_DANDER then
            (BattleUIWindow.UpdateCardRage)(para)
          else
            if msgId == windowMsgEnum.E_MSG_UPDATE_BOTTOM_HEAD then
              (BattleUIWindow.UpdateBottomHead)(para)
            else
              if msgId == windowMsgEnum.E_MSG_UPDATE_ORDER_LINE then
                (BattleUIWindow.UpdateOrderLine)(para)
              else
                if msgId == windowMsgEnum.E_MSG_RESET_ORDER_LINE then
                  (BattleUIWindow.ResetOrderCard)(para)
                else
                  if msgId == windowMsgEnum.E_MSG_REFRESH_ORDER_LINE then
                    (BattleUIWindow.RefreshOrderCard)(para)
                  else
                    if msgId == windowMsgEnum.E_MSG_SHOW_DAMAGE then
                      (BattleUIWindow.ShowDamagePanel)(para)
                    else
                      if msgId == windowMsgEnum.E_MSG_SHOW_SKILL_INFO then
                        (BattleUIWindow.AddSkillInfoPanel)(para)
                      else
                        if msgId == windowMsgEnum.E_MSG_CHANGE_WAVE_UPDATE then
                          (BattleUIWindow.ChangeWaveUpdateInfo)()
                        else
                          if msgId == windowMsgEnum.E_MSG_SHOW_WAVE_START then
                            (BattleUIWindow.ShowPlayWaveStart)(para)
                          else
                            if msgId == windowMsgEnum.E_MSG_SHOW_BOSS_COME then
                              (BattleUIWindow.ShowPlayBossCome)(para)
                            else
                              if msgId == windowMsgEnum.E_MSG_SHOW_UNIQUE_UI then
                                (BattleUIWindow.UpdateSkillUIState)(true, para)
                              else
                                if msgId == windowMsgEnum.E_MSG_HIDE_UNIQUE_UI then
                                  if Time.timeScale == 0 then
                                    return 
                                  end
                                  ;
                                  (BattleUIWindow.UpdateSkillUIState)(false)
                                else
                                  if msgId == windowMsgEnum.E_MSG_UPDATE_SETTING_UI then
                                    (BattleUIWindow.UpdateSettingUI)()
                                  else
                                    if msgId == windowMsgEnum.E_MSG_UPDATE_BOSS_BLOOD then
                                      (BattleUIWindow.UpdateBossHp)(para)
                                    else
                                      if msgId == windowMsgEnum.E_MSG_PLAY_SKILL_EFFECT then
                                        (BattleUIWindow.PlaySkillEffect)(para)
                                      else
                                        if msgId == windowMsgEnum.E_MSG_REOPEN then
                                          (BattleUIWindow.ChangeWaveUpdateInfo)()
                                          ;
                                          (BattleUIWindow.ShowPanel)()
                                        else
                                          if msgId == windowMsgEnum.E_MSG_PLAY_SKILL_CARD then
                                            (BattleUIWindow.ShowSkillCard)(para)
                                          else
                                            if msgId == windowMsgEnum.E_MSG_BATTLE_PAUSE then
                                              (BattleMgr.PauseBattle)()
                                              ;
                                              (BattleUIWindow.UpdateStopBtn)()
                                            end
                                          end
                                        end
                                      end
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

return BattleUIWindow

