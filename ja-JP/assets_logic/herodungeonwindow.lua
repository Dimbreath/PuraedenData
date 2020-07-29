-- params : ...
-- function num : 0 , upvalues : _ENV
require("HeroDungeon_HeroDungeonWindowByName")
require("HeroDungeon_BookComponentByName")
require("BattleConfig")
RenderTexture = (CS.UnityEngine).RenderTexture
NTexture = FairyGUI.NTexture
Animation = (CS.UnityEngine).Animation
SwipeGesture = FairyGUI.SwipeGesture
local contentPane = nil
local uis = {}
local HeroDungeonWindow = {}
local chapters = {}
local book1 = "book_01"
local book2 = "book_02"
local book3 = "book_04"
local book4 = "book_03"
local book5 = "book_05"
local bookAni = {LEFT_UPTURN = "zf_shang", LEFT_DOWN = "zf_xia", RIGHT_UPTURN = "yf_shang", RIGHT_DOWN = "yf_xia"}
local isLoading = false
local bookNameList = {
[1] = {book1, book1 .. "_l", book1 .. "_r"}
, 
[2] = {book2, book2 .. "_l", book2 .. "_r"}
, 
[3] = {book3, book3 .. "_l", book3 .. "_r"}
, 
[4] = {book4, book4 .. "_l", book4 .. "_r"}
, 
[5] = {book5, book5 .. "_l", book5 .. "_r"}
}
local mRoot = nil
local currentIndex = 0
local TopLoaderList = {}
local startIndex = false
local initPos = 0
local canClick = true
HeroDungeonWindow.OnInit = function(bridge, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, uis, mRoot, HeroDungeonWindow, startIndex, TopLoaderList, canClick, currentIndex, initPos, bookAni
  bridge:SetView((WinResConfig.HeroDungeonWindow).package, (WinResConfig.HeroDungeonWindow).comName)
  contentPane = bridge.contentPane
  uis = GetHeroDungeon_HeroDungeonWindowUis(contentPane)
  mRoot = uis.root
  ;
  (HeroDungeonWindow.InitAssetWin)()
  startIndex = false
  ;
  (HeroDungeonWindow.InitChapter)()
  TopLoaderList = {}
  canClick = false
  ;
  (HeroDungeonWindow.InitFunctionControl)()
  ;
  (HeroDungeonWindow.InitBookShell)()
  currentIndex = (HeroDungeonWindow.GetCurrentChapterIndex)()
  initPos = currentIndex
  TopLoaderList = (HeroDungeonWindow.CreateAndPlayBookAni)(currentIndex, bookAni.LEFT_DOWN)
  ;
  (HeroDungeonWindow.InitBtn)()
  ;
  (HeroDungeonWindow.CheckArrowShow)()
end

HeroDungeonWindow.InitBookShell = function(...)
  -- function num : 0_1 , upvalues : mRoot, _ENV
  local under = mRoot:GetChild("book_under")
  local face = mRoot:GetChild("book_face")
  local face2 = mRoot:GetChild("book_face_under")
  ;
  (Util.ShowUIModel)("book_under", under, nil, false, function(model, ...)
    -- function num : 0_1_0 , upvalues : _ENV
    (CSLuaUtil.SetGOScale)(model, 100, 100, 100, false)
    ;
    (SkeletonAnimationUtil.SetAnimation)(model.gameObject, 0, "book_open", false, nil, true)
  end
)
  ;
  (Util.ShowUIModel)("book_face", face, nil, false, function(model, ...)
    -- function num : 0_1_1 , upvalues : _ENV
    (CSLuaUtil.SetGOScale)(model, 100, 100, 100, false)
    ;
    (SkeletonAnimationUtil.SetAnimation)(model.gameObject, 0, "book_open", false, nil, true)
  end
)
  ;
  (Util.ShowUIModel)("book_face_under", face2, nil, false, function(model, ...)
    -- function num : 0_1_2 , upvalues : _ENV
    (CSLuaUtil.SetGOScale)(model, 100, 100, 100, false)
    ;
    (SkeletonAnimationUtil.SetAnimation)(model.gameObject, 0, "book_open", false, nil, true)
  end
)
end

HeroDungeonWindow.InitBtn = function(...)
  -- function num : 0_2 , upvalues : uis, chapters, currentIndex, _ENV, canClick, HeroDungeonWindow, TopLoaderList, bookAni, mRoot
  ((uis.RightBtn).onClick):Set(function(...)
    -- function num : 0_2_0 , upvalues : chapters, currentIndex, _ENV, canClick, HeroDungeonWindow, TopLoaderList, bookAni, mRoot
    local nextID = (chapters[currentIndex]).next
    local nextData = ((TableData.gTable).BaseChapterData)[tonumber(nextID)]
    if (Util.CheckCondition)(nextData.open_condition) then
      if (PlotDungeonMgr.ChapterIsOpen)(nextID) then
        if not canClick then
          return 
        end
        canClick = false
        ;
        (HeroDungeonWindow.RemoveBookCharacter)()
        currentIndex = currentIndex + 1
        ;
        (HeroDungeonWindow.PlayBookAni)(TopLoaderList, bookAni.LEFT_UPTURN)
        local index = mRoot:GetChildIndex(mRoot:GetChild("book_face_under"))
        local leftObj = TopLoaderList[2]
        mRoot:SetChildIndex(leftObj, index + 1)
        TopLoaderList = (HeroDungeonWindow.CreateAndPlayBookAni)(currentIndex, bookAni.LEFT_DOWN, true)
        ;
        (HeroDungeonWindow.CheckArrowShow)()
      else
        do
          ;
          (MessageMgr.SendCenterTips)((PUtil.get)(20000287))
        end
      end
    end
  end
)
  ;
  ((uis.LeftBtn).onClick):Set(function(...)
    -- function num : 0_2_1 , upvalues : canClick, HeroDungeonWindow, currentIndex, TopLoaderList, bookAni, mRoot
    if not canClick then
      return 
    end
    canClick = false
    ;
    (HeroDungeonWindow.RemoveBookCharacter)()
    currentIndex = currentIndex - 1
    ;
    (HeroDungeonWindow.PlayBookAni)(TopLoaderList, bookAni.RIGHT_UPTURN)
    local index = mRoot:GetChildIndex(mRoot:GetChild("book_face_under"))
    local right = TopLoaderList[3]
    mRoot:SetChildIndex(right, index + 1)
    TopLoaderList = (HeroDungeonWindow.CreateAndPlayBookAni)(currentIndex, bookAni.RIGHT_DOWN, false)
    ;
    (HeroDungeonWindow.CheckArrowShow)()
  end
)
  ;
  (((uis.BookComponent).root).onClick):Set(function(...)
    -- function num : 0_2_2 , upvalues : HeroDungeonWindow, currentIndex
    (HeroDungeonWindow.OnClickItem)(currentIndex)
  end
)
end

HeroDungeonWindow.CheckArrowShow = function(...)
  -- function num : 0_3 , upvalues : uis, currentIndex, chapters, _ENV, HeroDungeonWindow
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  (uis.LeftBtn).visible = currentIndex > 1
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.RightBtn).visible = currentIndex < #chapters
  ;
  (Util.SetOnClickDelay)(1)
  ;
  (HeroDungeonWindow.RefreshChapterInfo)()
  ;
  (HeroDungeonWindow.CheckRedDot)()
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

HeroDungeonWindow.RefreshChapterInfo = function(...)
  -- function num : 0_4 , upvalues : uis, chapters, currentIndex, _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.BookComponent).NameTxt).text = (chapters[currentIndex]).name
  local currentID = (PlotDungeonMgr.GetAlreadyPassStage)((chapters[currentIndex]).id)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  if currentID == 0 then
    ((uis.BookComponent).c2Ctr).selectedIndex = 1
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.BookComponent).ClearTxt).text = (PUtil.get)(20000236)
  else
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.BookComponent).c2Ctr).selectedIndex = 0
    local stageData = ((TableData.gTable).BaseStageData)[tonumber(currentID)]
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((uis.BookComponent).ProgressionTxt).text = (PUtil.get)(20000051, stageData.remark)
  end
end

HeroDungeonWindow.CheckRedDot = function(...)
  -- function num : 0_5 , upvalues : uis, HeroDungeonWindow, _ENV, chapters, currentIndex
  ((uis.RightBtn):GetChild("RedDot")).visible = (HeroDungeonWindow.JudgeIsRedDot)(true)
  ;
  ((uis.LeftBtn):GetChild("RedDot")).visible = (HeroDungeonWindow.JudgeIsRedDot)(false)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.BookComponent).RedDot).root).visible = (RedDotMgr.IsContainHeroPlotData)((chapters[currentIndex]).id)
end

HeroDungeonWindow.JudgeIsRedDot = function(isRight, ...)
  -- function num : 0_6 , upvalues : _ENV, chapters, currentIndex
  local redDotList = (RedDotMgr.HeroPlotData)()
  local currentChapter = (chapters[currentIndex]).id
  if isRight then
    for _,v in ipairs(redDotList) do
      if currentChapter < v then
        return true
      end
    end
  else
    do
      for _,v in ipairs(redDotList) do
        if v < currentChapter then
          return true
        end
      end
      do
        return false
      end
    end
  end
end

HeroDungeonWindow.PlayBookAni = function(loaderList, aniName, ...)
  -- function num : 0_7 , upvalues : _ENV
  for _,v in ipairs(loaderList) do
    (SkeletonAnimationUtil.SetAnimation)((v.Model).gameObject, 0, aniName, false, nil, true)
  end
end

HeroDungeonWindow.CreateAndPlayBookAni = function(bookIndex, aniName, right, func, ...)
  -- function num : 0_8 , upvalues : bookNameList, startIndex, _ENV, uis, HeroDungeonWindow, currentIndex, initPos, TopLoaderList, mRoot
  local NameList = bookNameList[bookIndex]
  local loaderList = {}
  local index = 0
  if startIndex then
    index = 3
  end
  ;
  (LuaSound.PlaySound)(LuaSound.HERO_DUNGEON_SHOW, SoundBank.OTHER)
  startIndex = not startIndex
  for i = 1, 3 do
    do
      local loader = (uis.root):GetChild("book_0" .. i + index)
      ;
      (Util.RecycleUIModel)(loader, false)
      ;
      (Util.ShowUIModel)(NameList[i], loader, nil, false, function(model, ...)
    -- function num : 0_8_0 , upvalues : _ENV, i, aniName, func, HeroDungeonWindow, currentIndex
    (CSLuaUtil.SetGOScale)(model, 100, 100, 100, false)
    if i == 1 then
      (SkeletonAnimationUtil.SetAnimation)(model, 0, aniName, false, function(...)
      -- function num : 0_8_0_0 , upvalues : func, HeroDungeonWindow, currentIndex
      if func then
        func()
      end
      ;
      (HeroDungeonWindow.SetBookCharacter)(currentIndex)
    end
, true)
    else
      ;
      (SkeletonAnimationUtil.SetAnimation)(model, 0, aniName, false, nil, true)
    end
  end
, false, true)
      ;
      (table.insert)(loaderList, loader)
      local reduce = 2
      if currentIndex ~= 5 and currentIndex ~= initPos - 1 and currentIndex ~= initPos + 1 then
        reduce = 1
      end
      local obj = TopLoaderList[i]
      if i == 3 and right and obj then
        local mIndex = mRoot:GetChildIndex(obj)
        mRoot:SetChildIndex(loader, mIndex - reduce)
      else
        do
          if i == 2 and obj and not right then
            local mIndex = mRoot:GetChildIndex(obj)
            mRoot:SetChildIndex(loader, mIndex - reduce)
          end
        end
      end
      do
        -- DECOMPILER ERROR at PC95: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  return loaderList
end

HeroDungeonWindow.InitFunctionControl = function(...)
  -- function num : 0_9 , upvalues : _ENV, uis
  local winName = (WinResConfig.HeroDungeonWindow).name
  local RegisterGuideAndControl = GuideData.RegisterGuideAndControl
  local ControlID = ControlID
  RegisterGuideAndControl(ControlID.HeroChapterList_FirstChapter, (uis.BookComponent).root, winName)
end

HeroDungeonWindow.GetCurrentChapterIndex = function(...)
  -- function num : 0_10 , upvalues : _ENV, chapters
  local index = 0
  local chapterID = (PlotDungeonMgr.GetBackHeroChapter)()
  if chapterID then
    for i,v in ipairs(chapters) do
      if v.id == chapterID then
        index = i
      end
    end
  else
    do
      for i,v in ipairs(chapters) do
        if (PlotDungeonMgr.ChapterIsOpen)(v.id) then
          index = i
        end
      end
      do
        return index
      end
    end
  end
end

HeroDungeonWindow.OnClickItem = function(index, ...)
  -- function num : 0_11 , upvalues : _ENV, chapters
  if (PlotDungeonMgr.GetAlreadyPassStage)((chapters[index]).id) then
    (PlotDungeonMgr.SetSelectChapter)((chapters[index]).id)
    ;
    (GuideMgr.InGuideOpenWindow)((WinResConfig.HeroDungeonMainWindow).name)
  else
    if (Util.CheckCondition)((chapters[index]).open_condition) then
      local chapterData = ((TableData.gTable).BaseChapterData)[(chapters[index]).pre]
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(20000083, chapterData.name))
    end
  end
end

HeroDungeonWindow.SetBookCharacter = function(index, ...)
  -- function num : 0_12 , upvalues : uis, chapters, _ENV, canClick
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((uis.CardQ).root).visible = true
  local modelName = (chapters[index]).book_monter_show
  ;
  (Util.CreateMiniModelByPath)(((uis.CardQ).root):GetChild("n18"), modelName, function(model, ...)
    -- function num : 0_12_0 , upvalues : canClick, _ENV
    canClick = true
    ;
    (SkeletonAnimationUtil.SetAnimation)(model, 0, BattleCardState.LAND, false, function(...)
      -- function num : 0_12_0_0 , upvalues : _ENV, model
      (SkeletonAnimationUtil.SetAnimation)(model, 0, BattleCardState.IDLE, true)
    end
, true)
    ;
    (SkeletonAnimationUtil.SetFlip)(model, true, false)
  end
)
end

HeroDungeonWindow.RemoveBookCharacter = function(...)
  -- function num : 0_13 , upvalues : _ENV, uis
  (Util.RecycleUIModel)(((uis.CardQ).root):GetChild("n18"), false)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.CardQ).root).visible = false
  local eff = (ResHelper.InstantiateEffect)(BattleEffectEnum.COMMON_BOOK_FLASH)
  ;
  (CSLuaUtil.SetGOLocalPos)(eff, 1, 1, 1)
  eff:SetLayer(LayerMaskNames.UI, true)
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (eff.transform).position = ((Game.uiCamera).transform).position
  local sortingHelper = require("SortingHelper")
  ;
  (sortingHelper.SetOrderInLayer)(eff, 10000, true)
  ;
  (SimpleTimer.setTimeout)(1, function(...)
    -- function num : 0_13_0 , upvalues : _ENV, eff
    local FxManager = require("FxManager")
    FxManager:ResetFx(eff)
    ;
    (ResHelper.DestroyGameObject)(eff)
  end
)
end

HeroDungeonWindow.InitChapter = function(...)
  -- function num : 0_14 , upvalues : _ENV, chapters
  local chapterData = (TableData.gTable).BaseChapterData
  for _,v in pairs(chapterData) do
    if v.type == (ProtoEnum.E_CHALLENGE_TYPE).ELITE_CHALLENGE then
      (table.insert)(chapters, v)
    end
  end
  ;
  (table.sort)(chapters, function(a, b, ...)
    -- function num : 0_14_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

HeroDungeonWindow.OnShown = function(...)
  -- function num : 0_15
end

HeroDungeonWindow.OnHide = function(...)
  -- function num : 0_16
end

HeroDungeonWindow.OnClose = function(...)
  -- function num : 0_17 , upvalues : _ENV, chapters, isLoading, contentPane, uis
  (GuideData.AbolishControlRefer)((WinResConfig.HeroDungeonWindow).name)
  ;
  (RedDotMgr.RemoveUIRefer)((WinResConfig.HeroDungeonWindow).name)
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.HeroDungeonWindow).name)
  chapters = {}
  ;
  (PlotDungeonMgr.SetBackHeroChapter)(nil)
  isLoading = false
  contentPane = nil
  uis = nil
end

HeroDungeonWindow.InitAssetWin = function(...)
  -- function num : 0_18 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.HeroDungeonWindow).name
  m.Tip = (PUtil.get)(20000038)
  m.model = uis.AssetStrip
  m.closeToWindow = (WinResConfig.AdventureWindow).name
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  m.activityIds = (Util.GetActivityIds)(76000002)
  m.CloseBtnFun = function(...)
    -- function num : 0_18_0 , upvalues : _ENV
    (PlotDungeonMgr.RecodeHeroDungeonPos)(-1)
  end

  m.BackBtnFun = m.CloseBtnFun
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

HeroDungeonWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_19
  if msgId ~= 1 or msgId == 2 then
  end
end

return HeroDungeonWindow

