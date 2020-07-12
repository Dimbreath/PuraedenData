-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_ArenaBattleFailByName")
require("CommonResource_HeadFrameByName")
require("CommonResource_HeadFrameWordByName")
ArenaBattleFailWindow = {}
local uis, settleData = nil, nil
-- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

ArenaBattleFailWindow.OnInit = function(bridge, ...)
  -- function num : 0_0 , upvalues : _ENV, uis, settleData
  bridge:SetView((WinResConfig.ArenaBattleFailWindow).package, (WinResConfig.ArenaBattleFailWindow).comName)
  uis = GetBattle_ArenaBattleFailUis(bridge.contentPane)
  local argTable = bridge.argTable
  settleData = argTable[1]
  ;
  (Util.CreateSelfShowModel)(uis.CharacterLoader)
  ;
  (ArenaBattleFailWindow.InitScore)(settleData.addScore)
  ;
  (ArenaBattleFailWindow.InitWord)()
  ;
  (ArenaBattleFailWindow.InitBtn)(uis.DataBtn, {btnTxt = (PUtil.get)(20000061), fun = function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    local ChallengeSummarizeDataTable = (BattleResultCount.GetBattleDamageData)()
    ;
    (CommonWinMgr.OpenBattleDataWindow)(ChallengeSummarizeDataTable)
  end
})
  ;
  (ArenaBattleFailWindow.InitBtn)(uis.CloseBtn, {btnTxt = (PUtil.get)(60000004), fun = function(...)
    -- function num : 0_0_1 , upvalues : _ENV
    if UIMgr:IsWindowOpen((WinResConfig.BattleUIWindow).name) == true then
      ld("Battle", function(...)
      -- function num : 0_0_1_0 , upvalues : _ENV
      (BattleMgr.CloseBattle)()
    end
)
    end
  end
})
end

-- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

ArenaBattleFailWindow.InitGoods = function(reward, ...)
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

ArenaBattleFailWindow.InitScore = function(addScore, ...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.ScoreNumberTxt).text = "+" .. tostring(addScore or 0)
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

ArenaBattleFailWindow.InitWord = function(...)
  -- function num : 0_3
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

ArenaBattleFailWindow.InitBtn = function(btn, btnData, ...)
  -- function num : 0_4
  if btnData then
    btn.text = btnData.btnTxt
    ;
    (btn.onClick):Add(btnData.fun)
  else
    btn.visible = false
  end
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R2 in 'UnsetPending'

ArenaBattleFailWindow.OnShown = function(...)
  -- function num : 0_5
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

ArenaBattleFailWindow.OnHide = function(...)
  -- function num : 0_6
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

ArenaBattleFailWindow.OnClose = function(...)
  -- function num : 0_7 , upvalues : _ENV, uis
  (Util.RecycleUIModel)(uis.CharacterLoader)
  uis = nil
end

-- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

ArenaBattleFailWindow.HandleMessage = function(msgId, ...)
  -- function num : 0_8
  if msgId ~= 1 or msgId == 2 then
  end
end

return ArenaBattleFailWindow

