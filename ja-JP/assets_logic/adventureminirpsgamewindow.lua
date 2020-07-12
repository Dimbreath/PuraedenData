-- params : ...
-- function num : 0 , upvalues : _ENV
require("AdventureGame_RPSMainByName")
local AdventureMiniRPSGameWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _components = {}
local _polygonClickChecker = nil
local _clickArea = {
[0] = {Vector2(-6.2, 3), Vector2(-2.8, 3), Vector2(-2.8, -2), Vector2(-6.2, -2)}
, 
[1] = {Vector2(1.7, 3), Vector2(-1.7, 3), Vector2(-1.7, -2), Vector2(1.7, -2)}
, 
[2] = {Vector2(6.2, 3), Vector2(2.8, 3), Vector2(2.8, -2), Vector2(6.2, -2)}
}
local _drawCardAnim = {[0] = "choupail", [1] = "choupai", [2] = "choupair"}
local _selectAnim = {[0] = "xuanzhel", [1] = "xuanzhe", [2] = "xuanzher"}
local _npcDrawAnim = "choupai_difang"
local _gestureName = {[0] = "quantou", [1] = "jiandao", [2] = "bu"}
AdventureMiniRPSGameWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, AdventureMiniRPSGameWindow
  bridgeObj:SetView((WinResConfig.AdventureMiniRPSGameWindow).package, (WinResConfig.AdventureMiniRPSGameWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetAdventureGame_RPSMainUis(contentPane)
  ;
  (AdventureMiniRPSGameWindow.InitVariable)()
  ;
  (AdventureMiniRPSGameWindow.InitText)()
  ;
  (AdventureMiniRPSGameWindow.InitButtonEvent)()
  ;
  (AdventureMiniRPSGameWindow.InitComponentstatus)()
end

AdventureMiniRPSGameWindow.InitVariable = function(...)
  -- function num : 0_1 , upvalues : _components, _ENV, uis, AdventureMiniRPSGameWindow, _polygonClickChecker
  _components[AdventureRPSGestureType.Rock] = {Loader = uis.ALoader}
  _components[AdventureRPSGestureType.Paper] = {Loader = uis.BLoader}
  _components[AdventureRPSGestureType.Scissor] = {Loader = uis.AnimationLoader}
  ;
  (AdventureMiniRPSGameWindow.InitComponent)(AdventureRPSGestureType.Rock)
  ;
  (AdventureMiniRPSGameWindow.InitComponent)(AdventureRPSGestureType.Paper)
  ;
  (AdventureMiniRPSGameWindow.InitComponent)(AdventureRPSGestureType.Scissor)
  _polygonClickChecker = GameObject("PolygonClickChecker")
  _polygonClickChecker:AddComponent(typeof(CS.PolygonClickChecker))
end

AdventureMiniRPSGameWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.WordTxt).text = (PUtil.get)(60000300)
end

AdventureMiniRPSGameWindow.InitButtonEvent = function(...)
  -- function num : 0_3
end

AdventureMiniRPSGameWindow.InitComponentstatus = function(...)
  -- function num : 0_4
end

AdventureMiniRPSGameWindow.InitEvent = function(...)
  -- function num : 0_5
end

AdventureMiniRPSGameWindow.RemoveEvent = function(...)
  -- function num : 0_6
end

AdventureMiniRPSGameWindow.OnShown = function(...)
  -- function num : 0_7 , upvalues : AdventureMiniRPSGameWindow
  (AdventureMiniRPSGameWindow.InitEvent)()
  ;
  (AdventureMiniRPSGameWindow.Init)()
end

AdventureMiniRPSGameWindow.OnHide = function(...)
  -- function num : 0_8
end

AdventureMiniRPSGameWindow.Init = function(...)
  -- function num : 0_9 , upvalues : _ENV, uis, AdventureMiniRPSGameWindow
  (LuaSound.LoadAndPlayBGM)(1010004)
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.WordTxt).visible = false
  ;
  (LuaSound.PlaySound)(LuaSound.ADVENTURE_RPS_START, SoundBank.OTHER)
  ;
  (AdventureMiniRPSGameWindow.PlayPhase1Anim)(AdventureMiniRPSGameWindow.AfterPhase1)
end

AdventureMiniRPSGameWindow.PlayPhase1Anim = function(...)
  -- function num : 0_10 , upvalues : _components, _ENV, _drawCardAnim, AdventureMiniRPSGameWindow
  local pos = (((_components[AdventureRPSGestureType.Scissor]).Model).transform).localPosition
  pos.z = -500
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((_components[AdventureRPSGestureType.Scissor]).Model).transform).localPosition = pos
  for i = 0, 2 do
    ((_components[i]).Anim):Play(_drawCardAnim[i])
  end
  ;
  (SimpleTimer.setTimeout)(1, AdventureMiniRPSGameWindow.AfterPhase1)
end

AdventureMiniRPSGameWindow.AfterPhase1 = function(...)
  -- function num : 0_11 , upvalues : _components, _ENV, uis, _clickArea, _polygonClickChecker, _selectAnim, argTable
  local pos = (((_components[AdventureRPSGestureType.Scissor]).Model).transform).localPosition
  pos.z = 0
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((_components[AdventureRPSGestureType.Scissor]).Model).transform).localPosition = pos
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.WordTxt).visible = true
  for i = 0, 2 do
    local index = i
    do
      ((CS.PolygonClick).AddClick)((_components[i]).Model, _clickArea[i], function(go, ...)
    -- function num : 0_11_0 , upvalues : _ENV, _polygonClickChecker, _components, index, _selectAnim, argTable
    (GameObject.Destroy)(_polygonClickChecker)
    ;
    ((_components[index]).Anim):Play(_selectAnim[index])
    for i = 0, 2 do
      -- DECOMPILER ERROR at PC20: Confused about usage of register: R5 in 'UnsetPending'

      if i ~= index then
        ((_components[i]).Loader).visible = false
      end
    end
    ;
    (LuaSound.PlaySound)(LuaSound.ADVENTURE_RPS_RESULT, SoundBank.OTHER)
    ;
    (AdventureMgr.ChooseGesture)(argTable[1], index)
  end
)
    end
  end
end

AdventureMiniRPSGameWindow.InitComponent = function(type, ...)
  -- function num : 0_12 , upvalues : _components, _ENV, _gestureName
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  (_components[type]).Model = (Util.ShowUIModel)(_gestureName[type], (_components[type]).Loader)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (_components[type]).Anim = (((_components[type]).Model).transform):GetComponentInChildren(typeof((CS.UnityEngine).Animator))
end

AdventureMiniRPSGameWindow.OnClose = function(...)
  -- function num : 0_13 , upvalues : _ENV, _components, AdventureMiniRPSGameWindow, uis, contentPane, argTable
  (LuaSound.LoadAndPlayBGM)(1010005)
  for i = 0, 2 do
    (Util.RecycleUIModel)((_components[i]).Loader, true)
  end
  ;
  (AdventureMiniRPSGameWindow.RemoveEvent)()
  uis = nil
  contentPane = nil
  argTable = {}
end

AdventureMiniRPSGameWindow.ClickQuitBtn = function(...)
  -- function num : 0_14 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.AdventureMiniRPSGameWindow).name)
end

AdventureMiniRPSGameWindow.ShowResult = function(gesture, npcGesture, status, ...)
  -- function num : 0_15 , upvalues : _ENV, _components, _gestureName, _npcDrawAnim, uis
  local finalIndex, npc, pos = nil, nil, nil
  if status == AdventureRewardType.Even then
    finalIndex = 2
    if gesture == AdventureRPSGestureType.Rock then
      npc = _components[AdventureRPSGestureType.Scissor]
    else
      npc = _components[AdventureRPSGestureType.Rock]
    end
    ;
    (Util.RecycleUIModel)(npc.Loader, true)
    npc.Model = (Util.ShowUIModel)(_gestureName[npcGesture], npc.Loader)
    npc.Anim = ((npc.Model).transform):GetComponentInChildren(typeof((CS.UnityEngine).Animator))
  else
    if status == AdventureRewardType.Win then
      finalIndex = 1
      npc = _components[npcGesture]
      pos = {x = 435 + (ResolutionHandler.AdaptOffset).X, y = 336 + (ResolutionHandler.AdaptOffset).Y}
    else
      finalIndex = 3
      npc = _components[npcGesture]
      pos = {x = 915 + (ResolutionHandler.AdaptOffset).X, y = 336 + (ResolutionHandler.AdaptOffset).Y}
    end
  end
  -- DECOMPILER ERROR at PC73: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (npc.Loader).visible = true
  ;
  (npc.Anim):Play("stand")
  ;
  (SimpleTimer.setTimeout)(0.02, function(...)
    -- function num : 0_15_0 , upvalues : npc, _npcDrawAnim
    (npc.Anim):Play(_npcDrawAnim)
  end
)
  ;
  (SimpleTimer.setTimeout)(1.4, function(...)
    -- function num : 0_15_1 , upvalues : pos, _ENV, uis, finalIndex
    do
      if pos ~= nil then
        local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_ADVENTUREGAME_RPS_WIN)
        ;
        (uis.root):AddChild(holder)
        holder:SetXY(pos.x, pos.y)
      end
      -- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (uis.c1Ctr).selectedIndex = finalIndex
      -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (uis.WordTxt).text = ""
      ;
      (SimpleTimer.setTimeout)(2, function(...)
      -- function num : 0_15_1_0 , upvalues : _ENV
      UIMgr:CloseWindow((WinResConfig.AdventureMiniRPSGameWindow).name)
      ;
      (AdventureMgr.AfterShowResult)()
    end
)
    end
  end
)
end

AdventureMiniRPSGameWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_16 , upvalues : _ENV, AdventureMiniRPSGameWindow
  if msgId == (WindowMsgEnum.Adventure).E_MSG_SHOW_RPS_RESULT then
    (AdventureMiniRPSGameWindow.ShowResult)(para.Self, para.NPC, para.Result)
  end
end

return AdventureMiniRPSGameWindow

