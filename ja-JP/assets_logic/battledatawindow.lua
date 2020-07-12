-- params : ...
-- function num : 0 , upvalues : _ENV
require("BattleDataCount_BattleDataWindowByName")
require("BattleDataCount_BattleDataModelByName")
require("BattleDataCount_RecordBattleDataCardGrpByName")
local BattleDataWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
GTween = FairyGUI.GTween
local tweenList = {}
BattleDataWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, tweenList, uis
  bridgeObj:SetView((WinResConfig.BattleDataWindow).package, (WinResConfig.BattleDataWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  contentPane:Center()
  tweenList = {}
  uis = GetBattleDataCount_BattleDataWindowUis(contentPane)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.WordTxt).text = (PUtil.get)(33)
  uis = uis.BattleDataComp
  ;
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.BattleDataWindow).name)
  end
)
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.Colour_01_Txt).text = (PUtil.get)(20000375)
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.Colour_02_Txt).text = (PUtil.get)(20000376)
end

BattleDataWindow.OnShown = function(...)
  -- function num : 0_1 , upvalues : uis, argTable, _ENV, BattleDataWindow
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

  (uis.BattleDataModelList).numItems = 0
  local dataS = argTable[1]
  for _,v in ipairs(dataS) do
    local model = (BattleDataWindow.CreateSingleSummarize)(v)
    if model then
      (uis.BattleDataModelList):AddChild(model)
    end
  end
end

BattleDataWindow.CreateSingleSummarize = function(data, ...)
  -- function num : 0_2 , upvalues : _ENV, BattleDataWindow
  if not data then
    return 
  end
  local singleModel = UIMgr:CreateObject("BattleDataCount", "BattleDataModel")
  local singleUis = GetBattleDataCount_BattleDataModelUis(singleModel)
  if data.isSelfSuccess then
    ChangeController(singleUis.c1Ctr, 0)
  else
    ChangeController(singleUis.c1Ctr, 1)
  end
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (singleUis.MySelfTxt).text = (PUtil.get)(20000266)
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (singleUis.EnemyTxt).text = (PUtil.get)(20000267)
  local maxDamage = (BattleDataWindow.GetMaxDamage)(data.SelfCardData, data.EnemyCardData)
  local maxDefense = (BattleDataWindow.GetMaxDefense)(data.SelfCardData, data.EnemyCardData)
  for i = 1, 6 do
    local selfData = (BattleDataWindow.GetCardDataByPos)(data.SelfCardData, i)
    local enemyData = (BattleDataWindow.GetCardDataByPos)(data.EnemyCardData, i)
    local selfModel = (Util.GetGroupDate)(singleModel, singleUis.MySelfGrp, i)
    local enemyModel = (Util.GetGroupDate)(singleModel, singleUis.EnemyGrp, i)
    ;
    (BattleDataWindow.SetCardData)(selfModel, selfData, maxDamage, maxDefense)
    ;
    (BattleDataWindow.SetCardData)(enemyModel, enemyData, maxDamage, maxDefense)
  end
  return singleModel
end

BattleDataWindow.SetCardData = function(model, data, maxDamage, maxDefense, ...)
  -- function num : 0_3 , upvalues : _ENV, tweenList
  local CardModel = GetBattleDataCount_RecordBattleDataCardGrpUis(model)
  if data then
    ChangeUIController(model, "c1", 0)
    local cardInfo = {}
    do
      cardInfo.id = ((data.CardData).cardInfo).id
      cardInfo.quality = ((data.CardData).cardInfo).quality
      cardInfo.star = ((data.CardData).cardInfo).star
      cardInfo.level = ((data.CardData).cardInfo).level
      local config, isMonster = (CardData.GetBaseConfig)(((data.CardData).cardInfo).id)
      ;
      (Util.SetHeadFrame)((CardModel.HeadFrameGrp).root, cardInfo, isMonster)
      local cardData = (CardData.GetBaseConfig)(tonumber(((data.CardData).cardInfo).id))
      -- DECOMPILER ERROR at PC50: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (CardModel.PlayerNameTxt).text = cardData.name
      local gt = (GTween.To)(0, data.DamageNum, 1)
      local ackTxt = CardModel.NumberTxt
      local actBar = CardModel.BattleSettleProgressBar
      ackTxt.visible = data.DamageNum > 0
      gt:OnUpdate(function(...)
    -- function num : 0_3_0 , upvalues : actBar, gt, maxDamage, ackTxt, _ENV
    actBar.value = (gt.value).x / maxDamage * 100
    ackTxt.text = (Util.NumberTransformKilo)((math.ceil)((gt.value).x))
  end
)
      ;
      (table.insert)(tweenList, gt)
      local defBar = model:GetChild("DefBar")
      local defTxt = CardModel.DefTxt
      defTxt.visible = data.HurtNum > 0
      defBar.value = 0
      defTxt.text = 0
      local gt2 = (GTween.To)(0, data.HurtNum, 1)
      gt2:OnUpdate(function(...)
    -- function num : 0_3_1 , upvalues : defBar, gt2, maxDefense, defTxt, _ENV
    defBar.value = (gt2.value).x / maxDefense * 100
    defTxt.text = (Util.NumberTransformKilo)((math.ceil)((gt2.value).x))
  end
)
      ;
      (table.insert)(tweenList, gt2)
    end
  else
    ChangeUIController(model, "c1", 1)
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

BattleDataWindow.GetMaxDamage = function(self, enemy, ...)
  -- function num : 0_4 , upvalues : _ENV
  local maxValue = 0
  for _,v in pairs(self) do
    if maxValue < v.DamageNum then
      maxValue = v.DamageNum
    end
  end
  for _,v in pairs(enemy) do
    if maxValue < v.DamageNum then
      maxValue = v.DamageNum
    end
  end
  return maxValue
end

BattleDataWindow.GetMaxDefense = function(self, enemy, ...)
  -- function num : 0_5 , upvalues : _ENV
  local maxValue = 0
  for _,v in pairs(self) do
    if maxValue < v.HurtNum then
      maxValue = v.HurtNum
    end
  end
  for _,v in pairs(enemy) do
    if maxValue < v.HurtNum then
      maxValue = v.HurtNum
    end
  end
  return maxValue
end

BattleDataWindow.GetCardDataByPos = function(data, pos, ...)
  -- function num : 0_6 , upvalues : _ENV
  for _,v in ipairs(data) do
    if (v.CardData).posIndex == pos then
      return v
    end
  end
end

BattleDataWindow.OnHide = function(...)
  -- function num : 0_7
end

BattleDataWindow.OnClose = function(...)
  -- function num : 0_8 , upvalues : _ENV, tweenList, uis, contentPane
  for _,v in ipairs(tweenList) do
    if v then
      v:Kill()
    end
  end
  uis = nil
  contentPane = nil
end

BattleDataWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_9
end

return BattleDataWindow

