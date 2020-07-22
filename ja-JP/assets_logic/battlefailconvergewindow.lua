-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_BattleFailByName")
require("Battle_CardTipsByName")
local BattleFailConvergeWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local battleSummarizeData, winData, battleCardData = nil, nil, nil
local LimitData = {}
BattleFailConvergeWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, winData, battleSummarizeData, uis, BattleFailConvergeWindow, LimitData
  bridgeObj:SetView((WinResConfig.BattleFailConvergeWindow).package, (WinResConfig.BattleFailConvergeWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  winData = argTable[1]
  if not winData then
    return 
  end
  battleSummarizeData = (BattleResultCount.GetBattleDamageData)()
  uis = GetBattle_BattleFailUis(contentPane)
  ;
  (BattleFailConvergeWindow.InitCardBG)()
  ;
  (BattleFailConvergeWindow.InitBottom)()
  LimitData = {}
  ;
  (LuaSound.LoadAndPlayBGM)(1020103)
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.RewardGrp).FailWordTxt).text = (PUtil.get)(20000456)
end

BattleFailConvergeWindow.InitCardAttrEnough = function(...)
  -- function num : 0_1 , upvalues : _ENV
  local DataTable = (((BattleResultCount.GetBattleDamageData)())[1]).SelfCardData
  local equipLvAttr = {}
  local cardLv = {}
  local cardStageLv = {}
  local cardStartLv = {}
  local cardSkillLv = {}
  for _,v in pairs(DataTable) do
    local cardId = ((v.CardData).cardInfo).id
    do
      if ((v.CardData).cardInfo).equipInfo then
        local totalLv = 0
        for _,v2 in ipairs(((v.CardData).cardInfo).equipInfo) do
          totalLv = totalLv + v2.level
        end
        equipLvAttr[cardId] = totalLv
      end
      cardLv[cardId] = ((v.CardData).cardInfo).level
      cardStageLv[cardId] = ((v.CardData).cardInfo).quality
      cardStartLv[cardId] = ((v.CardData).cardInfo).star
      do
        if ((v.CardData).cardInfo).skillInfo then
          local totalLv = 0
          for _,v2 in ipairs(((v.CardData).cardInfo).skillInfo) do
            totalLv = totalLv + v2.value
          end
          cardSkillLv[cardId] = totalLv
        end
        -- DECOMPILER ERROR at PC63: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  return equipLvAttr, cardLv, cardStageLv, cardStartLv, cardSkillLv
end

BattleFailConvergeWindow.InitGotoData = function(...)
  -- function num : 0_2 , upvalues : _ENV, BattleFailConvergeWindow, LimitData, uis
  local BattleFail = (TableData.gTable).BaseBattleFailData
  local equipLvAttr, cardLv, cardStageLv, cardStartLv, cardSkillLv = (BattleFailConvergeWindow.InitCardAttrEnough)()
  local ListData = {}
  for _,v in pairs(BattleFail) do
    do
      local property = v.rate_type
      do
        local limitValue = LimitData[property]
        local functionId = v.id
        local isMax = true
        if functionId == ControlID.Home_EquipBtn then
          for _,v in pairs(equipLvAttr) do
            if v < limitValue then
              isMax = false
              break
            end
          end
        else
          do
            if functionId == ControlID.Card_Strength then
              for _,v in pairs(cardLv) do
                if v < limitValue then
                  isMax = false
                  break
                end
              end
            else
              do
                if functionId == ControlID.Card_Break then
                  for _,v in pairs(cardStageLv) do
                    if v < limitValue then
                      isMax = false
                      break
                    end
                  end
                else
                  do
                    if functionId == ControlID.Card_Wake then
                      for _,v in pairs(cardStartLv) do
                        if v < limitValue then
                          isMax = false
                          break
                        end
                      end
                    else
                      do
                        if functionId == ControlID.Card_Talent then
                          for i,v in pairs(cardSkillLv) do
                            local limitValue = (cardStartLv[i] + 2) * limitValue
                            if v < limitValue then
                              isMax = false
                              break
                            end
                          end
                        else
                          do
                            do
                              if functionId == ControlID.Home_TeamBtn then
                                ld("Talent", function(...)
    -- function num : 0_2_0 , upvalues : _ENV, limitValue, isMax
    local value = (TalentData.ReturnNewestNodeId)()
    if value < limitValue then
      isMax = false
    end
  end
)
                              else
                                if functionId == ControlID.Home_LotteryBtn then
                                  isMax = false
                                end
                              end
                              if not isMax then
                                (table.insert)(ListData, v)
                              end
                            end
                            -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                            -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out IF_STMT

                            -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                            -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out IF_STMT

                            -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                            -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out IF_STMT

                            -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                            -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out IF_STMT

                            -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                            -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out IF_STMT

                            -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out DO_STMT

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
  ;
  (table.sort)(ListData, function(a, b, ...)
    -- function num : 0_2_1
    do return a.sort < b.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  if ListData then
    for _,v in ipairs(ListData) do
      local failItem = UIMgr:CreateObject("Battle", "BattleFailureItem")
      ;
      (failItem:GetChild("ItemLoader")).url = (Util.GetItemUrl)(v.icon)
      ;
      (failItem:GetChild("NameLoader")).url = (Util.GetItemUrl)(v.name_icon)
      ;
      (failItem.onClick):Set(function(...)
    -- function num : 0_2_2 , upvalues : _ENV, v
    (BattleMgr.CloseBattle)()
    ;
    (SimpleTimer.setTimeout)(0.5, function(...)
      -- function num : 0_2_2_0 , upvalues : _ENV, v
      (Util.GetWayGoto)(v.id)
    end
)
  end
)
      ;
      ((uis.RewardGrp).ItemList):AddChild(failItem)
    end
  end
end

BattleFailConvergeWindow.InitBottom = function(...)
  -- function num : 0_3 , upvalues : uis, BattleFailConvergeWindow, _ENV, winData
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.RewardGrp).c1Ctr).selectedIndex = 1
  ;
  (BattleFailConvergeWindow.InitBtn)()
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.RewardGrp).ItemList).defaultItem = (Util.GetResUrl)("Battle:BattleFailureItem")
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R0 in 'UnsetPending'

  if winData.BattleType == (ProtoEnum.E_BATTLE_TYPE).HERO or winData.BattleType == (ProtoEnum.E_BATTLE_TYPE).STORY then
    ((uis.RewardGrp).c2Ctr).selectedIndex = 0
  else
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R0 in 'UnsetPending'

    if winData.BattleType == (ProtoEnum.E_BATTLE_TYPE).ARENA or winData.BattleType == (ProtoEnum.E_BATTLE_TYPE).EXPEDITION then
      ((uis.RewardGrp).c2Ctr).selectedIndex = 1
    else
      -- DECOMPILER ERROR at PC64: Confused about usage of register: R0 in 'UnsetPending'

      if winData.BattleType == (ProtoEnum.E_BATTLE_TYPE).GOLD or winData.BattleType == (ProtoEnum.E_BATTLE_TYPE).EXP or winData.BattleType == (ProtoEnum.E_BATTLE_TYPE).EQUIPEXP then
        ((uis.RewardGrp).c2Ctr).selectedIndex = 2
      else
        -- DECOMPILER ERROR at PC74: Confused about usage of register: R0 in 'UnsetPending'

        if winData.BattleType == (ProtoEnum.E_BATTLE_TYPE).TOWER then
          ((uis.RewardGrp).c2Ctr).selectedIndex = 3
        else
          -- DECOMPILER ERROR at PC78: Confused about usage of register: R0 in 'UnsetPending'

          ;
          ((uis.RewardGrp).c2Ctr).selectedIndex = 1
        end
      end
    end
  end
  ;
  (BattleFailConvergeWindow.SetBgLoader)()
  ;
  (MessageMgr.OnRegisterBackWinFunc)((WinResConfig.BattleFailConvergeWindow).name, function(...)
    -- function num : 0_3_0 , upvalues : uis, winData
    local tran = (uis.root):GetTransform("in")
    if not tran.playing then
      ((winData.btn2).fun)()
    end
  end
)
end

BattleFailConvergeWindow.SetBgLoader = function(...)
  -- function num : 0_4 , upvalues : BattleFailConvergeWindow, _ENV, uis
  local fashionId = (BattleFailConvergeWindow.GetRandomFashionID)()
  local fashionData = ((TableData.gTable).BaseFashionData)[fashionId]
  if fashionData == nil then
    return 
  end
  local isStatic = (Util.GetPlayerSetting)(fashionData.card_id .. "Static", "0")
  if isStatic == "0" and fashionData.show_spine then
    local spine = (Util.ShowUIModel)(fashionData.show_spine, (uis.RewardGrp).ShowLoader, fashionData.show_spine_type, false, function(model, ...)
    -- function num : 0_4_0 , upvalues : _ENV, fashionData
    (Util.UpdateShowSpineByConfig)(model, fashionData)
    ;
    (SkeletonAnimationUtil.SetAnimation)(model, 0, "idle", true)
  end
)
  else
    do
      do
        local t_Object = (Util.ShowUIModel)(fashionData.show_texture, (uis.RewardGrp).ShowLoader)
        ;
        (Util.UpdateShowTextureByConfig)(t_Object, fashionData)
        ;
        (SimpleTimer.setTimeout)(3, function(...)
    -- function num : 0_4_1 , upvalues : _ENV, fashionId, uis
    (AudioManager.PlayBubbleAndVoice)(true, true, fashionId, CVAudioType.BattleLoseBubble, (uis.RewardGrp).ShowLoader, uis, false, false, true, false)
  end
)
      end
    end
  end
end

BattleFailConvergeWindow.GetRandomFashionID = function(...)
  -- function num : 0_5 , upvalues : _ENV, BattleFailConvergeWindow
  local pos = (math.random)(1, 6)
  local fashionID = (BattleFailConvergeWindow.GetFashionIdByPos)(pos)
  if fashionID == nil then
    for i = pos + 6, pos + 12 do
      local mPos = i % 6
      if mPos == 0 then
        mPos = 6
      end
      fashionID = (BattleFailConvergeWindow.GetFashionIdByPos)(mPos)
      if fashionID ~= nil then
        return fashionID
      end
    end
  else
    do
      do return fashionID end
    end
  end
end

BattleFailConvergeWindow.GetFashionIdByPos = function(pos, ...)
  -- function num : 0_6 , upvalues : _ENV, BattleFailConvergeWindow
  if UIMgr:IsWindowOpen((WinResConfig.BattleUIWindow).name) == true then
    local cardData = (BattleFailConvergeWindow.GetCardData)(pos)
    if cardData then
      return cardData.fashionId
    end
  end
end

BattleFailConvergeWindow.InitBtn = function(...)
  -- function num : 0_7 , upvalues : _ENV, battleSummarizeData, BattleFailConvergeWindow, uis, winData
  local btn = {}
  btn.btnTxt = (PUtil.get)(60000066)
  btn.fun = function(...)
    -- function num : 0_7_0 , upvalues : _ENV, battleSummarizeData
    (CommonWinMgr.OpenBattleDataWindow)(battleSummarizeData)
  end

  ;
  (BattleFailConvergeWindow.SetBtn)((uis.RewardGrp).DateBtn, btn)
  ;
  (BattleFailConvergeWindow.SetBtn)((uis.RewardGrp).NextBtn, winData.btn1)
  do
    if not winData.btn2 then
      local m = {}
      m.btnTxt = (PUtil.get)(60000004)
      m.fun = function(...)
    -- function num : 0_7_1 , upvalues : _ENV
    if UIMgr:IsWindowOpen((WinResConfig.BattleUIWindow).name) == true then
      ld("Battle", function(...)
      -- function num : 0_7_1_0 , upvalues : _ENV
      (BattleMgr.CloseBattle)()
    end
)
    else
      UIMgr:CloseWindow((WinResConfig.BattleFailConvergeWindow).name)
    end
  end

      winData.btn2 = m
    end
    ;
    (BattleFailConvergeWindow.SetBtn)((uis.RewardGrp).ConfirmBtn, winData.btn2)
  end
end

BattleFailConvergeWindow.SetBtn = function(ui, btnData, ...)
  -- function num : 0_8
  if not btnData then
    ui.visible = false
  else
    ui.visible = true
    ui.text = btnData.btnTxt
    ;
    (ui.onClick):Set(function(...)
    -- function num : 0_8_0 , upvalues : btnData
    (btnData.fun)()
  end
)
  end
end

local posTools = {1, 2, 3, 11, 12, 13}
BattleFailConvergeWindow.GetCardData = function(pos, ...)
  -- function num : 0_9 , upvalues : battleCardData, _ENV, posTools
  battleCardData = (BattleData.GetCardsByCamp)(BattleCardCamp.LEFT)
  for _,v in ipairs(battleCardData) do
    if v:GetPosIndex() == posTools[pos] then
      return v
    end
  end
end

BattleFailConvergeWindow.InitCardBG = function(...)
  -- function num : 0_10 , upvalues : uis, _ENV, BattleFailConvergeWindow
  local timer = 1
  for i = 1, 6 do
    local ui = (uis.root):GetChild("Card_0" .. i .. "_Tips")
    local pos = -1
    for j = timer, 6 do
      if UIMgr:IsWindowOpen((WinResConfig.BattleUIWindow).name) == true then
        local data = (BattleFailConvergeWindow.GetCardData)(j)
        if data then
          pos = j
          timer = j + 1
          break
        end
      end
    end
    do
      do
        ;
        (BattleFailConvergeWindow.SetCardBG)(ui, pos)
        -- DECOMPILER ERROR at PC38: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
end

BattleFailConvergeWindow.SetCardBG = function(ui, pos, ...)
  -- function num : 0_11 , upvalues : _ENV, BattleFailConvergeWindow, winData
  local model = GetBattle_CardTipsUis(ui)
  local cardHp = 0
  local cardDander = 0
  local cardId = 0
  local cardFashionID = 0
  local data = (BattleFailConvergeWindow.GetCardData)(pos)
  if data then
    cardHp = data:GetHp()
    cardDander = data:GetDander()
    cardId = data:GetCardId()
    cardFashionID = data:GetFashionId()
  end
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((model.OneGrp).root).visible = false
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((model.TwoGrp).root).visible = false
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((model.ThreeGrp).root).visible = false
  if not cardId or cardId <= 0 then
    (BattleFailConvergeWindow.SetControlIndex)(ui, "c1", 1)
    return 
  end
  ;
  (BattleFailConvergeWindow.SetControlIndex)(ui, "c1", 0)
  if cardHp <= 0 then
    (BattleFailConvergeWindow.SetControlIndex)(ui, "c2", 1)
  else
    ;
    (BattleFailConvergeWindow.SetControlIndex)(ui, "c2", 0)
  end
  local fashionID = cardFashionID
  -- DECOMPILER ERROR at PC64: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((model.CardQGrp).CardLoader).align = 1
  -- DECOMPILER ERROR at PC67: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((model.CardQGrp).CardLoader).verticalAlign = 2
  ;
  (Util.CreateMiniModel)((model.CardQGrp).CardLoader, fashionID)
  ;
  (BattleFailConvergeWindow.SetCardTexture)(fashionID, (model.CardTipsPictureGrp).CardPictureLoader)
  local cardData = (BattleFailConvergeWindow.GetOneCardData)(cardId)
  -- DECOMPILER ERROR at PC91: Confused about usage of register: R10 in 'UnsetPending'

  if cardData then
    ((model.CardQGrp).LevelTxt).text = (PUtil.get)(20000265, cardData.level)
    if (Util.CardIsMaxLevel)(cardData) then
      (((model.CardQGrp).root):GetChild("LevelExpBar")).value = 100
    else
      local nextExp = ((CardData.GetCardLevelUpConfig)(cardData.grow_type, cardData.level)).next_exp
      ;
      (((model.CardQGrp).root):GetChild("LevelExpBar")).value = cardData.exp / nextExp * 100
    end
    do
      ;
      (((model.CardQGrp).root):GetChild("CardHpBar")).value = cardHp / cardData.max_hp * 100
      ;
      (((model.CardQGrp).root):GetChild("CardAngerBar")).value = cardDander / cardData.max_dander * 100
      PlayUITrans(ui, "Float")
      if winData.BattleType == (ProtoEnum.E_BATTLE_TYPE).EXPEDITION then
        (BattleFailConvergeWindow.SetControlIndex)(ui, "c3", 2)
      else
        if winData.BattleType == (ProtoEnum.E_BATTLE_TYPE).STORY or winData.BattleType == (ProtoEnum.E_BATTLE_TYPE).HERO then
          (BattleFailConvergeWindow.SetControlIndex)(ui, "c3", 0)
        else
          ;
          (BattleFailConvergeWindow.SetControlIndex)(ui, "c3", 1)
        end
      end
    end
  end
end

BattleFailConvergeWindow.GetOneCardData = function(id, ...)
  -- function num : 0_12 , upvalues : _ENV
  local cardData = (CardData.GetCardData)(id)
  return cardData
end

BattleFailConvergeWindow.SetControlIndex = function(ui, name, index, ...)
  -- function num : 0_13
  (ui:GetController(name)).selectedIndex = index
  local con = (ui:GetChild("CardTipsPictureGrp")):GetController(name)
  if con then
    con.selectedIndex = index
  end
  ;
  ((ui:GetChild("CardQGrp")):GetController(name)).selectedIndex = index
end

BattleFailConvergeWindow.SetCardTexture = function(fashionID, loader, ...)
  -- function num : 0_14 , upvalues : _ENV
  (Util.SetSliverHeadIcon)(fashionID, loader)
end

BattleFailConvergeWindow.OnShown = function(...)
  -- function num : 0_15 , upvalues : uis, _ENV
  local title = ((uis.FailTips).root):GetChild("Decorate_01_Image")
  local pos = Vector2(title.x + title.width * 0.5, title.y + title.height + 30)
  local holder = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_BATTLE_SETTLE_DEFEAT, false, (uis.FailTips).root, pos)
  ;
  (SimpleTimer.setTimeout)(2, function(...)
    -- function num : 0_15_0 , upvalues : holder
    holder.visible = false
  end
)
end

BattleFailConvergeWindow.OnHide = function(...)
  -- function num : 0_16
end

BattleFailConvergeWindow.OnClose = function(...)
  -- function num : 0_17 , upvalues : uis, _ENV, contentPane, argTable
  if (uis.RewardGrp).ShowLoader then
    (Util.RecycleUIModel)((uis.RewardGrp).ShowLoader, true)
  end
  ;
  (AudioManager.DisposeCurAudioAndBubble)()
  uis = nil
  contentPane = nil
  argTable = {}
end

BattleFailConvergeWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_18
end

return BattleFailConvergeWindow

