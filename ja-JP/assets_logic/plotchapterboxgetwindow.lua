-- params : ...
-- function num : 0 , upvalues : _ENV
require("PlotDungeon_BoxGetByName")
local PlotChapterBoxGetWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local stageID = -1
local isCanClick = true
PlotChapterBoxGetWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, stageID, uis, PlotChapterBoxGetWindow, isCanClick
  bridgeObj:SetView((WinResConfig.PlotChapterBoxGetWindow).package, (WinResConfig.PlotChapterBoxGetWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  if argTable[1] then
    stageID = tonumber(argTable[1])
  end
  uis = GetPlotDungeon_BoxGetUis(contentPane)
  local box = (Util.ShowUIModel)("juqingbaoxiang", uis.BoxLoader, nil, false, function(model, ...)
    -- function num : 0_0_0 , upvalues : _ENV, PlotChapterBoxGetWindow
    (SkeletonAnimationUtil.SetAnimation)(model, 0, "idle", true)
    ;
    (PlotChapterBoxGetWindow.PlayBoxSfx)(UIEffectEnum.UI_BOX_CLOSE)
  end
)
  isCanClick = true
  ;
  (Util.SetOnClickDelay)(1)
  ;
  ((uis.TouchScreenBtn).onClick):Set(function(...)
    -- function num : 0_0_1 , upvalues : isCanClick, _ENV, stageID, PlotChapterBoxGetWindow, box
    if isCanClick then
      isCanClick = false
      local boxState = (PlotDungeonMgr.GetAppendixState)(stageID)
      if boxState == AppendixBoxState.Unclaimed then
        (LuaSound.PlaySound)(LuaSound.TX_OPEN_BOX, SoundBank.OTHER)
        ;
        (PlotChapterBoxGetWindow.PlayBoxSfx)(UIEffectEnum.UI_BOX_OPEN)
        ;
        (SkeletonAnimationUtil.SetAnimation)(box, 0, "open", false, function(...)
      -- function num : 0_0_1_0 , upvalues : isCanClick, _ENV, stageID
      isCanClick = true
      UIMgr:CloseWindow((WinResConfig.PlotChapterBoxGetWindow).name)
      ;
      (PlotDungeonService.ReqGetAppendixBox)(stageID)
    end
)
      end
    end
  end
)
end

PlotChapterBoxGetWindow.PlayBoxSfx = function(name, ...)
  -- function num : 0_1 , upvalues : uis, _ENV
  local mPos = (uis.BoxLoader).xy + Vector2((uis.BoxLoader).width / 2, (uis.BoxLoader).height)
  ;
  (LuaEffect.CreateEffectToObj)(name, false, uis.root, mPos)
end

PlotChapterBoxGetWindow.OnShown = function(...)
  -- function num : 0_2
end

PlotChapterBoxGetWindow.OnHide = function(...)
  -- function num : 0_3
end

PlotChapterBoxGetWindow.OnClose = function(...)
  -- function num : 0_4 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

PlotChapterBoxGetWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_5
end

return PlotChapterBoxGetWindow

