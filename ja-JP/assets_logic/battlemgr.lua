-- params : ...
-- function num : 0 , upvalues : _ENV
BattleMgr = {}
local self = BattleMgr
local UIMgr = UIMgr
local BattleState = BattleState
local ipairs = ipairs
local tonumber = tonumber
local selfTxt, enemyTxt = nil, nil
-- DECOMPILER ERROR at PC10: Confused about usage of register: R7 in 'UnsetPending'

BattleMgr.InitBattle = function(...)
  -- function num : 0_0 , upvalues : _ENV, self
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

  if IsBattleServer == nil then
    BattleMgr.startRecord = false
    ;
    (BattleConfig.UpdateCurFrameRate)()
    ClearHurtNum()
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

    BattleMgr.BossInited = false
    ;
    (UpdateMgr.AddFixedUpdateHandler)(self.FixedUpdate)
    local battleCamera = Game.battleCamera
    do
      do
        if battleCamera then
          local ShakeAnimPlay = require("ShakeAnimPlay")
          ;
          (ShakeAnimPlay.EnableShake)(battleCamera, false)
          ;
          (Util.SetCameraActive)(battleCamera, true)
          if BattleConfig.runIntoBattle == true then
            (CSLuaUtil.SetGOLocalPos)(battleCamera, BattleConfig.battleCameraPosition + BattleConfig.battleStartCameraOffset)
          else
            ;
            (CSLuaUtil.SetGOLocalPos)(battleCamera, BattleConfig.battleCameraPosition)
          end
          ;
          (Util.SetCameraOrthographicSize)(battleCamera, BattleConfig.orthographicSize)
          ;
          (Util.SetCameraCullingMask)(battleCamera, BattleConfig.originBattleCameraCullingMask)
          ;
          (Util.MoveBattleCamera)(Vector3.zero, 0)
        end
        ;
        (BattleBackground.CreateBackground)()
        ;
        (self.CreateBattleUI)()
        ;
        (self.DealPreEvent)()
      end
    end
  end
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R7 in 'UnsetPending'

BattleMgr.CreateBattleUI = function(...)
  -- function num : 0_1 , upvalues : _ENV, UIMgr
  local battleType = BattleData.battleType
  local name = (WinResConfig.BattleUIWindow).name
  if OvertureMgr.isPlaying then
    if UIMgr:IsWindowOpen(name) == true then
      UIMgr:SendWindowMessage(name, (WindowMsgEnum.BattleUIWindow).E_MSG_REOPEN)
    else
      OpenWindow(name, UILayer.HUD)
    end
  else
    OpenWindow(name, UILayer.HUD)
  end
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R7 in 'UnsetPending'

BattleMgr.DealPreEvent = function(...)
  -- function num : 0_2 , upvalues : _ENV, BattleState
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

  BattleData.curPreBattleEventInfo = (BattleDataCount.InsertPreBattleCount)()
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((BattleData.battleData).battleProcessData)[BattleData.curWave]).preBattleEventInfo = BattleData.curPreBattleEventInfo
  if IsBattleServer == nil then
    (BattleData.SetBattleState)(BattleState.PRE_EVENT_ING)
    ;
    (BattlePlay.PlayBuffPreBattle)(function(...)
    -- function num : 0_2_0 , upvalues : _ENV, BattleState
    (BattleData.SetBattleState)(BattleState.WAVE_SHOW_BEGIN)
  end
)
  else
    ;
    (BattleData.SetBattleState)(BattleState.WAVE_SHOW_BEGIN)
  end
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R7 in 'UnsetPending'

BattleMgr.ShowBattleWave = function(...)
  -- function num : 0_3 , upvalues : _ENV, BattleState, UIMgr
  (BattleData.SetBattleState)(BattleState.WAVE_SHOW_ING)
  if IsBattleServer == nil then
    UIMgr:SendWindowMessage("BattleUIWindow", (WindowMsgEnum.BattleUIWindow).E_MSG_SHOW_WAVE_START, BattleData.enemyCurWave)
    UIMgr:SendWindowMessage("BattleUIWindow", (WindowMsgEnum.BattleUIWindow).E_MSG_UPDATE_WAVE, BattleData.enemyCurWave .. "/" .. BattleData.enemyMaxWave)
    print("当前波数：", BattleData.enemyCurWave)
  else
    ;
    (BattleData.SetBattleState)(BattleState.ROUND_START)
  end
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R7 in 'UnsetPending'

BattleMgr.GetCurWaveBossId = function(...)
  -- function num : 0_4 , upvalues : _ENV
  local curWave = BattleData.enemyCurWave
  local monsterGroup = (BattleData.GetMonsterGroup)(curWave)
  do
    if monsterGroup then
      local monsterConfig = ((TableData.gTable).BaseMonsterGroupData)[monsterGroup]
      if monsterConfig and monsterConfig.boss_id > 0 then
        return monsterConfig.boss_id, monsterConfig.hp_bar_count
      end
    end
    return 0, 0
  end
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R7 in 'UnsetPending'

BattleMgr.ShowBossTips = function(...)
  -- function num : 0_5 , upvalues : _ENV, BattleState, UIMgr
  (BattleData.SetBattleState)(BattleState.BOSS_SHOW_ING)
  if BattleData.curWaveBossId > 0 then
    UIMgr:SendWindowMessage("BattleUIWindow", (WindowMsgEnum.BattleUIWindow).E_MSG_SHOW_BOSS_COME)
  else
    ;
    (BattleData.SetBattleState)(BattleState.ROUND_START)
  end
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R7 in 'UnsetPending'

BattleMgr.ShowBattleRound = function(...)
  -- function num : 0_6 , upvalues : _ENV, BattleState, ipairs, UIMgr
  (BattleData.SetBattleState)(BattleState.ROUND_PLAYING)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

  BattleData.roundIndex = BattleData.roundIndex + 1
  if (BattleResultCount.IsWaveOver)() == true then
    return 
  end
  if IsBattleServer == nil then
    (BattleData.SaveBattleProcess)((string.format)("第 %d 回合", BattleData.roundIndex))
  end
  loge("----------------------大回合前的卡片状态-----------------------------")
  if IsBattleServer == true then
    local allCardList = (BattleData.GetAllCardList)()
    for i,v in ipairs(allCardList) do
      if IsBattleServer == true then
        do
          print("pos:", v:GetPosIndex(), " hp:", v:GetHp(), " maxHp:", v:GetMaxHp())
          -- DECOMPILER ERROR at PC55: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC55: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    local preRoundInfo = nil
    if not (BattleData.allRoundData)[BattleData.roundIndex] then
      (BattleBuffMgr.SetAllBuffRoundActive)(false)
      preRoundInfo = (BattleAtk.InsertPreRoundInfo)()
      ;
      (BattleBuffMgr.SetAllBuffRoundActive)(true)
      -- DECOMPILER ERROR at PC88: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (BattleData.allRoundData)[BattleData.roundIndex] = {round = BattleData.roundIndex, preRoundInfo = preRoundInfo, 
attackInfo = {}
}
    end
    -- DECOMPILER ERROR at PC95: Confused about usage of register: R2 in 'UnsetPending'

    BattleData.curRoundData = (BattleData.allRoundData)[BattleData.roundIndex]
    if IsBattleServer == nil then
      UIMgr:SendWindowMessage("BattleUIWindow", (WindowMsgEnum.BattleUIWindow).E_MSG_UPDATE_ROUND, BattleData.roundIndex)
      ;
      (BattleData.SetBattleState)(BattleState.PRE_ROUND_PLAY)
    else
      ;
      (BattleData.SetBattleState)(BattleState.CHANGE_ATTACK)
    end
    print("当前回合数：", BattleData.roundIndex)
  end
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R7 in 'UnsetPending'

BattleMgr.InitCurAtkInfo = function(...)
  -- function num : 0_7 , upvalues : _ENV, ipairs, BattleState, self
  local allCardList = (BattleData.GetAllCardList)()
  for _,card in ipairs(allCardList) do
    if card and card:GetHp() <= 0 then
      (BattleBuffMgr.ClearCardBuff)(card:GetPosIndex())
    end
  end
  loge("----------------------出手回合前的卡片状态-----------------------------")
  local allCardList = (BattleData.GetAllCardList)()
  if IsBattleServer == nil and BattleConfig.isPlayBack ~= true then
    for i,v in ipairs(allCardList) do
      print("pos:", v:GetPosIndex(), " hp:", v:GetHp(), " displayHp:", v:GetDisPlayHp(), " dander:", v:GetDander(), " maxHp:", v:GetMaxHp())
      if v:GetHp() ~= v:GetDisPlayHp() then
        loge("战斗异常，表现血量和实际血量对不上")
        ;
        (BattleData.SetBattleState)(BattleState.BATTLE_ERROR)
        return 
      end
    end
  end
  do
    ;
    (BattleData.SetBattleState)(BattleState.ROUND_PLAYING)
    if (BattleResultCount.IsWaveOver)() == true then
      return 
    end
    if BattleConfig.isPlayBack == true then
      (self.StartToAtkPlayBack)()
      return 
    end
    ;
    (BattleDataCount.ClearNoUsedBuffCount)()
    ;
    (BattleBuffMgr.SetAllBuffRoundActive)(false)
    ;
    (BattleData.AddAutoSkill)()
    local curSkill = (BattleData.GetCurSkillAtk)()
    if curSkill then
      PrintTable(curSkill, " 找到必杀技： ")
      local cardUid = curSkill.cardUid
      local skillConfig = curSkill.skillConfig
      local atkCard = (BattleData.GetCardInfoByUid)(cardUid)
      if (BattleSkill.IsNoAttackActionSkill)(skillConfig) then
        (BattleAtk.InsertBuffNoAtk)(atkCard, false, skillConfig)
      else
        ;
        (BattleAtk.InsertSkillInfo)(curSkill)
      end
      local curAtkInfo = BattleAtk.curAtkInfo
      if curAtkInfo then
        (BattleMgr.GetAtkInfoDes)(curAtkInfo)
        ;
        (BattleBuffMgr.SetAllBuffRoundActive)(true)
        ;
        (BattleData.SetBattleState)(BattleState.BUFF_BEFORE_ATTACK)
        return 
      end
    end
    do
      ;
      (self.StartToAtk)()
    end
  end
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R7 in 'UnsetPending'

BattleMgr.StartToAtkPlayBack = function(...)
  -- function num : 0_8 , upvalues : _ENV, UIMgr, BattleState
  local attackInfo = (BattleData.curRoundData).attackInfo
  if attackInfo and attackInfo[1] then
    local atkInfo = attackInfo[1]
    local guideProcess = atkInfo.guideProcess
    if guideProcess then
      atkInfo.guideProcess = nil
      ;
      (GuideMgr.SetProcessEndCallBack)(guideProcess, BattleMgr.StartToAtkPlayBack)
      ;
      (GuideMgr.SetFirstGuideData)(guideProcess)
      ;
      (GuideMgr.CurrentGuideIsDungeon)(false)
      ;
      (GuideMgr.PlayGuide)(atkInfo.guideFirst)
      return 
    end
    if IsBattleServer ~= true then
      UIMgr:SendWindowMessage("BattleUIWindow", (WindowMsgEnum.BattleUIWindow).E_MSG_UPDATE_ORDER_LINE)
    end
    local atkCardUid = (attackInfo[1]).atkCardUid
    local skillType = (attackInfo[1]).skillType
    if skillType ~= BattleSkillType.SKILL then
      local card = (BattleData.GetCardInfoByUid)(atkCardUid)
      if card then
        card:SetIsAlreadyAtk(true)
        local nextCard = (BattleData.GetCurAtkCard)()
        if nextCard then
          nextCard:SetIsAlreadyAtk(false, true)
        end
      end
    end
    do
      do
        -- DECOMPILER ERROR at PC69: Confused about usage of register: R5 in 'UnsetPending'

        BattleAtk.curAtkInfo = atkInfo
        ;
        (table.remove)(attackInfo, 1)
        ;
        (BattleData.SetBattleState)(BattleState.BUFF_BEFORE_ATTACK)
        ;
        (BattleData.SetBattleState)(BattleState.CHANGE_ROUND)
      end
    end
  end
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R7 in 'UnsetPending'

BattleMgr.StartToAtk = function(...)
  -- function num : 0_9 , upvalues : _ENV, UIMgr, BattleState
  local BattleAtk = BattleAtk
  local atkCard = (BattleData.GetCurAtkCard)()
  if atkCard then
    if IsBattleServer ~= true then
      UIMgr:SendWindowMessage("BattleUIWindow", (WindowMsgEnum.BattleUIWindow).E_MSG_UPDATE_ORDER_LINE)
    end
    atkCard:SetIsAlreadyAtk(true)
    local nextCard = (BattleData.GetCurAtkCard)()
    if nextCard then
      nextCard:SetIsAlreadyAtk(false, true)
    end
    log("创建攻击数据")
    local isSmallSkill = (BattleAtk.GetIsUseSmallSkill)(atkCard)
    if isSmallSkill == true then
      if (BattleBuff.IsForbiddenSmall)(atkCard) == true then
        (BattleAtk.InsetAttackFailInfo)(atkCard)
      else
        local skillConfig = atkCard:GetSmallSkillConfig()
        if (BattleSkill.IsNoAttackActionSkill)(skillConfig) then
          (BattleAtk.InsertBuffNoAtk)(atkCard, false, skillConfig)
        else
          ;
          (BattleAtk.InsertSmallSkillInfo)(atkCard)
        end
      end
    else
      do
        if (BattleBuff.IsForbiddenNormal)(atkCard) == true then
          (BattleAtk.InsetAttackFailInfo)(atkCard)
        else
          local skillConfig = atkCard:GetNormalAttackConfig()
          if (BattleSkill.IsNoAttackActionSkill)(skillConfig) then
            (BattleAtk.InsertBuffNoAtk)(atkCard, false, skillConfig)
          else
            ;
            (BattleAtk.InsetNormalAttackInfo)(atkCard)
          end
        end
        do
          do
            local curAtkInfo = BattleAtk.curAtkInfo
            if curAtkInfo then
              (BattleMgr.GetAtkInfoDes)(curAtkInfo)
              ;
              (BattleBuffMgr.SetAllBuffRoundActive)(true)
              ;
              (BattleData.SetBattleState)(BattleState.BUFF_BEFORE_ATTACK)
            end
            ;
            (BattleData.SetBattleState)(BattleState.CHANGE_ROUND)
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R7 in 'UnsetPending'

BattleMgr.TurnToNextRound = function(...)
  -- function num : 0_10 , upvalues : _ENV, self
  (BattleData.ClearAtkFlag)()
  ;
  (self.ShowBattleRound)()
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R7 in 'UnsetPending'

BattleMgr.TurnToNextWave = function(...)
  -- function num : 0_11 , upvalues : _ENV, BattleState, self, UIMgr
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

  BattleMgr.BossInited = false
  local BattleData = BattleData
  BattleData.enemyCurWave = BattleData.enemyCurWave + 1
  ;
  (BattleData.SetBattleState)(BattleState.CHANGE_WAVEING)
  BattleData.roundIndex = 0
  BattleData.curWaveBossId = (self.GetCurWaveBossId)()
  ;
  (BattleData.InitWaveInfo)()
  ;
  (BattleData.InitCardData)(true)
  ;
  (BattleData.ClearAtkFlag)()
  if IsBattleServer == nil then
    (BattleBackground.CreateBackground)(true)
    ;
    (BattlePlay.CreateAllCard)()
    ;
    (BattlePlay.ShowCardEnter)(true)
    UIMgr:SendWindowMessage("BattleUIWindow", (WindowMsgEnum.BattleUIWindow).E_MSG_CHANGE_WAVE_UPDATE)
  else
    ;
    (self.DealPreEvent)()
  end
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R7 in 'UnsetPending'

BattleMgr.IsInBattle = function(...)
  -- function num : 0_12 , upvalues : _ENV, BattleState
  local state = (BattleData.GetBattleState)()
  do return state ~= BattleState.BATTLE_CLOSE end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R7 in 'UnsetPending'

BattleMgr.ResetCameraAnimator = function(...)
  -- function num : 0_13 , upvalues : _ENV, ipairs
  local cameraList = {Game.battleCamera, Game.skillCamera}
  local Animator = (CS.UnityEngine).Animator
  for _,camera in ipairs(cameraList) do
    local anim = camera:GetComponent(typeof(Animator))
    if anim then
      (((CS.UnityEngine).Object).DestroyImmediate)(anim)
      anim = camera:AddComponent(typeof(Animator))
      ;
      (CSLuaUtil.SetAnimatorController)(anim, "BattleSceneShake/BattleCameraShake")
    end
  end
end

-- DECOMPILER ERROR at PC52: Confused about usage of register: R7 in 'UnsetPending'

BattleMgr.CloseBattle = function(force, callback, noLoading, ...)
  -- function num : 0_14 , upvalues : _ENV, self, selfTxt, enemyTxt, BattleState, UIMgr
  local Util = Util
  local Game = Game
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R5 in 'UnsetPending'

  Time.timeScale = 1
  if IsBattleServer == nil then
    local clearFunc = function(...)
    -- function num : 0_14_0 , upvalues : _ENV, self, Util, Game, selfTxt, enemyTxt, BattleState
    local launch = (CS.Launch).Singleton
    launch.TimelineCamera = nil
    ;
    (AudioManager.StopAllBattleVoice)()
    ;
    (UpdateMgr.RemoveFixedUpdateHandler)(self.FixedUpdate)
    ;
    (SimpleTimer.StopAllTimer)()
    ;
    (LeanTween.cancelAll)()
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

    Time.timeScale = 1
    ;
    (BattleCameraMgr.mirrorCamera)(false)
    ;
    (Util.SetCameraActive)(Game.battleRightCamera, false)
    ;
    (BattleMgr.ResetCameraAnimator)()
    ;
    (Util.SetCameraCullingMask)(Game.battleCamera, BattleConfig.originBattleCameraCullingMask)
    selfTxt = nil
    enemyTxt = nil
    ;
    (GuideMgr.ClearFightMildGuide)()
    ;
    (BattleCameraMgr.Clear)()
    ;
    (BattleData.SetBattleState)(BattleState.BATTLE_CLOSE)
    local cameraSkill = (Game.skillCamera):GetComponentInChildren(typeof(Camera))
    if cameraSkill then
      cameraSkill:ResetProjectionMatrix()
    end
    local cameraSkillRole = (Game.skillRoleCamera):GetComponentInChildren(typeof(Camera))
    if cameraSkillRole then
      cameraSkillRole:ResetProjectionMatrix()
    end
    local cameraSkillBg = (Game.skillBgCamera):GetComponentInChildren(typeof(Camera))
    if cameraSkillBg then
      cameraSkillBg:ResetProjectionMatrix()
    end
    local SkillParse = require("SkillParse")
    ClearSkillMask(nil, true)
    ;
    (SkillParse.Clear)()
    ;
    (Util.MoveBattleCamera)(Vector3.zero, 0)
    ;
    (Util.SetCameraActive)(Game.battleCamera, false)
    ;
    (BattleBuffMgr.InitBuffList)()
    ;
    (BattleData.ClearBattleData)()
    ClearHurtNum()
    ;
    (BattleBackground.ClearBackground)()
    if BattleRoot and BattleRoot.transform then
      local count = (BattleRoot.transform).childCount
      for index = count - 1, 0, -1 do
        local child = (BattleRoot.transform):GetChild(index)
        if child then
          local name = child.name
          if (string.find)(name, "cardspine") == true then
            (ResHelper.DestroyGameObject)(child.gameObject)
          else
            ;
            (ResHelper.DestroyGameObject)(child.gameObject, false)
          end
        end
      end
    end
    do
      ;
      (ResHelper.ClearModel)()
      ;
      (ResHelper.ClearEffect)()
      ;
      (((CS.UnityEngine).Resources).UnloadUnusedAssets)()
      ;
      (((CS.System).GC).Collect)()
      collectgarbage("collect")
      ;
      (CSLuaUtil.SetGOLocalPos)(Game.battleCamera, BattleConfig.battleCameraPosition)
    end
  end

    do
      if noLoading == true then
        clearFunc()
        ;
        (Game.SetMainFramerate)()
        if callback then
          callback()
        end
        return 
      end
      UIMgr:SetOnShownComplete((WinResConfig.LoadingWindow).name, function(...)
    -- function num : 0_14_1 , upvalues : _ENV, clearFunc, UIMgr, force, Game, callback
    local batteleType = BattleData.battleType
    clearFunc()
    ;
    (((LeanTween.value)(0, 1, 0.3)):setOnUpdate(function(value, ...)
      -- function num : 0_14_1_0 , upvalues : UIMgr, _ENV
      UIMgr:SendWindowMessage((WinResConfig.LoadingWindow).name, (WindowMsgEnum.LoadingWindow).E_MSG_UPDATE_LOADING_PROCESS, value)
    end
)):setOnComplete(function(...)
      -- function num : 0_14_1_1 , upvalues : force, UIMgr, _ENV, Game, batteleType, callback
      force = force or false
      UIMgr:CloseWindow((WinResConfig.LoadingWindow).name, true, force)
      ;
      (Game.SetMainFramerate)()
      if batteleType == (ProtoEnum.E_BATTLE_TYPE).TOWER or batteleType == (ProtoEnum.E_BATTLE_TYPE).TOWER_ENCOUNTER then
        (LuaSound.LoadAndPlayBGM)(1040011)
      else
        ;
        (LuaSound.LoadAndPlayBGM)(1010002)
      end
      if callback then
        callback()
      end
    end
)
  end
)
      OpenWindow((WinResConfig.LoadingWindow).name, UILayer.Loading)
    end
  else
    do
      ;
      (BattleData.SetBattleState)(BattleState.BATTLE_CLOSE)
      loge("战斗结束")
    end
  end
end

-- DECOMPILER ERROR at PC55: Confused about usage of register: R7 in 'UnsetPending'

BattleMgr.FixedUpdate = function(...)
  -- function num : 0_15 , upvalues : _ENV, self, BattleState
  if IsBattleServer == true then
    return 
  end
  if (self.IsAllAtkComplete)() == true and (BattleData.GetBattleState)() == BattleState.BUFF_AFTER_ATTACK_END then
    (BattleData.SetBattleState)(BattleState.CHANGE_ATTACK)
  end
  local curState = (BattleData.GetBattleState)()
  ;
  (self.PlayBattleState)(curState)
  ;
  (BattlePlay.UpdateCardFloat)()
end

-- DECOMPILER ERROR at PC57: Confused about usage of register: R7 in 'UnsetPending'

BattleMgr.startRecord = false
local startTime = 0
local textHand = nil
-- DECOMPILER ERROR at PC62: Confused about usage of register: R9 in 'UnsetPending'

BattleMgr.ShowLeftCardSkeletonFrame = function(...)
  -- function num : 0_16 , upvalues : textHand, _ENV, startTime
  if textHand == nil then
    textHand = ((FairyGUI.UIObjectFactory).NewObject)((FairyGUI.ObjectType).Text)
    textHand.color = ((CS.UnityEngine).Color)(1, 0, 0)
    textHand.x = 200
    textHand.y = 200
    textHand:SetScale(5, 5)
    ;
    (GRoot.inst):AddChild(textHand)
  end
  if BattleMgr.startRecord == true then
    textHand.text = (math.ceil)((Time.fixedTime - startTime) / 0.016)
  else
    textHand.text = ""
    startTime = Time.fixedTime
  end
end

-- DECOMPILER ERROR at PC65: Confused about usage of register: R9 in 'UnsetPending'

BattleMgr.SetTestHpTxt = function(self, enemy, ...)
  -- function num : 0_17 , upvalues : selfTxt, enemyTxt
  selfTxt = self
  selfTxt.visible = false
  enemyTxt.visible = false
end

local ShowHpInfo = function(team, txtCtrl, ...)
  -- function num : 0_18 , upvalues : ipairs, _ENV
  local remainHp = 0
  local totalHp = 0
  if team and txtCtrl then
    for i,v in ipairs(team) do
      remainHp = remainHp + (math.max)(v:GetDisPlayHp(), 0)
      totalHp = totalHp + v:GetMaxHp()
    end
  end
  do
    if totalHp > 0 then
      txtCtrl.text = (string.format)("%.1f", (remainHp) * 100 / (totalHp)) .. "%"
    else
      txtCtrl.text = ""
    end
  end
end

-- DECOMPILER ERROR at PC69: Confused about usage of register: R10 in 'UnsetPending'

BattleMgr.UpdateTestHp = function(...)
  -- function num : 0_19 , upvalues : selfTxt, enemyTxt, _ENV, ShowHpInfo
  if selfTxt and enemyTxt then
    selfTxt.visible = true
    enemyTxt.visible = true
    local leftTeam = (BattleData.GetTeam)(BattleCardCamp.LEFT)
    local rightTeam = (BattleData.GetTeam)(BattleCardCamp.RIGHT)
    ShowHpInfo(leftTeam, selfTxt)
    ShowHpInfo(rightTeam, enemyTxt)
  end
end

-- DECOMPILER ERROR at PC72: Confused about usage of register: R10 in 'UnsetPending'

BattleMgr.PlayBattleState = function(curState, ...)
  -- function num : 0_20 , upvalues : BattleState, self, _ENV, tonumber
  local switch = {[BattleState.PRE_EVENT_BEGIN] = function(...)
    -- function num : 0_20_0 , upvalues : self
    (self.DealPreEvent)()
  end
, [BattleState.WAVE_SHOW_BEGIN] = function(...)
    -- function num : 0_20_1 , upvalues : self
    (self.ShowBattleWave)()
  end
, [BattleState.BOSS_SHOW_BEGIN] = function(...)
    -- function num : 0_20_2 , upvalues : self
    (self.ShowBossTips)()
  end
, [BattleState.ROUND_START] = function(...)
    -- function num : 0_20_3 , upvalues : self
    (self.ShowBattleRound)()
  end
, [BattleState.PRE_ROUND_PLAY] = function(...)
    -- function num : 0_20_4 , upvalues : _ENV
    (BattlePlay.PlayPreRoundInfo)()
  end
, [BattleState.CHANGE_ATTACK] = function(...)
    -- function num : 0_20_5 , upvalues : _ENV
    (BattlePlay.PlayEnd)()
  end
, [BattleState.BUFF_BEFORE_ATTACK] = function(...)
    -- function num : 0_20_6 , upvalues : _ENV
    (BattlePlay.PlayBuffBeforeAtk)()
  end
, [BattleState.PLAY_ATTACK] = function(...)
    -- function num : 0_20_7 , upvalues : _ENV
    (BattlePlay.PlayAtk)()
  end
, [BattleState.BUFF_AFTER_ATTACK] = function(...)
    -- function num : 0_20_8 , upvalues : _ENV
    (BattlePlay.PlayBuffAfterAtk)()
  end
, [BattleState.CHANGE_ROUND] = function(...)
    -- function num : 0_20_9 , upvalues : self
    (self.TurnToNextRound)()
  end
, [BattleState.CHANGE_WAVE] = function(...)
    -- function num : 0_20_10 , upvalues : _ENV, BattleState, self
    (BattleData.SetBattleState)(BattleState.CHANGE_WAVEING)
    if IsBattleServer == nil then
      (SimpleTimer.setTimeout)(0.5, function(...)
      -- function num : 0_20_10_0 , upvalues : self
      (self.TurnToNextWave)()
    end
)
    else
      ;
      (self.TurnToNextWave)()
    end
  end
, [BattleState.BATTLE_OVER] = function(...)
    -- function num : 0_20_11 , upvalues : _ENV, BattleState, self, tonumber
    -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

    if IsBattleServer == nil then
      Time.timeScale = 1
      ;
      (BattleData.SetBattleState)(BattleState.SEND_BATTLE_END_MSG)
      ;
      (UpdateMgr.RemoveFixedUpdateHandler)(self.FixedUpdate)
      local callBack = function(...)
      -- function num : 0_20_11_0 , upvalues : _ENV, self
      OpenPlotPlay(BattleData.stageId, PlotPlayTriggerType.BEFORE_VICTORY, function(...)
        -- function num : 0_20_11_0_0 , upvalues : _ENV, self
        (BattlePlay.PlayBattleWin)(self.DealBattleOver)
      end
, BattleData.battleType == (ProtoEnum.E_BATTLE_TYPE).CG)
      -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end

      do
        local isWin, actionInfo = (BattleResultCount.IsBattleWin)()
        if isWin == true then
          do
            if actionInfo then
              local action_table = split(actionInfo.action, "|")
              local posIndex = actionInfo.posIndex
              if action_table and action_table[1] == "run" then
                local card = (BattleData.GetCardInfoByPos)(posIndex)
                if card and card:GetHp() > 0 then
                  if action_table[2] then
                    card:ShowTalk((PUtil.get)(tonumber(action_table[2])))
                  end
                  ;
                  (SimpleTimer.setTimeout)(3, function(...)
      -- function num : 0_20_11_1 , upvalues : _ENV, posIndex, card, action_table, callBack
      if (BattleMgr.IsInBattle)() == false then
        return 
      end
      ;
      (BattleBuffMgr.ClearCardBuff)(posIndex)
      card:ChangeState(action_table[1], true)
      local position = card.position
      local model = card:GetModel()
      local move = BattleConfig.nextWaveCardMoveX
      local moveTime = BattleConfig.nextWaveCardMoveTime
      ;
      (SkeletonAnimationUtil.SetFlip)(model, false, false)
      ;
      ((LeanTween.moveLocalX)(model, position.x + move, moveTime)):setOnComplete(function(...)
        -- function num : 0_20_11_1_0 , upvalues : callBack
        callBack()
      end
)
      local shadow = card:GetShadow()
      ;
      (LeanTween.moveLocalX)(shadow, position.x + move, moveTime)
    end
)
                else
                  callBack()
                end
              end
            else
              do
                callBack()
                ;
                (self.DealBattleOver)()
              end
            end
            ;
            (self.DealBattleOver)()
          end
        end
      end
    end
  end
}
  local func = switch[curState]
  if func then
    func()
  end
end

-- DECOMPILER ERROR at PC75: Confused about usage of register: R10 in 'UnsetPending'

BattleMgr.DealBattleOver = function(...)
  -- function num : 0_21 , upvalues : _ENV, ipairs, self
  do
    if IsBattleServer == nil and OvertureMgr.isPlaying == true then
      local callback = BattleData.endCallback
      if callback then
        callback()
        return 
      end
    end
    local E_BATTLE_TYPE = ProtoEnum.E_BATTLE_TYPE
    ;
    (BattleBuffMgr.InitBuffList)()
    local battleType = BattleData.battleType
    local battleCompleteData = {}
    battleCompleteData.success = BattleResultCount.isBattleWin
    battleCompleteData.damageData = {}
    battleCompleteData.battleData = BattleData.battleData
    battleCompleteData.id = BattleData.stageId
    battleCompleteData.notEnterBattle = false
    battleCompleteData.allTeamCardState = BattleData.allBattleTeamCardState
    if battleType == E_BATTLE_TYPE.EXPEDITION and IsBattleServer ~= true then
      battleCompleteData.expeditionBattleData = {changeFc = (ExpeditionMgr.GetExpeditionChangeFc)(), selfMaxFc = (ExpeditionMgr.GetExpeditionSelfMaxFc)(), stageId = (ExpeditionMgr.GetCurrentStage)()}
    end
    local saveErrorLog = false
    if BattleData.receiveAllTeamCardState and (table.equal)(BattleData.receiveAllTeamCardState, BattleData.allBattleTeamCardState) == false then
      if IsBattleServer == true then
        LOG_ERROR("receiveAllTeamCardState ~= allBattleTeamCardState")
        saveErrorLog = true
      else
        loge("卡片状态对不上")
      end
    end
    battleCompleteData.challengeType = (BattleData.GetChallengeType)(battleType)
    do
      if battleType == E_BATTLE_TYPE.GOLD or battleType == E_BATTLE_TYPE.EXP or battleType == E_BATTLE_TYPE.EQUIPEXP then
        local totalDamage, totalHp = (BattleResultCount.GetRealTotalDamage)()
        -- DECOMPILER ERROR at PC100: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (battleCompleteData.damageData).totalEnemyHp = totalHp
        -- DECOMPILER ERROR at PC102: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (battleCompleteData.damageData).totalSelfDamage = totalDamage
      end
      battleCompleteData.challengeSummarizeData = (BattleResultCount.GetBattleDamageData)()
      if IsBattleServer == nil then
        if IsBattleTest == true then
          for waveNum,data in ipairs((BattleData.battleData).battleProcessData) do
            local roundData = data.roundData
            -- DECOMPILER ERROR at PC125: Confused about usage of register: R10 in 'UnsetPending'

            BattleTestResult.roundCount = BattleTestResult.roundCount + #roundData
          end
          print("战斗结果：")
          print("是否获胜：", BattleResultCount.isBattleWin, "总回合数：", BattleTestResult.roundCount)
          return 
        end
        -- DECOMPILER ERROR at PC154: Confused about usage of register: R4 in 'UnsetPending'

        if (battleType == E_BATTLE_TYPE.STORY or battleType == E_BATTLE_TYPE.HERO or battleType == E_BATTLE_TYPE.ACTIVITY) and PlotDungeonService then
          PlotDungeonMgr.saveStageId = battleCompleteData.id
          ;
          (PlotDungeonService.ReqSettleStage)(battleCompleteData)
        end
        if (battleType == E_BATTLE_TYPE.GOLD or battleType == E_BATTLE_TYPE.EXP or battleType == E_BATTLE_TYPE.EQUIPEXP) and DailyDungeonService then
          (DailyDungeonService.ReqSettleTrial)(battleCompleteData)
        end
        if battleType == E_BATTLE_TYPE.ARENA then
          local fightResult = (ArenaData.GetFightResult)()
          if fightResult then
            (CommonWinMgr.OpenArenaBattleWindow)(fightResult)
            ;
            (ArenaData.SaveFightResult)()
          else
            ;
            (self.CloseBattle)()
          end
        else
          do
            if battleType == E_BATTLE_TYPE.ADVENTURE then
              (AdventureService.ReqSettleAdventureBattle)(battleCompleteData)
            else
              if battleType == E_BATTLE_TYPE.GUILD_PK then
                (GuildMgr.AfterBattle)({success = battleCompleteData.success})
              else
                if battleType == E_BATTLE_TYPE.TOWER then
                  (TowerService.ReqSettleTower)(battleCompleteData)
                else
                  if battleType == E_BATTLE_TYPE.TOWER_ENCOUNTER then
                    (TowerService.ReqSettleEncounter)(battleCompleteData)
                  else
                    if battleType == E_BATTLE_TYPE.EXPEDITION then
                      (ExpeditionService.OnReqSettleExpedition)((ExpeditionMgr.GetCurrentStage)(), battleCompleteData)
                    else
                      if battleType == E_BATTLE_TYPE.CG then
                        (HandBookService.OnReqSettleCGCopyStage)(battleCompleteData)
                      end
                    end
                  end
                end
              end
            end
            do
              if Game.testPackage ~= true then
                local str = PrintTable(battleCompleteData, "battleCompleteData")
                ;
                ((CS.FileManager).WriteFile)("BattleResult/BattleResult" .. (LuaTime.GetStampStr)(BattleData.curBattleTime) .. ".txt", str)
              end
              -- DECOMPILER ERROR at PC271: Confused about usage of register: R4 in 'UnsetPending'

              BattleData.serverBattleData = battleCompleteData
              -- DECOMPILER ERROR at PC283: Confused about usage of register: R4 in 'UnsetPending'

              if IsBattleTest == true then
                if BattleResultCount.isBattleWin == true then
                  BattleTestResult.winCount = BattleTestResult.winCount + 1
                else
                  -- DECOMPILER ERROR at PC289: Confused about usage of register: R4 in 'UnsetPending'

                  BattleTestResult.failCount = BattleTestResult.failCount + 1
                end
                for waveNum,data in ipairs((BattleData.battleData).battleProcessData) do
                  local roundData = data.roundData
                  -- DECOMPILER ERROR at PC302: Confused about usage of register: R10 in 'UnsetPending'

                  BattleTestResult.roundCount = BattleTestResult.roundCount + #roundData
                end
              end
              do
                if saveErrorLog == true then
                  local str = PrintTable(BattleData.serverBattleData, "battleCompleteData")
                  if FileUtil then
                    (FileUtil.WriteFile)("BattleResult/BattleResult" .. (LuaTime.GetStampStr)(BattleData.curBattleTime) .. "_Server.txt", str)
                  end
                  local str2 = PrintTable(BattleData.saveClientBattleData, "battleCompleteData")
                  if FileUtil then
                    (FileUtil.WriteFile)("BattleResult/BattleResult" .. (LuaTime.GetStampStr)(BattleData.curBattleTime) .. "_Client.txt", str2)
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

-- DECOMPILER ERROR at PC78: Confused about usage of register: R10 in 'UnsetPending'

BattleMgr.PauseBattle = function(...)
  -- function num : 0_22 , upvalues : _ENV, self
  if Time.timeScale ~= 0 then
    self.saveTimeScale = Time.timeScale
  end
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

  Time.timeScale = 0
end

-- DECOMPILER ERROR at PC81: Confused about usage of register: R10 in 'UnsetPending'

BattleMgr.ContinueBattle = function(...)
  -- function num : 0_23 , upvalues : _ENV, self
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  Time.timeScale = self.saveTimeScale
  self.saveTimeScale = nil
end

-- DECOMPILER ERROR at PC84: Confused about usage of register: R10 in 'UnsetPending'

BattleMgr.IsAllAtkComplete = function(...)
  -- function num : 0_24 , upvalues : _ENV, ipairs
  local waitActionCardPosTable = BattleAtk.waitActionCardPosTable
  if #waitActionCardPosTable > 0 then
    for i,v in ipairs(waitActionCardPosTable) do
      if v.actionComplete == false then
        return false
      end
    end
    return true
  else
    return true
  end
end

-- DECOMPILER ERROR at PC87: Confused about usage of register: R10 in 'UnsetPending'

BattleMgr.GetAtkInfoDes = function(atkInfo, ...)
  -- function num : 0_25 , upvalues : _ENV, ipairs
  if IsBattleServer == true then
    return 
  end
  local hpAtk = atkInfo.hpAtk
  local danderAtk = atkInfo.danderAtk
  local atkPos = atkInfo.atkPos
  loge("本回合攻击数据")
  print("    攻击者位置:", atkPos, " 血量变化：", hpAtk, " 怒气变化：", danderAtk)
  ;
  (BattleData.SaveBattleProcess)("    攻击者位置:" .. atkPos .. " 血量变化：" .. hpAtk .. " 怒气变化：" .. danderAtk)
  local defCardInfo = atkInfo.defCardsInfo
  for i,v in ipairs(defCardInfo) do
    local defHp = v.hpDef
    local danderDef = v.danderDef
    local defPos = v.defPos
    print("       受击者位置:", defPos, " 血量变化：", defHp, " 怒气变化：", danderDef)
    ;
    (BattleData.SaveBattleProcess)("       受击者位置:" .. defPos .. " 血量变化：" .. defHp .. " 怒气变化：" .. danderDef)
  end
  local assistInfo = atkInfo.assistAtkInfo
  for i,v in ipairs(assistInfo) do
    local hpAtk = v.hpAtk
    local danderAtk = v.danderAtk
    local atkPos = v.atkPos
    print("    协击者位置:", atkPos, " 血量变化：", hpAtk, " 怒气变化：", danderAtk)
    ;
    (BattleData.SaveBattleProcess)("    协击者位置:" .. atkPos .. " 血量变化：" .. hpAtk .. " 怒气变化：" .. danderAtk)
    local defCardInfo = v.defCardsInfo
    for _,v2 in ipairs(defCardInfo) do
      local defHp = v2.hpDef
      local danderDef = v2.danderDef
      local defPos = v2.defPos
      print("       协击受击者位置:", defPos, " 血量变化：", defHp, " 怒气变化：", danderDef)
      ;
      (BattleData.SaveBattleProcess)("       协击受击者位置:" .. defPos .. " 血量变化：" .. defHp .. " 怒气变化：" .. danderDef)
    end
  end
end

-- DECOMPILER ERROR at PC90: Confused about usage of register: R10 in 'UnsetPending'

BattleMgr.GetPreBattleEvent = function(battleType, stageId, battleData, ...)
  -- function num : 0_26 , upvalues : _ENV, ipairs, tonumber
  local eventTable = {}
  local E_BATTLE_TYPE = ProtoEnum.E_BATTLE_TYPE
  if (battleType == E_BATTLE_TYPE.GOLD or battleType == E_BATTLE_TYPE.EXP or battleType == E_BATTLE_TYPE.EQUIPEXP) and stageId then
    local stageConfig = ((TableData.gTable).BaseTrialStageData)[stageId]
    if stageConfig then
      local buffIdStr = stageConfig.buff_id
      if buffIdStr then
        buffIdStr = split(buffIdStr, ":")
        for _,v in ipairs(buffIdStr) do
          (table.insert)(eventTable, {eventId = tonumber(v)})
        end
      end
    end
  end
  do
    if battleType == E_BATTLE_TYPE.TOWER and stageId then
      local stageConfig = ((TableData.gTable).BaseTowerStageData)[stageId]
      if stageConfig then
        local buffIdStr = stageConfig.buff_id
        if buffIdStr then
          buffIdStr = split(buffIdStr, ":")
          for _,v in ipairs(buffIdStr) do
            (table.insert)(eventTable, {eventId = tonumber(v)})
          end
        end
      end
    end
    do
      if battleType == E_BATTLE_TYPE.EXPEDITION then
        if IsBattleServer == true then
          eventTable = battleData.preBattleEvent
        else
          local preBattleEvent = (ExpeditionMgr.ExpeditionBuff)()
          if preBattleEvent then
            for _,v in ipairs(preBattleEvent) do
              (table.insert)(eventTable, {eventId = tonumber(v)})
              ;
              (table.insert)((BattleData.battleData).preBattleEvent, {eventId = tonumber(v)})
            end
          end
        end
      else
        do
          if battleType == E_BATTLE_TYPE.CG and stageId then
            local stageConfig = ((TableData.gTable).BaseHandbookStageData)[stageId]
            if stageConfig then
              local buffIdStr = stageConfig.buff_id
              if buffIdStr then
                buffIdStr = split(buffIdStr, ":")
                for _,v in ipairs(buffIdStr) do
                  (table.insert)(eventTable, {eventId = tonumber(v)})
                end
              end
            end
          end
          do
            if IsBattleTest == true then
              eventTable = battleData.preBattleEvent
            end
            return eventTable
          end
        end
      end
    end
  end
end


