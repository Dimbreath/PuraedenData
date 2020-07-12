-- params : ...
-- function num : 0 , upvalues : _ENV
require("CGcollection_CGLookWindowByName")
require("CGcollection_CGTipsByName")
local CGPreviewWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local winType = {Main = 1, Branch = 2}
local mType, openList = nil, nil
local cgList = {}
local MaxOpenIndex = 0
CGPreviewWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, mType, openList, uis, MaxOpenIndex, CGPreviewWindow
  bridgeObj:SetView((WinResConfig.CGPreviewWindow).package, (WinResConfig.CGPreviewWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  mType = argTable[1]
  openList = argTable[2]
  uis = GetCGcollection_CGLookWindowUis(contentPane)
  uis = uis.CGLook
  MaxOpenIndex = 0
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.CommentList).itemRenderer = CGPreviewWindow.CardRenderer
  ;
  (uis.CommentList):SetVirtual()
  ;
  (CGPreviewWindow.RefreshWin)()
  ;
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.CGPreviewWindow).name)
  end
)
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.SureBtn).text = (PUtil.get)(20000016)
  ;
  ((uis.SureBtn).onClick):Set(function(...)
    -- function num : 0_0_1 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.CGPreviewWindow).name)
  end
)
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.TitleTxt).text = (PUtil.get)(20000269)
end

CGPreviewWindow.CardRenderer = function(index, object, ...)
  -- function num : 0_1 , upvalues : cgList, _ENV, mType, winType, CGPreviewWindow
  local data = cgList[index + 1]
  if data == nil then
    return 
  end
  local model = GetCGcollection_CGTipsUis(object)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (model.WordTxt).text = data.name
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (model.LockTxt).text = data.des
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (model.NumberTxt).text = "No." .. (string.format)("%03d", data.index)
  local icon = object:GetChild("IconImage")
  icon.url = (Util.GetItemUrl)(data.icon)
  if mType == winType.Main then
    local isOpen = (CGPreviewWindow.GetListIsOpen)(data.id)
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R6 in 'UnsetPending'

    if isOpen then
      (model.c1Ctr).selectedIndex = 5
    else
      local chapterState = (PlotDungeonMgr.ChapterIsOpen)(data.chapter_id)
      -- DECOMPILER ERROR at PC53: Confused about usage of register: R7 in 'UnsetPending'

      if chapterState then
        (model.c1Ctr).selectedIndex = (CGPreviewWindow.GetPassStageNum)(data.chapter_id)
      else
        -- DECOMPILER ERROR at PC56: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (model.c1Ctr).selectedIndex = 0
      end
    end
  else
    do
      -- DECOMPILER ERROR at PC59: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (model.c1Ctr).selectedIndex = 5
      ;
      (icon.onClick):Set(function(...)
    -- function num : 0_1_0 , upvalues : mType, winType, model, data, _ENV
    if mType == winType.Main then
      if (model.c1Ctr).selectedIndex == 0 then
        local des = data.des
        local chapter_id = data.chapter_id
        local chapter = nil
        local TenMultiple = chapter_id % 10 == 0
        if chapter_id % 100 <= 10 then
          chapter = (string.sub)(des, 1, 9)
        elseif (chapter_id % 100 > 10 and chapter_id % 100 <= 20) or TenMultiple then
          chapter = (string.sub)(des, 1, 12)
        else
          chapter = (string.sub)(des, 1, 15)
        end
        ;
        (MessageMgr.SendCenterTips)((PUtil.get)(20000416, chapter))
      elseif (model.c1Ctr).selectedIndex < 5 then
        OpenWindow((WinResConfig.CGShowWindow).name, UILayer.HUD, data.id, (model.c1Ctr).selectedIndex)
      else
        (CommonWinMgr.OpenCGShow)(data.id, false)
      end
    end
    -- DECOMPILER ERROR: 9 unprocessed JMP targets
  end
)
    end
  end
end

CGPreviewWindow.GetPassStageNum = function(chapterID, ...)
  -- function num : 0_2 , upvalues : _ENV
  local ChapterData = ((TableData.gTable).BaseChapterData)[tonumber(chapterID)]
  if not ChapterData then
    return 0
  end
  local stageList = split(ChapterData.stages, ":")
  for i,v in ipairs(stageList) do
    if not (PlotDungeonMgr.IsPassDungeon)(tonumber(v)) then
      return i - 1
    end
  end
  return #stageList
end

CGPreviewWindow.RefreshWin = function(...)
  -- function num : 0_3 , upvalues : _ENV, mType, cgList, uis, CGPreviewWindow, MaxOpenIndex
  local CGData = (TableData.gTable).BaseHandbookCGData
  for _,v in pairs(CGData) do
    if v.type == mType then
      (table.insert)(cgList, v)
    end
  end
  ;
  (table.sort)(cgList, function(a, b, ...)
    -- function num : 0_3_0
    do return a.index < b.index end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.CommentList).numItems = #cgList
  for i,v in ipairs(cgList) do
    local isOpen = (CGPreviewWindow.GetListIsOpen)(v.id)
    local num = (CGPreviewWindow.GetPassStageNum)(v.chapter_id)
    if (isOpen or num >= 5) and MaxOpenIndex < i then
      MaxOpenIndex = i
    end
  end
  ;
  (uis.CommentList):ScrollToView(MaxOpenIndex - 1)
end

CGPreviewWindow.GetListIsOpen = function(cgId, ...)
  -- function num : 0_4 , upvalues : _ENV, openList
  for _,v in ipairs(openList) do
    if v == cgId then
      return true
    end
  end
  return false
end

CGPreviewWindow.OnShown = function(...)
  -- function num : 0_5
end

CGPreviewWindow.OnHide = function(...)
  -- function num : 0_6
end

CGPreviewWindow.OnClose = function(...)
  -- function num : 0_7 , upvalues : uis, contentPane, argTable, cgList
  uis = nil
  contentPane = nil
  argTable = {}
  cgList = {}
end

CGPreviewWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_8
end

return CGPreviewWindow

