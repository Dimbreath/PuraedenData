-- params : ...
-- function num : 0 , upvalues : _ENV
require("Expedition_RewardShowWindowByName")
local ExpeditionDetailWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local stageData = nil
ExpeditionDetailWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, stageData, uis
  bridgeObj:SetView((WinResConfig.ExpeditionDetailWindow).package, (WinResConfig.ExpeditionDetailWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  contentPane:Center()
  local stageId = argTable[1]
  stageData = ((TableData.gTable).BaseExpeditionStageData)[stageId]
  uis = GetExpedition_RewardShowWindowUis(contentPane)
  uis = uis.RewardShowGrp
  ;
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.ExpeditionDetailWindow).name)
    UIMgr:SendWindowMessage((WinResConfig.ExpeditionWindow).name, (WindowMsgEnum.ExpeditionWindow).GOTO_BACK_POINT)
  end
)
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.IntoBtn).text = (PUtil.get)(20000003)
  ;
  ((uis.IntoBtn).onClick):Set(function(...)
    -- function num : 0_0_1 , upvalues : _ENV, stageId
    (ExpeditionMgr.OnClickChallenge)(stageId)
  end
)
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.PlotImageLoader).url = (Util.GetItemUrl)(stageData.battle_banner_show)
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.DropDisplayTxt).text = (PUtil.get)(20000001)
  ;
  (LeanTween.delayedCall)(0.6, function(...)
    -- function num : 0_0_2 , upvalues : _ENV, stageId
    if UIMgr:IsWindowOpen((WinResConfig.ExpeditionDetailWindow).name) == false then
      return 
    end
    ;
    (BattleBackground.PreLoad)(stageId, (ProtoEnum.E_BATTLE_TYPE).EXPEDITION)
    local otherPlayerList = (ExpeditionMgr.GetEnemyFormation)()
    for _,card in pairs(otherPlayerList) do
      local fashionConfig = (CardData.GetFashionConfig)(card)
      ;
      (BattleResource.PreLoadByPath)(fashionConfig.spd_bundle)
    end
    local myselfList = (ExpeditionMgr.GetSelfFormation)()
    for _,cardId in pairs(myselfList) do
      (BattleResource.PreLoadCard)(cardId)
    end
  end
)
end

ExpeditionDetailWindow.OnShown = function(...)
  -- function num : 0_1 , upvalues : _ENV, stageData, uis
  if not (ExpeditionMgr.ExpeditionStageIsFight)(stageData.id) then
    loge("此时应该有问题了")
  end
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.TitileNameTxt).text = (PUtil.get)(20000336)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.NumberTxt).text = stageData.name
  local items = (Util.ParseConfigStr)(stageData.drop_show)
  for _,v in ipairs(items) do
    (Util.SetFrame)(v[2], 1, uis.Prop1List, false, false, true)
  end
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R1 in 'UnsetPending'

  if stageData.type == (ExpeditionMgr.StageType).General then
    (uis.c1Ctr).selectedIndex = 0
  else
    -- DECOMPILER ERROR at PC53: Confused about usage of register: R1 in 'UnsetPending'

    if stageData.type == (ExpeditionMgr.StageType).Hard then
      (uis.c1Ctr).selectedIndex = 1
    else
      -- DECOMPILER ERROR at PC62: Confused about usage of register: R1 in 'UnsetPending'

      if stageData.type == (ExpeditionMgr.StageType).Dead then
        (uis.c1Ctr).selectedIndex = 2
      end
    end
  end
  -- DECOMPILER ERROR at PC68: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.Buff_01_Txt).text = (PUtil.get)(20000473)
  -- DECOMPILER ERROR at PC74: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.Buff_02_Txt).text = (PUtil.get)(20000474)
  -- DECOMPILER ERROR at PC80: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.Buff_03_Txt).text = (PUtil.get)(20000476)
  -- DECOMPILER ERROR at PC86: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.Buff_04_Txt).text = (PUtil.get)(20000475)
end

ExpeditionDetailWindow.OnHide = function(...)
  -- function num : 0_2
end

ExpeditionDetailWindow.OnClose = function(...)
  -- function num : 0_3 , upvalues : uis, contentPane, stageData
  uis = nil
  contentPane = nil
  stageData = nil
end

ExpeditionDetailWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_4
end

return ExpeditionDetailWindow

