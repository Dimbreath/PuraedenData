-- params : ...
-- function num : 0 , upvalues : _ENV
require("Tower_EncounterWindowByName")
local TowerBounsLevelWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _mask1, _mask2 = nil, nil
TowerBounsLevelWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, TowerBounsLevelWindow
  bridgeObj:SetView((WinResConfig.TowerBounsLevelWindow).package, (WinResConfig.TowerBounsLevelWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetTower_EncounterWindowUis(contentPane)
  ;
  (TowerBounsLevelWindow.InitVariable)()
  ;
  (TowerBounsLevelWindow.InitText)()
  ;
  (TowerBounsLevelWindow.InitButtonEvent)()
end

TowerBounsLevelWindow.InitVariable = function(...)
  -- function num : 0_1 , upvalues : _mask1, uis, _mask2
  _mask1 = (((uis.Encounter).Left).root):GetChild("n2")
  _mask2 = (((uis.Encounter).Right).root):GetChild("n2")
end

TowerBounsLevelWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.Encounter).RetreatBtn).text = (PUtil.get)(60000475)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.Encounter).WhileBtn).text = (PUtil.get)(60000476)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.Encounter).BattleBtn).text = (PUtil.get)(60000477)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.Encounter).TipsTxt).text = (PUtil.get)(60000478)
end

TowerBounsLevelWindow.InitButtonEvent = function(...)
  -- function num : 0_3 , upvalues : uis, TowerBounsLevelWindow
  (((uis.Encounter).RetreatBtn).onClick):Set(TowerBounsLevelWindow.ClickRetreatBtn)
  ;
  (((uis.Encounter).WhileBtn).onClick):Set(TowerBounsLevelWindow.ClickUtilNextTimeBtn)
  ;
  (((uis.Encounter).BattleBtn).onClick):Set(TowerBounsLevelWindow.ClickFightBtn)
end

TowerBounsLevelWindow.OnShown = function(...)
  -- function num : 0_4 , upvalues : TowerBounsLevelWindow
  (TowerBounsLevelWindow.Init)()
end

TowerBounsLevelWindow.OnHide = function(...)
  -- function num : 0_5
end

TowerBounsLevelWindow.OnClose = function(...)
  -- function num : 0_6 , upvalues : _ENV, uis, contentPane, argTable
  (Util.RecycleUIModel)((uis.Encounter).ALoader, true)
  uis = nil
  contentPane = nil
  argTable = {}
end

TowerBounsLevelWindow.Init = function(...)
  -- function num : 0_7 , upvalues : TowerBounsLevelWindow, _ENV, uis
  (TowerBounsLevelWindow.InitSelfInfo)()
  ;
  (TowerBounsLevelWindow.InitRivalInfo)()
  ;
  (Util.ShowUIModel)("ui_tianzhita_daojian", (uis.Encounter).ALoader)
end

TowerBounsLevelWindow.InitSelfInfo = function(...)
  -- function num : 0_8 , upvalues : uis, _ENV, _mask1
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  (((uis.Encounter).LeftNumber).NameTxt).text = (ActorData.GetNickName)()
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.Encounter).LeftNumber).ArenaNumber_01_Txt).text = (Util.GetFCByFomation)((TowerData.BounsLevelData).myCards)
  ;
  (Util.CreateNo3rdSelfShowModel)(((uis.Encounter).Left).PicLoader)
  ;
  (Util.SetModelClip)(((uis.Encounter).Left).PicLoader, _mask1, true)
end

TowerBounsLevelWindow.InitRivalInfo = function(...)
  -- function num : 0_9 , upvalues : uis, _ENV, _mask2
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  (((uis.Encounter).RightNumber).NameTxt).text = (TowerData.BounsLevelData).rivalName
  local config = ((TableData.gTable).BaseTowerData)[TowerData.CurrentLayer]
  local fc = 0
  for k,v in pairs((TowerData.BounsLevelData).rivalCards) do
    fc = fc + v.fc
  end
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((uis.Encounter).RightNumber).ArenaNumber_01_Txt).text = (math.ceil)((fc) * config.fc_show * 0.0001)
  ;
  (Util.CreateShowModel)((ActorMgr.GetCanShowFashion)((TowerData.BounsLevelData).rivalFashionShow), ((uis.Encounter).Right).PicLoader)
  ;
  (Util.SetModelClip)(((uis.Encounter).Right).PicLoader, _mask2, true)
end

TowerBounsLevelWindow.ClickRetreatBtn = function(...)
  -- function num : 0_10 , upvalues : _ENV, TowerBounsLevelWindow
  (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000480), function(...)
    -- function num : 0_10_0 , upvalues : _ENV, TowerBounsLevelWindow
    (TowerService.ReqCancelEncounter)()
    ;
    (TowerBounsLevelWindow.ClickUtilNextTimeBtn)()
  end
)
end

TowerBounsLevelWindow.ClickUtilNextTimeBtn = function(...)
  -- function num : 0_11 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.TowerBounsLevelWindow).name)
end

TowerBounsLevelWindow.ClickFightBtn = function(...)
  -- function num : 0_12 , upvalues : _ENV
  local formationData = {}
  local btnData = {}
  btnData.btnTxt = (PUtil.get)(20000021)
  btnData.fun = function(formation, ...)
    -- function num : 0_12_0 , upvalues : _ENV
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

    (TowerData.BounsLevelData).myCards = (Util.CovertLoaclFormationToRemote)(formation)
    ;
    (TowerService.ReqInTowerEncounter)((TowerData.BounsLevelData).myCards)
  end

  formationData.myselfList = (Util.CovertRemoteFormationToLocal)((TowerData.BounsLevelData).myCards)
  formationData.otherPlayerList = (Util.CovertRivalCardStateToLocal)((TowerData.BounsLevelData).rivalCards)
  formationData.BtnData = btnData
  formationData.battleType = (ProtoEnum.E_BATTLE_TYPE).TOWER_ENCOUNTER
  formationData.formationType = FormationType.Basic
  formationData.closeFun = function(formation, ...)
    -- function num : 0_12_1 , upvalues : _ENV
    (TowerMgr.BeforCloseBounsFormation)(formation, function(...)
      -- function num : 0_12_1_0 , upvalues : _ENV
      UIMgr:CloseToWindow((WinResConfig.AdventureWindow).name)
    end
)
  end

  formationData.backFun = function(formation, ...)
    -- function num : 0_12_2 , upvalues : _ENV
    (TowerMgr.BeforCloseBounsFormation)(formation, function(...)
      -- function num : 0_12_2_0 , upvalues : _ENV
      UIMgr:CloseWindow((WinResConfig.FormationWindow).name)
    end
)
  end

  formationData.isSelfClose = true
  local config = ((TableData.gTable).BaseTowerData)[TowerData.CurrentLayer]
  formationData.FCFactor = config.fc_show
  ;
  (MessageMgr.OpenFormationWindow)(formationData)
end

TowerBounsLevelWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_13 , upvalues : _ENV, uis
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

  if msgId == (WindowMsgEnum.Tower).E_MSG_REFRESH_SELF_FC then
    (((uis.Encounter).LeftNumber).ArenaNumber_01_Txt).text = (Util.GetFCByFomation)((TowerData.BounsLevelData).myCards)
  end
end

return TowerBounsLevelWindow

