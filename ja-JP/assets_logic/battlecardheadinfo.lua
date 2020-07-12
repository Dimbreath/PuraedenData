-- params : ...
-- function num : 0 , upvalues : _ENV
local SortingHelper = nil
if IsBattleServer == nil then
  require("Battle_BattleCharacterBloodByName")
  require("Battle_BuffIconByName")
  SortingHelper = require("SortingHelper")
end
BattleCardHeadInfo = {headInfoRes = "BattleCharacterBlood"}
local ChangeController = ChangeController
if Util then
  local GetResUrl = Util.GetResUrl
end
local BattleCardCamp = BattleCardCamp
local WinResConfig = WinResConfig
local WindowMsgEnum = WindowMsgEnum
local ipairs = ipairs
local math = math
local min = math.min
local abs = math.abs
-- DECOMPILER ERROR at PC32: Confused about usage of register: R10 in 'UnsetPending'

BattleCardHeadInfo.BindInfo = function(battleCard, ...)
  -- function num : 0_0 , upvalues : _ENV, BattleCardCamp, WinResConfig, WindowMsgEnum, min, math, ChangeController, ipairs, GetResUrl, abs
  local headInfo = {}
  local totalBuffCount = 6
  local headObject, hpGreenProgressBar, hpYellowProgressBar, rageProgressBar, defenseProgressBar, hpEliteProgressBar, hpBossProgressBar, uiPanel, buffIcon1Grp, buffIcon2Grp, buffIcon3Grp, controller, orderTxt, attackOrder, percentageTxt, buffIconList, talk = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
  headInfo.Init = function(self, battleCard, ...)
    -- function num : 0_0_0 , upvalues : uiPanel, _ENV, headObject, hpGreenProgressBar, hpEliteProgressBar, hpBossProgressBar, hpYellowProgressBar, rageProgressBar, defenseProgressBar, buffIcon1Grp, buffIcon2Grp, buffIcon3Grp, controller, attackOrder, orderTxt, percentageTxt, buffIconList, talk
    local headInfo = (((battleCard:GetModel()).transform):Find("HeadInfo")).gameObject
    if headInfo then
      headInfo:SetActive(true)
      uiPanel = (headInfo.transform):GetComponent(typeof(FairyGUI.UIPanel))
      headObject = uiPanel.ui
      self.lastHp = battleCard:GetHp()
      self.lastDander = battleCard:GetDander()
      local uis = GetBattle_BattleCharacterBloodUis(headObject)
      hpGreenProgressBar = uis.HpGreenProgressBar
      hpEliteProgressBar = uis.HpEliteProgressBar
      hpBossProgressBar = uis.HpBossProgressBar
      hpYellowProgressBar = uis.HpYellowProgressBar
      rageProgressBar = uis.RageProgressBar
      defenseProgressBar = uis.DefenseProgressBar
      defenseProgressBar.visible = false
      buffIcon1Grp = uis.BuffIcon1Grp
      buffIcon2Grp = uis.BuffIcon2Grp
      buffIcon3Grp = uis.BuffIcon3Grp
      controller = (uis.AttackOrder).c1Ctr
      attackOrder = (uis.AttackOrder).root
      orderTxt = (uis.AttackOrder).NumberTxt
      percentageTxt = uis.PercentageTxt
      buffIconList = uis.BuffIconList
      talk = uis.Talk
      self:UpdateHp(battleCard)
      self:UpdateDander(battleCard)
      self:ClearAllBuff()
      self.posIndex = battleCard:GetPosIndex()
      self.uis = uis
    end
  end

  headInfo.SetMonsterType = function(self, type, ...)
    -- function num : 0_0_1 , upvalues : headObject, _ENV
    if headObject then
      ChangeUIController(headObject, "c2", type)
    end
  end

  headInfo.UpdateShield = function(self, curShield, totalShield, ...)
    -- function num : 0_0_2 , upvalues : _ENV, defenseProgressBar, BattleCardCamp, WinResConfig, WindowMsgEnum
    if curShield and totalShield then
      local card = (BattleData.GetCardInfoByPos)(self.posIndex)
      local visible = false
      local value = 0
      if curShield <= 0 then
        defenseProgressBar.visible = false
        if card then
          card:ClearShield()
        end
      else
        defenseProgressBar.visible = true
        local targetValue = 100 * curShield / totalShield
        defenseProgressBar.value = targetValue
        visible = true
        value = targetValue
      end
      do
        if card:GetCampFlag() == BattleCardCamp.LEFT then
          UIMgr:SendWindowMessage((WinResConfig.BattleUIWindow).name, (WindowMsgEnum.BattleUIWindow).E_MSG_UPDATE_CARD_SHIELD, {posIndex = self.posIndex, visible = visible, value = value})
        end
      end
    end
  end

  headInfo.UpdateHp = function(self, battleCard, hurtHp, ...)
    -- function num : 0_0_3 , upvalues : min, _ENV, hpYellowProgressBar, percentageTxt, math, hpGreenProgressBar, hpEliteProgressBar, hpBossProgressBar, BattleCardCamp, WinResConfig, WindowMsgEnum
    local _lastHP = self.lastHp
    local _nowHp = battleCard:GetHp()
    local maxHp = battleCard:GetMaxHp()
    if hurtHp then
      _nowHp = min(_lastHP + hurtHp, maxHp)
    end
    local targetValue = 100 * _nowHp / maxHp
    if _lastHP ~= _nowHp then
      print("血量变化 位置：", battleCard:GetPosIndex(), " 更新前前血量：", _lastHP, " ，更新后血量", _nowHp)
    end
    if BattleConfig.isPlayBack == true then
      battleCard:SetHp(_nowHp)
    end
    if _nowHp < _lastHP then
      ((LeanTween.value)(hpYellowProgressBar.value, targetValue, 0.5)):setOnUpdate(function(value, ...)
      -- function num : 0_0_3_0 , upvalues : percentageTxt, math
      if percentageTxt then
        local num = (math.ceil)(value)
        percentageTxt.text = num .. "%"
      end
    end
)
      hpGreenProgressBar.value = targetValue
      hpEliteProgressBar.value = targetValue
      hpBossProgressBar.value = targetValue
      hpYellowProgressBar:TweenValue(targetValue, 0.5)
    else
      if _lastHP < _nowHp then
        ((LeanTween.value)(hpYellowProgressBar.value, targetValue, 0.5)):setOnUpdate(function(value, ...)
      -- function num : 0_0_3_1 , upvalues : percentageTxt, math
      if percentageTxt then
        local num = (math.ceil)(value)
        percentageTxt.text = num .. "%"
      end
    end
)
        hpGreenProgressBar:TweenValue(targetValue, 0.5)
        hpEliteProgressBar:TweenValue(targetValue, 0.5)
        hpBossProgressBar:TweenValue(targetValue, 0.5)
        hpYellowProgressBar.value = targetValue
      else
        percentageTxt.text = (math.ceil)(targetValue) .. "%"
        hpGreenProgressBar.value = targetValue
        hpEliteProgressBar.value = targetValue
        hpBossProgressBar.value = targetValue
        hpYellowProgressBar.value = targetValue
      end
    end
    self.lastHp = _nowHp
    if battleCard:GetCampFlag() == BattleCardCamp.LEFT then
      UIMgr:SendWindowMessage((WinResConfig.BattleUIWindow).name, (WindowMsgEnum.BattleUIWindow).E_MSG_UPDATE_CARD_HP, {posIndex = battleCard:GetPosIndex(), lastHp = _lastHP, nowHp = _nowHp, targetValue = targetValue})
    else
      if battleCard:IsBoss() == true then
        UIMgr:SendWindowMessage((WinResConfig.BattleUIWindow).name, (WindowMsgEnum.BattleUIWindow).E_MSG_UPDATE_BOSS_BLOOD, {maxHp = maxHp, lastHp = _lastHP, nowHp = _nowHp})
      end
    end
  end

  headInfo.UpdateDander = function(self, battleCard, dander, removeFullRage, ...)
    -- function num : 0_0_4 , upvalues : min, math, rageProgressBar, _ENV, BattleCardCamp, WindowMsgEnum
    local _lastDander = self.lastDander
    local _nowDander = battleCard:GetDander()
    if dander then
      _nowDander = min(battleCard:GetMaxDanderLimit(), _lastDander + dander)
      _nowDander = (math.max)(_nowDander, 0)
    end
    local maxDander = battleCard:GetMaxDander()
    local value = min(100 * _nowDander / maxDander, 100)
    rageProgressBar:TweenValue(value, 0.5)
    if BattleConfig.isPlayBack == true then
      battleCard:SetDander(_nowDander)
    end
    self.lastDander = _nowDander
    if battleCard:GetCampFlag() == BattleCardCamp.LEFT then
      UIMgr:SendWindowMessage("BattleUIWindow", (WindowMsgEnum.BattleUIWindow).E_MSG_UPDATE_CARD_DANDER, {posIndex = battleCard:GetPosIndex(), targetValue = value, removeFullRage = removeFullRage})
    end
  end

  headInfo.UpdateVisible = function(self, visible, ...)
    -- function num : 0_0_5 , upvalues : headObject
    if headObject then
      headObject.visible = visible
    end
  end

  headInfo.UpdateAttackVisible = function(self, visible, ...)
    -- function num : 0_0_6 , upvalues : attackOrder, _ENV, headObject
    attackOrder.visible = visible
    if visible == true then
      ChangeUIController(headObject, "c3", 0)
    else
      ChangeUIController(headObject, "c3", 1)
    end
  end

  headInfo.UpdateHpVisible = function(self, visible, ...)
    -- function num : 0_0_7 , upvalues : percentageTxt
    percentageTxt.visible = visible
  end

  headInfo.UpdateBuffVisible = function(self, visible, ...)
    -- function num : 0_0_8 , upvalues : buffIconList
    buffIconList.visible = visible
  end

  headInfo.UpdateAtkFlag = function(self, isAtk, isNext, ...)
    -- function num : 0_0_9 , upvalues : ChangeController, controller
    if isAtk == true then
      ChangeController(controller, 2)
    else
      if isNext == true then
        ChangeController(controller, 1)
      else
        ChangeController(controller, 0)
      end
    end
  end

  headInfo.UpdateAtkOrderTxt = function(self, num, ...)
    -- function num : 0_0_10 , upvalues : orderTxt
    if orderTxt then
      orderTxt.text = num
    end
  end

  headInfo.UpdateSortingOrder = function(self, sortingOrder, ...)
    -- function num : 0_0_11 , upvalues : headObject
    if headObject then
    end
  end

  headInfo.UpdateBuff = function(self, saveEffectTable, ...)
    -- function num : 0_0_12 , upvalues : _ENV, ipairs, totalBuffCount, buffIconList, GetResUrl
    local url = (Util.GetResUrl)("Battle:BuffIcon")
    local GetBuffDataByDetailId = BattleBuffMgr.GetBuffDataByDetailId
    self:ClearAllBuff()
    for i,v in ipairs(saveEffectTable) do
      if i <= totalBuffCount then
        local buff = GetBuffDataByDetailId(v.buffId, self.posIndex, v.buffTimeStamp)
        if buff then
          local buffIcon = buffIconList:GetFromPool(url)
          if buffIcon then
            local uisBuff = GetBattle_BuffIconUis(buffIcon)
            local buffIconLoader = uisBuff.BuffIconLoader
            local loaderTxt = uisBuff.LoaderTxt
            if buffIconLoader then
              buffIconLoader.url = GetResUrl(v.effectPath)
            end
            if loaderTxt then
              loaderTxt.text = buff:GetTotalCount() - buff:GetActiveCount()
            end
          end
          do
            do
              buffIconList:AddChild(buffIcon)
              -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end

  headInfo.Flip = function(self, flip, ...)
    -- function num : 0_0_13 , upvalues : headObject, abs
    if headObject then
      if flip then
        headObject.scaleX = -abs(headObject.scaleX)
      else
        headObject.scaleX = abs(headObject.scaleX)
      end
    end
  end

  headInfo.ShowTalk = function(self, txt, ...)
    -- function num : 0_0_14 , upvalues : talk
    -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

    if talk then
      (talk.root).visible = true
      -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (talk.TalkTxt).text = txt
    end
  end

  headInfo.RemoveTalk = function(self, ...)
    -- function num : 0_0_15 , upvalues : talk
    -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

    if talk then
      (talk.root).visible = false
      -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (talk.TalkTxt).text = ""
    end
  end

  headInfo.ClearAllBuff = function(self, ...)
    -- function num : 0_0_16 , upvalues : buffIconList
    if buffIconList then
      buffIconList:RemoveChildrenToPool()
    end
  end

  headInfo.Destroy = function(self, ...)
    -- function num : 0_0_17 , upvalues : headObject, _ENV, buffIconList, headInfo, uiPanel, hpGreenProgressBar, hpEliteProgressBar, hpBossProgressBar, hpYellowProgressBar, rageProgressBar, percentageTxt, controller, attackOrder, orderTxt, defenseProgressBar, talk
    if headObject then
      ChangeUIController(headObject, "c2", 0)
    end
    if buffIconList then
      self:ClearAllBuff()
      ;
      (buffIconList.itemPool):Clear()
    end
    self:RemoveTalk()
    headInfo:Flip(false)
    headInfo:UpdateVisible(false)
    self.uis = {}
    uiPanel = nil
    headObject = nil
    hpGreenProgressBar = nil
    hpEliteProgressBar = nil
    hpBossProgressBar = nil
    hpYellowProgressBar = nil
    rageProgressBar = nil
    percentageTxt = nil
    controller = nil
    attackOrder = nil
    orderTxt = nil
    buffIconList = nil
    defenseProgressBar = nil
    talk = nil
  end

  headInfo:Init(battleCard)
  return headInfo
end


