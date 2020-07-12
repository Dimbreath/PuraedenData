-- params : ...
-- function num : 0 , upvalues : _ENV
require("CGcollection_CGByName")
local CGShowWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local CGId, lockNum = nil, nil
local SingleTime = 0.5
CGShowWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, CGId, lockNum, uis, CGShowWindow
  bridgeObj:SetView((WinResConfig.CGShowWindow).package, (WinResConfig.CGShowWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  CGId = argTable[1]
  lockNum = argTable[2]
  uis = GetCGcollection_CGUis(contentPane)
  ;
  (CGShowWindow.SetCGShow)()
  ;
  ((GRoot.inst).onClick):Set(CGShowWindow.CloseWindow)
end

CGShowWindow.CloseWindow = function(...)
  -- function num : 0_1 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.CGShowWindow).name)
end

CGShowWindow.GetShowEffectNum = function(...)
  -- function num : 0_2 , upvalues : _ENV, CGId
  local cgShow = (Util.GetPlayerSetting)(PlayerPrefsKeyName.PLOT_CG_EFFECT_SHOW, "")
  local content = (Util.ParseConfigStr)(cgShow)
  for _,v in ipairs(content) do
    if tonumber(v[1]) == CGId then
      return tonumber(v[2])
    end
  end
  return 0
end

CGShowWindow.SaveCGShow = function(...)
  -- function num : 0_3 , upvalues : _ENV, CGId, lockNum
  local cgShow = (Util.GetPlayerSetting)(PlayerPrefsKeyName.PLOT_CG_EFFECT_SHOW, "")
  local content = (Util.ParseConfigStr)(cgShow)
  local str = ""
  local isContain = false
  for _,v in ipairs(content) do
    if #v > 1 then
      if tonumber(v[1]) == CGId then
        str = str .. "," .. v[1] .. ":" .. lockNum
        isContain = true
      else
        str = str .. "," .. v[1] .. ":" .. v[2]
      end
    end
  end
  if not isContain then
    str = str .. "," .. CGId .. ":" .. lockNum
  end
  ;
  (Util.SetPlayerSetting)(PlayerPrefsKeyName.PLOT_CG_EFFECT_SHOW, str)
end

CGShowWindow.SetCGShow = function(...)
  -- function num : 0_4 , upvalues : _ENV, CGId, CGShowWindow, uis
  local CGData = ((TableData.gTable).BaseHandbookCGData)[CGId]
  if CGData.type == 1 then
    (CGShowWindow.PlayEffect)()
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.TouchScreenTxt).text = (PUtil.get)(20000273)
  else
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.CGShow).c1Ctr).selectedIndex = 5
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.TouchScreenTxt).text = (PUtil.get)(20000284)
  end
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.NameTxt).text = CGData.name
  local texture = (ResHelper.LoadTexture)(CGData.fashion_id)
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R2 in 'UnsetPending'

  if texture ~= nil then
    (((uis.CGShow).CGImage).CGLoader).texture = (FairyGUI.NTexture)(texture)
  end
  ;
  (CGShowWindow.SaveCGShow)()
end

CGShowWindow.PlayEffect = function(...)
  -- function num : 0_5 , upvalues : uis, CGShowWindow, lockNum, _ENV, SingleTime
  local parent = uis.root
  local num = (CGShowWindow.GetShowEffectNum)()
  if num < lockNum then
    for i = num + 1, lockNum do
      do
        (SimpleTimer.setTimeout)((i - num) * SingleTime, function(...)
    -- function num : 0_5_0 , upvalues : uis, i, _ENV, parent
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

    ((uis.CGShow).c1Ctr).selectedIndex = i
    local pos = Vector2((GRoot.inst).width / 2, (GRoot.inst).height / 2)
    ;
    (LuaEffect.CreateEffectToObj)("FX_ui_peace" .. i .. "_big", true, parent, pos)
  end
)
      end
    end
  else
    do
      -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((uis.CGShow).c1Ctr).selectedIndex = lockNum
    end
  end
end

CGShowWindow.OnShown = function(...)
  -- function num : 0_6
end

CGShowWindow.OnHide = function(...)
  -- function num : 0_7
end

CGShowWindow.OnClose = function(...)
  -- function num : 0_8 , upvalues : _ENV, CGShowWindow, uis, contentPane, argTable
  ((GRoot.inst).onClick):Remove(CGShowWindow.CloseWindow)
  uis = nil
  contentPane = nil
  argTable = {}
end

CGShowWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_9
end

return CGShowWindow

