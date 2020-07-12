-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_CardLookByName")
local CardLookWindow = {}
local uis, contentPane, bridge, argTable, fashionData, fashionId = nil, nil, nil, nil, nil, nil
local isRotate = false
local uniqueEffect = nil
local moveAble = true
CardLookWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, bridge, argTable, fashionId, fashionData, uis, isRotate, CardLookWindow
  bridgeObj:SetView((WinResConfig.CardLookWindow).package, (WinResConfig.CardLookWindow).comName)
  contentPane = bridgeObj.contentPane
  bridge = bridgeObj
  argTable = bridgeObj.argTable
  contentPane:Center()
  if argTable[1] then
    fashionId = argTable[1]
  end
  fashionData = ((TableData.gTable).BaseFashionData)[fashionId]
  uis = GetCard_CardLookUis(contentPane)
  ;
  ((uis.CloseBtn).onClick):Clear()
  ;
  ((uis.CloseBtn).onClick):Add(function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.CardLookWindow).name)
  end
)
  ;
  ((uis.RotateBtn).onClick):Clear()
  ;
  ((uis.RotateBtn).onClick):Add(function(...)
    -- function num : 0_0_1 , upvalues : fashionData, _ENV, isRotate, CardLookWindow
    if fashionData.type == 3 then
      (MessageMgr.SendCenterTips)((PUtil.get)(208))
      return 
    end
    isRotate = not isRotate
    ;
    (CardLookWindow.SetRotateWindow)()
  end
)
  -- DECOMPILER ERROR at PC55: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.SwitchBtn).visible = fashionData.type == 2
  ;
  ((uis.SwitchBtn).onClick):Clear()
  ;
  ((uis.SwitchBtn).onClick):Add(function(...)
    -- function num : 0_0_2 , upvalues : fashionData, _ENV, CardLookWindow, fashionId
    local cardID = fashionData.card_id
    local isStatic = (Util.GetPlayerSetting)(cardID .. "Static", "0")
    if isStatic == "0" then
      (Util.SetPlayerSetting)(cardID .. "Static", "1")
    else
      ;
      (Util.SetPlayerSetting)(cardID .. "Static", "0")
    end
    ;
    (CardLookWindow.SetCg)(fashionId)
  end
)
  ;
  (UpdateMgr.AddUpdateHandler)(CardLookWindow.Update)
  ;
  (CardLookWindow.SetCg)(fashionId)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

local lastX = 0
local lastY = 0
local isTwoTouch = false
local firstTouch, secondTouch, lastDistance, twoTouchDistance = nil, nil, nil, nil
CardLookWindow.Update = function(...)
  -- function num : 0_1 , upvalues : _ENV, lastX, lastY, uis, isTwoTouch, firstTouch, secondTouch, lastDistance, twoTouchDistance, CardLookWindow
  if Input.touchCount <= 0 then
    return 
  end
  if Input.touchCount == 1 and ((Input.GetTouch)(0)).phase == ((CS.UnityEngine).TouchPhase).Began then
    lastX = (((Input.touches)[0]).position).x
    lastY = (((Input.touches)[0]).position).y
  end
  if Input.touchCount == 1 and ((Input.GetTouch)(0)).phase == ((CS.UnityEngine).TouchPhase).Moved then
    local x = (((Input.touches)[0]).position).x - lastX
    lastX = (((Input.touches)[0]).position).x
    local y = (((Input.touches)[0]).position).y - lastY
    lastY = (((Input.touches)[0]).position).y
    x = x / Screen.width * ResolutionHandler.Width
    y = y / Screen.height * ResolutionHandler.Height
    -- DECOMPILER ERROR at PC89: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (uis.CardLoader).x = (uis.CardLoader).x + x
    -- DECOMPILER ERROR at PC94: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (uis.CardLoader).y = (uis.CardLoader).y - y
  end
  do
    if Input.touchCount > 1 then
      if ((Input.GetTouch)(1)).phase == ((CS.UnityEngine).TouchPhase).Began then
        isTwoTouch = true
        firstTouch = ((Input.touches)[0]).position
        secondTouch = ((Input.touches)[1]).position
        lastDistance = (Vector2.Distance)(firstTouch, secondTouch)
      end
      if isTwoTouch then
        firstTouch = ((Input.touches)[0]).position
        secondTouch = ((Input.touches)[1]).position
        twoTouchDistance = (Vector2.Distance)(firstTouch, secondTouch)
        local changeScaleDistance = (twoTouchDistance - lastDistance) * 0.005
        ;
        (CardLookWindow.ChangeScale)(1 + changeScaleDistance)
        lastDistance = twoTouchDistance
      end
      do
        if ((Input.GetTouch)(0)).phase == ((CS.UnityEngine).TouchPhase).Ended then
          lastX = (((Input.touches)[1]).position).x
          lastY = (((Input.touches)[1]).position).y
        end
        if ((Input.GetTouch)(1)).phase == ((CS.UnityEngine).TouchPhase).Ended then
          isTwoTouch = false
          firstTouch = Vector3.zero
          secondTouch = Vector3.zero
          lastX = (((Input.touches)[0]).position).x
          lastY = (((Input.touches)[0]).position).y
        end
      end
    end
  end
end

CardLookWindow.SetRotateWindow = function(...)
  -- function num : 0_2 , upvalues : isRotate, _ENV, uis
  if isRotate then
    print("竖屏")
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.c1Ctr).selectedIndex = 1
  else
    print("横屏")
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.c1Ctr).selectedIndex = 0
  end
end

CardLookWindow.SetCg = function(fashionId, ...)
  -- function num : 0_3 , upvalues : _ENV, uis, uniqueEffect
  local fashionData = ((TableData.gTable).BaseFashionData)[fashionId]
  local isStatic = (Util.GetPlayerSetting)(fashionData.card_id .. "Static", "0")
  ;
  (Util.RecycleUIModel)(uis.CardLoader)
  if uniqueEffect ~= nil then
    (LuaEffect.DestroyEffect)(uniqueEffect)
    uniqueEffect = nil
  end
  if fashionData.show_cg ~= nil then
    local holder, effect = (LuaEffect.AddUIEffect)(fashionData.show_cg, false, true, Vector3.zero, 1)
    uniqueEffect = holder
    ;
    (CSLuaUtil.SetGOLocalPos)(effect, 0, 0, 0)
    ;
    (CSLuaUtil.SetGOScale)(effect, 1, 1, 1)
    holder:SetXY((uis.CardLoader).width / 2, (uis.CardLoader).height / 2)
    ;
    ((uis.Empty).root):AddChild(holder)
  else
    do
      print("---------------static", isStatic)
      if isStatic == "0" then
        (Util.CreateShowModel)(fashionId, uis.CardLoader)
      else
        local t_Object = (Util.ShowUIModel)(fashionData.show_texture, uis.CardLoader)
        ;
        (CSLuaUtil.SetGOLocalPos)(t_Object, ((t_Object.transform).localPosition).x, 0, 0)
      end
    end
  end
end

CardLookWindow.ChangeScale = function(delta, ...)
  -- function num : 0_4 , upvalues : uis, _ENV
  local scaling = (uis.CardLoader).scale * delta
  if scaling.x < 0.6 then
    scaling = 0.6 * Vector2.one
  end
  if scaling.x > 1.4 then
    scaling = 1.4 * Vector2.one
  end
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.CardLoader).scale = scaling
end

CardLookWindow.OnClose = function(...)
  -- function num : 0_5 , upvalues : _ENV, uis, CardLookWindow, isRotate, uniqueEffect, contentPane, bridge, argTable, fashionData, fashionId
  (Util.RecycleUIModel)(uis.CardLoader)
  ;
  (UpdateMgr.RemoveUpdateHandler)(CardLookWindow.Update)
  UIMgr:SendWindowMessage("CardChoiceWindow", (WindowMsgEnum.CardWindow).E_MSG_CARD_CLOSECARDLOOK, {})
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

  if isRotate then
    (uis.c1Ctr).selectedIndex = 0
  end
  uis = nil
  if uniqueEffect ~= nil then
    (LuaEffect.DestroyEffect)(uniqueEffect)
    uniqueEffect = nil
  end
  contentPane = nil
  bridge = nil
  argTable = nil
  fashionData = nil
  fashionId = nil
  isRotate = false
end

return CardLookWindow

