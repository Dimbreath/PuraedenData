-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BattleUpByName")
BattleUpWindow = {}
local contentPane, uis, transition, numTween, closeTween, closeTrans = nil, nil, nil, nil, nil, nil
local GTween = FairyGUI.GTween
local curValue, targetValue = nil, nil
local argTable = {}
local fightSpine, fightEffect, holder, eventInstance = nil, nil, nil, nil
-- DECOMPILER ERROR at PC13: Confused about usage of register: R14 in 'UnsetPending'

BattleUpWindow.OnInit = function(bridge, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis
  bridge:SetView((WinResConfig.BattleUpWindow).package, (WinResConfig.BattleUpWindow).comName)
  contentPane = bridge.contentPane
  argTable = bridge.argTable
  uis = GetCommonResource_BattleUpUis(contentPane)
  ;
  (BattleUpWindow.PlayTransitionIn)()
  ;
  (BattleUpWindow.StartSound)()
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R14 in 'UnsetPending'

BattleUpWindow.PlayTransitionIn = function(param, ...)
  -- function num : 0_1 , upvalues : fightSpine, _ENV, uis, fightEffect, holder, contentPane, argTable
  if fightSpine == nil then
    (Util.ShowUIModel)("ui_fighting", uis.EggLoader, nil, false, function(obj, ...)
    -- function num : 0_1_0 , upvalues : fightSpine, _ENV
    fightSpine = obj
    ;
    (CSLuaUtil.SetGOScale)(obj, 100, 100, 100, false)
    ;
    (CSLuaUtil.SetGOLocalPos)(obj, 0, 14, 0)
    ;
    (SkeletonAnimationUtil.SetAnimation)(obj, 0, "idle", false)
  end
)
  else
    ;
    (SkeletonAnimationUtil.SetAnimation)(fightSpine, 0, "idle", false)
  end
  if fightEffect and holder then
    (LuaEffect.DestroyEffect)(holder)
    contentPane:RemoveChild(holder)
  end
  local zhanwei = contentPane:GetChild("zhanwei")
  holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_BATTLEUP, true, true)
  contentPane:AddChildAt(holder, contentPane:GetChildIndex(zhanwei))
  holder:SetXY(zhanwei.x, zhanwei.y)
  PlayUITrans(contentPane, "Battle", function(...)
    -- function num : 0_1_1
  end
)
  ;
  (BattleUpWindow.PlayNumChange)(param or argTable[1])
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R14 in 'UnsetPending'

BattleUpWindow.PlayNumChange = function(cardId, ...)
  -- function num : 0_2 , upvalues : _ENV, targetValue, curValue, numTween, closeTween, uis, GTween
  local fcChangeInfo = nil
  if cardId then
    fcChangeInfo = (CardData.fcChangeList)[cardId]
  else
    fcChangeInfo = ActorData.fcChangeList
  end
  if fcChangeInfo then
    targetValue = tonumber(fcChangeInfo.newFc)
    if not curValue then
      curValue = tonumber(fcChangeInfo.preFc)
      if numTween then
        numTween:Kill()
      end
      if closeTween then
        closeTween:Kill()
      end
      -- DECOMPILER ERROR at PC39: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (uis.NumberTxt).scale = Vector2(1, 1)
      numTween = (((GTween.To)(curValue, targetValue, 0.7)):OnUpdate(function(...)
    -- function num : 0_2_0 , upvalues : uis, _ENV, numTween, curValue
    if uis and uis.NumberTxt then
      local num = (math.ceil)((numTween.value).x)
      curValue = num
      -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (uis.NumberTxt).text = num
    end
  end
)):OnComplete(function(...)
    -- function num : 0_2_1 , upvalues : uis, curValue, targetValue, _ENV
    if uis and uis.NumberTxt then
      curValue = targetValue
      -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (uis.NumberTxt).text = curValue
      ;
      (BattleUpWindow.PlayTransitionHide)()
    end
  end
)
    end
  end
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R14 in 'UnsetPending'

BattleUpWindow.PlayTransitionHide = function(...)
  -- function num : 0_3 , upvalues : numTween, _ENV, closeTween, GTween, closeTrans, contentPane, fightSpine
  numTween = nil
  ;
  (BattleUpWindow.StopSound)()
  closeTween = ((GTween.DelayedCall)(0.5)):OnComplete(function(...)
    -- function num : 0_3_0 , upvalues : closeTween, closeTrans, _ENV, contentPane, fightSpine
    closeTween = nil
    closeTrans = PlayUITrans(contentPane, "BattleEnd", function(...)
      -- function num : 0_3_0_0 , upvalues : _ENV
      UIMgr:CloseWindow((WinResConfig.BattleUpWindow).name)
    end
)
    if fightSpine then
      (SkeletonAnimationUtil.SetAnimation)(fightSpine, 0, "idle2", false)
    end
  end
)
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R14 in 'UnsetPending'

BattleUpWindow.StartSound = function(...)
  -- function num : 0_4 , upvalues : eventInstance, _ENV
  if eventInstance == nil then
    eventInstance = (LuaSound.PlaySound)(LuaSound.BATTLE_UP, SoundBank.OTHER)
  end
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R14 in 'UnsetPending'

BattleUpWindow.StopSound = function(...)
  -- function num : 0_5 , upvalues : eventInstance, _ENV
  if eventInstance then
    (LuaSound.StopSound)(eventInstance, (((CS.FMOD).Studio).STOP_MODE).ALLOWFADEOUT)
    eventInstance = nil
  end
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R14 in 'UnsetPending'

BattleUpWindow.OnShown = function(...)
  -- function num : 0_6
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R14 in 'UnsetPending'

BattleUpWindow.OnHide = function(...)
  -- function num : 0_7
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R14 in 'UnsetPending'

BattleUpWindow.OnClose = function(...)
  -- function num : 0_8 , upvalues : fightSpine, _ENV, uis, numTween, closeTween, closeTrans, fightEffect, holder, transition, contentPane, curValue, targetValue
  if fightSpine then
    (Util.RecycleUIModel)(uis.EggLoader, true)
    fightSpine = nil
  end
  ;
  (BattleUpWindow.StopSound)()
  if numTween then
    numTween:Kill()
    numTween = nil
  end
  if closeTween then
    closeTween:Kill()
    closeTween = nil
  end
  if closeTrans then
    closeTrans:Stop()
    closeTrans = nil
  end
  fightEffect = nil
  holder = nil
  transition = nil
  uis = nil
  contentPane = nil
  curValue = nil
  targetValue = nil
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R0 in 'UnsetPending'

  ActorData.fcChangeList = nil
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R14 in 'UnsetPending'

BattleUpWindow.HandleMessage = function(msgId, param, ...)
  -- function num : 0_9 , upvalues : numTween, closeTween, _ENV, closeTrans
  if msgId == 1 then
    if numTween or closeTween then
      (BattleUpWindow.PlayNumChange)(param)
    else
      if closeTrans then
        closeTrans:Stop()
        closeTrans = nil
      end
      ;
      (BattleUpWindow.PlayTransitionIn)(param)
    end
  end
end

return BattleUpWindow

