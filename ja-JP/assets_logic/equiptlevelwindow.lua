-- params : ...
-- function num : 0 , upvalues : _ENV
require("Equipt_EquiptLevelWindowByName")
local EquiptLevelWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _unlockAttrLevel = {}
local _currentCost, _ctrl, _iconImg = nil, nil, nil
EquiptLevelWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, EquiptLevelWindow
  bridgeObj:SetView((WinResConfig.EquiptLevelWindow).package, (WinResConfig.EquiptLevelWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetEquipt_EquiptLevelWindowUis(contentPane)
  ;
  (EquiptLevelWindow.InitVariable)()
  ;
  (EquiptLevelWindow.InitText)()
  ;
  (EquiptLevelWindow.InitButtonEvent)()
end

EquiptLevelWindow.InitVariable = function(...)
  -- function num : 0_1 , upvalues : _ctrl, uis, _iconImg, _ENV
  _ctrl = ((uis.EquiptLevelGrp).root):GetController("c1")
  _iconImg = ((uis.EquiptLevelGrp).root):GetChild("IconImage")
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.EquiptLevelGrp).MainAttributeGrp).SMImage).color = ((CS.UnityEngine).Color)(0.53725490196078, 0.4078431372549, 0.72941176470588)
end

EquiptLevelWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.EquiptLevelGrp).LevelUpMaxBtn).text = (PUtil.get)(20)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.EquiptLevelGrp).LevelUpBtn).text = (PUtil.get)(21)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.EquiptLevelGrp).BigCloseBtn).text = (PUtil.get)(60000004)
end

EquiptLevelWindow.InitButtonEvent = function(...)
  -- function num : 0_3 , upvalues : uis, EquiptLevelWindow
  (((uis.EquiptLevelGrp).CloseBtn).onClick):Add(EquiptLevelWindow.ClickCloseBtn)
  ;
  (((uis.EquiptLevelGrp).BigCloseBtn).onClick):Add(EquiptLevelWindow.ClickCloseBtn)
  ;
  (((uis.EquiptLevelGrp).LevelUpBtn).onClick):Add(EquiptLevelWindow.ClickUpgradeBtn)
  ;
  (((uis.EquiptLevelGrp).LevelUpMaxBtn).onClick):Add(EquiptLevelWindow.ClickMaxUpgradeBtn)
end

EquiptLevelWindow.InitEvent = function(...)
  -- function num : 0_4
end

EquiptLevelWindow.RemoveEvent = function(...)
  -- function num : 0_5
end

EquiptLevelWindow.OnShown = function(...)
  -- function num : 0_6 , upvalues : EquiptLevelWindow
  (EquiptLevelWindow.InitEvent)()
  ;
  (EquiptLevelWindow.Init)()
end

EquiptLevelWindow.OnHide = function(...)
  -- function num : 0_7 , upvalues : EquiptLevelWindow
  (EquiptLevelWindow.RemoveEvent)()
end

EquiptLevelWindow.Init = function(...)
  -- function num : 0_8 , upvalues : EquiptLevelWindow
  (EquiptLevelWindow.InitBasicInfo)()
  ;
  (EquiptLevelWindow.InitUnlockSideAttrLevel)()
  ;
  (EquiptLevelWindow.Refresh)()
end

EquiptLevelWindow.InitBasicInfo = function(...)
  -- function num : 0_9 , upvalues : uis, argTable, _iconImg, _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.EquiptLevelGrp).EquiptNameTxt).text = (argTable[2]).name
  _iconImg.url = (Util.GetItemUrl)((argTable[2]).icon)
  ;
  ((uis.EquiptLevelGrp).StarList):RemoveChildrenToPool()
  for i = 1, (argTable[2]).star do
    ((uis.EquiptLevelGrp).StarList):AddItemFromPool()
  end
end

EquiptLevelWindow.Refresh = function(...)
  -- function num : 0_10 , upvalues : uis, _ENV, argTable, _ctrl, EquiptLevelWindow
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.EquiptLevelGrp).EquiptLevelTxt).text = "Lv." .. tostring((argTable[1]).level)
  ;
  (EquiptMgr.SetDetailAttrs)((uis.EquiptLevelGrp).root, argTable[1])
  if ((EquiptData.UpgradeConfig)[(argTable[2]).grow_type]).MaxLevel <= (argTable[1]).level then
    _ctrl.selectedIndex = 1
  else
    _ctrl.selectedIndex = 0
    ;
    (EquiptLevelWindow.InitUnlockAttr)()
    ;
    (EquiptLevelWindow.InitCost)()
  end
end

EquiptLevelWindow.InitUnlockSideAttrLevel = function(...)
  -- function num : 0_11 , upvalues : _ENV, argTable, _unlockAttrLevel
  local unlockLevels = split((argTable[2]).random_trigger, ":")
  local count = #unlockLevels
  for i = 1, count do
    (table.insert)(_unlockAttrLevel, tonumber(unlockLevels[i]))
  end
  ;
  (table.sort)(_unlockAttrLevel, function(x, y, ...)
    -- function num : 0_11_0
    do return x < y end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

EquiptLevelWindow.InitUnlockAttr = function(...)
  -- function num : 0_12 , upvalues : _unlockAttrLevel, argTable, uis, _ENV
  local count = #_unlockAttrLevel
  local level = 0
  for i = 1, count do
    if (argTable[1]).level < _unlockAttrLevel[i] then
      level = _unlockAttrLevel[i]
      break
    end
  end
  do
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

    if level ~= 0 then
      ((uis.EquiptLevelGrp).ConditionTxt).text = (PUtil.get)(60000065, level)
    else
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((uis.EquiptLevelGrp).ConditionTxt).text = ""
    end
  end
end

EquiptLevelWindow.InitCost = function(...)
  -- function num : 0_13 , upvalues : _currentCost, _ENV, argTable, uis
  _currentCost = ((EquiptData.UpgradeConfig)[(argTable[2]).grow_type])[(argTable[1]).level]
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.EquiptLevelGrp).GoldTxt).text = _currentCost.next_gold
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.EquiptLevelGrp).ExpTxt).text = _currentCost.next_exp
end

EquiptLevelWindow.OnClose = function(...)
  -- function num : 0_14 , upvalues : uis, contentPane, _iconImg
  uis = nil
  contentPane = nil
  _iconImg = nil
end

EquiptLevelWindow.ClickCloseBtn = function(...)
  -- function num : 0_15 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.EquiptLevelWindow).name)
end

EquiptLevelWindow.ClickUpgradeBtn = function(...)
  -- function num : 0_16 , upvalues : _ENV, argTable, _currentCost
  (EquiptMgr.TryUpgradeEquipment)(argTable[1], argTable[3], _currentCost.next_exp, _currentCost.next_gold)
end

EquiptLevelWindow.ClickMaxUpgradeBtn = function(...)
  -- function num : 0_17 , upvalues : _ENV, argTable
  (EquiptMgr.TryFullyUpgradeEquipment)(argTable[1], argTable[2], argTable[3])
end

EquiptLevelWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_18 , upvalues : _ENV, EquiptLevelWindow
  if msgId == (WindowMsgEnum.Equipt).E_MSG_REFRESH_EQUIPMENT then
    (EquiptLevelWindow.Refresh)()
  end
end

return EquiptLevelWindow

