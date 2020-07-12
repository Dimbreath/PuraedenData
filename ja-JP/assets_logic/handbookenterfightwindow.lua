-- params : ...
-- function num : 0 , upvalues : _ENV
require("PlotDungeon_PlotDetailByName")
require("PlotDungeon_PlotDetailWindowByName")
local HandBookEnterFightWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local stageID = nil
HandBookEnterFightWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, stageID, uis, HandBookEnterFightWindow
  bridgeObj:SetView((WinResConfig.HandBookEnterFightWindow).package, (WinResConfig.HandBookEnterFightWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  stageID = argTable[1]
  uis = GetPlotDungeon_PlotDetailWindowUis(contentPane)
  uis = uis.PlotDetail
  local StageData = ((TableData.gTable).BaseHandbookStageData)[stageID]
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.vitalityTxt).visible = false
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.vitalitynumberTxt).visible = false
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.recommendedcombatmumberTxt).text = StageData.fc
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.mycombatnumberTxt).text = (ActorData.GetFc)()
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.titilenameTxt).text = StageData.name
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.challengenumberTxt).visible = false
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.PoltImageLoader).url = (Util.GetItemUrl)(StageData.battle_banner_show)
  if not (HandBookMgr.GetStageIsGetReward)(stageID) then
    local items = split(StageData.first_reward, ",")
    for _,v in ipairs(items) do
      (Util.SetFrameByConfig)(v, uis.Prop1List, false, true)
    end
  end
  do
    -- DECOMPILER ERROR at PC76: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (uis.ChallengeBtn).text = (PUtil.get)(60000008)
    ;
    ((uis.ChallengeBtn).onClick):Set(function(...)
    -- function num : 0_0_0 , upvalues : HandBookEnterFightWindow
    (HandBookEnterFightWindow.OnClickChallenge)()
  end
)
    ;
    ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_0_1 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.HandBookEnterFightWindow).name)
  end
)
  end
end

HandBookEnterFightWindow.OnClickChallenge = function(...)
  -- function num : 0_1 , upvalues : _ENV, stageID, HandBookEnterFightWindow
  local StageData = ((TableData.gTable).BaseHandbookStageData)[stageID]
  local groupList = split(StageData.monster_group_list, ":")
  local enemyList = (Util.CovertMonsterFormationToLocal)(tonumber(groupList[1]))
  local btnData = {}
  btnData.btnTxt = (PUtil.get)(20000021)
  btnData.fun = HandBookEnterFightWindow.ClickInStage
  local formationData = {}
  formationData.enemyList = enemyList
  local selfMonster = split(StageData.embattle_monster_ids, ":")
  formationData.PrepareList = selfMonster
  local externalData = {}
  externalData.maxFight = StageData.embattle_count_limit
  externalData.mustID = StageData.embattle_need_id
  formationData.ExternalData = externalData
  formationData.BtnData = btnData
  formationData.formationType = FormationType.Basic
  formationData.battleType = (ProtoEnum.E_BATTLE_TYPE).CG
  formationData.stageId = stageID
  ;
  (MessageMgr.OpenFormationWindow)(formationData)
end

HandBookEnterFightWindow.ClickInStage = function(list, ...)
  -- function num : 0_2 , upvalues : _ENV, stageID
  (HandBookService.OnReqInCGCopyStage)(stageID, list)
end

HandBookEnterFightWindow.OnShown = function(...)
  -- function num : 0_3
end

HandBookEnterFightWindow.OnHide = function(...)
  -- function num : 0_4
end

HandBookEnterFightWindow.OnClose = function(...)
  -- function num : 0_5 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

HandBookEnterFightWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_6
end

return HandBookEnterFightWindow

