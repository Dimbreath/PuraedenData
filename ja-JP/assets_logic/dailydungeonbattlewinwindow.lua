-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_DailyDungeonBattleWinByName")
require("CommonResource_HeadFrameByName")
require("CommonResource_HeadFrameWordByName")
GTextField = FairyGUI.GTextField
TextFormat = FairyGUI.TextFormat
DailyDungeonBattleWinWindow = {}
local uis, settleData = nil, nil
-- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

DailyDungeonBattleWinWindow.OnInit = function(bridge, ...)
  -- function num : 0_0 , upvalues : _ENV, uis, settleData
  bridge:SetView((WinResConfig.DailyDungeonBattleWinWindow).package, (WinResConfig.DailyDungeonBattleWinWindow).comName)
  uis = GetBattle_DailyDungeonBattleWinUis(bridge.contentPane)
  local argTable = bridge.argTable
  settleData = argTable[1]
  local damageData = settleData.damageData
  if damageData.totalEnemyHp < 0 then
    (DailyDungeonBattleWinWindow.HideSweepInfo)()
  end
  ;
  (Util.CreateSelfShowModel)(uis.CharacterLoader)
  ;
  (DailyDungeonBattleWinWindow.InitGoods)(settleData)
  ;
  (DailyDungeonBattleWinWindow.InitProgress)(settleData.damageData)
  ;
  (DailyDungeonBattleWinWindow.InitBtn)(uis.DataBtn, {btnTxt = (PUtil.get)(20000061), fun = function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    local ChallengeSummarizeDataTable = (BattleResultCount.GetBattleDamageData)()
    ;
    (CommonWinMgr.OpenBattleDataWindow)(ChallengeSummarizeDataTable)
  end
})
  if settleData.isDraw then
    local isDraw = (settleData.isDraw)[1]
  end
  if Game.testPackage == true then
    isDraw = false
  end
  local callback = function(...)
    -- function num : 0_0_1 , upvalues : isDraw, _ENV, settleData
    if isDraw == true then
      OpenWindow((WinResConfig.DailyDungeonPassRewardWindow).name, UILayer.HUD, settleData)
    else
      UIMgr:CloseWindow((WinResConfig.DailyDungeonBattleWinWindow).name)
    end
  end

  ;
  (DailyDungeonBattleWinWindow.InitBtn)(uis.CloseBtn, {btnTxt = (PUtil.get)(60000004), fun = function(...)
    -- function num : 0_0_2 , upvalues : _ENV, callback
    if UIMgr:IsWindowOpen((WinResConfig.BattleUIWindow).name) == true then
      UIMgr:SetOnShownComplete((WinResConfig.DailyDungeonDifficultyWindow).name, function(...)
      -- function num : 0_0_2_0 , upvalues : callback
      callback()
    end
)
      ld("Battle", function(...)
      -- function num : 0_0_2_1 , upvalues : _ENV
      (BattleMgr.CloseBattle)()
    end
)
    else
      callback()
    end
  end
})
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

DailyDungeonBattleWinWindow.HideSweepInfo = function(...)
  -- function num : 0_1 , upvalues : uis
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

  (uis.DataBtn).visible = false
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.HurtNumberTxt).visible = false
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.HurtNumberProgressBar).visible = false
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.Decorate_10_Image).visible = false
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.Decorate_11_Image).visible = false
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

DailyDungeonBattleWinWindow.InitGoods = function(settleData, ...)
  -- function num : 0_2 , upvalues : uis, _ENV
  local trialDrop = settleData.trialDrop
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.ItemList).numItems = 0
  if trialDrop then
    for _,v in ipairs(trialDrop) do
      local data = v
      if tonumber(data.id) ~= AssetType.ACTOR_EXP and tonumber(data.id) ~= AssetType.CARD_EXP then
        local frame, LongPressGesture = (Util.CreateFrame)(data.id, false, data.value)
        if LongPressGesture then
          LongPressGesture:Dispose()
        end
        local loader = frame:GetChild("IconLoader")
        if loader then
          local allCount = (ActorData.GetGoodsCount)(data.id, v.type)
          local drawCount = (DailyDungeonBattleWinWindow.GetDrawCountById)(settleData.drawDrop, data.id)
          ;
          (CommonWinMgr.RegisterItemLongPress)(loader, data.id, nil, allCount - drawCount)
        end
        do
          do
            ;
            (uis.ItemList):AddChild(frame)
            -- DECOMPILER ERROR at PC60: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC60: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC60: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R2 in 'UnsetPending'

DailyDungeonBattleWinWindow.GetDrawCountById = function(drawDrop, id, ...)
  -- function num : 0_3 , upvalues : _ENV
  if drawDrop then
    for _,v in ipairs(drawDrop) do
      if v.id == id then
        return v.value
      end
    end
  end
  do
    return 0
  end
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

DailyDungeonBattleWinWindow.InitProgress = function(damageData, ...)
  -- function num : 0_4 , upvalues : uis, _ENV
  local progressBar = uis.HurtNumberProgressBar
  local progressTxt = uis.HurtNumberTxt
  local totalSelfDamage, totalEnemyHp = nil, nil
  if damageData then
    totalSelfDamage = damageData.totalSelfDamage
  else
    -- DECOMPILER ERROR at PC12: Overwrote pending register: R4 in 'AssignReg'

    totalSelfDamage = (BattleResultCount.GetRealTotalDamage)()
  end
  progressBar.value = 0
  progressBar:TweenValue(100 * totalSelfDamage / totalEnemyHp, 1)
  ;
  ((LeanTween.value)(0, totalSelfDamage, 1)):setOnUpdate(function(value, ...)
    -- function num : 0_4_0 , upvalues : progressTxt, _ENV, totalEnemyHp
    progressTxt.text = (math.ceil)(value) .. "/" .. totalEnemyHp
  end
)
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

DailyDungeonBattleWinWindow.InitBtn = function(btn, btnData, ...)
  -- function num : 0_5
  if btnData then
    btn.text = btnData.btnTxt
    ;
    (btn.onClick):Add(btnData.fun)
  else
    btn.visible = false
  end
end

-- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

DailyDungeonBattleWinWindow.OnShown = function(...)
  -- function num : 0_6 , upvalues : uis, _ENV
  local title = uis.Decorate_13_Image
  local pos = Vector2(title.x + title.width * 0.5, title.y + title.height * 0.5)
  ;
  (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_UNLOCK, true, uis.root, pos)
end

-- DECOMPILER ERROR at PC41: Confused about usage of register: R2 in 'UnsetPending'

DailyDungeonBattleWinWindow.OnHide = function(...)
  -- function num : 0_7
end

-- DECOMPILER ERROR at PC44: Confused about usage of register: R2 in 'UnsetPending'

DailyDungeonBattleWinWindow.OnClose = function(...)
  -- function num : 0_8 , upvalues : _ENV, uis
  (Util.RecycleUIModel)(uis.CharacterLoader)
  uis = nil
end

-- DECOMPILER ERROR at PC47: Confused about usage of register: R2 in 'UnsetPending'

DailyDungeonBattleWinWindow.HandleMessage = function(msgId, ...)
  -- function num : 0_9
  if msgId ~= 1 or msgId == 2 then
  end
end

return DailyDungeonBattleWinWindow

