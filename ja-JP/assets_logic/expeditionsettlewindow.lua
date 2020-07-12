-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_ExpeditionBattleWinByName")
require("Expedition_ItemBuyByName")
require("Expedition_CardHeadByName")
local ExpeditionSettleWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local cards = {}
local items = {}
local ExpeditionData = nil
ExpeditionSettleWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, cards, items, uis, ExpeditionSettleWindow, ExpeditionData
  bridgeObj:SetView((WinResConfig.ExpeditionSettleWindow).package, (WinResConfig.ExpeditionSettleWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  contentPane:Center()
  cards = argTable[1]
  items = argTable[2]
  local stageId = argTable[3]
  uis = GetBattle_ExpeditionBattleWinUis(contentPane)
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.DataBtn).text = (PUtil.get)(20000023)
  ;
  ((uis.DataBtn).onClick):Set(function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    local ChallengeSummarizeDataTable = (BattleResultCount.GetBattleDamageData)()
    ;
    (CommonWinMgr.OpenBattleDataWindow)(ChallengeSummarizeDataTable)
  end
)
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.ConfirmBtn).text = (PUtil.get)(20000016)
  ;
  ((uis.ConfirmBtn).onClick):Set(function(...)
    -- function num : 0_0_1 , upvalues : _ENV
    if UIMgr:IsWindowOpen((WinResConfig.BattleUIWindow).name) == true then
      ld("Battle", function(...)
      -- function num : 0_0_1_0 , upvalues : _ENV
      (BattleMgr.CloseBattle)()
    end
)
      UIMgr:CloseWindow((WinResConfig.ExpeditionSettleWindow).name)
      UIMgr:SetOnShownComplete((WinResConfig.ExpeditionWindow).name, function(...)
      -- function num : 0_0_1_1 , upvalues : _ENV
      (SimpleTimer.setTimeout)(0.3, function(...)
        -- function num : 0_0_1_1_0 , upvalues : _ENV
        UIMgr:SendWindowMessage((WinResConfig.ExpeditionWindow).name, (WindowMsgEnum.ExpeditionWindow).GOTO_NEXT_POINT, true)
      end
)
    end
)
    else
      UIMgr:CloseWindow((WinResConfig.ExpeditionSettleWindow).name)
    end
  end
)
  ;
  (Util.CreateSelfShowModel)(uis.CharacterLoader)
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.HeadIconList).itemRenderer = ExpeditionSettleWindow.CardItemRenderer
  ExpeditionData = ((TableData.gTable).BaseExpeditionStageData)[stageId]
  -- DECOMPILER ERROR at PC69: Confused about usage of register: R2 in 'UnsetPending'

  if ExpeditionData.type == (ExpeditionMgr.StageType).Hard then
    (uis.WordTxt).text = (PUtil.get)(20000114)
  else
    -- DECOMPILER ERROR at PC82: Confused about usage of register: R2 in 'UnsetPending'

    if ExpeditionData.type == (ExpeditionMgr.StageType).Dead then
      (uis.WordTxt).text = (PUtil.get)(20000115)
    else
      -- DECOMPILER ERROR at PC85: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (uis.WordTxt).visible = false
    end
  end
end

ExpeditionSettleWindow.CardItemRenderer = function(index, obj, ...)
  -- function num : 0_1 , upvalues : _ENV, cards, ExpeditionData
  local model = GetExpedition_CardHeadUis(obj)
  local data = cards[index + 1]
  local cardData = (CardData.GetCardData)(data.cardId)
  ;
  (Util.SetHeadFrameByOneCard)((model.HeadFrameGrp).root, cardData)
  local hp = (obj:GetChild("HpBar")).asProgress
  local Dander = (obj:GetChild("DanderBar")).asProgress
  if data.cardState == (ExpeditionMgr.CardState).Dead then
    hp.value = 0
    Dander.value = 0
    ChangeController((model.HeadFrameGrp).c3Ctr, 3)
  else
    hp.value = data.supHp / cardData.max_hp * 100
    Dander.value = data.supDander / cardData.max_dander * 100
  end
  if ExpeditionData.type == (ExpeditionMgr.StageType).Hard then
    ChangeController((model.HeadFrameGrp).c3Ctr, 2)
  else
    if ExpeditionData.type == (ExpeditionMgr.StageType).Dead then
      ChangeController((model.HeadFrameGrp).c3Ctr, 3)
    end
  end
end

ExpeditionSettleWindow.OnShown = function(...)
  -- function num : 0_2 , upvalues : _ENV, items, uis, cards
  for _,v in ipairs(items) do
    (Util.SetFrame)(v.id, v.value, uis.ItemList)
  end
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.HeadIconList).numItems = #cards
end

ExpeditionSettleWindow.OnHide = function(...)
  -- function num : 0_3
end

ExpeditionSettleWindow.OnClose = function(...)
  -- function num : 0_4 , upvalues : _ENV, uis, ExpeditionData, contentPane, cards, items
  (Util.RecycleUIModel)(uis.CharacterLoader)
  ExpeditionData = nil
  uis = nil
  contentPane = nil
  cards = {}
  items = {}
end

ExpeditionSettleWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_5
end

return ExpeditionSettleWindow

