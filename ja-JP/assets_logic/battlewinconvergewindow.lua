-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_BattleWinByName")
require("Battle_CardTipsByName")
GTween = FairyGUI.GTween
local BattleWinConvergeWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local winData, battleSummarizeData, battleCardData = nil, nil, nil
local itemList = {}
local itemType = {BASIC = 1, FIRST = 2, LUCK = 3}
local aniType = {intimacy = 1, cardLV = 2, cardUpLv = 3}
local baseTable = {}
local currentIndex = 0
local tempPop, ToolsTxt, ToolsBtn = nil, nil, nil
local playerExpAniTime = 4
local fashionId = 0
local isCanClick = false
BattleWinConvergeWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, winData, isCanClick, battleSummarizeData, uis, BattleWinConvergeWindow, tempPop, ToolsTxt, ToolsBtn
  bridgeObj:SetView((WinResConfig.BattleWinConvergeWindow).package, (WinResConfig.BattleWinConvergeWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  winData = argTable[1]
  if not winData then
    return 
  end
  isCanClick = false
  battleSummarizeData = (BattleResultCount.GetBattleDamageData)()
  uis = GetBattle_BattleWinUis(contentPane)
  ;
  (BattleWinConvergeWindow.InitBottomReward)()
  ;
  (BattleWinConvergeWindow.InitCardBG)()
  ;
  (BattleWinConvergeWindow.InitSpecialTip)()
  ;
  (BattleWinConvergeWindow.InitFunctionControl)()
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.RewardGrp).HurtTxt).text = (PUtil.get)(20000410)
  ;
  (UpdateMgr.AddUpdateHandler)(BattleWinConvergeWindow.Update)
  ;
  (BattleWinConvergeWindow.InitBaseFashionData)()
  tempPop = UIMgr:CreateObject("Tool", "TempTools")
  ToolsTxt = tempPop:GetChild("n1")
  ToolsBtn = tempPop:GetChild("btn")
  ;
  (LuaSound.LoadAndPlayBGM)(1020102)
end

BattleWinConvergeWindow.InitFunctionControl = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local winName = (WinResConfig.BattleWinConvergeWindow).name
  local RegisterGuideAndControl = GuideData.RegisterGuideAndControl
  local ControlID = ControlID
  RegisterGuideAndControl(ControlID.FightSettle_Next, (uis.RewardGrp).NextBtn, winName)
  RegisterGuideAndControl(ControlID.FightSettle_BackStage, (uis.RewardGrp).ConfirmBtn, winName)
end

BattleWinConvergeWindow.InitBaseFashionData = function(...)
  -- function num : 0_2 , upvalues : _ENV, baseTable
  local data = (TableData.gTable).BaseFashionData
  for _,v in pairs(data) do
    (table.insert)(baseTable, v)
  end
  ;
  (table.sort)(baseTable, function(a, b, ...)
    -- function num : 0_2_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

local fashionShowID = {}
BattleWinConvergeWindow.Update = function(...)
  -- function num : 0_3 , upvalues : _ENV, fashionShowID, currentIndex, baseTable, uis, BattleWinConvergeWindow, ToolsBtn, ToolsTxt, tempPop
  if (Input.GetKey)(KeyCode.Z) and (Input.GetKeyDown)(KeyCode.X) then
    fashionShowID = {}
    for i = 1, 6 do
      currentIndex = currentIndex + 1
      local fashion = baseTable[currentIndex]
      if not fashion then
        (MessageMgr.SendCenterTips)("没了")
      end
      local mLoader = (((uis.root):GetChild("Card_0" .. i .. "_Tips")):GetChild("CardTipsPictureGrp")):GetChild("CardPictureLoader")
      ;
      (table.insert)(fashionShowID, fashion.id)
      ;
      (BattleWinConvergeWindow.SetCardTexture)(fashion.id, mLoader)
    end
  else
    do
      if (Input.GetKey)(KeyCode.Z) and (Input.GetKeyDown)(KeyCode.C) then
        ToolsBtn.visible = false
        ToolsTxt.text = ""
        local str = ""
        for i = 1, #fashionShowID do
          local mLoader = (((uis.root):GetChild("Card_0" .. i .. "_Tips")):GetChild("CardTipsPictureGrp")):GetChild("CardPictureLoader")
          str = str .. "fashionID: " .. fashionShowID[i] .. "" .. "  X坐标:" .. ((((mLoader.image).gameObject).transform).localPosition).x .. "  Y坐标:" .. ((((mLoader.image).gameObject).transform).localPosition).y .. "" .. "  缩放:" .. ((((mLoader.image).gameObject).transform).localScale).x .. "\n"
        end
        ToolsTxt.text = str
        ;
        (GRoot.inst):ShowPopup(tempPop)
      else
        do
          if (Input.GetKey)(KeyCode.Z) and (Input.GetKeyDown)(KeyCode.V) then
            ToolsBtn.visible = true
            ToolsTxt.text = ""
            fashionShowID = {}
            ;
            (ToolsBtn.onClick):Set(function(...)
    -- function num : 0_3_0 , upvalues : _ENV, ToolsTxt, uis, BattleWinConvergeWindow, fashionShowID
    local ids = split(ToolsTxt.text, ",")
    local length = (math.min)(#ids, 6)
    for i = 1, 6 do
      local mLoader = (((uis.root):GetChild("Card_0" .. i .. "_Tips")):GetChild("CardTipsPictureGrp")):GetChild("CardPictureLoader")
      if i <= length then
        mLoader.visible = true
        local fashionID = tonumber(ids[i])
        ;
        (BattleWinConvergeWindow.SetCardTexture)(fashionID, mLoader)
        ;
        (table.insert)(fashionShowID, fashionID)
      else
        do
          do
            mLoader.visible = false
            -- DECOMPILER ERROR at PC43: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC43: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC43: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
)
            ;
            (GRoot.inst):ShowPopup(tempPop)
          else
            if (Input.GetKey)(KeyCode.Z) and (Input.GetKeyDown)(KeyCode.F) then
              local ui = (uis.root):GetChild("Card_01_Tips")
              PlayUITrans(ui, "Float")
            end
          end
        end
      end
    end
  end
end

BattleWinConvergeWindow.InitSpecialTip = function(...)
  -- function num : 0_4 , upvalues : winData, _ENV, uis
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  if winData.SpecialTips and not (Util.StringIsNullOrEmpty)(winData.SpecialTips) then
    (uis.c1Ctr).selectedIndex = 1
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.ExpeditionTxt).text = winData.SpecialTips
  else
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.c1Ctr).selectedIndex = 0
  end
end

BattleWinConvergeWindow.InitBtn = function(...)
  -- function num : 0_5 , upvalues : _ENV, battleSummarizeData, BattleWinConvergeWindow, uis, winData
  if UIMgr:IsWindowOpen((WinResConfig.BattleUIWindow).name) then
    local btn = {}
    btn.btnTxt = (PUtil.get)(60000066)
    btn.fun = function(...)
    -- function num : 0_5_0 , upvalues : _ENV, battleSummarizeData
    (CommonWinMgr.OpenBattleDataWindow)(battleSummarizeData)
  end

    ;
    (BattleWinConvergeWindow.SetBtn)((uis.RewardGrp).DateBtn, btn)
  else
    do
      ;
      (BattleWinConvergeWindow.SetBtn)((uis.RewardGrp).DateBtn)
      ;
      (BattleWinConvergeWindow.SetBtn)((uis.RewardGrp).NextBtn, winData.btn1)
      do
        if not winData.btn2 then
          local m = {}
          m.btnTxt = (PUtil.get)(185)
          m.fun = function(...)
    -- function num : 0_5_1 , upvalues : _ENV
    if UIMgr:IsWindowOpen((WinResConfig.BattleUIWindow).name) == true then
      ld("Battle", function(...)
      -- function num : 0_5_1_0 , upvalues : _ENV
      (BattleMgr.CloseBattle)()
    end
)
    else
      UIMgr:CloseWindow((WinResConfig.BattleWinConvergeWindow).name)
    end
  end

          winData.btn2 = m
        end
        ;
        (BattleWinConvergeWindow.SetBtn)((uis.RewardGrp).ConfirmBtn, winData.btn2)
      end
    end
  end
end

BattleWinConvergeWindow.SetBtn = function(ui, btnData, ...)
  -- function num : 0_6 , upvalues : playerExpAniTime, winData, _ENV, isCanClick, uis
  if not btnData then
    ui.visible = false
  else
    ui.visible = true
    ui.text = btnData.btnTxt
    local waitTime = playerExpAniTime
    if not winData.ActorExp then
      local currentExp = (ActorData.GetExp)()
    end
    local addExp = winData.TeamAddExp
    if currentExp and addExp and currentExp < addExp then
      waitTime = playerExpAniTime + 1
    end
    ;
    (SimpleTimer.setTimeout)(waitTime, function(...)
    -- function num : 0_6_0 , upvalues : isCanClick, ui, uis, btnData
    isCanClick = true
    ;
    (ui.onClick):Set(function(...)
      -- function num : 0_6_0_0 , upvalues : ui, uis, btnData
      if ui.visible and ui.alpha > 0.95 and ((uis.RewardGrp).root).alpha > 0.95 then
        (btnData.fun)()
      end
    end
)
  end
)
  end
end

BattleWinConvergeWindow.InitCardBG = function(...)
  -- function num : 0_7 , upvalues : uis, _ENV, BattleWinConvergeWindow
  local timer = 1
  for i = 1, 6 do
    local ui = (uis.root):GetChild("Card_0" .. i .. "_Tips")
    local pos = -1
    for j = timer, 6 do
      if UIMgr:IsWindowOpen((WinResConfig.BattleUIWindow).name) == true then
        local data = (BattleWinConvergeWindow.GetCardData)(j)
        if data then
          pos = j
          timer = j + 1
          break
        end
      else
        do
          do
            local cardId = (BattleWinConvergeWindow.GetCardIDByPos)(j)
            if cardId and cardId > 0 then
              pos = j
              timer = j + 1
              break
            end
            -- DECOMPILER ERROR at PC44: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC44: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC44: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
    ;
    (BattleWinConvergeWindow.SetCardBG)(ui, pos)
  end
end

BattleWinConvergeWindow.SetControlIndex = function(ui, name, index, ...)
  -- function num : 0_8
  (ui:GetController(name)).selectedIndex = index
  local con = (ui:GetChild("CardTipsPictureGrp")):GetController(name)
  if con then
    con.selectedIndex = index
  end
  ;
  ((ui:GetChild("CardQGrp")):GetController(name)).selectedIndex = index
end

BattleWinConvergeWindow.GetCardIDByPos = function(pos, ...)
  -- function num : 0_9 , upvalues : _ENV, winData
  for _,v in ipairs(winData.cardInfo) do
    if v.value == pos then
      return v.id
    end
  end
end

local posTools = {1, 2, 3, 11, 12, 13}
BattleWinConvergeWindow.GetCardData = function(pos, ...)
  -- function num : 0_10 , upvalues : battleCardData, _ENV, posTools
  battleCardData = (BattleData.GetCardsByCamp)(BattleCardCamp.LEFT)
  for _,v in ipairs(battleCardData) do
    if v:GetPosIndex() == posTools[pos] then
      return v
    end
  end
end

BattleWinConvergeWindow.SetCardBG = function(ui, pos, ...)
  -- function num : 0_11 , upvalues : _ENV, BattleWinConvergeWindow, winData, aniType
  local model = GetBattle_CardTipsUis(ui)
  local cardHp = 0
  local cardDander = 0
  local cardId = 0
  local cardFashionID = 0
  if UIMgr:IsWindowOpen((WinResConfig.BattleUIWindow).name) == true then
    local data = (BattleWinConvergeWindow.GetCardData)(pos)
    if data then
      cardHp = data:GetHp()
      cardDander = data:GetDander()
      cardId = data:GetCardId()
      cardFashionID = data:GetFashionId()
    end
  else
    do
      cardId = (BattleWinConvergeWindow.GetCardIDByPos)(pos)
      do
        if cardId and cardId > 0 then
          local cardData = (CardData.GetCardData)(cardId)
          cardHp = cardData.max_hp
          cardFashionID = cardData.fashionId
          cardDander = 0
        end
        -- DECOMPILER ERROR at PC50: Confused about usage of register: R7 in 'UnsetPending'

        ;
        ((model.OneGrp).root).visible = false
        -- DECOMPILER ERROR at PC53: Confused about usage of register: R7 in 'UnsetPending'

        ;
        ((model.TwoGrp).root).visible = false
        -- DECOMPILER ERROR at PC56: Confused about usage of register: R7 in 'UnsetPending'

        ;
        ((model.ThreeGrp).root).visible = false
        if not cardId or cardId <= 0 then
          (BattleWinConvergeWindow.SetControlIndex)(ui, "c1", 1)
          return 
        end
        ;
        (BattleWinConvergeWindow.SetControlIndex)(ui, "c1", 0)
        if cardHp <= 0 then
          (BattleWinConvergeWindow.SetControlIndex)(ui, "c2", 1)
        else
          ;
          (BattleWinConvergeWindow.SetControlIndex)(ui, "c2", 0)
        end
        local fashionID = cardFashionID
        -- DECOMPILER ERROR at PC88: Confused about usage of register: R8 in 'UnsetPending'

        ;
        ((model.CardQGrp).CardLoader).align = 1
        -- DECOMPILER ERROR at PC91: Confused about usage of register: R8 in 'UnsetPending'

        ;
        ((model.CardQGrp).CardLoader).verticalAlign = 2
        ;
        (Util.CreateMiniModel)((model.CardQGrp).CardLoader, fashionID)
        ;
        (BattleWinConvergeWindow.SetCardTexture)(fashionID, (model.CardTipsPictureGrp).CardPictureLoader)
        if winData.BattleType == (ProtoEnum.E_BATTLE_TYPE).EXPEDITION then
          (BattleWinConvergeWindow.SetControlIndex)(ui, "c3", 2)
        else
          if winData.BattleType == (ProtoEnum.E_BATTLE_TYPE).STORY or winData.BattleType == (ProtoEnum.E_BATTLE_TYPE).HERO then
            (BattleWinConvergeWindow.SetControlIndex)(ui, "c3", 0)
          else
            ;
            (BattleWinConvergeWindow.SetControlIndex)(ui, "c3", 1)
          end
        end
        PlayUITrans(ui, "Float")
        if not winData.cardData or not (winData.cardData)[cardId] then
          local cardData = (CardData.GetCardData)(cardId)
        end
        if not cardData then
          return 
        end
        local aniTable = {}
        local aniCom = {model.OneGrp, model.TwoGrp, model.ThreeGrp}
        if winData.CardAddIntimacy and winData.CardAddIntimacy > 0 then
          (table.insert)(aniTable, aniType.intimacy)
        end
        if winData.CardAddExp and winData.CardAddExp > 0 then
          (table.insert)(aniTable, aniType.cardLV)
        end
        local isLevel = false
        local cardLv = cardData.level
        if winData.CardAddExp and winData.CardAddExp > 0 and cardData.exp < winData.CardAddExp then
          (table.insert)(aniTable, aniType.cardUpLv)
          isLevel = true
          cardLv = cardData.level - 1
        end
        -- DECOMPILER ERROR at PC211: Confused about usage of register: R13 in 'UnsetPending'

        ;
        ((model.CardQGrp).LevelTxt).text = (PUtil.get)(20000265, cardLv)
        for i,v in ipairs(aniTable) do
          local com = aniCom[i]
          -- DECOMPILER ERROR at PC221: Confused about usage of register: R19 in 'UnsetPending'

          if v == aniType.intimacy then
            (com.c1Ctr).selectedIndex = 0
            local isUpLevel = (RedDotService.CardIntimacyIsUp)(cardId)
            -- DECOMPILER ERROR at PC233: Confused about usage of register: R20 in 'UnsetPending'

            if isUpLevel then
              (com.NumberTxt).text = "+" .. winData.CardAddIntimacy .. "  UP"
            else
              -- DECOMPILER ERROR at PC239: Confused about usage of register: R20 in 'UnsetPending'

              ;
              (com.NumberTxt).text = "+" .. winData.CardAddIntimacy
            end
            local AssetData = ((TableData.gTable).BaseAssetData)[AssetType.INTIMACY_EXTENT]
            -- DECOMPILER ERROR at PC251: Confused about usage of register: R21 in 'UnsetPending'

            ;
            (com.IconLoader).url = (Util.GetItemUrl)(AssetData.icon)
          else
            do
              -- DECOMPILER ERROR at PC257: Confused about usage of register: R19 in 'UnsetPending'

              if v == aniType.cardLV then
                (com.c1Ctr).selectedIndex = 0
                -- DECOMPILER ERROR at PC262: Confused about usage of register: R19 in 'UnsetPending'

                ;
                (com.NumberTxt).text = "+" .. winData.CardAddExp
                local AssetData = ((TableData.gTable).BaseAssetData)[AssetType.CARD_EXP]
                -- DECOMPILER ERROR at PC274: Confused about usage of register: R20 in 'UnsetPending'

                ;
                (com.IconLoader).url = (Util.GetItemUrl)(AssetData.icon)
              else
                do
                  do
                    -- DECOMPILER ERROR at PC280: Confused about usage of register: R19 in 'UnsetPending'

                    if v == aniType.cardUpLv then
                      (com.c1Ctr).selectedIndex = 1
                      -- DECOMPILER ERROR at PC287: Confused about usage of register: R19 in 'UnsetPending'

                      ;
                      (com.PlayerLevelTxt).text = (PUtil.get)(20000371, cardData.level)
                    end
                    -- DECOMPILER ERROR at PC289: Confused about usage of register: R19 in 'UnsetPending'

                    ;
                    (com.root).visible = true
                    -- DECOMPILER ERROR at PC290: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC290: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                    -- DECOMPILER ERROR at PC290: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC290: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC290: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                    -- DECOMPILER ERROR at PC290: LeaveBlock: unexpected jumping out IF_STMT

                  end
                end
              end
            end
          end
        end
        local LevelExpBar = ((model.CardQGrp).root):GetChild("LevelExpBar")
        if OvertureMgr.isPlaying == true then
          LevelExpBar.value = 0
          LevelExpBar:TweenValue(33, 1.5)
          return 
        end
        if (Util.CardIsMaxLevel)(cardData) then
          LevelExpBar.value = 100
        else
          if winData.CardAddExp and winData.CardAddExp > 0 then
            (Util.PlayProgressBarAni)(cardData, winData.CardAddExp, LevelExpBar, 1.5)
          else
            local nextExp = ((CardData.GetCardLevelUpConfig)(cardData.grow_type, cardData.level)).next_exp
            LevelExpBar.value = cardData.exp / nextExp * 100
          end
        end
        do
          if isLevel then
            (SimpleTimer.setTimeout)(1.5, function(...)
    -- function num : 0_11_0 , upvalues : _ENV, LevelExpBar
    (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_BATTLE_WIN_LEVEL_UP, true, LevelExpBar, Vector2(-LevelExpBar.width / 2, -(GRoot.inst).height / 2 + 100))
    ;
    (LuaSound.PlaySound)(LuaSound.RESULT_ROLE_LVUP, SoundBank.OTHER)
  end
)
            ;
            (SimpleTimer.setTimeout)(2, function(...)
    -- function num : 0_11_1 , upvalues : model, _ENV, cardData
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

    ((model.CardQGrp).LevelTxt).text = (PUtil.get)(20000265, cardData.level)
  end
)
          end
          local hpInfer = ((model.CardQGrp).root):GetChild("CardHpBar")
          local dander = ((model.CardQGrp).root):GetChild("CardAngerBar")
          local gtHp = (GTween.To)(0, cardHp / cardData.max_hp * 100, 2)
          gtHp:OnUpdate(function(...)
    -- function num : 0_11_2 , upvalues : hpInfer, gtHp
    hpInfer.value = (gtHp.value).x
  end
)
          local gtDander = (GTween.To)(0, cardDander / cardData.max_dander * 100, 2)
          gtDander:OnUpdate(function(...)
    -- function num : 0_11_3 , upvalues : dander, gtDander
    dander.value = (gtDander.value).x
  end
)
        end
      end
    end
  end
end

BattleWinConvergeWindow.SetCardTexture = function(fashionID, loader, ...)
  -- function num : 0_12 , upvalues : _ENV
  (Util.SetSliverHeadIcon)(fashionID, loader)
end

BattleWinConvergeWindow.ItemAddToList = function(list, type, ...)
  -- function num : 0_13 , upvalues : _ENV, itemList
  if list then
    local mList = (Util.MajorSort)(list)
    for _,v in ipairs(mList) do
      local mData = {}
      mData.item = v
      mData.type = type
      ;
      (table.insert)(itemList, mData)
    end
  end
end

BattleWinConvergeWindow.GetRandomFashionID = function(...)
  -- function num : 0_14 , upvalues : _ENV, BattleWinConvergeWindow
  local pos = (math.random)(1, 6)
  local fashionID = (BattleWinConvergeWindow.GetFashionIdByPos)(pos)
  if fashionID == nil then
    for i = pos + 6, pos + 12 do
      local mPos = i % 6
      if mPos == 0 then
        mPos = 6
      end
      fashionID = (BattleWinConvergeWindow.GetFashionIdByPos)(mPos)
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

BattleWinConvergeWindow.GetFashionIdByPos = function(pos, ...)
  -- function num : 0_15 , upvalues : _ENV, BattleWinConvergeWindow
  if UIMgr:IsWindowOpen((WinResConfig.BattleUIWindow).name) == true then
    local cardData = (BattleWinConvergeWindow.GetCardData)(pos)
    if cardData then
      return cardData.fashionId
    end
  else
    do
      local cardId = (BattleWinConvergeWindow.GetCardIDByPos)(pos)
      if cardId ~= nil then
        local cardConfig, isMonster = (CardData.GetBaseConfig)(cardId)
        if cardConfig == nil then
          return 
        end
        if isMonster then
          return ((TableData.gTable).BaseFashionData)[cardConfig.unlock_fashion_id]
        else
          local cardData = (CardData.GetCardData)(cardId)
          if cardData then
            return cardData.fashionId
          end
        end
      end
    end
  end
end

BattleWinConvergeWindow.SetBgLoader = function(...)
  -- function num : 0_16 , upvalues : _ENV, fashionId, uis
  local fashionData = ((TableData.gTable).BaseFashionData)[fashionId]
  if fashionData == nil then
    return 
  end
  local isStatic = (Util.GetPlayerSetting)(fashionData.card_id .. "Static", "0")
  if isStatic == "0" and fashionData.show_spine then
    (Util.CreateShowModel)(fashionId, (uis.RewardGrp).ShowLoader, true)
  else
    local t_Object = (Util.ShowUIModel)(fashionData.show_texture, (uis.RewardGrp).ShowLoader)
    ;
    (Util.UpdateShowTextureByConfig)(t_Object, fashionData)
  end
end

BattleWinConvergeWindow.InitBottomReward = function(...)
  -- function num : 0_17 , upvalues : uis, _ENV, BattleWinConvergeWindow, winData, itemType, itemList, fashionId, isCanClick
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.RewardGrp).Reward_01_Txt).text = (PUtil.get)(20000354)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.RewardGrp).c1Ctr).selectedIndex = 0
  ;
  (BattleWinConvergeWindow.InitBtn)()
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.RewardGrp).ItemList).itemRenderer = BattleWinConvergeWindow.RewardItemRender
  ;
  (BattleWinConvergeWindow.ItemAddToList)(winData.FirstGoods, itemType.FIRST)
  ;
  (BattleWinConvergeWindow.ItemAddToList)(winData.BasicGoods, itemType.BASIC)
  ;
  (BattleWinConvergeWindow.ItemAddToList)(winData.LuckGoods, itemType.LUCK)
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.RewardGrp).ItemList).numItems = #itemList
  local baseCard = nil
  do
    for _,v in ipairs(itemList) do
      local ConfigData, type = (Util.GetConfigDataByID)((v.item).id)
      if type == PropType.CARD then
        baseCard = ConfigData
        break
      end
    end
  end
  do
    fashionId = (BattleWinConvergeWindow.GetRandomFashionID)()
    if baseCard ~= nil then
      local tempCardList = (PlotDungeonMgr.TempObtainCardList)()
      local isContain = false
      for _,v in ipairs(tempCardList) do
        if v == baseCard.id then
          isContain = true
          break
        end
      end
      do
        do
          UIMgr:SetOnHideComplete((WinResConfig.PiceGetShowWindow).name, function(...)
    -- function num : 0_17_0 , upvalues : _ENV, fashionId, uis
    (AudioManager.PlayBubbleAndVoice)(true, true, fashionId, CVAudioType.BattleWinBubble, (uis.RewardGrp).ShowLoader, uis, false, false, true, false, nil, true)
  end
)
          ;
          (SimpleTimer.setTimeout)(3, function(...)
    -- function num : 0_17_1 , upvalues : isContain, _ENV, baseCard
    if isContain then
      OpenWindowWithOpen((WinResConfig.PiceGetShowWindow).name, UILayer.HUD, true, baseCard.id, tonumber((split(baseCard.debris_goods, ":"))[3]))
    else
      OpenWindowWithOpen((WinResConfig.PiceGetShowWindow).name, UILayer.HUD, true, baseCard.id)
    end
  end
)
          ;
          (SimpleTimer.setTimeout)(3, function(...)
    -- function num : 0_17_2 , upvalues : _ENV, fashionId, uis
    (AudioManager.PlayBubbleAndVoice)(true, true, fashionId, CVAudioType.BattleWinBubble, (uis.RewardGrp).ShowLoader, uis, false, false, true, false, nil, true)
  end
)
          -- DECOMPILER ERROR at PC104: Confused about usage of register: R1 in 'UnsetPending'

          if winData.BattleType == (ProtoEnum.E_BATTLE_TYPE).HERO or winData.BattleType == (ProtoEnum.E_BATTLE_TYPE).STORY then
            ((uis.RewardGrp).c2Ctr).selectedIndex = 0
            ;
            (BattleWinConvergeWindow.SetTeamExp)()
          else
            -- DECOMPILER ERROR at PC122: Confused about usage of register: R1 in 'UnsetPending'

            if winData.BattleType == (ProtoEnum.E_BATTLE_TYPE).ARENA or winData.BattleType == (ProtoEnum.E_BATTLE_TYPE).EXPEDITION then
              ((uis.RewardGrp).c2Ctr).selectedIndex = 1
            else
              -- DECOMPILER ERROR at PC144: Confused about usage of register: R1 in 'UnsetPending'

              if winData.BattleType == (ProtoEnum.E_BATTLE_TYPE).GOLD or winData.BattleType == (ProtoEnum.E_BATTLE_TYPE).EXP or winData.BattleType == (ProtoEnum.E_BATTLE_TYPE).EQUIPEXP then
                ((uis.RewardGrp).c2Ctr).selectedIndex = 2
                ;
                (BattleWinConvergeWindow.DamageProgress)(winData.DamageNum)
              else
                -- DECOMPILER ERROR at PC157: Confused about usage of register: R1 in 'UnsetPending'

                if winData.BattleType == (ProtoEnum.E_BATTLE_TYPE).TOWER then
                  ((uis.RewardGrp).c2Ctr).selectedIndex = 3
                  ;
                  (BattleWinConvergeWindow.SetLuck)()
                else
                  -- DECOMPILER ERROR at PC163: Confused about usage of register: R1 in 'UnsetPending'

                  ;
                  ((uis.RewardGrp).c2Ctr).selectedIndex = 1
                end
              end
            end
          end
          ;
          (BattleWinConvergeWindow.SetBgLoader)()
          ;
          (MessageMgr.OnRegisterBackWinFunc)((WinResConfig.BattleWinConvergeWindow).name, function(...)
    -- function num : 0_17_3 , upvalues : isCanClick, winData
    if isCanClick then
      ((winData.btn2).fun)()
    end
  end
)
        end
      end
    end
  end
end

BattleWinConvergeWindow.SetLuck = function(...)
  -- function num : 0_18 , upvalues : uis, _ENV, winData
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.RewardGrp).TowerTxt).text = (PUtil.get)(20000198)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.RewardGrp).TowerLuckTxt).text = winData.LuckNum
end

BattleWinConvergeWindow.DamageProgress = function(damageData, ...)
  -- function num : 0_19 , upvalues : uis, _ENV, playerExpAniTime
  local progressBar = (uis.RewardGrp).HurtProgressBar
  local progressTxt = (uis.RewardGrp).ExpNumberTxt
  progressTxt.text = ""
  if damageData.totalEnemyHp <= 0 then
    progressBar.value = 100
    progressTxt.visible = false
    return 
  end
  local totalSelfDamage, totalEnemyHp = nil, nil
  if damageData then
    totalSelfDamage = damageData.totalSelfDamage
  else
    -- DECOMPILER ERROR at PC21: Overwrote pending register: R4 in 'AssignReg'

    totalSelfDamage = (BattleResultCount.GetRealTotalDamage)()
  end
  progressBar.value = 0
  ;
  (SimpleTimer.setTimeout)(playerExpAniTime, function(...)
    -- function num : 0_19_0 , upvalues : progressBar, totalSelfDamage, totalEnemyHp, _ENV, progressTxt
    progressBar:TweenValue(100 * totalSelfDamage / totalEnemyHp, 1)
    ;
    ((LeanTween.value)(0, totalSelfDamage, 1)):setOnUpdate(function(value, ...)
      -- function num : 0_19_0_0 , upvalues : _ENV, totalEnemyHp, progressTxt
      local percent = (math.ceil)(value / totalEnemyHp * 100)
      progressTxt.text = (PUtil.get)(20000436, (Util.NumberTransformKilo)((math.ceil)(value)), (Util.NumberTransformKilo)(totalEnemyHp), percent)
    end
)
  end
)
end

BattleWinConvergeWindow.SetTeamExp = function(...)
  -- function num : 0_20 , upvalues : BattleWinConvergeWindow
  (BattleWinConvergeWindow.SetExpAni)()
end

BattleWinConvergeWindow.SetExpTxt = function(level, exp, ...)
  -- function num : 0_21 , upvalues : _ENV, uis
  local LevelUpData = ((TableData.gTable).BasePlayerLevelUpData)[level + 72300000]
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

  if LevelUpData.next_exp <= 0 or LevelUpData.next_exp <= exp then
    ((uis.RewardGrp).ExpNumberTxt).text = (PUtil.get)(20000048)
  else
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((uis.RewardGrp).ExpNumberTxt).text = (math.floor)(exp) .. "/" .. LevelUpData.next_exp
  end
end

BattleWinConvergeWindow.SetBtnVisible = function(value, ...)
  -- function num : 0_22 , upvalues : uis, winData
  if uis == nil then
    return 
  end
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.RewardGrp).ConfirmBtn).visible = value
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.RewardGrp).NextBtn).visible = not value or winData.btn1 ~= nil
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.RewardGrp).DateBtn).visible = value
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

BattleWinConvergeWindow.SetExpAni = function(...)
  -- function num : 0_23 , upvalues : winData, _ENV, uis, BattleWinConvergeWindow, playerExpAniTime
  if not winData.ActorExp then
    local currentExp = (ActorData.GetExp)()
  end
  if not winData.ActorLevel then
    local level = (ActorData.GetLevel)()
  end
  local LevelUpData = ((TableData.gTable).BasePlayerLevelUpData)[level + 72300000]
  local addExp = winData.TeamAddExp
  if currentExp < addExp then
    local next = addExp - currentExp
    do
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R5 in 'UnsetPending'

      ((uis.RewardGrp).LevelTxt).text = level - 1
      local LevelUpNext = ((TableData.gTable).BasePlayerLevelUpData)[level - 1 + 72300000]
      -- DECOMPILER ERROR at PC38: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((uis.RewardGrp).ExperienceProgressBar).value = (LevelUpNext.next_exp - next) / LevelUpNext.next_exp * 100
      ;
      (BattleWinConvergeWindow.SetExpTxt)(level - 1, LevelUpNext.next_exp - next)
      ;
      (SimpleTimer.setTimeout)(playerExpAniTime, function(...)
    -- function num : 0_23_0 , upvalues : _ENV, LevelUpNext, next, uis, BattleWinConvergeWindow, level
    local gt = (GTween.To)(LevelUpNext.next_exp - next, LevelUpNext.next_exp, 1)
    gt:OnUpdate(function(...)
      -- function num : 0_23_0_0 , upvalues : uis, gt, LevelUpNext, BattleWinConvergeWindow, level
      -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

      if uis then
        ((uis.RewardGrp).ExperienceProgressBar).value = (gt.value).x / LevelUpNext.next_exp * 100
        ;
        (BattleWinConvergeWindow.SetExpTxt)(level - 1, (gt.value).x)
      end
    end
)
    gt:OnComplete(function(...)
      -- function num : 0_23_0_1 , upvalues : _ENV, uis, level, BattleWinConvergeWindow
      -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

      if OvertureMgr.isPlaying == true then
        ((uis.RewardGrp).ExperienceProgressBar).value = 0
        -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

        ;
        ((uis.RewardGrp).LevelTxt).text = level
        ;
        (BattleWinConvergeWindow.SetExpTxt)(level, 0)
      end
      if (Util.IsPrepareLevelUpWindow)() then
        local func = function(...)
        -- function num : 0_23_0_1_0 , upvalues : BattleWinConvergeWindow, _ENV
        (BattleWinConvergeWindow.SetBtnVisible)(false)
        OpenWindow((WinResConfig.PlayerLevelUpWindow).name, UILayer.HUD1)
      end

        do
          if UIMgr:IsWindowOpen((WinResConfig.PiceGetShowWindow).name) then
            UIMgr:SetOnHideComplete((WinResConfig.PiceGetShowWindow).name, function(...)
        -- function num : 0_23_0_1_1 , upvalues : func
        func()
      end
)
          else
            func()
          end
        end
      end
    end
)
  end
)
    end
  else
    do
      if LevelUpData.next_exp <= 0 or LevelUpData.next_exp <= currentExp then
        addExp = 0
      end
      -- DECOMPILER ERROR at PC60: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((uis.RewardGrp).LevelTxt).text = level
      -- DECOMPILER ERROR at PC67: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((uis.RewardGrp).ExperienceProgressBar).value = (currentExp - addExp) / LevelUpData.next_exp * 100
      ;
      (BattleWinConvergeWindow.SetExpTxt)(level, currentExp - addExp)
      ;
      (SimpleTimer.setTimeout)(playerExpAniTime, function(...)
    -- function num : 0_23_1 , upvalues : _ENV, currentExp, addExp, uis, LevelUpData, BattleWinConvergeWindow, level
    local gt = (GTween.To)(currentExp - addExp, currentExp, 1)
    gt:OnUpdate(function(...)
      -- function num : 0_23_1_0 , upvalues : uis, gt, LevelUpData, BattleWinConvergeWindow, level
      -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

      if uis then
        ((uis.RewardGrp).ExperienceProgressBar).value = (gt.value).x / LevelUpData.next_exp * 100
        ;
        (BattleWinConvergeWindow.SetExpTxt)(level, (gt.value).x)
      end
    end
)
  end
)
    end
  end
end

BattleWinConvergeWindow.RewardItemRender = function(index, obj, ...)
  -- function num : 0_24 , upvalues : itemList, itemType, _ENV
  local data = itemList[index + 1]
  local itemData = data.item
  if data.type == itemType.FIRST then
    local showDebris = false
    local tempCardList = (PlotDungeonMgr.TempObtainCardList)()
    if tempCardList ~= nil then
      for _,v in ipairs(tempCardList) do
        if v == itemData.id then
          showDebris = true
          break
        end
      end
    end
    do
      do
        ;
        (Util.SetAllItemIcon)(obj, itemData.id, itemData.Num, false, true, false, false, false, false, showDebris)
        if data.type == itemType.LUCK then
          (Util.SetAllItemIcon)(obj, itemData.id, itemData.Num, false, false, false, true)
        else
          ;
          (Util.SetAllItemIcon)(obj, itemData.id, itemData.Num, false, false)
        end
      end
    end
  end
end

BattleWinConvergeWindow.OnShown = function(...)
  -- function num : 0_25 , upvalues : _ENV, uis
  (GuideMgr.CheckIsTriggerGuide)((WinResConfig.BattleWinConvergeWindow).name)
  local title = ((uis.WinTitle).root):GetChild("Decorate_01_Image")
  local pos = Vector2(title.x + title.width * 0.5, title.y + title.height + 30)
  local holder = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_BATTLE_SETTLE_WIN, false, (uis.WinTitle).root, pos)
  ;
  (SimpleTimer.setTimeout)(3, function(...)
    -- function num : 0_25_0 , upvalues : holder
    holder.visible = false
  end
)
end

BattleWinConvergeWindow.OnHide = function(...)
  -- function num : 0_26
end

BattleWinConvergeWindow.OnClose = function(...)
  -- function num : 0_27 , upvalues : uis, _ENV, BattleWinConvergeWindow, contentPane, argTable, winData, battleSummarizeData, itemList
  if (uis.RewardGrp).ShowLoader then
    (Util.RecycleUIModel)((uis.RewardGrp).ShowLoader, true)
  end
  ;
  (UpdateMgr.RemoveUpdateHandler)(BattleWinConvergeWindow.Update)
  ;
  (GuideData.AbolishControlRefer)((WinResConfig.BattleWinConvergeWindow).name)
  ;
  (AudioManager.DisposeCurAudioAndBubble)()
  uis = nil
  contentPane = nil
  argTable = {}
  winData = nil
  battleSummarizeData = nil
  itemList = {}
  ;
  (RedDotService.ClearTempData)()
end

BattleWinConvergeWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_28 , upvalues : BattleWinConvergeWindow, uis, winData, _ENV
  if msgId == 1 then
    (BattleWinConvergeWindow.SetBtnVisible)(true)
    if uis then
      if not winData.ActorExp then
        local currentExp = (ActorData.GetExp)()
        do
          if not winData.ActorLevel then
            local level = (ActorData.GetLevel)()
          end
          -- DECOMPILER ERROR at PC22: Confused about usage of register: R4 in 'UnsetPending'

          ;
          ((uis.RewardGrp).LevelTxt).text = level
          local gt2 = (GTween.To)(0, currentExp, 1)
          ;
          (BattleWinConvergeWindow.SetExpTxt)(level, 0)
          local LevelUpData = ((TableData.gTable).BasePlayerLevelUpData)[level + 72300000]
          gt2:OnUpdate(function(...)
    -- function num : 0_28_0 , upvalues : uis, gt2, LevelUpData, BattleWinConvergeWindow, level
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

    if uis then
      ((uis.RewardGrp).ExperienceProgressBar).value = (gt2.value).x / LevelUpData.next_exp * 100
      ;
      (BattleWinConvergeWindow.SetExpTxt)(level, (gt2.value).x)
    end
  end
)
        end
      end
    end
  end
end

return BattleWinConvergeWindow

