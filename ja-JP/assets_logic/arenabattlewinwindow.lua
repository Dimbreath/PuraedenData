-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_ArenaBattleWinByName")
require("CommonResource_HeadFrameByName")
require("CommonResource_HeadFrameWordByName")
ArenaBattleWinWindow = {}
local uis, settleData = nil, nil
-- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

ArenaBattleWinWindow.OnInit = function(bridge, ...)
  -- function num : 0_0 , upvalues : _ENV, uis, settleData
  bridge:SetView((WinResConfig.ArenaBattleWinWindow).package, (WinResConfig.ArenaBattleWinWindow).comName)
  uis = GetBattle_ArenaBattleWinUis(bridge.contentPane)
  local argTable = bridge.argTable
  settleData = argTable[1]
  ;
  (Util.CreateSelfShowModel)(uis.CharacterLoader)
  ;
  (ArenaBattleWinWindow.InitGoods)(settleData.reward)
  ;
  (ArenaBattleWinWindow.InitScore)(settleData.addScore)
  if UIMgr:IsWindowOpen((WinResConfig.BattleUIWindow).name) then
    (ArenaBattleWinWindow.InitBtn)(uis.DataBtn, {btnTxt = (PUtil.get)(20000061), fun = function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    local ChallengeSummarizeDataTable = (BattleResultCount.GetBattleDamageData)()
    ;
    (CommonWinMgr.OpenBattleDataWindow)(ChallengeSummarizeDataTable)
  end
})
  else
    ;
    (ArenaBattleWinWindow.InitBtn)(uis.DataBtn)
  end
  ;
  (ArenaBattleWinWindow.InitBtn)(uis.CloseBtn, {btnTxt = (PUtil.get)(60000004), fun = function(...)
    -- function num : 0_0_1 , upvalues : _ENV
    if UIMgr:IsWindowOpen((WinResConfig.BattleUIWindow).name) == true then
      ld("Battle", function(...)
      -- function num : 0_0_1_0 , upvalues : _ENV
      (BattleMgr.CloseBattle)()
    end
)
    else
      UIMgr:CloseWindow((WinResConfig.ArenaBattleWinWindow).name)
    end
  end
})
end

-- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

ArenaBattleWinWindow.InitGoods = function(reward, ...)
  -- function num : 0_1 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (uis.ItemList).numItems = 0
  if reward then
    for _,v in ipairs(reward) do
      local data = v
      if tonumber(data.id) ~= AssetType.ACTOR_EXP and tonumber(data.id) ~= AssetType.CARD_EXP then
        local frame = (Util.CreateFrame)(data.id, false, data.value)
        ;
        (uis.ItemList):AddChild(frame)
      end
    end
  end
end

-- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

ArenaBattleWinWindow.InitScore = function(addScore, ...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.ScoreNumberTxt).text = "+" .. tostring(addScore or 0)
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

ArenaBattleWinWindow.InitBtn = function(btn, btnData, ...)
  -- function num : 0_3
  if btnData then
    btn.visible = true
    btn.text = btnData.btnTxt
    ;
    (btn.onClick):Add(btnData.fun)
  else
    btn.visible = false
  end
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

ArenaBattleWinWindow.OnShown = function(...)
  -- function num : 0_4 , upvalues : uis, _ENV
  local title = uis.Decorate_13_Image
  local pos = Vector2(title.x + title.width * 0.5, title.y + title.height * 0.5)
  ;
  (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_UNLOCK, true, uis.root, pos)
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R2 in 'UnsetPending'

ArenaBattleWinWindow.OnHide = function(...)
  -- function num : 0_5
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

ArenaBattleWinWindow.OnClose = function(...)
  -- function num : 0_6 , upvalues : _ENV, uis, settleData
  (Util.RecycleUIModel)(uis.CharacterLoader)
  uis = nil
  settleData = nil
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

ArenaBattleWinWindow.HandleMessage = function(msgId, ...)
  -- function num : 0_7
  if msgId ~= 1 or msgId == 2 then
  end
end

return ArenaBattleWinWindow

