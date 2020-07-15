-- params : ...
-- function num : 0 , upvalues : _ENV
local Asset = require("AssetStripWindow")
local CommonWinMgr = {}
CommonWinMgr.RegisterAssets = function(param, ...)
  -- function num : 0_0 , upvalues : Asset
  (Asset.Init)(param)
end

CommonWinMgr.RemoveAssets = function(name, ...)
  -- function num : 0_1 , upvalues : Asset
  (Asset.RemoveWindow)(name)
end

CommonWinMgr.RefreshAssets = function(...)
  -- function num : 0_2 , upvalues : Asset
  (Asset.RefreshAsset)()
end

CommonWinMgr.ModifyAssetsAmount = function(winName, moneyType, moneyNum, ...)
  -- function num : 0_3 , upvalues : Asset
  (Asset.RefreshAssetAmount)(winName, moneyType, moneyNum)
end

CommonWinMgr.ChangeAssetsType = function(windowName, types, ...)
  -- function num : 0_4 , upvalues : Asset
  (Asset.ChangeAssetType)(windowName, types)
end

CommonWinMgr.SetCountDown = function(id, endTime, ...)
  -- function num : 0_5 , upvalues : Asset
  (Asset.SetCountDownData)(id, endTime)
end

CommonWinMgr.HideCountDown = function(id, ...)
  -- function num : 0_6 , upvalues : Asset
  (Asset.HideMultiple)(id)
end

local _gestureDic = {}
CommonWinMgr.RegisterItemLongPress = function(item, itemId, equipInfo, Num, ResClick, ...)
  -- function num : 0_7 , upvalues : _ENV, CommonWinMgr
  if OvertureMgr.isPlaying == true then
    return 
  end
  local data, propType = (Util.GetConfigDataByID)(itemId)
  if propType == PropType.CARD or not data then
    return 
  end
  local LongPressGesture = (CommonWinMgr.GetGesture)(item)
  LongPressGesture.once = true
  LongPressGesture.trigger = 0.2
  ;
  (LongPressGesture.onAction):Set(function(...)
    -- function num : 0_7_0 , upvalues : _ENV, ResClick, itemId, Num, equipInfo
    if UIMgr:IsWindowOpen((WinResConfig.GuideWindow).name) then
      return 
    end
    if not ResClick then
      ((FairyGUI.Stage).inst):CancelClick(0)
    end
    OpenWindow((WinResConfig.ItemTipsWindow).name, UILayer.Popup, itemId, Num, equipInfo)
  end
)
  ;
  (LongPressGesture.onEnd):Set(function(...)
    -- function num : 0_7_1 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.ItemTipsWindow).name)
  end
)
  return LongPressGesture
end

CommonWinMgr.GetGesture = function(item, ...)
  -- function num : 0_8 , upvalues : _gestureDic, _ENV
  if _gestureDic[item.uid] == nil then
    _gestureDic[item.uid] = (FairyGUI.LongPressGesture)(item)
  end
  return _gestureDic[item.uid]
end

local gestureDicTalent = {}
CommonWinMgr.RegisterTalentLongPress = function(item, talentId, talentLvl, extraLvl, ResClick, ...)
  -- function num : 0_9 , upvalues : CommonWinMgr, _ENV
  local LongPressGesture = (CommonWinMgr.GetGestureTalent)(item)
  LongPressGesture.once = true
  LongPressGesture.trigger = 0.2
  ;
  (LongPressGesture.onAction):Set(function(...)
    -- function num : 0_9_0 , upvalues : ResClick, _ENV, talentId, talentLvl, extraLvl
    if not ResClick then
      ((FairyGUI.Stage).inst):CancelClick(0)
    end
    OpenWindow("SkillTipsWindow", UILayer.HUD)
    UIMgr:SendWindowMessage((WinResConfig.SkillTipsWindow).name, (WindowMsgEnum.Talent).E_MSG_TALNET_TALENT_TIPS, {talentId = talentId, talentLvl = talentLvl, extraLvl = extraLvl})
  end
)
  ;
  (LongPressGesture.onEnd):Set(function(...)
    -- function num : 0_9_1 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.SkillTipsWindow).name)
  end
)
  return LongPressGesture
end

CommonWinMgr.GetGestureTalent = function(item, ...)
  -- function num : 0_10 , upvalues : gestureDicTalent, _ENV
  if gestureDicTalent[item.uid] == nil then
    gestureDicTalent[item.uid] = (FairyGUI.LongPressGesture)(item)
  end
  return gestureDicTalent[item.uid]
end

CommonWinMgr.ClearGestureDicTalent = function(...)
  -- function num : 0_11 , upvalues : _ENV, gestureDicTalent
  for uid,gesture in ipairs(gestureDicTalent) do
    gesture:Enable(false)
    gesture:Dispose()
  end
  gestureDicTalent = {}
end

local gestureMultiple = {}
CommonWinMgr.RegisterMultipleLongPress = function(item, name, multNum, icon, endTime, ResClick, ...)
  -- function num : 0_12 , upvalues : CommonWinMgr, _ENV
  local LongPressGesture = (CommonWinMgr.GetGestureMultiple)(item)
  LongPressGesture.once = true
  LongPressGesture.trigger = 0.2
  ;
  (LongPressGesture.onAction):Set(function(...)
    -- function num : 0_12_0 , upvalues : ResClick, _ENV, name, multNum, icon, endTime
    if not ResClick then
      ((FairyGUI.Stage).inst):CancelClick(0)
    end
    OpenWindow((WinResConfig.DoubleRewardTipsWindow).name, UILayer.HUD, name, multNum, icon, endTime)
  end
)
  ;
  (LongPressGesture.onEnd):Set(function(...)
    -- function num : 0_12_1 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.DoubleRewardTipsWindow).name)
  end
)
  return LongPressGesture
end

CommonWinMgr.GetGestureMultiple = function(item, ...)
  -- function num : 0_13 , upvalues : gestureMultiple, _ENV
  if gestureMultiple[item.uid] == nil then
    gestureMultiple[item.uid] = (FairyGUI.LongPressGesture)(item)
  end
  return gestureMultiple[item.uid]
end

CommonWinMgr.ClearGestureMultiple = function(...)
  -- function num : 0_14 , upvalues : _ENV, gestureMultiple
  for uid,gesture in ipairs(gestureMultiple) do
    gesture:Enable(false)
    gesture:Dispose()
  end
  gestureMultiple = {}
end

CommonWinMgr.OpenBattleDataWindow = function(BattleDataS, ...)
  -- function num : 0_15 , upvalues : _ENV
  if not BattleDataS or #BattleDataS <= 0 then
    return 
  end
  OpenWindow((WinResConfig.BattleDataWindow).name, UILayer.HUD, BattleDataS)
end

CommonWinMgr.OpenDailyDungeonBattleWindow = function(sData, ...)
  -- function num : 0_16 , upvalues : _ENV, CommonWinMgr
  local m = {}
  m.BattleType = (ProtoEnum.E_BATTLE_TYPE).EXP
  local StageData = ((TableData.gTable).BaseTrialStageData)[tonumber(BattleData.stageId)]
  if StageData then
    m.CardAddIntimacy = StageData.card_intimacy
  end
  m.cardInfo = sData.cardInfo
  m.DamageNum = sData.damageData
  m.BasicGoods = (Util.GoodsObjectToItemDataModel)(sData.trialDrop)
  local btn2 = {}
  btn2.btnTxt = (PUtil.get)(60000004)
  local callBack = function(...)
    -- function num : 0_16_0 , upvalues : sData, _ENV
    if sData.isDraw then
      local isDraw = (sData.isDraw)[1]
    end
    if Game.testPackage == true then
      isDraw = false
    end
    if isDraw == true then
      OpenWindow((WinResConfig.DailyDungeonPassRewardWindow).name, UILayer.HUD, sData)
    else
      UIMgr:CloseWindow((WinResConfig.BattleWinConvergeWindow).name)
    end
  end

  btn2.fun = function(...)
    -- function num : 0_16_1 , upvalues : _ENV, callBack
    if UIMgr:IsWindowOpen((WinResConfig.BattleUIWindow).name) == true then
      UIMgr:SetOnShownComplete((WinResConfig.DailyDungeonDifficultyWindow).name, function(...)
      -- function num : 0_16_1_0 , upvalues : callBack
      callBack()
    end
)
      ld("Battle", function(...)
      -- function num : 0_16_1_1 , upvalues : _ENV
      (BattleMgr.CloseBattle)()
    end
)
    else
      callBack()
    end
  end

  m.btn2 = btn2
  ;
  (CommonWinMgr.OpenBattleSettleConvergeWindow)(m)
end

CommonWinMgr.OpenArenaBattleWindow = function(sData, ...)
  -- function num : 0_17 , upvalues : _ENV, CommonWinMgr
  if sData.isSuccess == true then
    local m = {}
    m.BattleType = (ProtoEnum.E_BATTLE_TYPE).ARENA
    m.cardInfo = (sData.arenaData).arenaCardGroups
    local goods = (Util.GoodsObjectToItemDataModel)(sData.reward)
    local score = {}
    score.id = AssetType.ARENA_SCORE
    score.Num = sData.addScore
    ;
    (table.insert)(goods, score)
    m.BasicGoods = goods
    local btn2 = {}
    btn2.btnTxt = (PUtil.get)(20000024)
    btn2.fun = function(...)
    -- function num : 0_17_0 , upvalues : _ENV
    if UIMgr:IsWindowOpen((WinResConfig.BattleUIWindow).name) == true then
      ld("Battle", function(...)
      -- function num : 0_17_0_0 , upvalues : _ENV
      (BattleMgr.CloseBattle)()
    end
)
    else
      ;
      (LuaSound.LoadAndPlayBGM)(1010002)
      UIMgr:CloseWindow((WinResConfig.BattleWinConvergeWindow).name)
    end
  end

    m.btn2 = btn2
    ;
    (CommonWinMgr.OpenBattleSettleConvergeWindow)(m)
  else
    do
      local m = {}
      m.BattleType = (ProtoEnum.E_BATTLE_TYPE).ARENA
      ;
      (CommonWinMgr.OpenBattleFailConvergeWindow)(m)
    end
  end
end

CommonWinMgr.OpenCommonFcUp = function(cardId, ...)
  -- function num : 0_18 , upvalues : _ENV
  loge("准备打开战斗力变化      ")
  if cardId then
    local fcInfo = (CardData.fcChangeList)[cardId]
    if fcInfo and fcInfo.preFc < fcInfo.newFc then
      if UIMgr:IsWindowOpen((WinResConfig.BattleUpWindow).name) == true then
        UIMgr:SendWindowMessage((WinResConfig.BattleUpWindow).name, 1, cardId)
      else
        OpenWindow((WinResConfig.BattleUpWindow).name, UILayer.Popup, cardId)
      end
      return true
    end
  else
    do
      do
        local fcInfo = ActorData.fcChangeList
        if fcInfo and fcInfo.preFc < fcInfo.newFc then
          if UIMgr:IsWindowOpen((WinResConfig.BattleUpWindow).name) == true then
            UIMgr:SendWindowMessage((WinResConfig.BattleUpWindow).name, 1)
          else
            OpenWindow((WinResConfig.BattleUpWindow).name, UILayer.Popup)
          end
          return true
        end
        return false
      end
    end
  end
end

CommonWinMgr.OpenCGShow = function(CGid, isGet, fun, ...)
  -- function num : 0_19 , upvalues : _ENV
  OpenWindow((WinResConfig.HandBookCGShowWindow).name, UILayer.HUD, CGid, isGet, fun)
end

local m = {}
CommonWinMgr.OpenBattleSettleConvergeWindow = function(data, ...)
  -- function num : 0_20 , upvalues : _ENV
  OpenWindow((WinResConfig.BattleWinConvergeWindow).name, UILayer.HUD, data)
end

local m = {}
CommonWinMgr.OpenBattleFailConvergeWindow = function(data, ...)
  -- function num : 0_21 , upvalues : _ENV
  OpenWindow((WinResConfig.BattleFailConvergeWindow).name, UILayer.HUD, data)
end

return CommonWinMgr

