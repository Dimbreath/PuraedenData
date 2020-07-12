-- params : ...
-- function num : 0 , upvalues : _ENV
require("Message_FunctionOpenByName")
local FunctionOpenWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local functionData = nil
FunctionOpenWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, functionData
  bridgeObj:SetView((WinResConfig.FunctionOpenWindow).package, (WinResConfig.FunctionOpenWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetMessage_FunctionOpenUis(contentPane)
  ;
  (LuaSound.PlaySound)(LuaSound.COMMON_SHOW_REWARD, SoundBank.OTHER)
  local fID = argTable[1]
  functionData = ((TableData.gTable).BaseFunctionData)[tonumber(fID)]
  ;
  ((uis.TouchScreenBtn).onClick):Set(function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.FunctionOpenWindow).name)
  end
)
  ;
  (GuideMgr.PlotDungeonTrigger)(tonumber(fID))
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.TouchTxt).text = (PUtil.get)(20000268)
end

FunctionOpenWindow.OnShown = function(...)
  -- function num : 0_1 , upvalues : functionData, uis, _ENV
  if not functionData then
    return 
  end
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.IconLoader).url = (Util.GetItemUrl)(functionData.icon)
  ;
  (Util.ShowUIModel)("FunctionOpen", uis.BookLoader, nil, true, function(model, ...)
    -- function num : 0_1_0 , upvalues : _ENV
    (SkeletonAnimationUtil.SetAnimation)(model, 0, "in", false, function(...)
      -- function num : 0_1_0_0 , upvalues : _ENV, model
      (SkeletonAnimationUtil.SetAnimation)(model, 0, "idle", true)
    end
)
  end
)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.WordTxt).text = (PUtil.get)(20000106, functionData.name)
  local title = uis.Title_01_Image
  ;
  (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_UNLOCK, true, uis.root, title.xy)
  local pos = Vector2((uis.IconLoader).x + (uis.IconLoader).width / 2, (uis.IconLoader).y + (uis.IconLoader).height / 2)
  ;
  (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_FUNCTION_OPEN, true, uis.root, pos)
end

FunctionOpenWindow.OnHide = function(...)
  -- function num : 0_2
end

FunctionOpenWindow.OnClose = function(...)
  -- function num : 0_3 , upvalues : _ENV, uis, contentPane, argTable
  (FunctionControlMgr.IsPrepareFunctionOpenWindow)(false)
  ;
  (Util.RecycleUIModel)(uis.BookLoader)
  uis = nil
  contentPane = nil
  argTable = {}
end

FunctionOpenWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_4
end

return FunctionOpenWindow

