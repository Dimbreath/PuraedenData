-- params : ...
-- function num : 0 , upvalues : _ENV
BattleService = {}
local self = BattleService
-- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

BattleService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV, self
  if IsBattleServer == nil then
    (Net.AddListener)((Proto.MsgName).InitBattleData, self.OnBattle_ResInitData)
    ;
    (Net.AddListener)((Proto.MsgName).BattleCompleteData, self.OnBattle_BattleCompleteData)
  end
end

-- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

BattleService.OnBattle_ResInitData = function(param, ...)
  -- function num : 0_1 , upvalues : _ENV, self
  PrintTable(param, "战斗初始化数据：")
  ;
  (self.DealBattleData)(param)
end

-- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

BattleService.OnBattle_BattleCompleteData = function(param, replay, ...)
  -- function num : 0_2 , upvalues : self
  (self.DealBattleData)(param, replay)
end

-- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

BattleService.DealBattleData = function(data, replay, callback, ...)
  -- function num : 0_3 , upvalues : _ENV
  (LuaSound.StopBGM)()
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  BattleData.Replay = replay or false
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  BattleData.endCallback = callback
  UIMgr:SetOnShownComplete((WinResConfig.LoadingWindow).name, function(...)
    -- function num : 0_3_0 , upvalues : _ENV, data
    (ResHelper.ClearModel)()
    ;
    (ResHelper.ClearEffect)()
    ;
    (((CS.UnityEngine).Resources).UnloadUnusedAssets)()
    ld("Battle", function(...)
      -- function num : 0_3_0_0 , upvalues : _ENV, data
      (BattleData.SaveBattleData)(data)
      ;
      (BattleResource.Load)()
    end
)
  end
)
  if UIMgr:IsWindowOpen((WinResConfig.FormationWindow).name) then
    UIMgr:CloseWindow((WinResConfig.FormationWindow).name, true, true)
  end
  OpenWindow((WinResConfig.LoadingWindow).name, UILayer.Loading)
end

-- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

BattleService.SendOutBattle = function(...)
  -- function num : 0_4 , upvalues : _ENV
  local m = {}
  m.battleUid = BattleData.battleUid
  ;
  (Net.Send)((Proto.MsgName).ReqExitBattle, m)
end

;
(BattleService.Init)()

