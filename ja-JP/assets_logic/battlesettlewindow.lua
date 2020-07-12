-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_BattleSettlementWinByName")
require("CommonResource_HeadFrameByName")
require("CommonResource_HeadFrameWordByName")
GTween = FairyGUI.GTween
GTextField = FairyGUI.GTextField
TextFormat = FairyGUI.TextFormat
BattleSettleWindow = {}
local uis = nil
local stageId = 0
local fbType = 0
-- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

BattleSettleWindow.OnInit = function(bridge, ...)
  -- function num : 0_0 , upvalues : _ENV, uis, fbType, stageId
  bridge:SetView((WinResConfig.BattleSettleWindow).package, (WinResConfig.BattleSettleWindow).comName)
  uis = GetBattle_BattleSettlementWinUis(bridge.contentPane)
  local data = (MessageMgr.GetSettleData)()
  ;
  (Util.CreateSelfShowModel)(uis.CharacterLoader)
  fbType = data.fbType
  stageId = data.stageId
  ;
  (BattleSettleWindow.InitGoods)(data.firstGoods, data.goods)
  ;
  (BattleSettleWindow.InitCard)(data.playCards, data.cardExp)
  ;
  (BattleSettleWindow.InitBtn)(uis.DateBtn, data.btn1)
  ;
  (BattleSettleWindow.InitBtn)(uis.NextBtn, data.btn2)
  ;
  (BattleSettleWindow.InitBtn)(uis.ConfirmBtn, data.btn3)
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

BattleSettleWindow.SetExpAni = function(stageID, ...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local StageData = ((TableData.gTable).BaseStageData)[tonumber(stageID)]
  local currentExp = (ActorData.GetExp)()
  local LevelUpData = ((TableData.gTable).BasePlayerLevelUpData)[(ActorData.GetLevel)() + 72300000]
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R4 in 'UnsetPending'

  if not StageData then
    (uis.LevelTxt).text = (ActorData.GetLevel)()
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (uis.ExperienceProgressBar).value = currentExp / LevelUpData.next_exp * 100
    return 
  end
  local addExp = StageData.player_exp
  if currentExp < addExp then
    local next = addExp - currentExp
    do
      -- DECOMPILER ERROR at PC40: Confused about usage of register: R6 in 'UnsetPending'

      (uis.LevelTxt).text = (ActorData.GetLevel)() - 1
      local LevelUpNext = ((TableData.gTable).BasePlayerLevelUpData)[(ActorData.GetLevel)() - 1 + 72300000]
      local gt = (GTween.To)(LevelUpNext.next_exp - next, LevelUpNext.next_exp, 1)
      gt:OnUpdate(function(...)
    -- function num : 0_1_0 , upvalues : uis, gt, LevelUpNext
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

    if uis then
      (uis.ExperienceProgressBar).value = (gt.value).x / LevelUpNext.next_exp * 100
    end
  end
)
      gt:OnComplete(function(...)
    -- function num : 0_1_1 , upvalues : uis, _ENV, currentExp, LevelUpData
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

    if uis then
      (uis.LevelTxt).text = (ActorData.GetLevel)()
      local gt2 = (GTween.To)(0, currentExp, 1)
      do
        gt2:OnUpdate(function(...)
      -- function num : 0_1_1_0 , upvalues : uis, gt2, LevelUpData
      -- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

      if uis then
        (uis.ExperienceProgressBar).value = (gt2.value).x / LevelUpData.next_exp * 100
      end
    end
)
      end
    end
  end
)
    end
  else
    do
      -- DECOMPILER ERROR at PC69: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (uis.LevelTxt).text = (ActorData.GetLevel)()
      local gt = (GTween.To)(currentExp - addExp, currentExp, 1)
      gt:OnUpdate(function(...)
    -- function num : 0_1_2 , upvalues : uis, gt, LevelUpData
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

    (uis.ExperienceProgressBar).value = (gt.value).x / LevelUpData.next_exp * 100
  end
)
    end
  end
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R3 in 'UnsetPending'

BattleSettleWindow.InitGoods = function(first, obj, ...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (uis.ItemList).numItems = 0
  local gold = 0
  if first then
    for _,v in ipairs(first) do
      local data = v
      if tonumber(data.id) == AssetType.GOLD then
        gold = data.Num + gold
      else
        if tonumber(data.id) ~= AssetType.ACTOR_EXP and tonumber(data.id) ~= AssetType.CARD_EXP then
          local frame = (Util.CreateFrame)(data.id, false, data.Num, true)
          ;
          (uis.ItemList):AddChild(frame)
        end
      end
    end
  end
  do
    if obj then
      for _,v in ipairs(obj) do
        local data = v
        if tonumber(data.id) == AssetType.GOLD then
          gold = data.Num + (gold)
        else
          if tonumber(data.id) ~= AssetType.ACTOR_EXP and tonumber(data.id) ~= AssetType.CARD_EXP then
            local frame = (Util.CreateFrame)(data.id, false, data.Num)
            ;
            (uis.ItemList):AddChild(frame)
          end
        end
      end
    end
    do
      -- DECOMPILER ERROR at PC91: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (uis.GoldTxt).text = gold
    end
  end
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R3 in 'UnsetPending'

BattleSettleWindow.InitCard = function(Cards, exp, ...)
  -- function num : 0_3 , upvalues : _ENV, uis
  for _,v in ipairs(Cards) do
    local cardData = (CardData.GetCardData)(tonumber(v))
    local Card = UIMgr:CreateObject("CommonResource", "HeadFrameWord")
    local model = GetCommonResource_HeadFrameWordUis(Card)
    local CardModel = model.n0
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (CardModel.LevelTxt).text = "Lv." .. cardData.level
    SetCardStar(cardData.star, CardModel.Star_01_smallImage, CardModel.Star_02_smallImage, CardModel.Star_03_smallImage, CardModel.Star_04_smallImage, CardModel.Star_05_smallImage, CardModel.Star_06_smallImage, CardModel.Star_07_smallImage)
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (CardModel.IconLoader).url = (CardMgr.GetHeadIconSquareUrl)(cardData)
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (CardModel.IconLoader).fill = (FairyGUI.FillType).ScaleMatchHeight
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (CardModel.BlackImage).visible = cardData.star > 0
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R11 in 'UnsetPending'

    if cardData.quality > 0 then
      (CardModel.StageTxt).visible = true
      -- DECOMPILER ERROR at PC59: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (CardModel.StageTxt).text = cardData.quality
    else
      -- DECOMPILER ERROR at PC62: Confused about usage of register: R11 in 'UnsetPending'

      (CardModel.StageTxt).visible = false
    end
    -- DECOMPILER ERROR at PC64: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (CardModel.FightImage).visible = false
    local preUpStageData = (CardMgr.GetBaseCardQualityData)(cardData.quality, cardData.id)
    local levelShow = split(preUpStageData.level_show, ":")
    -- DECOMPILER ERROR at PC78: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (CardModel.c2Ctr).selectedIndex = tonumber(levelShow[1])
    -- DECOMPILER ERROR at PC83: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (CardModel.QualityCtrlCtr).selectedIndex = tonumber(levelShow[3])
    -- DECOMPILER ERROR at PC99: Confused about usage of register: R13 in 'UnsetPending'

    if exp and exp > 0 then
      if (Util.CardIsMaxLevel)(cardData) then
        (model.NumberTxt).text = (PUtil.get)(20000048)
      else
        -- DECOMPILER ERROR at PC107: Confused about usage of register: R13 in 'UnsetPending'

        (model.NumberTxt).text = (PUtil.get)(20000041, exp)
      end
      if cardData.exp < exp then
        local levelUp = UIMgr:CreateObject("CommonResource", "LevelUpGrp")
        levelUp:SetXY(0, -15)
        levelUp.sortingOrder = (CardModel.LevelTxt).sortingOrder + 1
        Card:AddChild(levelUp)
      end
    end
    ;
    (uis.HeadIconList):AddChild(Card)
  end
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R3 in 'UnsetPending'

BattleSettleWindow.InitBtn = function(btn, btnData, ...)
  -- function num : 0_4
  if btnData then
    btn.text = btnData.btnTxt
    ;
    (btn.onClick):Add(btnData.fun)
  else
    btn.visible = false
  end
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R3 in 'UnsetPending'

BattleSettleWindow.OnShown = function(...)
  -- function num : 0_5 , upvalues : _ENV, stageId, uis
  (BattleSettleWindow.SetExpAni)(stageId)
  local LevelUpData = ((TableData.gTable).BasePlayerLevelUpData)[(ActorData.GetLevel)() + 72300000]
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

  if LevelUpData.next_exp <= 0 or LevelUpData.next_exp <= (ActorData.GetExp)() then
    (uis.ExpNumberTxt).text = (PUtil.get)(20000048)
  else
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.ExpNumberTxt).text = (ActorData.GetExp)() .. "/" .. LevelUpData.next_exp
  end
  local title = (uis.root):GetChild("n9")
  local pos = Vector2(title.x + title.width * 0.5, title.y + title.height * 0.5)
  ;
  (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_UNLOCK, true, uis.root, pos)
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R3 in 'UnsetPending'

BattleSettleWindow.OnHide = function(...)
  -- function num : 0_6
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R3 in 'UnsetPending'

BattleSettleWindow.OnClose = function(...)
  -- function num : 0_7 , upvalues : _ENV, uis
  (Util.RecycleUIModel)(uis.CharacterLoader)
  uis = nil
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R3 in 'UnsetPending'

BattleSettleWindow.HandleMessage = function(msgId, ...)
  -- function num : 0_8
  if msgId ~= 1 or msgId == 2 then
  end
end

return BattleSettleWindow

