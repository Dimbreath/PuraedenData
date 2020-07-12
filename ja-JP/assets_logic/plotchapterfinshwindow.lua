-- params : ...
-- function num : 0 , upvalues : _ENV
require("PlotDungeon_PlotEndByName")
local PlotChapterFinshWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local chapterID = -1
local boxStage = -1
PlotChapterFinshWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, chapterID, boxStage, uis
  bridgeObj:SetView((WinResConfig.PlotChapterFinshWindow).package, (WinResConfig.PlotChapterFinshWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  if argTable[1] then
    chapterID = tonumber(argTable[1])
  end
  if argTable[2] then
    boxStage = tonumber(argTable[2])
  end
  uis = GetPlotDungeon_PlotEndUis(contentPane)
  local chapterData = ((TableData.gTable).BaseChapterData)[chapterID]
  if chapterData.type == DungeonType.BasicDungeon then
    (Util.ShowGuideTips)(GuideTipsCheckPoint.PassStoryChapter, chapterData.name)
  else
    if chapterData.type == DungeonType.HeroDungeon then
      (Util.ShowGuideTips)(GuideTipsCheckPoint.PassHeroDungeon, chapterData.name)
    end
  end
  -- DECOMPILER ERROR at PC60: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.WordTxt).text = chapterData.name
  -- DECOMPILER ERROR at PC66: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.TipsTxt).text = (PUtil.get)(20000268)
  ;
  ((uis.TouchScreenBtn).onClick):Set(function(...)
    -- function num : 0_0_0 , upvalues : _ENV, chapterData, boxStage
    UIMgr:SetOnHideComplete((WinResConfig.PlotChapterFinshWindow).name, function(...)
      -- function num : 0_0_0_0 , upvalues : _ENV, chapterData, boxStage
      local stage = split(chapterData.stages, ":")
      local stageID = tonumber(stage[#stage])
      local stageData = ((TableData.gTable).BaseStageData)[stageID]
      local cgID = tonumber(stageData.cg_reward)
      if cgID and cgID > 0 then
        (Util.ShowGuideTips)(GuideTipsCheckPoint.AcquireStoryCG, (((TableData.gTable).BaseHandbookCGData)[cgID]).name)
        ;
        (CommonWinMgr.OpenCGShow)(cgID, true, function(...)
        -- function num : 0_0_0_0_0 , upvalues : _ENV, boxStage
        OpenWindow((WinResConfig.PlotChapterBoxGetWindow).name, UILayer.HUD, boxStage)
      end
)
      else
        OpenWindow((WinResConfig.PlotChapterBoxGetWindow).name, UILayer.HUD, boxStage)
      end
    end
)
    UIMgr:CloseWindow((WinResConfig.PlotChapterFinshWindow).name)
    ;
    (Util.SetOnClickDelay)(0.7)
  end
)
  ;
  (LuaSound.StopBGM)()
end

PlotChapterFinshWindow.OnShown = function(...)
  -- function num : 0_1 , upvalues : _ENV
  (LuaSound.PlaySound)(LuaSound.PLOT_PASS, SoundBank.OTHER)
end

PlotChapterFinshWindow.OnHide = function(...)
  -- function num : 0_2
end

PlotChapterFinshWindow.OnClose = function(...)
  -- function num : 0_3 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

PlotChapterFinshWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_4
end

return PlotChapterFinshWindow

