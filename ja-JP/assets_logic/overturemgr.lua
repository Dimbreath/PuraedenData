-- params : ...
-- function num : 0 , upvalues : _ENV
OvertureMgr = {}
OVERTURE_PROGRESS = {NONE = "0", AFTER_NAME = "1", BEFORE_BATTLE_1 = "2", AFTER_BATTLE_1 = "3", AFTER_BATTLE_2 = "4"}
local endCallback = nil
-- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

OvertureMgr.OpenOverture = function(callback, ...)
  -- function num : 0_0 , upvalues : _ENV, endCallback
  (ActorMgr.InitHeartMessageUpdate)()
  if OvertureMgr.isPlaying == true then
    return 
  end
  endCallback = callback
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  OvertureMgr.isPlaying = true
  local progress = (OvertureMgr.GetProgress)()
  ;
  (OvertureMgr.PlayOverture)(progress)
end

-- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

OvertureMgr.PlayOverture = function(index, ...)
  -- function num : 0_1 , upvalues : _ENV, endCallback
  if not index then
    index = (OvertureMgr.GetProgress)()
  end
  if index == OVERTURE_PROGRESS.NONE then
    (OvertureMgr.SendRecord)(1)
    UIMgr:CloseAllWindow()
    ld("PlotPlay")
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

    PlotPlayData.ForceKeepBGM = true
    OpenPlotPlay("75001111:75001112:75001113", PlotPlayTriggerType.INSTANTLY_PLAY, function(...)
    -- function num : 0_1_0 , upvalues : _ENV
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

    PlotPlayData.ForceKeepBGM = false
    OpenWindow((WinResConfig.NameWindow).name, UILayer.HUD1)
    ;
    (OvertureMgr.SendRecord)(2)
  end
)
  else
    if index == OVERTURE_PROGRESS.AFTER_NAME then
      local name = (WinResConfig.NameWindow).name
      if UIMgr:IsWindowOpen(name) == true then
        UIMgr:CloseWindow(name, function(...)
    -- function num : 0_1_1 , upvalues : _ENV
    OpenPlotPlay("75001114:75001115:75001116:75001117:75001118", PlotPlayTriggerType.INSTANTLY_PLAY, function(...)
      -- function num : 0_1_1_0 , upvalues : _ENV
      (OvertureMgr.SetProgress)(OVERTURE_PROGRESS.BEFORE_BATTLE_1)
      ;
      (OvertureMgr.PlayOverture)()
    end
)
  end
)
      else
        UIMgr:CloseAllWindow()
        OpenPlotPlay("75001114:75001115:75001116:75001117:75001118", PlotPlayTriggerType.INSTANTLY_PLAY, function(...)
    -- function num : 0_1_2 , upvalues : _ENV
    (OvertureMgr.SetProgress)(OVERTURE_PROGRESS.BEFORE_BATTLE_1)
    ;
    (OvertureMgr.PlayOverture)()
  end
)
      end
    else
      do
        if index == OVERTURE_PROGRESS.BEFORE_BATTLE_1 then
          local battleCompleteData = require("OvertureScript1")
          ;
          (BattleData.SaveBattleData)(battleCompleteData, function(...)
    -- function num : 0_1_3 , upvalues : _ENV
    (BattleMgr.CloseBattle)(false, function(...)
      -- function num : 0_1_3_0 , upvalues : _ENV
      (OvertureMgr.SetProgress)(OVERTURE_PROGRESS.AFTER_BATTLE_1)
      ;
      (OvertureMgr.PlayOverture)()
    end
, true)
  end
)
          ;
          (BattleResource.Load)()
        else
          do
            if index == OVERTURE_PROGRESS.AFTER_BATTLE_1 then
              local battleCompleteData = require("OvertureScript2")
              ;
              (BattleData.SaveBattleData)(battleCompleteData, function(...)
    -- function num : 0_1_4 , upvalues : _ENV
    local data = {
BasicGoods = {
[1] = {Num = 20, Type = 2, id = 21100001, isGet = false}
, 
[2] = {Num = 5000, Type = 2, id = 21100003, isGet = false}
, 
[3] = {Num = 6, Type = 1, id = 21110001, isGet = false}
}
, BattleType = BattleData.battleType, CardAddExp = 10, 
FirstGoods = {}
, 
cardData = {
[11100003] = {id = 11100003, level = 1, exp = 10}
, 
[11100002] = {id = 11100002, level = 1, exp = 10}
}
, TeamAddExp = 6, ActorLevel = 3, ActorExp = 0, 
btn2 = {btnTxt = (PUtil.get)(60000004), fun = function(...)
      -- function num : 0_1_4_0 , upvalues : _ENV
      (BattleMgr.CloseBattle)(false, function(...)
        -- function num : 0_1_4_0_0
      end
, true)
      ;
      (OvertureMgr.SetProgress)(OVERTURE_PROGRESS.AFTER_BATTLE_2)
      ;
      (OvertureMgr.PlayOverture)()
    end
}
}
    ;
    (OvertureMgr.SendRecord)(6)
    ;
    (CommonWinMgr.OpenBattleSettleConvergeWindow)(data)
  end
)
              ;
              (BattleResource.Load)()
            else
              do
                if index == OVERTURE_PROGRESS.AFTER_BATTLE_2 and endCallback then
                  endCallback()
                end
              end
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

OvertureMgr.GetProgress = function(...)
  -- function num : 0_2 , upvalues : _ENV
  local key = (LoginMgr.GetAccount)() .. "_OVERTURE_PROGRESS"
  local progress = (Util.GetPlayerSetting)(key, OVERTURE_PROGRESS.NONE)
  return progress
end

-- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

OvertureMgr.SetProgress = function(progress, ...)
  -- function num : 0_3 , upvalues : _ENV
  if progress == OVERTURE_PROGRESS.AFTER_NAME then
    (OvertureMgr.SendRecord)(3)
  else
    if progress == OVERTURE_PROGRESS.BEFORE_BATTLE_1 then
      (OvertureMgr.SendRecord)(4)
    else
      if progress == OVERTURE_PROGRESS.AFTER_BATTLE_1 then
        (OvertureMgr.SendRecord)(5)
      else
        if progress == OVERTURE_PROGRESS.AFTER_BATTLE_2 then
          (OvertureMgr.SendRecord)(7)
        end
      end
    end
  end
  local key = (LoginMgr.GetAccount)() .. "_OVERTURE_PROGRESS"
  ;
  (Util.SetPlayerSetting)(key, progress)
end

-- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

OvertureMgr.HideSetBtn = function(...)
  -- function num : 0_4 , upvalues : _ENV
  local progress = (OvertureMgr.GetProgress)()
  do return progress == OVERTURE_PROGRESS.NONE or progress == OVERTURE_PROGRESS.AFTER_NAME end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

OvertureMgr.SendRecord = function(record, ...)
  -- function num : 0_5 , upvalues : _ENV
  local m = {}
  m.type = record
  m.platform = (LoginMgr.GetPlatform)()
  m.channel = (LoginMgr.GetChannel)()
  m.account = (LoginMgr.GetAccount)()
  m.deviceId = SystemInfo.deviceUniqueIdentifier
  ;
  (Net.Send)((Proto.MsgName).ReqOverture, m)
end


