-- params : ...
-- function num : 0 , upvalues : _ENV
require("Expedition_ChoiceDifficultyWindowByName")
local ExpeditionEnterWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local Eid = nil
ExpeditionEnterWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, Eid, uis, ExpeditionEnterWindow
  bridgeObj:SetView((WinResConfig.ExpeditionEnterWindow).package, (WinResConfig.ExpeditionEnterWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  Eid = argTable[1]
  uis = GetExpedition_ChoiceDifficultyWindowUis(contentPane)
  uis = uis.ChoiceDifficultyGrp
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.CloseBtn).text = (PUtil.get)(60000005)
  ;
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.ExpeditionEnterWindow).name)
  end
)
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.IntoBtn).text = (PUtil.get)(40002005)
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.WordTxt).text = (PUtil.get)(20000292)
  ;
  ((uis.IntoBtn).onClick):Set(function(...)
    -- function num : 0_0_1 , upvalues : _ENV, Eid, argTable
    (ExpeditionService.OnReqSetExpedition)(Eid)
    ;
    (ExpeditionMgr.ChapterSortNum)(argTable[2])
  end
)
  ;
  (ExpeditionEnterWindow.InitFunctionControl)()
end

ExpeditionEnterWindow.InitFunctionControl = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local winName = (WinResConfig.ExpeditionEnterWindow).name
  local RegisterGuideAndControl = GuideData.RegisterGuideAndControl
  local ControlID = ControlID
  RegisterGuideAndControl(ControlID.ExpeditionSure_SureBtn, uis.IntoBtn, winName)
end

ExpeditionEnterWindow.OnShown = function(...)
  -- function num : 0_2 , upvalues : uis, argTable, _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

  (uis.c1Ctr).selectedIndex = argTable[2] - 1
  ;
  (LuaSound.PlaySound)(LuaSound.COMMON_WARNING, SoundBank.OTHER)
end

ExpeditionEnterWindow.OnHide = function(...)
  -- function num : 0_3
end

ExpeditionEnterWindow.OnClose = function(...)
  -- function num : 0_4 , upvalues : _ENV, uis, contentPane
  (GuideData.AbolishControlRefer)((WinResConfig.ExpeditionEnterWindow).name)
  uis = nil
  contentPane = nil
end

ExpeditionEnterWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_5
end

return ExpeditionEnterWindow

