-- params : ...
-- function num : 0 , upvalues : _ENV
require("PlotPlay_PlotPlayPanelByName")
local CubismAutoEyeBlinkInput = (((CS.Live2D).Cubism).Framework).CubismAutoEyeBlinkInput
local CubismRenderController = (((CS.Live2D).Cubism).Rendering).CubismRenderController
local Renderer = (CS.UnityEngine).Renderer
local RTM_Ins = (CS.RTManager).Singleton
local ResType = (FairyGUI.GLoader).ResType
local GTween = FairyGUI.GTween
local AudioMgr = (CS.AudioAssetManager).Singleton
local SkeletonMecanim = ((CS.Spine).Unity).SkeletonMecanim
local PlotPlayRoleNameTxtStatus = {None = 0, Left = 1}
local PlotPlayPlayMode = {Manual = 1, Auto = 2}
local PlotPlayNoHideComponent = {BlankBtn = true, root = true, CardShow_01_Grp = true, CardShow_02_Grp = true, CardShow_03_Grp = true, CardShow_04_Grp = true, CardShow_05_Grp = true, backsceneLoader = true, PlotPlayStarGrp = true, Mask_02_Image = true, CutGrp = true, Auto = true}
local PlotPlayStatue = {Normal = 1, Hide = 2, MakeChoice = 3}
local CharacterType = {Texture = 1, NonTexture = 2}
local MASK_MOVE_DURATION = 1
local MASK_MOVE_PHASE_1 = 0.1
local MASK_GAP_FIXER = 20
local TRANISITION_MASK_MODIFIER = 0.3
local DEFAULT_ANIM_DURATION = 0.6
local DEFAULT_WHITE_SCREEN_DURATION = 1
local PlotPlayPanelWindow = {}
local uis, contentPane, _dialogueConfig, _roleConfig, _typingEffect, _menuPopInAnim, _menuPopOutAnim, _contentInAnim, _contentOutAnim, _nameInAnim, _nameOutAnim = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
local _statue = PlotPlayStatue.Normal
local _lastStatue = nil
local _showingComponent = {}
local _currentMenuPop, _firstChoice = nil, nil
local _roleNameTxtStatue = PlotPlayRoleNameTxtStatus.Left
local _currentMode = PlotPlayPlayMode.Manual
local _autoTimer, _normalIndex, _blockAllIndex = nil, nil, nil
local _linesAudioId = -1
local _afterLineComplete, _lineTimestamp, _currentEffectId, _effectAudio = nil, nil, nil, nil
local _audioDone = false
local _originLoaderSize = nil
local _roleLoaders = {}
local _choices = {}
local _currentCharacters = {}
local _currentRole = nil
local _currentSceneEffect = {}
local _currentExpressionEffect = {}
local _roleAnimDuration = DEFAULT_ANIM_DURATION
local _moveSpeed = 900
local _showUpTimer, _quitTimer = nil, nil
local _movingRole = {}
local _quittingRole = {}
local _bgMask, _solidMask, _transitionalMask, _transitional2Mask, _originSolidMaskSize = nil, nil, nil, nil, nil
local _bgAnimPlaying = false
local _transitionEffect, _timeScale, lastBGMId, _lastRoleId, _shaking, _spineRoleTalking = nil, nil, nil, nil, nil, nil
local _moveDelay = 0.4
local _currentCharType = CharacterType.NonTexture
local _contentFadeOutTween, _afterRoleQuitComplete, _currentBtnStatus = nil, nil, nil
local _dialogueDone = {}
PlotPlayPanelWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, uis, lastBGMId, PlotPlayPanelWindow
  bridgeObj:SetView((WinResConfig.PlotPlayPanelWindow).package, (WinResConfig.PlotPlayPanelWindow).comName)
  contentPane = bridgeObj.contentPane
  contentPane:Center()
  uis = GetPlotPlay_PlotPlayPanelUis(contentPane)
  lastBGMId = (LuaSound.GetBGMId)()
  ;
  (LuaSound.StopBGM)()
  ;
  (PlotPlayPanelWindow.InitVariable)()
  ;
  (PlotPlayPanelWindow.InitButtonEvent)()
  ;
  (PlotPlayPanelWindow.InitText)()
end

PlotPlayPanelWindow.InitVariable = function(...)
  -- function num : 0_1 , upvalues : _typingEffect, _ENV, uis, _bgMask, _solidMask, _transitionalMask, _transitional2Mask, _originSolidMaskSize, _contentInAnim, _contentOutAnim, _nameInAnim, _nameOutAnim, _normalIndex, _blockAllIndex, PlotPlayPanelWindow, _roleLoaders, _originLoaderSize
  _typingEffect = (FairyGUI.TypingEffect)((uis.TalkWordGrp).talkTxt)
  _bgMask = (uis.root):GetChildAt(0)
  _solidMask = (uis.root):GetChild("Mask_01_Image")
  _transitionalMask = (uis.root):GetChild("Mask_02_Image")
  _transitional2Mask = (uis.root):GetChild("Mask_03_Image")
  _originSolidMaskSize = {x = _solidMask.width, y = _solidMask.height}
  _contentInAnim = ((uis.TalkWordGrp).root):GetTransition("in")
  _contentOutAnim = ((uis.TalkWordGrp).root):GetTransition("out")
  _nameInAnim = ((uis.TalkWordGrp).root):GetTransition("NameIn")
  _nameOutAnim = ((uis.TalkWordGrp).root):GetTransition("NameOut")
  _normalIndex = (uis.root):GetChildIndex(uis.BlankBtn)
  _blockAllIndex = (uis.root):GetChildIndex(uis.ChoiceList) - 1
  -- DECOMPILER ERROR at PC68: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.ChoiceList).visible = false
  ;
  (uis.ChoiceList):SetVirtual()
  -- DECOMPILER ERROR at PC74: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.ChoiceList).itemRenderer = PlotPlayPanelWindow.RefreshChoiceItem
  ;
  (uis.ChoiceList):SetBeginAnim(false, "in")
  _typingEffect.AfterTyping = PlotPlayPanelWindow.AfterTyping
  _roleLoaders = {}
  for i = 1, 5 do
    _roleLoaders[i] = {Avaiable = true, Loader = (uis["CardShow_0" .. tostring(i) .. "_Grp"]).CharacterLoader}
  end
  _originLoaderSize = ((_roleLoaders[1]).Loader).size
  ;
  (((uis.MenuPopOutWindow_01_Grp).root):GetTransition("in")).invalidateBatchingEveryFrame = true
  -- DECOMPILER ERROR at PC113: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.CutGrp).WordTxt).text = ""
end

PlotPlayPanelWindow.GetLoader = function(...)
  -- function num : 0_2 , upvalues : _roleLoaders, _ENV, _originLoaderSize
  local count = #_roleLoaders
  for i = 1, count do
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R5 in 'UnsetPending'

    if (_roleLoaders[i]).Avaiable then
      (_roleLoaders[i]).Avaiable = false
      -- DECOMPILER ERROR at PC18: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((_roleLoaders[i]).Loader).color = ((CS.UnityEngine).Color).white
      -- DECOMPILER ERROR at PC21: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((_roleLoaders[i]).Loader).alpha = 1
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((_roleLoaders[i]).Loader).xy = Vector2.zero
      -- DECOMPILER ERROR at PC30: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((_roleLoaders[i]).Loader).size = _originLoaderSize
      return (_roleLoaders[i]).Loader
    end
  end
  return nil
end

PlotPlayPanelWindow.RecycleLoader = function(loader, ...)
  -- function num : 0_3 , upvalues : _roleLoaders
  if _roleLoaders == nil then
    return 
  end
  local count = #_roleLoaders
  for i = 1, count do
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R6 in 'UnsetPending'

    if (_roleLoaders[i]).Loader == loader then
      (_roleLoaders[i]).Avaiable = true
      ;
      ((_roleLoaders[i]).Loader):RemoveModelRender()
      return true
    end
  end
  return false
end

PlotPlayPanelWindow.InitButtonEvent = function(...)
  -- function num : 0_4 , upvalues : uis, PlotPlayPanelWindow
  ((uis.MenuBtn).onClick):Add(PlotPlayPanelWindow.ClickMenuBtn)
  ;
  ((uis.NextBtn).onClick):Add(PlotPlayPanelWindow.ClickSkipBtn)
  ;
  ((uis.BlankBtn).onClick):Add(PlotPlayPanelWindow.ClickBlankBtn)
  ;
  (((uis.MenuPopOutWindow_01_Grp).BackLookBtn).onClick):Add(PlotPlayPanelWindow.ClickReviewBtn)
  ;
  (((uis.MenuPopOutWindow_01_Grp).AutoBtn).onClick):Add(PlotPlayPanelWindow.ClickChangeModeBtn)
  ;
  (((uis.MenuPopOutWindow_01_Grp).HideBtn).onClick):Add(PlotPlayPanelWindow.ClickHideBtn)
  ;
  ((uis.Live2DBtn).onClick):Add(PlotPlayPanelWindow.ClickChangeCharTypeBtn)
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.BlankBtn).disableSound = true
end

PlotPlayPanelWindow.InitText = function(...)
  -- function num : 0_5 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.MenuPopOutWindow_01_Grp).HideTxt).text = (PUtil.get)(60000454)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.MenuPopOutWindow_01_Grp).BacklookTxt).text = (PUtil.get)(60000453)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.MenuPopOutWindow_01_Grp).AutoTxt).text = (PUtil.get)(60000001)
end

PlotPlayPanelWindow.InitEvent = function(...)
  -- function num : 0_6
end

PlotPlayPanelWindow.RemoveEvent = function(...)
  -- function num : 0_7
end

PlotPlayPanelWindow.OnShown = function(...)
  -- function num : 0_8 , upvalues : PlotPlayPanelWindow
  (PlotPlayPanelWindow.InitEvent)()
  ;
  (PlotPlayPanelWindow.Init)()
end

PlotPlayPanelWindow.ResetMarkers = function(...)
  -- function num : 0_9 , upvalues : _linesAudioId, _afterLineComplete, _shaking, _audioDone, _spineRoleTalking, _dialogueDone
  _linesAudioId = -1
  _afterLineComplete = nil
  _shaking = false
  _audioDone = false
  _spineRoleTalking = false
  _dialogueDone = {}
end

PlotPlayPanelWindow.OnHide = function(...)
  -- function num : 0_10
end

PlotPlayPanelWindow.Init = function(...)
  -- function num : 0_11 , upvalues : PlotPlayPanelWindow, _currentCharType, _ENV, _timeScale, _solidMask, _transitionalMask, _transitional2Mask, _statue, PlotPlayStatue, _showingComponent, _roleNameTxtStatue, PlotPlayRoleNameTxtStatus, _currentMode, PlotPlayPlayMode, uis, _currentRole
  (PlotPlayPanelWindow.ResetMarkers)()
  _currentCharType = (PlayerPrefs.GetInt)(PlayerPrefsKeyName.PLOT_PLAY_ROLE_TYPE, Game.defaultPlotCharacterType)
  _timeScale = Time.timeScale
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

  Time.timeScale = 1
  if OvertureMgr.isPlaying == true and (OvertureMgr.HideSetBtn)() == true then
    (PlotPlayPanelWindow.HandleBtns)(PlotPlayBtnStatus.Hide)
  end
  ;
  (PlotPlayPanelWindow.ChangeChapterNameStatue)(false)
  ;
  (PlotPlayPanelWindow.ChangeMaskStatus)(_solidMask, _transitionalMask, false)
  ;
  (PlotPlayPanelWindow.SetMenuPopStatue)()
  _transitional2Mask.visible = false
  _statue = PlotPlayStatue.Normal
  _showingComponent = {}
  _roleNameTxtStatue = PlotPlayRoleNameTxtStatus.Left
  _currentMode = (Util.GetIntPlayerSetting)(PlayerPrefsKeyName.PLOT_PLAY_PLAY_TYPE, PlotPlayPlayMode.Manual)
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.Auto).root).visible = false
  _currentRole = nil
end

PlotPlayPanelWindow.SetMenuPopStatue = function(...)
  -- function num : 0_12 , upvalues : uis, _currentMenuPop, _menuPopInAnim, _menuPopOutAnim
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.MenuPopOutWindow_01_Grp).root).visible = false
  _currentMenuPop = uis.MenuPopOutWindow_01_Grp
  _menuPopInAnim = (_currentMenuPop.root):GetTransition("in")
  _menuPopOutAnim = (_currentMenuPop.root):GetTransition("out")
end

PlotPlayPanelWindow.OnClose = function(...)
  -- function num : 0_13 , upvalues : _ENV, _timeScale, lastBGMId, PlotPlayPanelWindow, _typingEffect, _quitTimer, uis, contentPane, _dialogueConfig, _roleConfig, _menuPopInAnim, _menuPopOutAnim, _currentMenuPop, _roleLoaders, _currentRole, _contentFadeOutTween
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  Time.timeScale = _timeScale
  if lastBGMId then
    (LuaSound.LoadAndPlayBGM)(lastBGMId)
    lastBGMId = nil
  end
  ;
  (PlotPlayPanelWindow.RemoveEvent)()
  _typingEffect:Cancel()
  ;
  (LeanTween.cancelAll)()
  ;
  (PlotPlayPanelWindow.RecycleAllRes)()
  if _quitTimer ~= nil then
    _quitTimer:stop()
    _quitTimer = nil
  end
  uis = nil
  contentPane = nil
  _dialogueConfig = nil
  _roleConfig = nil
  _typingEffect = nil
  _menuPopInAnim = nil
  _menuPopOutAnim = nil
  _currentMenuPop = nil
  _roleLoaders = nil
  _currentRole = nil
  if _contentFadeOutTween ~= nil then
    _contentFadeOutTween:Kill(true)
    _contentFadeOutTween = nil
  end
end

PlotPlayPanelWindow.ClickReviewBtn = function(...)
  -- function num : 0_14 , upvalues : _solidMask, _currentMenuPop, _ENV
  if _solidMask.visible then
    return 
  end
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (_currentMenuPop.root).visible = false
  OpenWindow((WinResConfig.StoryReviewWindow).name, UILayer.HUD1)
end

PlotPlayPanelWindow.ClickChangeModeBtn = function(...)
  -- function num : 0_15 , upvalues : _solidMask, _currentMenuPop, _currentMode, PlotPlayPlayMode, PlotPlayPanelWindow, _ENV, uis, _typingEffect, _audioDone, _quittingRole, _autoTimer
  if _solidMask.visible then
    return 
  end
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (_currentMenuPop.root).visible = false
  if _currentMode == PlotPlayPlayMode.Manual then
    (PlotPlayPanelWindow.HandleBtns)(PlotPlayBtnStatus.Hide)
    _currentMode = PlotPlayPlayMode.Auto
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.Auto).root).visible = true
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R0 in 'UnsetPending'

    if ((uis.TalkWordGrp).arowGrp).visible then
      ((uis.TalkWordGrp).arowGrp).visible = false
    end
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (_currentMenuPop.AutoTxt).text = (PUtil.get)(60000002)
    if not _typingEffect.Typing and _audioDone and (_G.next)(_quittingRole) == nil then
      (PlotPlayPanelWindow.SetChoiceStatue)(false)
      ;
      (PlotPlayMgr.AfterDialogueShowed)()
    end
  else
    ;
    (PlotPlayPanelWindow.HandleBtns)((PlotPlayData.CurrentChapterDataConfig).skip)
    _currentMode = PlotPlayPlayMode.Manual
    -- DECOMPILER ERROR at PC61: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.Auto).root).visible = false
    -- DECOMPILER ERROR at PC67: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (_currentMenuPop.AutoTxt).text = (PUtil.get)(60000001)
    if _autoTimer ~= nil then
      _autoTimer:stop()
    end
  end
  ;
  (Util.SetIntPlayerSetting)(PlayerPrefsKeyName.PLOT_PLAY_PLAY_TYPE, _currentMode)
end

PlotPlayPanelWindow.AfterTyping = function(...)
  -- function num : 0_16 , upvalues : _bgAnimPlaying, _currentMode, PlotPlayPlayMode, uis, _ENV, PlotPlayPanelWindow
  if _bgAnimPlaying then
    return 
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  if _currentMode == PlotPlayPlayMode.Manual then
    ((uis.TalkWordGrp).arowGrp).visible = true
  end
  loge("AfterTyping")
  ;
  (PlotPlayPanelWindow.AfterRoleCompleteTalk)()
end

PlotPlayPanelWindow.BeginAutoNextLines = function(...)
  -- function num : 0_17 , upvalues : _currentMode, PlotPlayPlayMode, _autoTimer, _ENV
  if _currentMode == PlotPlayPlayMode.Manual then
    return 
  end
  _autoTimer = (SimpleTimer.new)(PlotPlayData.AutoPlayInterval, 1, function(...)
    -- function num : 0_17_0 , upvalues : _ENV
    (PlotPlayMgr.AfterDialogueShowed)()
  end
)
  _autoTimer:start()
end

PlotPlayPanelWindow.SetBlankBtnLayer = function(blockAll, ...)
  -- function num : 0_18 , upvalues : uis
  if blockAll then
    (uis.root):SetChildIndex(uis.BlankBtn, (uis.root):GetChildIndex(uis.ChoiceList) - 1)
  else
    ;
    (uis.root):SetChildIndex(uis.BlankBtn, (uis.root):GetChildIndex((uis.TalkWordGrp).root) + 1)
  end
end

PlotPlayPanelWindow.ClickBlankBtn = function(...)
  -- function num : 0_19 , upvalues : _bgAnimPlaying, _ENV, _quitTimer, _currentMenuPop, _statue, PlotPlayStatue, PlotPlayPanelWindow, _typingEffect, _movingRole, _quittingRole, _audioDone, uis, _currentMode, PlotPlayPlayMode, _afterRoleQuitComplete, _shaking
  if _bgAnimPlaying then
    loge("_bgAnimPlaying")
    return 
  end
  if _quitTimer ~= nil and _quitTimer:IsRunIng() then
    loge("_quitTimer")
    return 
  end
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (_currentMenuPop.root).visible = false
  if _statue == PlotPlayStatue.Hide then
    (PlotPlayPanelWindow.ChangeUIStatus)(true)
    _typingEffect:Resume()
  else
    if _statue == PlotPlayStatue.MakeChoice then
      if (_G.next)(_movingRole) ~= nil or (_G.next)(_quittingRole) then
        return 
      end
      if _typingEffect.Typing == false and _audioDone and (uis.ChoiceList).visible == false then
        loge("unexpected shit happened")
        ;
        (PlotPlayPanelWindow.SetChoiceStatue)(true)
      end
      if _typingEffect.Typing then
        _typingEffect:Cancel()
        _typingEffect:FastPrint(0.002)
      end
      if _audioDone == false then
        _audioDone = true
      end
    else
      if _currentMode == PlotPlayPlayMode.Manual then
        if (_G.next)(_movingRole) ~= nil or (_G.next)(_quittingRole) and _afterRoleQuitComplete == nil then
          return 
        end
        if _typingEffect.Typing == false and _audioDone then
          if _afterRoleQuitComplete ~= nil then
            (PlotPlayPanelWindow.QuitCharacter)(_afterRoleQuitComplete.QuitEffect, _afterRoleQuitComplete.Complete, true)
            _afterRoleQuitComplete = nil
          else
            if not _shaking then
              (PlotPlayMgr.AfterDialogueShowed)()
            end
          end
        else
          if _typingEffect.Typing then
            _typingEffect:Cancel()
            _typingEffect:FastPrint(0.002)
          end
          if _audioDone == false then
            _audioDone = true
          end
        end
      else
        ;
        (PlotPlayPanelWindow.ClickChangeModeBtn)()
      end
    end
  end
end

PlotPlayPanelWindow.ClickChangeCharTypeBtn = function(...)
  -- function num : 0_20 , upvalues : _currentMenuPop, _currentCharType, CharacterType, _ENV, _currentCharacters, PlotPlayPanelWindow, _quittingRole, _linesAudioId, _afterLineComplete, _lineTimestamp, _dialogueConfig, AudioMgr
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

  (_currentMenuPop.root).visible = false
  if _currentCharType == CharacterType.NonTexture then
    do
      for k,v in pairs(_currentCharacters) do
        (PlotPlayPanelWindow.ChangeSingleCharacterType)(v, false)
      end
    end
    for k,v in pairs(_quittingRole) do
      (PlotPlayPanelWindow.ChangeSingleCharacterType)(v.Info, false)
    end
    _currentCharType = CharacterType.Texture
    ;
    (PlayerPrefs.SetInt)(PlayerPrefsKeyName.PLOT_PLAY_ROLE_TYPE, CharacterType.Texture)
    if _linesAudioId ~= -1 and _afterLineComplete ~= nil then
      local time = (ActorData.GetServerTime)() - _lineTimestamp
      time = time * 0.001
      local oldId = _linesAudioId
      _linesAudioId = (LuaSound.AudioMgrPlaySound)(tostring(_dialogueConfig.dialogue_sound), false, _afterLineComplete, nil, time)
      AudioMgr:RemoveSound(oldId)
    end
  else
    do
      for k,v in pairs(_currentCharacters) do
        (PlotPlayPanelWindow.ChangeSingleCharacterType)(v, true)
      end
      for k,v in pairs(_quittingRole) do
        (PlotPlayPanelWindow.ChangeSingleCharacterType)(v.Info, true)
      end
      _currentCharType = CharacterType.NonTexture
      ;
      (PlayerPrefs.SetInt)(PlayerPrefsKeyName.PLOT_PLAY_ROLE_TYPE, CharacterType.NonTexture)
      if _linesAudioId ~= -1 and _afterLineComplete ~= nil then
        local time = (ActorData.GetServerTime)() - _lineTimestamp
        time = time * 0.001
        local oldId = _linesAudioId
        local as = (PlotPlayPanelWindow.GetPlayerAudioReady)()
        local callback = _afterLineComplete
        _afterLineComplete = function(...)
    -- function num : 0_20_0 , upvalues : PlotPlayPanelWindow, callback, _lineTimestamp, _linesAudioId
    (PlotPlayPanelWindow.AfterPlayerAudioFinish)()
    callback()
    _lineTimestamp = 0
    _linesAudioId = -1
  end

        _linesAudioId = (LuaSound.AudioMgrPlaySound)(tostring(_dialogueConfig.dialogue_sound), false, _afterLineComplete, as, time)
        AudioMgr:RemoveSound(oldId)
      end
    end
  end
end

PlotPlayPanelWindow.ClickMenuBtn = function(...)
  -- function num : 0_21 , upvalues : _solidMask, PlotPlayPanelWindow
  if _solidMask.visible then
    return 
  end
  ;
  (PlotPlayPanelWindow.ChangeMenuPopStatue)()
end

PlotPlayPanelWindow.ClickHideBtn = function(...)
  -- function num : 0_22 , upvalues : _solidMask, _currentMenuPop, PlotPlayPanelWindow, _typingEffect
  if _solidMask.visible then
    return 
  end
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (_currentMenuPop.root).visible = false
  ;
  (PlotPlayPanelWindow.ChangeUIStatus)(false)
  _typingEffect:Stealth()
end

PlotPlayPanelWindow.ChangeUIStatus = function(show, immediately, checkNameStatus, ...)
  -- function num : 0_23 , upvalues : _statue, _lastStatue, _ENV, _showingComponent, _contentInAnim, _typingEffect, uis, _currentMode, PlotPlayPlayMode, PlotPlayRoleNameTxtStatus, _nameInAnim, _currentBtnStatus, PlotPlayStatue, PlotPlayNoHideComponent, _contentOutAnim, _nameOutAnim
  if show then
    _statue = _lastStatue
    for k,v in pairs(_showingComponent) do
      -- DECOMPILER ERROR at PC17: Confused about usage of register: R8 in 'UnsetPending'

      if not immediately and k == "TalkWordGrp" then
        if (v.root).visible == false then
          (v.root).visible = true
        end
        _contentInAnim:Play(function(...)
    -- function num : 0_23_0 , upvalues : _typingEffect, uis, _currentMode, PlotPlayPlayMode
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

    if not _typingEffect.Typing and ((uis.TalkWordGrp).arowGrp).visible == false and _currentMode == PlotPlayPlayMode.Manual then
      ((uis.TalkWordGrp).arowGrp).visible = true
    else
      -- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

      if _currentMode == PlotPlayPlayMode.Auto then
        ((uis.Auto).root).visible = true
      end
    end
  end
)
        if checkNameStatus then
          local dialogueConfig = (TableData.GetBaseStoryDialogueData)(PlotPlayData.CurrentDialogueID)
          if dialogueConfig.type == PlotPlayRoleNameTxtStatus.Left and dialogueConfig.carmera_type == 0 then
            _nameInAnim:Play()
          else
            -- DECOMPILER ERROR at PC43: Confused about usage of register: R9 in 'UnsetPending'

            ;
            (((uis.TalkWordGrp).CardName_01_Grp).root).visible = false
          end
        else
          do
            do
              _nameInAnim:Play()
              -- DECOMPILER ERROR at PC55: Confused about usage of register: R8 in 'UnsetPending'

              if type(v) == "table" then
                (v.root).visible = true
              else
                -- DECOMPILER ERROR at PC80: Unhandled construct in 'MakeBoolean' P3

                if (_currentBtnStatus == PlotPlayBtnStatus.Hide and k ~= "MenuBtn" and k ~= "NextBtn" and k ~= "Live2DBtn") or _currentBtnStatus ~= PlotPlayBtnStatus.Disable or _currentBtnStatus == PlotPlayBtnStatus.Enable then
                  v.visible = true
                end
              end
              -- DECOMPILER ERROR at PC81: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC81: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC81: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC81: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC81: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  else
    _lastStatue = _statue
    _statue = PlotPlayStatue.Hide
    local componentType = nil
    for k,v in pairs(uis) do
      componentType = type(v)
      if (v.visible or v.root == nil or not (v.root).visible or componentType == "table") and PlotPlayNoHideComponent[k] == nil then
        _showingComponent[k] = v
        -- DECOMPILER ERROR at PC119: Confused about usage of register: R9 in 'UnsetPending'

        if not immediately and k == "TalkWordGrp" then
          ((uis.TalkWordGrp).arowGrp).visible = false
          _contentOutAnim:Play()
          _nameOutAnim:Play()
        else
          -- DECOMPILER ERROR at PC130: Confused about usage of register: R9 in 'UnsetPending'

          if componentType == "table" then
            (v.root).visible = false
          else
            -- DECOMPILER ERROR at PC155: Unhandled construct in 'MakeBoolean' P3

            if (_currentBtnStatus == PlotPlayBtnStatus.Hide and k ~= "MenuBtn" and k ~= "NextBtn" and k ~= "Live2DBtn") or _currentBtnStatus ~= PlotPlayBtnStatus.Disable or _currentBtnStatus == PlotPlayBtnStatus.Enable then
              v.visible = false
            end
          end
        end
      end
    end
    -- DECOMPILER ERROR at PC164: Confused about usage of register: R4 in 'UnsetPending'

    if _currentMode == PlotPlayPlayMode.Auto then
      ((uis.Auto).root).visible = false
    end
  end
end

PlotPlayPanelWindow.ClickSkipBtn = function(...)
  -- function num : 0_24 , upvalues : _solidMask, _ENV, _quittingRole, _afterRoleQuitComplete, _typingEffect
  if _solidMask.visible then
    return 
  end
  if (_G.next)(_quittingRole) ~= nil and _afterRoleQuitComplete == nil then
    return 
  end
  ;
  (MessageMgr.OpenConfirmWindow)((PlotPlayData.CurrentChapterDataConfig).skip_content, function(...)
    -- function num : 0_24_0 , upvalues : _typingEffect, _ENV
    if _typingEffect ~= nil then
      _typingEffect:Cancel()
    end
    ;
    (PlotPlayMgr.AfterDialogueShowed)(nil, true)
  end
, nil, (PUtil.get)(60000417), (PUtil.get)(60000418), (PUtil.get)(185))
end

PlotPlayPanelWindow.ChangeMenuPopStatue = function(...)
  -- function num : 0_25 , upvalues : _currentMenuPop, _menuPopOutAnim, _menuPopInAnim
  if (_currentMenuPop.root).visible then
    _menuPopOutAnim:Play(function(...)
    -- function num : 0_25_0 , upvalues : _currentMenuPop
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

    (_currentMenuPop.root).visible = false
  end
)
  else
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (_currentMenuPop.root).visible = true
    _menuPopInAnim:Play()
  end
end

PlotPlayPanelWindow.ChangeRoleNameTxtStatus = function(statue, ...)
  -- function num : 0_26 , upvalues : _roleNameTxtStatue, PlotPlayRoleNameTxtStatus, uis, _nameInAnim, _nameOutAnim
  if (_roleNameTxtStatue == PlotPlayRoleNameTxtStatus.None and (((uis.TalkWordGrp).CardName_01_Grp).root).visible == false and _nameInAnim.playing == false) or _roleNameTxtStatue ~= PlotPlayRoleNameTxtStatus.None and (((uis.TalkWordGrp).CardName_01_Grp).root).visible and _nameOutAnim.playing == false then
    return 
  end
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

  if statue == PlotPlayRoleNameTxtStatus.Left then
    if (((uis.TalkWordGrp).CardName_01_Grp).root).visible == false then
      (((uis.TalkWordGrp).CardName_01_Grp).root).visible = true
      _nameOutAnim:Stop()
      _nameInAnim:Play()
    else
      if _nameOutAnim.playing then
        _nameOutAnim:Stop(false, false)
      end
    end
  else
    if (((uis.TalkWordGrp).CardName_01_Grp).root).visible then
      _nameOutAnim:Play(function(...)
    -- function num : 0_26_0 , upvalues : uis
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

    (((uis.TalkWordGrp).CardName_01_Grp).root).visible = false
  end
)
    end
  end
  _roleNameTxtStatue = statue
end

PlotPlayPanelWindow.PlayChapterName = function(callback, ...)
  -- function num : 0_27 , upvalues : _ENV, uis, PlotPlayPanelWindow
  (LuaSound.LoadAndPlayBGM)(1020101)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.PlotPlayStarGrp).ChapterTxt).text = (PlotPlayData.CurrentChapterDataConfig).name
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((uis.PlotPlayStarGrp).PlotPlayStarName).NameLoader).url = (Util.GetItemUrl)((PlotPlayData.CurrentChapterDataConfig).remark)
  ;
  (PlotPlayPanelWindow.ChangeChapterNameStatue)(true)
  ;
  (((uis.PlotPlayStarGrp).root):GetTransition("in")):Play(function(...)
    -- function num : 0_27_0 , upvalues : PlotPlayPanelWindow, callback
    (PlotPlayPanelWindow.ChangeChapterNameStatue)(false)
    callback()
  end
)
end

PlotPlayPanelWindow.HandleBtns = function(status, ...)
  -- function num : 0_28 , upvalues : _ENV, uis, _currentBtnStatus
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  if status == PlotPlayBtnStatus.Disable then
    (uis.NextBtn).visible = false
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.MenuBtn).visible = true
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.Live2DBtn).visible = not PlotPlayData.NotShowSwitchBtn
  else
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

    if status == PlotPlayBtnStatus.Hide then
      (uis.NextBtn).visible = false
      -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (uis.MenuBtn).visible = false
      -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (uis.Live2DBtn).visible = false
    else
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (uis.NextBtn).visible = true
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (uis.MenuBtn).visible = true
      -- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (uis.Live2DBtn).visible = not PlotPlayData.NotShowSwitchBtn
    end
  end
  _currentBtnStatus = status
end

PlotPlayPanelWindow.ChangeChapterNameStatue = function(show, ...)
  -- function num : 0_29 , upvalues : uis
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((uis.PlotPlayStarGrp).root).visible = show
end

PlotPlayPanelWindow.PlayOneDialogue = function(param, ...)
  -- function num : 0_30 , upvalues : uis, _dialogueConfig, _ENV, _lastRoleId, _currentExpressionEffect, _roleConfig, PlotPlayPanelWindow, _typingEffect, _quittingRole
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  if not (uis.BlankBtn).touchable then
    (uis.BlankBtn).touchable = true
  end
  _dialogueConfig = (TableData.GetBaseStoryDialogueData)(param.id)
  loge("play dialogue:" .. param.id)
  if _dialogueConfig == nil then
    loge("剧情对话ID：" .. tostring(param.id) .. "未配置")
    return 
  end
  if _dialogueConfig.role_type ~= _lastRoleId or (Util.StringIsNullOrEmpty)(_dialogueConfig.expression_path) == false then
    for k,v in pairs(_currentExpressionEffect) do
      if v ~= nil then
        v:Dispose()
      end
    end
  end
  do
    _currentExpressionEffect = {}
    _roleConfig = ((TableData.gTable).BaseStoryRoleData)[_dialogueConfig.role_type]
    ;
    (PlotPlayPanelWindow.CheckChoiceStatue)()
    ;
    (PlotPlayPanelWindow.SetContent)()
    _typingEffect:Start()
    local quitEffect = (PlotPlayPanelWindow.CheckQuitCharacter)(PlotRoleSpecialInOutType.Normal)
    if (_G.next)(_quittingRole) ~= nil then
      (PlotPlayPanelWindow.QuitCharacter)(quitEffect, PlotPlayPanelWindow.ShowCharacter)
    else
      ;
      (PlotPlayPanelWindow.ShowCharacter)()
    end
    ;
    (PlotPlayPanelWindow.ShowSceneEffect)(_dialogueConfig)
  end
end

PlotPlayPanelWindow.AfterRoleShowUp = function(...)
  -- function num : 0_31 , upvalues : PlotPlayPanelWindow
  (PlotPlayPanelWindow.ShowRoleShake)()
  ;
  (PlotPlayPanelWindow.ShowTypingEffect)()
  ;
  (PlotPlayPanelWindow.HandleSound)()
end

PlotPlayPanelWindow.AfterRoleCompleteTalk = function(...)
  -- function num : 0_32 , upvalues : _typingEffect, _audioDone, _dialogueDone, _dialogueConfig, _ENV, _statue, PlotPlayStatue, PlotPlayPanelWindow, _currentMode, PlotPlayPlayMode, _autoTimer, _firstChoice, _quittingRole, _afterRoleQuitComplete
  if _typingEffect == nil then
    return 
  end
  if _audioDone == false or _typingEffect.Typing or _dialogueDone[_dialogueConfig.id] then
    return 
  end
  _dialogueDone[_dialogueConfig.id] = true
  loge("AfterRoleCompleteTalk")
  local complete = function(...)
    -- function num : 0_32_0 , upvalues : _ENV, _statue, PlotPlayStatue, PlotPlayPanelWindow, _currentMode, PlotPlayPlayMode, _autoTimer, _firstChoice
    logw("complete")
    if _statue == PlotPlayStatue.MakeChoice then
      (PlotPlayPanelWindow.SetChoiceStatue)(true)
      if _currentMode == PlotPlayPlayMode.Auto then
        _autoTimer = (SimpleTimer.new)(PlotPlayData.AutoPlayInterval, 1, function(...)
      -- function num : 0_32_0_0 , upvalues : PlotPlayPanelWindow, _ENV, _firstChoice
      (PlotPlayPanelWindow.SetChoiceStatue)(false)
      ;
      (PlotPlayMgr.AfterDialogueShowed)(tonumber(_firstChoice))
    end
)
        _autoTimer:start()
      end
    else
      if _currentMode == PlotPlayPlayMode.Auto then
        (PlotPlayPanelWindow.BeginAutoNextLines)()
      end
    end
  end

  local quitEffect = (PlotPlayPanelWindow.CheckQuitCharacter)(PlotRoleSpecialInOutType.Special1)
  if (_G.next)(_quittingRole) ~= nil then
    if _dialogueConfig.next ~= -1 then
      (PlotPlayPanelWindow.QuitCharacter)(quitEffect, complete)
    else
      _afterRoleQuitComplete = {QuitEffect = quitEffect, Complete = function(...)
    -- function num : 0_32_1 , upvalues : _ENV
    (PlotPlayMgr.AfterDialogueShowed)(nil, false, true)
  end
}
      if _currentMode == PlotPlayPlayMode.Auto then
        (SimpleTimer.setTimeout)(PlotPlayData.AutoPlayInterval, function(...)
    -- function num : 0_32_2 , upvalues : _afterRoleQuitComplete, PlotPlayPanelWindow
    if _afterRoleQuitComplete ~= nil then
      (PlotPlayPanelWindow.QuitCharacter)(_afterRoleQuitComplete.QuitEffect, _afterRoleQuitComplete.Complete)
      _afterRoleQuitComplete = nil
    end
  end
)
      end
    end
  else
    complete()
  end
end

PlotPlayPanelWindow.CheckQuitCharacter = function(quitType, ...)
  -- function num : 0_33 , upvalues : _dialogueConfig, _ENV, _quittingRole, _currentCharacters
  if _dialogueConfig == nil then
    return 
  end
  local quitEffect = (PlotPlayData.GetRoleEffects)(_dialogueConfig.role_departure_type)
  _quittingRole = {}
  for k,v in pairs(quitEffect) do
    local info = _currentCharacters[k]
    if info ~= nil and v.Special == quitType then
      _quittingRole[k] = {Info = info, Effect = v}
      _currentCharacters[k] = nil
    end
  end
  return quitEffect
end

PlotPlayPanelWindow.QuitCharacter = function(quitEffect, callback, fadeOutContent, ...)
  -- function num : 0_34 , upvalues : _ENV, _quittingRole, _currentRole, PlotPlayPanelWindow, _moveDelay, uis, _nameOutAnim, _contentFadeOutTween, _quitTimer, _roleAnimDuration
  local delay = (PlotPlayData.GetRoleEffectDelay)(false, quitEffect, _quittingRole)
  for k,v in pairs(_quittingRole) do
    do
      if _currentRole ~= nil and (v.Info).id == _currentRole.id then
        _currentRole = nil
      end
      ;
      (PlotPlayPanelWindow.DealOneCharacter)(v.Info, nil, quitEffect[k], false, function(...)
    -- function num : 0_34_0 , upvalues : _quittingRole, k, PlotPlayPanelWindow, v, _ENV
    _quittingRole[k] = nil
    ;
    (PlotPlayPanelWindow.ResetAnimator)(v.Info)
    ;
    (Util.RecycleUIModel)((v.Info).Loader)
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (v.Info).model = nil
    ;
    (PlotPlayPanelWindow.RecycleLoader)((v.Info).Loader)
  end
, _moveDelay * (delay[k] or 0))
    end
  end
  if (((uis.TalkWordGrp).CardName_01_Grp).root).visible then
    _nameOutAnim:Play(function(...)
    -- function num : 0_34_1 , upvalues : uis
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

    (((uis.TalkWordGrp).CardName_01_Grp).root).visible = false
  end
)
    if fadeOutContent then
      _contentFadeOutTween = (((uis.TalkWordGrp).talkTxt):TweenFade(0, 0.5)):OnComplete(function(...)
    -- function num : 0_34_2 , upvalues : uis, _contentFadeOutTween
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    ((uis.TalkWordGrp).talkTxt).text = ""
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.TalkWordGrp).talkTxt).alpha = 1
    _contentFadeOutTween = nil
  end
)
    end
  end
  _quitTimer = (SimpleTimer.new)(_roleAnimDuration + 0.1, 1, function(...)
    -- function num : 0_34_3 , upvalues : callback, _quitTimer
    callback()
    _quitTimer = nil
  end
)
  _quitTimer:start()
end

PlotPlayPanelWindow.ShowCharacter = function(...)
  -- function num : 0_35 , upvalues : _ENV, _dialogueConfig, _roleAnimDuration, DEFAULT_ANIM_DURATION, _movingRole, _currentCharacters, PlotPlayPanelWindow, _moveDelay, _showUpTimer
  local charIDs = split(_dialogueConfig.role_ids, ":")
  ;
  (split(_dialogueConfig.position, ","))
  local charPos = nil
  local expression = nil
  if (Util.StringIsNullOrEmpty)(_dialogueConfig.expression) then
    expression = {}
  else
    expression = split(_dialogueConfig.expression, ":")
  end
  local action = nil
  if (Util.StringIsNullOrEmpty)(_dialogueConfig.action) then
    action = {}
  else
    action = split(_dialogueConfig.action, ":")
  end
  local stay = nil
  if (Util.StringIsNullOrEmpty)(_dialogueConfig.action_type) then
    stay = {}
  else
    stay = split(_dialogueConfig.action_type, ":")
  end
  local enterEffect = (PlotPlayData.GetRoleEffects)(_dialogueConfig.role_admission_type)
  local count = #charIDs
  local id, roleID, rolePath, color, args, targetPos, config = nil, nil, nil, nil, nil, nil, nil
  local roles = {}
  local shouldWait = false
  local eachWait = nil
  _roleAnimDuration = DEFAULT_ANIM_DURATION
  _movingRole = {}
  local delay = (PlotPlayData.GetRoleEffectDelay)(true, enterEffect, charPos)
  for i = 1, count do
    id = tonumber(charIDs[i])
    config = ((TableData.gTable).BaseStoryRoleData)[id]
    if _currentCharacters[id] == nil then
      if not delay[id] then
        do
          roles[id] = (PlotPlayPanelWindow.LoadNewCharacter)(config, charPos[i], enterEffect[id], true, _moveDelay * (config == nil or 0))
          roles[id] = _currentCharacters[id]
          _currentCharacters[id] = nil
          -- DECOMPILER ERROR at PC111: Overwrote pending register: R16 in 'AssignReg'

          if eachWait then
            _movingRole[id] = true
          end
          if not shouldWait then
            shouldWait = eachWait
          end
          ;
          (PlotPlayPanelWindow.SetCharacterExpressionAndMotion)(roles[id], expression[i], action[i], stay[i])
          -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  _currentCharacters = roles
  ;
  (PlotPlayPanelWindow.ShowCurrentCharacter)()
  if shouldWait then
    _showUpTimer = (SimpleTimer.new)(_roleAnimDuration, 1, PlotPlayPanelWindow.AfterRoleShowUp)
    _showUpTimer:start()
  else
    ;
    (PlotPlayPanelWindow.AfterRoleShowUp)()
  end
end

PlotPlayPanelWindow.LoadNewCharacter = function(config, pos, enterEffect, gray, delay, ...)
  -- function num : 0_36 , upvalues : _ENV, _currentCharacters, PlotPlayPanelWindow, _currentCharType, CharacterType
  local shouldWait = false
  local info = {}
  info = {}
  info.id = config.id
  if config.fashion_id ~= "0" and (Util.StringIsNullOrEmpty)(config.fashion_id) == false then
    info.Mark = tonumber(config.fashion_id)
  end
  local reuseData = nil
  if info.Mark ~= nil then
    for k,v in pairs(_currentCharacters) do
      if v.Mark == info.Mark then
        reuseData = v
        break
      end
    end
  end
  do
    if reuseData ~= nil then
      info = reuseData
      info.id = config.id
    else
      info.Loader = (PlotPlayPanelWindow.GetLoader)()
      local args = split(pos, ":")
      local targetPos = {x = tonumber(args[1]), y = tonumber(args[2])}
      -- DECOMPILER ERROR at PC70: Unhandled construct in 'MakeBoolean' P1

      if _currentCharType == CharacterType.NonTexture and (PlotPlayPanelWindow.InitNonTextureRole)(config, info) == false then
        (PlotPlayPanelWindow.InitStaticRoleImg)(config, info)
      end
      if (PlotPlayPanelWindow.InitStaticRoleImg)(config, info) == false then
        (PlotPlayPanelWindow.InitNonTextureRole)(config, info)
      end
      local nonTextureRes = not (Util.CheckNullString)(config.role_path)
      local textureRes = (((TableData.gTable).BaseFashionData)[info.Mark] ~= nil and not (Util.CheckNullString)((((TableData.gTable).BaseFashionData)[info.Mark]).show_texture))
      -- DECOMPILER ERROR at PC114: Unhandled construct in 'MakeBoolean' P3

      info.SkipChangeType = (not nonTextureRes or textureRes) and nonTextureRes
      info.ExpType = config.expression_type
      -- DECOMPILER ERROR at PC127: Confused about usage of register: R12 in 'UnsetPending'

      if gray then
        (info.Loader).color = ((CS.UnityEngine).Color).gray
      else
        -- DECOMPILER ERROR at PC134: Confused about usage of register: R12 in 'UnsetPending'

        (info.Loader).color = ((CS.UnityEngine).Color).white
      end
      info.CurrentScale = tonumber(args[3])
      if info.CurrentScale == nil then
        info.CurrentScale = 10000
      end
      if info.Model ~= nil then
        (PlotPlayPanelWindow.InitRoleInfo)(info)
        ;
        (PlotPlayPanelWindow.DealOneCharacter)(info, targetPos, enterEffect, true, nil, delay)
        shouldWait = true
      else
        -- DECOMPILER ERROR at PC166: Confused about usage of register: R12 in 'UnsetPending'

        ((info.Loader).parent).x = targetPos.x + (ResolutionHandler.AdaptOffset).X
        -- DECOMPILER ERROR at PC174: Confused about usage of register: R12 in 'UnsetPending'

        ;
        ((info.Loader).parent).y = targetPos.y + (ResolutionHandler.AdaptOffset).Y
      end
    end
    do return info, shouldWait end
    -- DECOMPILER ERROR: 11 unprocessed JMP targets
  end
end

PlotPlayPanelWindow.InitNonTextureRole = function(config, info, recycle, ...)
  -- function num : 0_37 , upvalues : _ENV, ResType
  if (Util.CheckNullString)(config.role_path) == false then
    if recycle then
      (Util.RecycleUIModel)(info.Loader)
    end
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (info.Loader).xy = Vector2.zero
    local fashionConfig = ((TableData.gTable).BaseFashionData)[tonumber(config.fashion_id)]
    if fashionConfig ~= nil then
      info.Model = (Util.ShowUIModel)(config.role_path, info.Loader, fashionConfig.show_spine_type)
      info.DefaultSkin = fashionConfig.show_spine_type
    else
      info.Model = (Util.ShowUIModel)(config.role_path, info.Loader)
    end
    do
      do
        if (info.Loader).CurrentResType == ResType.Texture and (Util.CheckNullString)(config.offset) == false then
          local offsetPos = split(config.offset, ":")
          -- DECOMPILER ERROR at PC65: Confused about usage of register: R5 in 'UnsetPending'

          ;
          (info.Loader).xy = Vector2(tonumber(offsetPos[1]), tonumber(offsetPos[2]))
        end
        do return info.Model ~= nil end
        do return false end
        -- DECOMPILER ERROR: 3 unprocessed JMP targets
      end
    end
  end
end

PlotPlayPanelWindow.InitStaticRoleImg = function(config, info, recycle, ...)
  -- function num : 0_38 , upvalues : _ENV
  local fashionConfig = ((TableData.gTable).BaseFashionData)[info.Mark]
  if fashionConfig ~= nil and (Util.CheckNullString)(fashionConfig.show_texture) == false then
    if recycle then
      (Util.RecycleUIModel)(info.Loader)
    end
    do
      if (Util.CheckNullString)(config.offset) == false then
        local offsetPos = split(config.offset, ":")
        -- DECOMPILER ERROR at PC38: Confused about usage of register: R5 in 'UnsetPending'

        ;
        (info.Loader).xy = Vector2(tonumber(offsetPos[1]), tonumber(offsetPos[2]))
      end
      info.Model = (Util.ShowUIModel)(fashionConfig.show_texture, info.Loader)
      do return true end
      do return false end
    end
  end
end

PlotPlayPanelWindow.InitModelScaleInfo = function(info, ...)
  -- function num : 0_39 , upvalues : ResType, PlotPlayPanelWindow, _ENV
  if info.Model ~= nil and info.orginModelScale == nil and (info.Loader).CurrentResType ~= ResType.Texture then
    info.orginModelScale = ((info.Model).transform).localScale
  end
  if info.Model ~= nil then
    local originScale = ((info.Model).transform).localScale
    local scalePos = ((info.Model).transform).localPosition
    local scale = (PlotPlayPanelWindow.GetCharacterScale)(info)
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((info.Model).transform).localScale = scale
    -- DECOMPILER ERROR at PC61: Confused about usage of register: R4 in 'UnsetPending'

    if (info.Loader).CurrentResType == ResType.Texture then
      ((info.Model).transform).localPosition = Vector3(scalePos.x - (scale.x - originScale.x) * (((info.Loader).image).texture).width * 0.5, scalePos.y + (scale.y - originScale.y) * (((info.Loader).image).texture).height, scalePos.z)
    end
  end
end

PlotPlayPanelWindow.InitRoleInfo = function(info, ...)
  -- function num : 0_40 , upvalues : PlotPlayPanelWindow, ResType, _ENV
  (PlotPlayPanelWindow.InitModelScaleInfo)(info)
  ;
  (PlotPlayPanelWindow.InitExpressionCtrl)(info)
  ;
  (PlotPlayPanelWindow.InitAnim)(info)
  if (info.Loader).CurrentResType == ResType.Spine and info.AnimModel ~= nil and info.Model ~= nil and (info.AnimModel):GetInstanceID() ~= (info.Model):GetInstanceID() then
    (SkeletonAnimationUtil.SetSkin)(info.AnimModel, info.DefaultSkin)
  end
end

PlotPlayPanelWindow.ProcessModelWithRT = function(info, ...)
  -- function num : 0_41 , upvalues : _ENV
  local scaler = GameObject("Scaler")
  ;
  (CSLuaUtil.ChangeLayer)(scaler.transform, "Model")
  ;
  (scaler.transform):SetParent(((info.Model).transform).parent)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (scaler.transform).localScale = Vector3.one * ResolutionHandler.UIscale
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (scaler.transform).localPosition = Vector3(-DesignScreen.width * 0.5 * ResolutionHandler.UIscale, DesignScreen.height * 0.5 * ResolutionHandler.UIscale, 0)
  ;
  ((info.Model).transform):SetParent(scaler.transform, true)
end

PlotPlayPanelWindow.SetCharacterExpressionAndMotion = function(info, expression, action, stay, ...)
  -- function num : 0_42 , upvalues : ResType, _ENV, CubismAutoEyeBlinkInput
  if info.Model == nil or (info.Loader).CurrentResType == ResType.Texture then
    return 
  end
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

  if info.ExpCtrl ~= nil and ((info.Loader).CurrentResType == ResType.Live2D or (info.Loader).CurrentResType == ResType.Live2DWithRT) then
    if (info.Expression)[expression] ~= nil then
      (info.ExpCtrl).CurrentExpressionIndex = (info.Expression)[expression]
    else
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (info.ExpCtrl).CurrentExpressionIndex = -1
    end
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R4 in 'UnsetPending'

    if (info.Pose)[expression] ~= nil and not PlotPlayDisableMotionRole[info.id] then
      (info.ExpCtrl).CurrentPoseExpressionIndex = (info.Pose)[expression]
    else
      -- DECOMPILER ERROR at PC48: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (info.ExpCtrl).CurrentPoseExpressionIndex = -1
    end
  end
  if info.Animator == nil then
    if info.ExpType == PlotPlayRoleExpType.All then
      (SkeletonAnimationUtil.SetSkin)(info.Model, expression)
      ;
      (SkeletonAnimationUtil.SetAnimation)(info.Model, 0, action, false, function(obj, ...)
    -- function num : 0_42_0 , upvalues : _ENV, info
    (SkeletonAnimationUtil.SetSkin)(info.DefaultSkin)
    ;
    (SkeletonAnimationUtil.SetAnimation)(info.Model, 0, BattleCardState.IDLE, true)
  end
)
    else
      ;
      (SkeletonAnimationUtil.SetExpression)(info.Model, expression)
      ;
      (SkeletonAnimationUtil.SetAnimation)(info.Model, 0, action, false, function(obj, ...)
    -- function num : 0_42_1 , upvalues : _ENV, info
    (SkeletonAnimationUtil.RemoveExpression)(info.Model)
    ;
    (SkeletonAnimationUtil.SetAnimation)(info.Model, 0, BattleCardState.IDLE, true)
  end
)
    end
  else
    if (Util.CheckNullString)(action) == false and not PlotPlayDisableMotionRole[info.id] then
      if info.TalkAnimLayer ~= nil then
        if info.ExpType == PlotPlayRoleExpType.All then
          (SkeletonAnimationUtil.SetSkin)(info.AnimModel, action)
        else
          ;
          (SkeletonAnimationUtil.SetExpression)(info.AnimModel, action)
        end
        info.CurrentExpression = action
      else
        -- DECOMPILER ERROR at PC131: Confused about usage of register: R4 in 'UnsetPending'

        if ((info.Animator):GetCurrentAnimatorStateInfo(0)):IsName(action) == false then
          if (info.Animator).enabled == false then
            (info.Animator).enabled = true
          end
          -- DECOMPILER ERROR at PC164: Unhandled construct in 'MakeBoolean' P3

          if ((info.Animator).parameterCount > 0 and (info.Loader).CurrentResType == ResType.Spine) or (info.Animator).parameterCount > 1 and ((info.Loader).CurrentResType == ResType.Live2D or (info.Loader).CurrentResType == ResType.Live2DWithRT) then
            (info.Animator):SetBool(action, true)
            ;
            ((FairyGUI.Timers).inst):Add(0.5, 1, function(...)
    -- function num : 0_42_2 , upvalues : _ENV, info, action
    if not (Util.IsNil)(info.Animator) then
      (info.Animator):SetBool(action, false)
    end
  end
)
          else
            ;
            (info.Animator):Play(action)
          end
          if (info.Loader).CurrentResType == ResType.Live2D or (info.Loader).CurrentResType == ResType.Live2DWithRT then
            if (Util.CheckNullString)(stay) then
              (info.Animator):SetBool("Stay", false)
              -- DECOMPILER ERROR at PC207: Confused about usage of register: R4 in 'UnsetPending'

              if info.AutoEyeBlink and (info.AutoEyeBlink).enabled then
                (info.AutoEyeBlink).enabled = false
              end
            else
              ;
              (info.Animator):SetBool("Stay", true)
              info.AutoEyeBlink = ((((info.Model).transform):GetChild(0)).gameObject):GetOrAddComponent(typeof(CubismAutoEyeBlinkInput))
              -- DECOMPILER ERROR at PC227: Confused about usage of register: R4 in 'UnsetPending'

              ;
              (info.AutoEyeBlink).enabled = true
              ;
              ((FairyGUI.Timers).inst):CallLater(function(arg, ...)
    -- function num : 0_42_3 , upvalues : _ENV, info
    if (Util.IsNil)(info.Model) then
      return 
    end
    info.EyeBlinkHelpTimer = (SimpleTimer.setTimeout)(((info.Animator):GetCurrentAnimatorStateInfo(0)).length, function(...)
      -- function num : 0_42_3_0 , upvalues : info
      -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

      (info.Animator).enabled = false
      info.EyeBlinkHelpTimer = nil
    end
)
  end
)
            end
          end
        end
      end
    else
      if (Util.CheckNullString)(action) and info.TalkAnimLayer ~= nil then
        if info.ExpType == PlotPlayRoleExpType.All then
          (SkeletonAnimationUtil.SetSkin)((info.Animator).gameObject, info.DefaultSkin)
        else
          ;
          (SkeletonAnimationUtil.RemoveExpression)((info.Animator).gameObject)
        end
        info.CurrentExpression = PlotPlayData.DefaultMotion
      end
    end
  end
end

PlotPlayPanelWindow.InitExpressionCtrl = function(roleInfo, ...)
  -- function num : 0_43 , upvalues : ResType, _ENV
  if (roleInfo.Loader).CurrentResType == ResType.Live2D and roleInfo.Model ~= nil then
    roleInfo.ExpCtrl = ((roleInfo.Model).transform):GetComponentInChildren(typeof(((((CS.Live2D).Cubism).Framework).Expression).CubismExpressionController))
    roleInfo.Expression = {}
    roleInfo.Pose = {}
    if roleInfo.ExpCtrl == nil then
      return 
    end
    local subCount = (((roleInfo.ExpCtrl).ExpressionsList).CubismExpressionObjects).Length
    for i = 0, subCount - 1 do
      -- DECOMPILER ERROR at PC53: Confused about usage of register: R6 in 'UnsetPending'

      if (((roleInfo.ExpCtrl).ExpressionsList).CubismExpressionObjects)[i] ~= nil then
        (roleInfo.Expression)[(((((roleInfo.ExpCtrl).ExpressionsList).CubismExpressionObjects)[i]).name):gsub(".exp3", "")] = i
      end
    end
    if (roleInfo.ExpCtrl).PoseList ~= nil then
      subCount = (((roleInfo.ExpCtrl).PoseList).CubismExpressionObjects).Length
      for i = 0, subCount - 1 do
        -- DECOMPILER ERROR at PC83: Confused about usage of register: R6 in 'UnsetPending'

        if (((roleInfo.ExpCtrl).PoseList).CubismExpressionObjects)[i] ~= nil then
          (roleInfo.Pose)[(((((roleInfo.ExpCtrl).PoseList).CubismExpressionObjects)[i]).name):gsub(".exp3", "")] = i
        end
      end
    end
  end
end

PlotPlayPanelWindow.InitAnim = function(roleInfo, ...)
  -- function num : 0_44 , upvalues : ResType, _ENV, SkeletonMecanim
  if roleInfo.Model == nil then
    return 
  end
  if (roleInfo.Loader).CurrentResType == ResType.Live2D then
    roleInfo.Animator = ((roleInfo.Model).transform):GetComponentInChildren(typeof((CS.UnityEngine).Animator))
  else
    if (roleInfo.Loader).CurrentResType == ResType.Spine then
      local sub = (roleInfo.Model):GetComponentInChildren(typeof(SkeletonMecanim))
      if sub ~= nil then
        roleInfo.AnimModel = sub.gameObject
      end
      if roleInfo.AnimModel == nil then
        (SkeletonAnimationUtil.SetAnimation)(roleInfo.Model, 0, BattleCardState.IDLE, true)
      else
        roleInfo.Animator = ((roleInfo.AnimModel).transform):GetComponentInChildren(typeof((CS.UnityEngine).Animator))
        if (roleInfo.Animator).layerCount > 2 then
          roleInfo.TalkAnimLayer = {}
          local count = (roleInfo.Animator).layerCount
          local layerName = nil
          for i = 0, count - 1 do
            layerName = (roleInfo.Animator):GetLayerName(i)
            -- DECOMPILER ERROR at PC76: Confused about usage of register: R8 in 'UnsetPending'

            ;
            (roleInfo.TalkAnimLayer)[layerName] = i
          end
        end
      end
    end
  end
end

PlotPlayPanelWindow.DealOneCharacter = function(roleInfo, targetPos, offset, show, func, delay, ...)
  -- function num : 0_45 , upvalues : _movingRole, ResType, _ENV, PlotPlayPanelWindow, _roleAnimDuration
  if roleInfo.Model == nil then
    if _movingRole[roleInfo.id] then
      _movingRole[roleInfo.id] = nil
    end
    if show == false and func ~= nil then
      func()
    end
    return false
  end
  local startPos = ((roleInfo.Loader).parent).xy
  if not delay then
    delay = 0
  end
  if offset == nil then
    offset = {X = 0, Y = 0}
  end
  local roleCom = nil
  if (offset.Special ~= PlotRoleSpecialInOutType.Special1 and show) or offset.Special ~= PlotRoleSpecialInOutType.Special2 and not show then
    roleCom = (PlotPlayPanelWindow.PrepareForRT)(roleInfo)
  end
  local complete = function(...)
    -- function num : 0_45_0 , upvalues : roleInfo, _movingRole, func
    roleInfo.InOutMove = nil
    if _movingRole[roleInfo.id] then
      _movingRole[roleInfo.id] = nil
    end
    if func ~= nil then
      func()
    end
  end

  local duration = nil
  -- DECOMPILER ERROR at PC69: Confused about usage of register: R10 in 'UnsetPending'

  if show then
    if offset.Special == PlotRoleSpecialInOutType.Special1 then
      ((roleInfo.Loader).parent).x = targetPos.x + (ResolutionHandler.AdaptOffset).X
      -- DECOMPILER ERROR at PC77: Confused about usage of register: R10 in 'UnsetPending'

      ;
      ((roleInfo.Loader).parent).y = targetPos.y + (ResolutionHandler.AdaptOffset).Y
      if _movingRole[roleInfo.id] then
        _movingRole[roleInfo.id] = nil
      end
    else
      duration = (PlotPlayPanelWindow.CharacterEnter)(roleInfo, offset, targetPos, roleCom, delay, complete)
    end
  else
    if offset.Special == PlotRoleSpecialInOutType.Special2 then
      complete()
    else
      duration = (PlotPlayPanelWindow.CharacterQuit)(roleInfo, offset, roleCom, delay, complete, startPos)
    end
  end
  if duration ~= nil and _roleAnimDuration < duration + delay then
    _roleAnimDuration = duration + delay
  end
  return true
end

PlotPlayPanelWindow.PrepareForRT = function(roleInfo, ...)
  -- function num : 0_46 , upvalues : _ENV, ResType, CubismRenderController, RTM_Ins, PlotPlayPanelWindow, Renderer
  if roleInfo.Model == nil then
    return 
  end
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (roleInfo.Loader).height = ResolutionHandler.Height
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (roleInfo.Loader).width = ResolutionHandler.Width
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((roleInfo.Loader).parent).xy = Vector2.zero
  local target = nil
  if (roleInfo.Loader).CurrentResType == ResType.Live2D then
    target = (((roleInfo.Model).transform):GetChild(0)):GetComponent(typeof(CubismRenderController))
    roleInfo.OriginColor = (roleInfo.Loader).TexColor
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (roleInfo.Loader).TexColor = ((CS.UnityEngine).Color).white
    RTM_Ins:ShowModelToLoader(roleInfo.Loader, ((roleInfo.Model).transform).gameObject, 1)
    ;
    (roleInfo.Loader):SetLive2DWithRT(target)
    ;
    (PlotPlayPanelWindow.ProcessModelWithRT)(roleInfo)
  else
    if (roleInfo.Loader).CurrentResType == ResType.Spine then
      target = ((roleInfo.Model).transform):GetComponent(typeof(Renderer))
      if (Util.IsNil)(target) then
        target = ((roleInfo.Model).transform):GetComponentInChildren(typeof(Renderer))
      end
      roleInfo.OriginColor = (roleInfo.Loader).TexColor
      -- DECOMPILER ERROR at PC94: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (roleInfo.Loader).TexColor = ((CS.UnityEngine).Color).white
      RTM_Ins:ShowModelToLoader(roleInfo.Loader, ((roleInfo.Model).transform).gameObject, 1)
      ;
      (roleInfo.Loader):SetSpineWithRT(target)
      ;
      (PlotPlayPanelWindow.ProcessModelWithRT)(roleInfo)
    end
  end
  return target
end

PlotPlayPanelWindow.ReleseFromRT = function(roleInfo, roleCom, ...)
  -- function num : 0_47 , upvalues : _originLoaderSize, _dialogueConfig, ResType, _ENV, RTM_Ins
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (roleInfo.Loader).size = _originLoaderSize
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  if roleInfo.id ~= not _dialogueConfig or _dialogueConfig.role_type and roleInfo.OriginColor ~= nil then
    (roleInfo.Loader).TexColor = roleInfo.OriginColor
  end
  if (roleInfo.Loader).CurrentResType == ResType.Live2DWithRT then
    (roleInfo.Loader):SetModelRender(roleCom)
  else
    if not (Util.IsNil)(roleInfo.Model) then
      (roleInfo.Loader):SetModelRender(roleCom, (roleInfo.Model).transform)
    end
  end
  RTM_Ins:ReleaseModelFromLoader(roleInfo.Loader, 1)
end

PlotPlayPanelWindow.CharacterEnter = function(roleInfo, offset, targetPos, roleCom, delay, complete, ...)
  -- function num : 0_48 , upvalues : _ENV, _moveSpeed, DEFAULT_ANIM_DURATION, _originLoaderSize, ResType, PlotPlayPanelWindow
  local duration = (math.sqrt)(offset.X * offset.X + offset.Y * offset.Y) / _moveSpeed
  if duration < DEFAULT_ANIM_DURATION then
    duration = DEFAULT_ANIM_DURATION
  end
  roleInfo.InOutMove = {}
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (roleInfo.InOutMove).StartMoveTimestamp = (LuaTime.GetTimeStamp)()
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (roleInfo.InOutMove).Duration = duration
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (roleInfo.InOutMove).RTStartPos = Vector3(targetPos.x + 0.5 * _originLoaderSize.x - offset.X, -targetPos.y - _originLoaderSize.y + offset.Y, 0)
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (roleInfo.InOutMove).RTEndPos = Vector3(targetPos.x + _originLoaderSize.x * 0.5, -targetPos.y - _originLoaderSize.y, 0)
  -- DECOMPILER ERROR at PC56: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (roleInfo.InOutMove).RTTargetPos = targetPos
  -- DECOMPILER ERROR at PC74: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (roleInfo.InOutMove).StartPos = Vector2(targetPos.x + (ResolutionHandler.AdaptOffset).X - offset.X, targetPos.y + (ResolutionHandler.AdaptOffset).Y - offset.Y)
  -- DECOMPILER ERROR at PC88: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (roleInfo.InOutMove).EndPos = Vector2(((roleInfo.InOutMove).StartPos).x + offset.X, ((roleInfo.InOutMove).StartPos).y + offset.Y)
  -- DECOMPILER ERROR at PC90: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (roleInfo.InOutMove).Delay = delay
  -- DECOMPILER ERROR at PC92: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (roleInfo.InOutMove).Complete = complete
  -- DECOMPILER ERROR at PC107: Confused about usage of register: R7 in 'UnsetPending'

  if (roleInfo.Loader).CurrentResType == ResType.Live2DWithRT or (roleInfo.Loader).CurrentResType == ResType.SpineWithRT then
    ((roleInfo.Model).transform).localPosition = (roleInfo.InOutMove).RTStartPos
    -- DECOMPILER ERROR at PC119: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (roleInfo.InOutMove).Tweener = ((FairyGUI.GTween).To)(((roleInfo.Model).transform).localPosition, (roleInfo.InOutMove).RTEndPos, duration)
    ;
    (((((roleInfo.InOutMove).Tweener):SetDelay(delay)):SetEase((FairyGUI.EaseType).Linear)):OnUpdate(function(...)
    -- function num : 0_48_0 , upvalues : roleInfo
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

    ((roleInfo.Model).transform).localPosition = (((roleInfo.InOutMove).Tweener).value).vec3
  end
)):OnComplete(function(...)
    -- function num : 0_48_1 , upvalues : PlotPlayPanelWindow, roleInfo, roleCom, targetPos, _ENV, complete
    (PlotPlayPanelWindow.ReleseFromRT)(roleInfo, roleCom)
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((roleInfo.Loader).parent).x = targetPos.x + (ResolutionHandler.AdaptOffset).X
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((roleInfo.Loader).parent).y = targetPos.y + (ResolutionHandler.AdaptOffset).Y
    complete()
  end
)
  else
    -- DECOMPILER ERROR at PC142: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((roleInfo.Loader).parent).x = ((roleInfo.InOutMove).StartPos).x
    -- DECOMPILER ERROR at PC148: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((roleInfo.Loader).parent).y = ((roleInfo.InOutMove).StartPos).y
    -- DECOMPILER ERROR at PC171: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (roleInfo.InOutMove).Tweener = ((((((roleInfo.Loader).parent):TweenMove((roleInfo.InOutMove).EndPos, duration)):SetDelay(delay)):SetEase((FairyGUI.EaseType).Linear)):OnUpdate(function(...)
    -- function num : 0_48_2 , upvalues : roleInfo
    (roleInfo.Loader):InvalidateBatchingState()
  end
)):OnComplete(complete)
  end
  -- DECOMPILER ERROR at PC176: Confused about usage of register: R7 in 'UnsetPending'

  if not offset.WithoutAlpha then
    (roleInfo.Loader).alpha = 0
    ;
    ((roleInfo.Loader):TweenFade(1, duration)):SetDelay(delay)
  else
    -- DECOMPILER ERROR at PC187: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (roleInfo.Loader).alpha = 1
  end
  return duration
end

PlotPlayPanelWindow.CharacterQuit = function(roleInfo, offset, roleCom, delay, complete, startPos, ...)
  -- function num : 0_49 , upvalues : _ENV, _moveSpeed, DEFAULT_ANIM_DURATION, _originLoaderSize, ResType, PlotPlayPanelWindow
  local duration = (math.sqrt)(offset.X * offset.X + offset.Y * offset.Y) / _moveSpeed
  if duration < DEFAULT_ANIM_DURATION then
    duration = DEFAULT_ANIM_DURATION
  end
  roleInfo.InOutMove = {}
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (roleInfo.InOutMove).StartMoveTimestamp = (LuaTime.GetTimeStamp)()
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (roleInfo.InOutMove).Duration = duration
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (roleInfo.InOutMove).RTStartPos = Vector3(startPos.x + 0.5 * _originLoaderSize.x - (ResolutionHandler.AdaptOffset).X, -startPos.y - _originLoaderSize.y + (ResolutionHandler.AdaptOffset).Y, 0)
  -- DECOMPILER ERROR at PC60: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (roleInfo.InOutMove).RTEndPos = Vector3(((roleInfo.InOutMove).RTStartPos).x + offset.X, ((roleInfo.InOutMove).RTStartPos).y - offset.Y, 0)
  -- DECOMPILER ERROR at PC65: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (roleInfo.InOutMove).StartPos = ((roleInfo.Loader).parent).xy
  -- DECOMPILER ERROR at PC79: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (roleInfo.InOutMove).EndPos = Vector2(((roleInfo.Loader).parent).x + offset.X, ((roleInfo.Loader).parent).y + offset.Y)
  -- DECOMPILER ERROR at PC81: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (roleInfo.InOutMove).Delay = delay
  -- DECOMPILER ERROR at PC83: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (roleInfo.InOutMove).Complete = complete
  -- DECOMPILER ERROR at PC98: Confused about usage of register: R7 in 'UnsetPending'

  if (roleInfo.Loader).CurrentResType == ResType.Live2DWithRT or (roleInfo.Loader).CurrentResType == ResType.SpineWithRT then
    ((roleInfo.Model).transform).localPosition = (roleInfo.InOutMove).RTStartPos
    -- DECOMPILER ERROR at PC110: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (roleInfo.InOutMove).Tweener = ((FairyGUI.GTween).To)(((roleInfo.Model).transform).localPosition, (roleInfo.InOutMove).RTEndPos, duration)
    ;
    (((((roleInfo.InOutMove).Tweener):SetDelay(delay)):SetEase((FairyGUI.EaseType).Linear)):OnUpdate(function(...)
    -- function num : 0_49_0 , upvalues : roleInfo
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

    ((roleInfo.Model).transform).localPosition = (((roleInfo.InOutMove).Tweener).value).vec3
  end
)):OnComplete(function(...)
    -- function num : 0_49_1 , upvalues : PlotPlayPanelWindow, roleInfo, roleCom, complete
    (PlotPlayPanelWindow.ReleseFromRT)(roleInfo, roleCom)
    if complete ~= nil then
      complete()
    end
  end
)
  else
    -- DECOMPILER ERROR at PC150: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (roleInfo.InOutMove).Tweener = ((((((roleInfo.Loader).parent):TweenMove((roleInfo.InOutMove).EndPos, duration)):SetDelay(delay)):SetEase((FairyGUI.EaseType).Linear)):OnUpdate(function(...)
    -- function num : 0_49_2 , upvalues : roleInfo
    (roleInfo.Loader):InvalidateBatchingState()
  end
)):OnComplete(complete)
  end
  -- DECOMPILER ERROR at PC155: Confused about usage of register: R7 in 'UnsetPending'

  if not offset.WithoutAlpha then
    (roleInfo.Loader).alpha = 1
    ;
    ((roleInfo.Loader):TweenFade(0, duration)):SetDelay(delay)
  end
  return duration
end

PlotPlayPanelWindow.ChangeSingleCharacterType = function(roleInfo, nonTexture, ...)
  -- function num : 0_50 , upvalues : _ENV, PlotPlayPanelWindow, _originLoaderSize, RTM_Ins
  if roleInfo.SkipChangeType then
    return 
  end
  if nonTexture then
    local config = ((TableData.gTable).BaseStoryRoleData)[roleInfo.id]
    if (PlotPlayPanelWindow.InitNonTextureRole)(config, roleInfo, true) then
      (PlotPlayPanelWindow.InitRoleInfo)(roleInfo)
      if roleInfo.InOutMove ~= nil then
        ((roleInfo.InOutMove).Tweener):Kill()
        local curPos = ((roleInfo.Loader).parent).xy
        do
          local color = (roleInfo.Loader).color
          -- DECOMPILER ERROR at PC38: Confused about usage of register: R5 in 'UnsetPending'

          ;
          (roleInfo.Loader).color = ((CS.UnityEngine).Color).white
          -- DECOMPILER ERROR at PC40: Confused about usage of register: R5 in 'UnsetPending'

          ;
          (roleInfo.Loader).TexColor = color
          -- DECOMPILER ERROR at PC42: Confused about usage of register: R5 in 'UnsetPending'

          ;
          (roleInfo.Loader).alpha = 1
          local roleCom = (PlotPlayPanelWindow.PrepareForRT)(roleInfo)
          local elapseTime = (LuaTime.GetTimeStamp)() - (roleInfo.InOutMove).StartMoveTimestamp
          do
            local startPos, endPos, delay, duration = nil, nil, nil, nil
            if elapseTime < (roleInfo.InOutMove).Delay then
              delay = (roleInfo.InOutMove).Delay - elapseTime
              startPos = (roleInfo.InOutMove).RTStartPos
              duration = (roleInfo.InOutMove).Duration
            else
              delay = 0
              duration = (roleInfo.InOutMove).Duration - (elapseTime - (roleInfo.InOutMove).Delay)
              local wholeDis = (roleInfo.InOutMove).EndPos - (roleInfo.InOutMove).StartPos
              local movedDis = curPos - (roleInfo.InOutMove).StartPos
              local percent = movedDis.magnitude / wholeDis.magnitude
              wholeDis = (roleInfo.InOutMove).RTEndPos - (roleInfo.InOutMove).RTStartPos
              startPos = (roleInfo.InOutMove).RTStartPos + (wholeDis) * percent
            end
            do
              endPos = (roleInfo.InOutMove).RTEndPos
              -- DECOMPILER ERROR at PC96: Confused about usage of register: R11 in 'UnsetPending'

              ;
              ((roleInfo.Model).transform).localPosition = startPos
              if duration < 0 then
                duration = 0
              end
              -- DECOMPILER ERROR at PC110: Confused about usage of register: R11 in 'UnsetPending'

              ;
              (roleInfo.InOutMove).Tweener = ((FairyGUI.GTween).To)(((roleInfo.Model).transform).localPosition, endPos, duration)
              ;
              (((((roleInfo.InOutMove).Tweener):SetDelay(delay)):SetEase((FairyGUI.EaseType).QuintOut)):OnUpdate(function(...)
    -- function num : 0_50_0 , upvalues : roleInfo
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

    ((roleInfo.Model).transform).localPosition = (((roleInfo.InOutMove).Tweener).value).vec3
  end
)):OnComplete(function(...)
    -- function num : 0_50_1 , upvalues : PlotPlayPanelWindow, roleInfo, roleCom, _ENV
    (PlotPlayPanelWindow.ReleseFromRT)(roleInfo, roleCom)
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

    if (roleInfo.InOutMove).RTTargetPos ~= nil then
      ((roleInfo.Loader).parent).x = ((roleInfo.InOutMove).RTTargetPos).x + (ResolutionHandler.AdaptOffset).X
      -- DECOMPILER ERROR at PC27: Confused about usage of register: R0 in 'UnsetPending'

      ;
      ((roleInfo.Loader).parent).y = ((roleInfo.InOutMove).RTTargetPos).y + (ResolutionHandler.AdaptOffset).Y
    end
    ;
    ((roleInfo.InOutMove).Complete)()
    roleInfo.InOutMove = nil
  end
)
            end
            if roleInfo.Model == nil then
              return 
            end
            local curPos = ((roleInfo.Model).transform).localPosition
            local config = ((TableData.gTable).BaseStoryRoleData)[roleInfo.id]
            if (PlotPlayPanelWindow.InitStaticRoleImg)(config, roleInfo, true) then
              (PlotPlayPanelWindow.InitRoleInfo)(roleInfo)
              if roleInfo.InOutMove ~= nil then
                ((roleInfo.InOutMove).Tweener):Kill()
                -- DECOMPILER ERROR at PC160: Confused about usage of register: R4 in 'UnsetPending'

                ;
                (roleInfo.Loader).size = _originLoaderSize
                RTM_Ins:ReleaseModelShareRT(roleInfo.Loader, 1)
                local elapseTime = (LuaTime.GetTimeStamp)() - (roleInfo.InOutMove).StartMoveTimestamp
                local startPos, endPos, delay, duration = nil, nil, nil, nil
                if elapseTime < (roleInfo.InOutMove).Delay then
                  delay = (roleInfo.InOutMove).Delay - elapseTime
                  startPos = (roleInfo.InOutMove).StartPos
                  duration = (roleInfo.InOutMove).Duration
                else
                  delay = 0
                  duration = (roleInfo.InOutMove).Duration - (elapseTime - (roleInfo.InOutMove).Delay)
                  local wholeDis = (roleInfo.InOutMove).RTEndPos - (roleInfo.InOutMove).RTStartPos
                  local movedDis = curPos - (roleInfo.InOutMove).RTStartPos
                  local percent = movedDis.magnitude / wholeDis.magnitude
                  wholeDis = (roleInfo.InOutMove).EndPos - (roleInfo.InOutMove).StartPos
                  startPos = (roleInfo.InOutMove).StartPos + (wholeDis) * percent
                end
                do
                  do
                    endPos = (roleInfo.InOutMove).EndPos
                    -- DECOMPILER ERROR at PC216: Confused about usage of register: R9 in 'UnsetPending'

                    ;
                    ((roleInfo.Loader).parent).xy = startPos
                    if duration < 0 then
                      duration = 0
                    end
                    -- DECOMPILER ERROR at PC242: Confused about usage of register: R9 in 'UnsetPending'

                    ;
                    (roleInfo.InOutMove).Tweener = ((((((roleInfo.Loader).parent):TweenMove(endPos, duration)):SetDelay(delay)):SetEase((FairyGUI.EaseType).QuintOut)):OnUpdate(function(...)
    -- function num : 0_50_2 , upvalues : roleInfo
    (roleInfo.Loader):InvalidateBatchingState()
  end
)):OnComplete((roleInfo.InOutMove).Complete)
                    -- DECOMPILER ERROR at PC245: Confused about usage of register: R4 in 'UnsetPending'

                    ;
                    (roleInfo.Loader).alpha = 1
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

PlotPlayPanelWindow.SetCharacterPos = function(roleInfo, arg, ...)
  -- function num : 0_51 , upvalues : _ENV, PlotPlayPanelWindow, _moveSpeed, _roleAnimDuration, _movingRole, ResType
  local startX = ((roleInfo.Loader).parent).x
  local startY = ((roleInfo.Loader).parent).y
  local args = split(arg, ":")
  local offset = {x = tonumber(args[1]) + (ResolutionHandler.AdaptOffset).X - startX, y = tonumber(args[2]) + (ResolutionHandler.AdaptOffset).Y - startY}
  roleInfo.CurrentScale = tonumber(args[3])
  if roleInfo.CurrentScale == nil then
    roleInfo.CurrentScale = 10000
  end
  if roleInfo.Model == nil then
    return 
  end
  local scale = (PlotPlayPanelWindow.GetCharacterScale)(roleInfo)
  if offset.x == 0 and offset.y == 0 and ((roleInfo.Model).transform).localScale == scale then
    return false
  end
  do
    if offset.x ~= 0 or offset.y ~= 0 then
      local duration = (math.abs)(offset.x) / _moveSpeed
      if _roleAnimDuration < duration then
        _roleAnimDuration = duration
      end
      ;
      ((((roleInfo.Loader).parent):TweenMove({x = ((roleInfo.Loader).parent).x + offset.x, y = ((roleInfo.Loader).parent).y + offset.y}, _roleAnimDuration)):SetEase((FairyGUI.EaseType).QuadInOut)):OnComplete(function(...)
    -- function num : 0_51_0 , upvalues : _movingRole, roleInfo
    if _movingRole[roleInfo.id] then
      _movingRole[roleInfo.id] = nil
    end
  end
)
    end
    if ((roleInfo.Model).transform).localScale ~= scale then
      if (roleInfo.Loader).CurrentResType == ResType.Texture then
        do
          if (((roleInfo.Model).transform).localScale).x ~= scale.x then
            local finalValue = (((roleInfo.Model).transform).localPosition).x - (scale.x - (((roleInfo.Model).transform).localScale).x) * (((roleInfo.Loader).image).texture).width * 0.5
            ;
            ((LeanTween.moveLocalX)(roleInfo.Model, finalValue, _roleAnimDuration)):setEaseInOutQuad()
          end
          do
            if (((roleInfo.Model).transform).localScale).y ~= scale.y then
              local finalValue = (((roleInfo.Model).transform).localPosition).y + (scale.y - (((roleInfo.Model).transform).localScale).y) * (((roleInfo.Loader).image).texture).height
              ;
              ((LeanTween.moveLocalY)(roleInfo.Model, finalValue, _roleAnimDuration)):setEaseInOutQuad()
            end
            ;
            (((LeanTween.scale)(roleInfo.Model, scale, _roleAnimDuration)):setEaseInOutQuad()):setOnComplete(function(...)
    -- function num : 0_51_1 , upvalues : _movingRole, roleInfo
    if _movingRole[roleInfo.id] then
      _movingRole[roleInfo.id] = nil
    end
  end
)
            return true
          end
        end
      end
    end
  end
end

PlotPlayPanelWindow.GetCharacterScale = function(info, ...)
  -- function num : 0_52 , upvalues : ResType, _ENV
  if (info.Loader).CurrentResType == ResType.Texture then
    return Vector3.one * (info.CurrentScale / 10000)
  else
    return info.orginModelScale * (info.CurrentScale / 10000)
  end
end

PlotPlayPanelWindow.ShowCurrentCharacter = function(...)
  -- function num : 0_53 , upvalues : PlotPlayPanelWindow, _currentRole, _roleConfig, _dialogueConfig, _ENV, _roleAnimDuration, _currentCharacters, uis
  (PlotPlayPanelWindow.SetCharacterName)()
  if _currentRole ~= nil and _roleConfig ~= nil and _currentRole.id == _roleConfig.id then
    (PlotPlayPanelWindow.ShowExpressionEffect)(_dialogueConfig)
    return 
  end
  do
    if _currentRole ~= nil then
      local _lastRole = _currentRole
      do
        ((LeanTween.value)(((_lastRole.Loader).color).r, (((CS.UnityEngine).Color).gray).r, _roleAnimDuration)):setOnUpdate(function(x, ...)
    -- function num : 0_53_0 , upvalues : _ENV, _lastRole
    local color = ((CS.UnityEngine).Color)(1, 1, 1) * x
    color.a = 1
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (_lastRole.Loader).color = color
  end
)
      end
    end
    if _roleConfig == nil then
      return 
    end
    _currentRole = _currentCharacters[_roleConfig.id]
    if _currentRole == nil then
      (PlotPlayPanelWindow.ShowExpressionEffect)(_dialogueConfig)
      return 
    end
    ;
    (uis.root):SetChildIndex((_currentRole.Loader).parent, (uis.root):GetChildIndex((uis.TalkWordGrp).root) - 1)
    ;
    (((LeanTween.value)(((_currentRole.Loader).color).r, (((CS.UnityEngine).Color).white).r, _roleAnimDuration)):setOnUpdate(function(x, ...)
    -- function num : 0_53_1 , upvalues : _currentRole, _ENV
    if _currentRole then
      local color = ((CS.UnityEngine).Color)(1, 1, 1) * x
      color.a = 1
      -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (_currentRole.Loader).color = color
    end
  end
)):setOnComplete(function(...)
    -- function num : 0_53_2 , upvalues : PlotPlayPanelWindow, _dialogueConfig
    (PlotPlayPanelWindow.ShowExpressionEffect)(_dialogueConfig)
  end
)
  end
end

PlotPlayPanelWindow.RecycleUnusedRole = function(recycleImmediately, callback, ...)
  -- function num : 0_54 , upvalues : _dialogueConfig, _ENV, PlotPlayPanelWindow, _currentCharacters, _quittingRole, _moveDelay
  if _dialogueConfig == nil then
    return 
  end
  local quitEffect = {}
  if not recycleImmediately then
    quitEffect = (PlotPlayData.GetRoleEffects)(_dialogueConfig.role_departure_type)
  end
  local Recycle = function(info, notRecycle, ...)
    -- function num : 0_54_0 , upvalues : callback, PlotPlayPanelWindow, _ENV
    if callback ~= nil then
      callback()
      callback = nil
    end
    ;
    (PlotPlayPanelWindow.ResetAnimator)(info)
    if not notRecycle then
      (Util.RecycleUIModel)(info.Loader)
      info.model = nil
      ;
      (PlotPlayPanelWindow.RecycleLoader)(info.Loader)
    end
  end

  -- DECOMPILER ERROR at PC28: Unhandled construct in 'MakeBoolean' P1

  if (_G.next)(_currentCharacters) == nil and (_G.next)(_quittingRole) == nil and callback ~= nil then
    callback()
  end
  if recycleImmediately then
    for k,v in pairs(_quittingRole) do
      if not (v.Info).Quitting then
        Recycle(v.Info)
      end
    end
  end
  do
    _quittingRole = {}
    do
      for k,v in pairs(_currentCharacters) do
        local value = v
        if recycleImmediately then
          Recycle(value)
          _currentCharacters[k] = nil
        else
          local notRecycle = quitEffect[k] ~= nil and (quitEffect[k]).Special == PlotRoleSpecialInOutType.Special2
          if not notRecycle then
            _currentCharacters[k] = nil
            _quittingRole[k] = {Info = v, NotRecycle = notRecycle}
          end
        end
      end
    end
    local runCallback = false
    do
      local delay = (PlotPlayData.GetRoleEffectDelay)(false, quitEffect, _quittingRole)
      for k,v in pairs(_quittingRole) do
        -- DECOMPILER ERROR at PC91: Confused about usage of register: R11 in 'UnsetPending'

        (v.Info).Quitting = true
      end
      -- DECOMPILER ERROR at PC115: Unhandled construct in 'MakeBoolean' P1

      if (PlotPlayPanelWindow.DealOneCharacter)(v.Info, nil, quitEffect[k], false, function(...)
    -- function num : 0_54_1 , upvalues : _quittingRole, k, Recycle, v
    _quittingRole[k] = nil
    Recycle(v.Info, v.NotRecycle)
  end
, (delay[k] or 0) * _moveDelay) or runCallback == false and callback ~= nil then
        callback()
        callback = nil
      end
      -- DECOMPILER ERROR: 6 unprocessed JMP targets
    end
  end
end

PlotPlayPanelWindow.ResetAnimator = function(info, ...)
  -- function num : 0_55 , upvalues : _ENV, ResType
  if info.EyeBlinkHelpTimer ~= nil then
    (info.EyeBlinkHelpTimer):stop()
  end
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  if (Util.IsNil)(info.Animator) == false then
    if (info.Animator).enabled == false then
      (info.Animator).enabled = true
    end
    if (info.Loader).CurrentResType == ResType.Live2D or (info.Loader).CurrentResType == ResType.Live2DWithRT then
      (info.Animator):SetBool("Stay", false)
    end
  end
end

PlotPlayPanelWindow.ShowSceneEffect = function(config, ...)
  -- function num : 0_56 , upvalues : _currentSceneEffect, PlotPlayPanelWindow
  _currentSceneEffect = (PlotPlayPanelWindow.ShowEffect)(config.scene_effect_path, config.scene_effect_position, _currentSceneEffect)
end

PlotPlayPanelWindow.ShowExpressionEffect = function(config, ...)
  -- function num : 0_57 , upvalues : _ENV, _currentCharType, CharacterType, _currentExpressionEffect, uis
  if (Util.StringIsNullOrEmpty)(config.expression_path) or _currentCharType == CharacterType.Texture then
    return 
  end
  local effects = split(config.expression_path, ",")
  local positions = split(config.expression_position, ",")
  local count = #effects
  local sceneEffect = {}
  local eachEffect, eachPosition, effect = nil, nil, nil
  for i = 1, count do
    eachEffect = effects[i]
    if positions[i] == nil then
      eachPosition = {0, 0}
    else
      eachPosition = split(positions[i], ":")
    end
    effect = (LuaEffect.AddUIEffect)(eachEffect, true)
    ;
    (table.insert)(_currentExpressionEffect, effect)
    ;
    (uis.root):AddChildAt(effect, (uis.root):GetChildIndex((uis.TalkWordGrp).root))
    effect.x = tonumber(eachPosition[1]) + (ResolutionHandler.AdaptOffset).X
    effect.y = tonumber(eachPosition[2]) + (ResolutionHandler.AdaptOffset).Y
  end
end

PlotPlayPanelWindow.ShowEffect = function(path, position, existsEffect, ...)
  -- function num : 0_58 , upvalues : _ENV, uis, PlotPlayPanelWindow
  if (Util.StringIsNullOrEmpty)(path) or (Util.StringIsNullOrEmpty)(position) then
    return {}
  end
  local effects = split(path or "", ",")
  local positions = split(position or "", ",")
  local count = #effects
  local sceneEffect = {}
  local eachEffect, eachPosition = nil, nil
  for i = 1, count do
    eachEffect = effects[i]
    if positions[i] == nil then
      eachPosition = {0, 0}
    else
      eachPosition = split(positions[i], ":")
    end
    if existsEffect[eachEffect] == nil then
      sceneEffect[eachEffect] = (LuaEffect.AddUIEffect)(eachEffect)
      ;
      (uis.root):AddChild(sceneEffect[eachEffect])
      if eachPosition[3] ~= nil and tonumber(eachPosition[3]) == 1 then
        (uis.root):SetChildIndex(sceneEffect[eachEffect], (uis.root):GetChildIndex((uis.TalkWordGrp).root))
      else
        if eachPosition[3] ~= nil and tonumber(eachPosition[3]) == 2 then
          (uis.root):SetChildIndex(sceneEffect[eachEffect], (uis.root):GetChildIndex(uis.backsceneLoader))
        else
          ;
          (uis.root):SetChildIndex(sceneEffect[eachEffect], (uis.root):GetChildIndex(uis.backsceneLoader) + 1)
        end
      end
    else
      sceneEffect[eachEffect] = existsEffect[eachEffect]
      existsEffect[eachEffect] = nil
    end
    -- DECOMPILER ERROR at PC116: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (sceneEffect[eachEffect]).x = tonumber(eachPosition[1]) + (ResolutionHandler.AdaptOffset).X
    -- DECOMPILER ERROR at PC125: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (sceneEffect[eachEffect]).y = tonumber(eachPosition[2]) + (ResolutionHandler.AdaptOffset).Y
  end
  ;
  (PlotPlayPanelWindow.RecycleEffect)(existsEffect)
  return sceneEffect
end

PlotPlayPanelWindow.RecycleEffect = function(effects, ...)
  -- function num : 0_59 , upvalues : _ENV
  if effects ~= nil then
    for k,v in pairs(effects) do
      v:Dispose()
      effects[k] = nil
    end
  end
end

PlotPlayPanelWindow.CheckChoiceStatue = function(...)
  -- function num : 0_60 , upvalues : _ENV, _dialogueConfig, _statue, PlotPlayStatue
  if (Util.CheckNullString)(_dialogueConfig.option_ids) then
    _statue = PlotPlayStatue.Normal
  else
    _statue = PlotPlayStatue.MakeChoice
  end
end

PlotPlayPanelWindow.SetChoiceStatue = function(show, ...)
  -- function num : 0_61 , upvalues : uis, PlotPlayPanelWindow
  if (uis.ChoiceList).visible == show then
    return 
  end
  if show then
    (PlotPlayPanelWindow.ShowChoice)()
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.ChoiceList).visible = show
  else
    if (uis.ChoiceList).AnimHide ~= nil then
      (uis.ChoiceList):AnimHide("out")
    else
      -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (uis.ChoiceList).visible = show
    end
  end
  ;
  (PlotPlayPanelWindow.ChangeSolidMaskStatus)(show)
end

PlotPlayPanelWindow.SetContent = function(...)
  -- function num : 0_62 , upvalues : uis, _dialogueConfig, _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.TalkWordGrp).talkTxt).text = _dialogueConfig.remark
  ;
  (LuaSound.PlaySound)(LuaSound.PLOT_CLICK, SoundBank.OTHER)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.TalkWordGrp).arowGrp).visible = false
end

PlotPlayPanelWindow.SetCharacterName = function(...)
  -- function num : 0_63 , upvalues : PlotPlayPanelWindow, _dialogueConfig, _roleConfig, uis
  (PlotPlayPanelWindow.ChangeRoleNameTxtStatus)(_dialogueConfig.type)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  if _roleConfig ~= nil then
    (((uis.TalkWordGrp).CardName_01_Grp).characternameTxt).text = _roleConfig.name
  end
end

PlotPlayPanelWindow.HandleSound = function(...)
  -- function num : 0_64 , upvalues : _dialogueConfig, _ENV, _audioDone, PlotPlayPanelWindow, _linesAudioId, _currentEffectId, _effectAudio, _afterLineComplete, _roleNameTxtStatue, PlotPlayRoleNameTxtStatus, _lineTimestamp
  if _dialogueConfig.bgm ~= 0 then
    (LuaSound.LoadAndPlayBGM)(_dialogueConfig.bgm)
  else
    ;
    (LuaSound.StopBGM)()
  end
  local callback = function(...)
    -- function num : 0_64_0 , upvalues : _audioDone, PlotPlayPanelWindow
    _audioDone = true
    ;
    (PlotPlayPanelWindow.AfterRoleCompleteTalk)()
  end

  if _linesAudioId ~= -1 then
    (PlotPlayPanelWindow.StopLineSound)()
  end
  _audioDone = false
  if _dialogueConfig.effect_sound ~= 0 and _currentEffectId ~= _dialogueConfig.effect_sound then
    _effectAudio = (LuaSound.LoadAndPlaySound)(_dialogueConfig.effect_sound)
    _currentEffectId = _dialogueConfig.effect_sound
  end
  _afterLineComplete = nil
  if (Util.GetPlayerSetting)(PlayerPrefsKeyName.CV_MUTE, "0") == "0" then
    if _roleNameTxtStatue == PlotPlayRoleNameTxtStatus.Left then
      local as = (PlotPlayPanelWindow.GetPlayerAudioReady)()
      _afterLineComplete = function(...)
    -- function num : 0_64_1 , upvalues : PlotPlayPanelWindow, callback, _linesAudioId
    (PlotPlayPanelWindow.AfterPlayerAudioFinish)()
    callback()
    _linesAudioId = -1
  end

      _lineTimestamp = (ActorData.GetServerTime)()
      _linesAudioId = (LuaSound.AudioMgrPlaySound)(tostring(_dialogueConfig.dialogue_sound), false, _afterLineComplete, as)
    else
      do
        _linesAudioId = (LuaSound.AudioMgrPlaySound)(tostring(_dialogueConfig.dialogue_sound), false, function(...)
    -- function num : 0_64_2 , upvalues : callback, _linesAudioId
    callback()
    _linesAudioId = -1
  end
)
        if _linesAudioId == -1 then
          callback()
        end
        callback()
      end
    end
  end
end

PlotPlayPanelWindow.GetPlayerAudioReady = function(...)
  -- function num : 0_65 , upvalues : _spineRoleTalking, _currentRole, ResType, _ENV
  local as = nil
  _spineRoleTalking = false
  if _currentRole ~= nil and _currentRole.Model ~= nil then
    if (_currentRole.Loader).CurrentResType == ResType.Live2D or (_currentRole.Loader).CurrentResType == ResType.Live2DWithRT then
      as = (_currentRole.Model):GetComponentInChildren(typeof((CS.UnityEngine).AudioSource))
    else
      if ((_currentRole.Loader).CurrentResType == ResType.Spine or (_currentRole.Loader).CurrentResType == ResType.SpineWithRT) and _currentRole.Animator ~= nil then
        _spineRoleTalking = true
        -- DECOMPILER ERROR at PC58: Unhandled construct in 'MakeBoolean' P1

        if _currentRole.TalkAnimLayer ~= nil and (_currentRole.TalkAnimLayer)[_currentRole.CurrentExpression] ~= nil then
          (_currentRole.Animator):SetLayerWeight((_currentRole.TalkAnimLayer)[_currentRole.CurrentExpression], 1)
          ;
          (_currentRole.Animator):Play("talk", (_currentRole.TalkAnimLayer)[_currentRole.CurrentExpression])
        end
      end
    end
  end
  ;
  (_currentRole.Animator):SetLayerWeight(1, 1)
  ;
  (_currentRole.Animator):Play("talk", 1)
  return as
end

PlotPlayPanelWindow.AfterPlayerAudioFinish = function(...)
  -- function num : 0_66 , upvalues : _spineRoleTalking, _currentRole
  if _spineRoleTalking and _currentRole ~= nil then
    -- DECOMPILER ERROR at PC20: Unhandled construct in 'MakeBoolean' P1

    if _currentRole.TalkAnimLayer ~= nil and (_currentRole.TalkAnimLayer)[_currentRole.CurrentExpression] ~= nil then
      (_currentRole.Animator):Play("stop_talk", (_currentRole.TalkAnimLayer)[_currentRole.CurrentExpression])
    end
    ;
    (_currentRole.Animator):Play("stop_talk", 1)
    ;
    (_currentRole.Animator):SetLayerWeight(1, 0)
    _spineRoleTalking = false
  end
end

PlotPlayPanelWindow.RemoveSound = function(stopLine, ...)
  -- function num : 0_67 , upvalues : PlotPlayPanelWindow, _effectAudio, _ENV, _dialogueConfig, _currentEffectId, _spineRoleTalking, _currentRole
  if stopLine then
    (PlotPlayPanelWindow.StopLineSound)()
    if _effectAudio ~= nil then
      (LuaSound.StopSound)(_effectAudio, (((CS.FMOD).Studio).STOP_MODE).ALLOWFADEOUT)
      _effectAudio = nil
    end
  else
    if _effectAudio ~= nil then
      local next = (TableData.GetBaseStoryDialogueData)(_dialogueConfig.next)
      if next == nil or next.effect_sound ~= _currentEffectId then
        (LuaSound.StopSound)(_effectAudio, (((CS.FMOD).Studio).STOP_MODE).ALLOWFADEOUT)
        _effectAudio = nil
      end
    end
  end
  do
    if _spineRoleTalking and _currentRole ~= nil and not (Util.IsNil)(_currentRole.Animator) then
      (_currentRole.Animator):Play("stop_talk", 1)
      ;
      (_currentRole.Animator):SetLayerWeight(1, 0)
      _spineRoleTalking = false
    end
  end
end

PlotPlayPanelWindow.StopLineSound = function(...)
  -- function num : 0_68 , upvalues : _linesAudioId, AudioMgr, _audioDone
  if _linesAudioId ~= -1 then
    AudioMgr:RemoveSound(_linesAudioId)
    _linesAudioId = -1
  end
  _audioDone = true
end

PlotPlayPanelWindow.ShowRoleShake = function(...)
  -- function num : 0_69 , upvalues : _ENV, _dialogueConfig, _currentCharacters, _shaking
  if (Util.StringIsNullOrEmpty)(_dialogueConfig.role_shake) or _dialogueConfig.role_shake == "0" then
    return 
  end
  local roleInfos = split(_dialogueConfig.role_shake, ",")
  local count = #roleInfos
  for i = 1, count do
    local index = i
    do
      local eachInfo = split(roleInfos[i], ":")
      if _currentCharacters[tonumber(eachInfo[1])] ~= nil then
        _shaking = true
      end
      ;
      (SimpleTimer.setTimeout)(tonumber(eachInfo[3]) or 0, function(...)
    -- function num : 0_69_0 , upvalues : _currentCharacters, _ENV, eachInfo, index, _shaking
    if _currentCharacters[tonumber(eachInfo[1])] ~= nil then
      (Util.Shake)((_currentCharacters[tonumber(eachInfo[1])]).Loader, tonumber(eachInfo[2]), 5, 1, function(...)
      -- function num : 0_69_0_0 , upvalues : index, _shaking
      if index == 1 then
        _shaking = false
      end
    end
)
    end
  end
)
    end
  end
end

PlotPlayPanelWindow.ShowTypingEffect = function(...)
  -- function num : 0_70 , upvalues : _typingEffect
  _typingEffect:PrintAll(0.04, 0.6)
end

PlotPlayPanelWindow.ShowChoice = function(...)
  -- function num : 0_71 , upvalues : _choices, _ENV, _dialogueConfig, uis
  _choices = split(_dialogueConfig.option_ids, ":")
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.ChoiceList).numItems = #_choices
end

PlotPlayPanelWindow.RefreshChoiceItem = function(index, item, ...)
  -- function num : 0_72 , upvalues : _ENV, _choices, _firstChoice, PlotPlayPanelWindow
  local config = ((TableData.gTable).BaseStoryOptionData)[tonumber(_choices[index + 1])]
  if index == 0 then
    _firstChoice = tonumber(config.next)
  end
  ;
  (item:GetChild("ChoiceTxt")).text = config.remark
  ;
  (item.onClick):Clear()
  item.touchable = true
  ;
  (item.onClick):Add(function(...)
    -- function num : 0_72_0 , upvalues : item, PlotPlayPanelWindow, _ENV, config
    item.touchable = false
    ;
    (PlotPlayPanelWindow.SetChoiceStatue)(false)
    ;
    (PlotPlayMgr.AfterDialogueShowed)(tonumber(config.next))
  end
)
end

PlotPlayPanelWindow.RecycleAllRes = function(...)
  -- function num : 0_73 , upvalues : uis, _ENV, PlotPlayPanelWindow, _currentSceneEffect, _currentCharacters
  if (uis.backsceneLoader).texture ~= nil then
    (ResHelper.UnloadTexture)(((uis.backsceneLoader).texture).nativeTexture)
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.backsceneLoader).texture = nil
    if BattleRoot ~= nil then
      BattleRoot:SetActive(true)
    end
    UIMgr:ShowBelowWindow("PlotPlayPanelWindow")
  end
  ;
  (PlotPlayPanelWindow.RecycleEffect)(_currentSceneEffect)
  ;
  (PlotPlayPanelWindow.RecycleUnusedRole)(true)
  _currentCharacters = {}
end

PlotPlayPanelWindow.ChangeMaskStatus = function(component1, component2, show, ...)
  -- function num : 0_74
  component1.visible = show
  component2.visible = show
end

PlotPlayPanelWindow.ShowAside = function(callback, ...)
  -- function num : 0_75 , upvalues : _ENV, PlotPlayPanelWindow, uis
  if (Util.StringIsNullOrEmpty)((PlotPlayData.CurrentChapterDataConfig).aside_content) == false then
    (PlotPlayPanelWindow.ShowBlackBg)()
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.CutGrp).WordTxt).alpha = 0
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.CutGrp).WordTxt).text = (PlotPlayData.CurrentChapterDataConfig).aside_content
    ;
    (((uis.CutGrp).WordTxt):TweenFade(1, 0.5)):OnComplete(function(...)
    -- function num : 0_75_0 , upvalues : _ENV, uis, callback
    (SimpleTimer.setTimeout)(2, function(...)
      -- function num : 0_75_0_0 , upvalues : uis, callback
      (((uis.CutGrp).WordTxt):TweenFade(0, 0.5)):OnComplete(function(...)
        -- function num : 0_75_0_0_0 , upvalues : uis, callback
        -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

        ((uis.CutGrp).WordTxt).text = ""
        callback()
      end
)
    end
)
  end
)
  else
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.CutGrp).WordTxt).text = ""
    callback()
  end
end

PlotPlayPanelWindow.ResetBackground = function(...)
  -- function num : 0_76 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.backsceneLoader).pivot = Vector2(0, 0)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.backsceneLoader).x = 0
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.backsceneLoader).y = 0
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.backsceneLoader).scale = Vector2.one
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.backsceneLoader).alpha = 1
end

PlotPlayPanelWindow.SetBackground = function(callback, ...)
  -- function num : 0_77 , upvalues : _ENV, PlotPlayPanelWindow, _bgMask, uis
  if (Util.StringIsNullOrEmpty)((PlotPlayData.CurrentChapterDataConfig).name) == false then
    (PlotPlayPanelWindow.ShowBlackBg)()
  end
  if (Util.CheckNullString)((PlotPlayData.CurrentChapterDataConfig).scene_path) then
    _bgMask.visible = false
    if callback ~= nil then
      callback()
    end
  else
    local texture = (ResHelper.LoadTexture)((PlotPlayData.CurrentChapterDataConfig).scene_path)
    if texture ~= nil then
      _bgMask.visible = true
      -- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (uis.backsceneLoader).texture = (FairyGUI.NTexture)(texture)
      UIMgr:HideBelowWindow("PlotPlayPanelWindow")
      if BattleRoot ~= nil then
        BattleRoot:SetActive(false)
      end
    end
    if callback ~= nil then
      callback()
    end
  end
end

PlotPlayPanelWindow.ShowBGEnter = function(callback, ...)
  -- function num : 0_78 , upvalues : PlotPlayPanelWindow, _bgAnimPlaying, _bgMask, _ENV, uis
  (PlotPlayPanelWindow.ChangeUIStatus)(false, true)
  _bgAnimPlaying = true
  local needReset = false
  if _bgMask.visible then
    _bgMask.visible = false
    needReset = true
  end
  ;
  (PlotPlayPanelWindow.RecycleUnusedRole)(true)
  local config = (TableData.GetBaseStoryDialogueData)(PlotPlayData.CurrentDialogueID)
  ;
  (PlotPlayPanelWindow.PreLoadSceneEffect)(config)
  ;
  (PlotPlayPanelWindow.PreLoadCharacter)(config)
  local enterEffectsInfo = split((PlotPlayData.CurrentChapterDataConfig).admission_type, ",")
  local enterEffect = {}
  local count = #enterEffectsInfo
  for i = 1, count do
    enterEffect[i] = split(enterEffectsInfo[i], ":")
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R10 in 'UnsetPending'

    if tonumber((enterEffect[i])[1]) == PlotPlayBGEffect.Zoom then
      (uis.backsceneLoader).pivot = Vector2(0.5, 0.5)
      local scale = tonumber((enterEffect[i])[2])
      if scale == nil then
        scale = 2
      end
      -- DECOMPILER ERROR at PC68: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (uis.backsceneLoader).scale = Vector2.one * scale
    end
  end
  ;
  (PlotPlayPanelWindow.ShowSingleBGEffect)(true, enterEffect, 1, function(...)
    -- function num : 0_78_0 , upvalues : _bgAnimPlaying, needReset, _bgMask, PlotPlayPanelWindow, callback
    _bgAnimPlaying = false
    if needReset then
      _bgMask.visible = true
    end
    ;
    (PlotPlayPanelWindow.ChangeUIStatus)(true, false, true)
    if callback ~= nil then
      callback()
    end
  end
)
end

PlotPlayPanelWindow.PreLoadSceneEffect = function(config, ...)
  -- function num : 0_79 , upvalues : PlotPlayPanelWindow
  (PlotPlayPanelWindow.ShowSceneEffect)(config)
end

PlotPlayPanelWindow.PreLoadCharacter = function(config, ...)
  -- function num : 0_80 , upvalues : _ENV, _currentCharacters, PlotPlayPanelWindow, _currentRole, _roleConfig
  local enterEffect = (PlotPlayData.GetRoleEffects)(config.role_admission_type)
  local charPos = (split(config.position, ","))
  -- DECOMPILER ERROR at PC8: Overwrote pending register: R3 in 'AssignReg'

  local expression = .end
  if (Util.StringIsNullOrEmpty)(config.expression) then
    expression = {}
  else
    expression = split(config.expression, ":")
  end
  local action = nil
  if (Util.StringIsNullOrEmpty)(config.action) then
    action = {}
  else
    action = split(config.action, ":")
  end
  local stay = nil
  if (Util.StringIsNullOrEmpty)(config.action_type) then
    stay = {}
  else
    stay = split(config.action_type, ":")
  end
  for k,v in pairs(enterEffect) do
    if config.role_type == k then
      do
        _currentCharacters[k] = (PlotPlayPanelWindow.LoadNewCharacter)(((TableData.gTable).BaseStoryRoleData)[k], charPos[v.Index], v, v.Special ~= PlotRoleSpecialInOutType.Special1)
        if config.role_type == k then
          _currentRole = _currentCharacters[k]
          _roleConfig = ((TableData.gTable).BaseStoryRoleData)[config.role_type]
        end
        ;
        (PlotPlayPanelWindow.SetCharacterExpressionAndMotion)(_currentCharacters[k], expression[v.Index], action[v.Index], stay[v.Index])
        -- DECOMPILER ERROR at PC97: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC97: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

PlotPlayPanelWindow.ShowSingleBGEffect = function(enter, effects, index, callback, keep, ...)
  -- function num : 0_81 , upvalues : PlotPlayPanelWindow, _ENV, _solidMask, _transitionalMask, uis, DEFAULT_WHITE_SCREEN_DURATION, _transitionEffect, _roleLoaders
  if #effects < index then
    if callback ~= nil then
      callback()
    end
    return 
  end
  local finishCallback = function(...)
    -- function num : 0_81_0 , upvalues : PlotPlayPanelWindow, enter, effects, index, callback, keep
    (PlotPlayPanelWindow.ShowSingleBGEffect)(enter, effects, index + 1, callback, keep)
  end

  local effect = effects[index]
  local effectType = tonumber(effect[1])
  if effectType == PlotPlayBGEffect.LinearMove then
    _solidMask.color = ((CS.UnityEngine).Color).black
    if not enter then
      (PlotPlayPanelWindow.ChangeSolidMaskStatus)(false)
    end
    local effectDir = tonumber(effect[2])
    do
      if not enter and (PlotPlayData.HaveNextPlot)() == false and index == #effects then
        (PlotPlayPanelWindow.SetMaskDirection)(false, effectDir)
        ;
        (PlotPlayPanelWindow.MaskLinearMove)(effectDir, false, _solidMask, _transitionalMask, function(...)
    -- function num : 0_81_1 , upvalues : keep, finishCallback, uis, PlotPlayPanelWindow, effectDir, _solidMask, _transitionalMask
    if keep then
      finishCallback()
      return 
    end
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.backsceneLoader).visible = false
    ;
    (PlotPlayPanelWindow.ChangeUIStatus)(false)
    ;
    (PlotPlayPanelWindow.RecycleAllRes)()
    ;
    (PlotPlayPanelWindow.SetMaskDirection)(true, effectDir)
    ;
    (PlotPlayPanelWindow.MaskLinearMove)(effectDir, true, _solidMask, _transitionalMask, finishCallback)
  end
)
      else
        ;
        (PlotPlayPanelWindow.SetMaskDirection)(enter, effectDir)
        ;
        (PlotPlayPanelWindow.MaskLinearMove)(effectDir, enter, _solidMask, _transitionalMask, finishCallback)
      end
    end
  else
  end
  do
    -- DECOMPILER ERROR at PC79: Confused about usage of register: R8 in 'UnsetPending'

    if effectType ~= PlotPlayBGEffect.Rotate or effectType == PlotPlayBGEffect.Zoom then
      (uis.backsceneLoader).pivot = Vector2(0.5, 0.5)
      local scale = tonumber(effect[2])
      if scale == nil then
        scale = 2
      end
      -- DECOMPILER ERROR at PC92: Confused about usage of register: R9 in 'UnsetPending'

      if enter then
        (uis.backsceneLoader).scale = Vector2.one * scale
        ;
        ((uis.backsceneLoader):TweenScale(Vector2.one, tonumber(effect[3]))):OnComplete(function(...)
    -- function num : 0_81_2 , upvalues : uis, _ENV, effect, finishCallback
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

    (uis.backsceneLoader).pivot = Vector2.zero
    if effect[4] == nil or tonumber(effect[4]) == 0 then
      finishCallback()
    end
  end
)
        if effect[4] ~= nil and tonumber(effect[4]) == 1 then
          finishCallback()
        end
      else
        -- DECOMPILER ERROR at PC118: Confused about usage of register: R9 in 'UnsetPending'

        ;
        (uis.backsceneLoader).scale = Vector2.one
        ;
        ((uis.backsceneLoader):TweenScale(Vector2.one * scale, tonumber(effect[3]))):OnComplete(function(...)
    -- function num : 0_81_3 , upvalues : uis, _ENV, effect, finishCallback
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

    (uis.backsceneLoader).pivot = Vector2.zero
    if effect[4] == nil or tonumber(effect[4]) == 0 then
      finishCallback()
    end
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.backsceneLoader).scale = Vector2.one
  end
)
        if effect[4] ~= nil and tonumber(effect[4]) == 1 then
          finishCallback()
        end
      end
    else
      do
        if effectType == PlotPlayBGEffect.Fade then
          _solidMask.color = ((CS.UnityEngine).Color).black
          if enter then
            (PlotPlayPanelWindow.ResetSolidMask)()
            _solidMask.visible = true
            _solidMask.alpha = 1
            ;
            (_solidMask:TweenFade(0, DEFAULT_WHITE_SCREEN_DURATION)):OnComplete(function(...)
    -- function num : 0_81_4 , upvalues : PlotPlayPanelWindow, _solidMask, finishCallback
    (PlotPlayPanelWindow.ResetSolidMask)()
    _solidMask.visible = false
    finishCallback()
  end
)
          else
            ;
            (PlotPlayPanelWindow.ShowBlackBg)()
            _solidMask.alpha = 0
            ;
            (_solidMask:TweenFade(1, DEFAULT_WHITE_SCREEN_DURATION)):OnComplete(finishCallback)
          end
        else
          if effectType == PlotPlayBGEffect.Effect then
            _transitionEffect = (LuaEffect.AddUIEffect)(effect[2])
            _transitionEffect:SetXY(ResolutionHandler.Width / 2, ResolutionHandler.Height / 2)
            ;
            (uis.root):AddChild(_transitionEffect)
            if effect[5] ~= nil and tonumber(effect[5]) == 1 then
              (PlotPlayPanelWindow.ChangeUIStatus)(false, true)
              for k,v in pairs(_roleLoaders) do
                -- DECOMPILER ERROR at PC217: Confused about usage of register: R13 in 'UnsetPending'

                (v.Loader).visible = false
              end
            end
            do
              ;
              (SimpleTimer.setTimeout)(tonumber(effect[3]), function(...)
    -- function num : 0_81_5 , upvalues : _ENV, _roleLoaders, finishCallback, effect, uis, _transitionEffect, _transitionalMask
    for k,v in pairs(_roleLoaders) do
      -- DECOMPILER ERROR at PC5: Confused about usage of register: R5 in 'UnsetPending'

      (v.Loader).visible = true
    end
    finishCallback()
    if effect[4] ~= nil and tonumber(effect[4]) == 1 then
      (uis.root):SetChildIndex(_transitionEffect, (uis.root):GetChildIndex((uis.TalkWordGrp).root))
    else
      ;
      (uis.root):SetChildIndex(_transitionEffect, (uis.root):GetChildIndex(_transitionalMask) - 2)
    end
  end
)
              if effectType == PlotPlayBGEffect.WhiteScreen then
                if not enter and (PlotPlayData.HaveNextPlot)() == false and index == #effects then
                  (PlotPlayPanelWindow.ShowWhiteScreenEffect)(enter, function(...)
    -- function num : 0_81_6 , upvalues : enter, _transitionEffect, PlotPlayPanelWindow, callback
    if not enter and _transitionEffect ~= nil then
      _transitionEffect:Dispose()
      _transitionEffect = nil
    end
    ;
    (PlotPlayPanelWindow.ShowWhiteScreenEffect)(true, callback)
  end
)
                else
                  ;
                  (PlotPlayPanelWindow.ShowWhiteScreenEffect)(enter, function(...)
    -- function num : 0_81_7 , upvalues : enter, _transitionEffect, callback
    if not enter and _transitionEffect ~= nil then
      _transitionEffect:Dispose()
      _transitionEffect = nil
    end
    if callback ~= nil then
      callback()
    end
  end
)
                end
              else
                if callback ~= nil then
                  callback()
                end
              end
            end
          end
        end
      end
    end
  end
end

PlotPlayPanelWindow.ResetSolidMask = function(...)
  -- function num : 0_82 , upvalues : _solidMask, _originSolidMaskSize
  _solidMask.width = _originSolidMaskSize.x
  _solidMask.height = _originSolidMaskSize.y
  _solidMask.rotation = 0
  _solidMask.x = _originSolidMaskSize.x * 0.5
  _solidMask.y = _originSolidMaskSize.y * 0.5
  _solidMask.alpha = 1
end

PlotPlayPanelWindow.ChangeSolidMaskStatus = function(showChoice, ...)
  -- function num : 0_83 , upvalues : uis, _solidMask, PlotPlayPanelWindow, _transitionalMask
  if showChoice then
    (uis.root):SetChildIndex(_solidMask, (uis.root):GetChildIndex(uis.ChoiceList))
    ;
    (PlotPlayPanelWindow.ResetSolidMask)()
    _solidMask.alpha = 0.5
    _solidMask.visible = true
  else
    ;
    (uis.root):SetChildIndex(_solidMask, (uis.root):GetChildIndex(_transitionalMask) - 1)
    _solidMask.alpha = 1
    _solidMask.visible = false
  end
end

PlotPlayPanelWindow.ShowBGQuit = function(callback, keep, recycleRole, ...)
  -- function num : 0_84 , upvalues : _bgAnimPlaying, _ENV, _dialogueConfig, PlotPlayPanelWindow, _bgMask
  _bgAnimPlaying = true
  if (PlotPlayData.CheckNextPlotBGM)(_dialogueConfig.bgm) then
    (LuaSound.StopBGM)()
  end
  ;
  (PlotPlayPanelWindow.RemoveSound)(true)
  local needReset = false
  if _bgMask.visible then
    _bgMask.visible = false
    needReset = true
  end
  if not (Util.CheckNullString)((PlotPlayData.CurrentChapterDataConfig).effect_sound) then
    local quitEffectSound = split((PlotPlayData.CurrentChapterDataConfig).effect_sound, ",")
    do
      local count = #quitEffectSound
      local info, id, delay = nil, nil, nil
      for i = 1, count do
        info = split(quitEffectSound[i], ":")
        id = tonumber(info[1])
        delay = tonumber(info[2])
        if delay == 0 then
          quitEffectSound[id] = {Sound = (LuaSound.LoadAndPlaySound)(id)}
        else
          quitEffectSound[id] = {Timer = (SimpleTimer.setTimeout)(delay, function(...)
    -- function num : 0_84_0 , upvalues : quitEffectSound, id, _ENV
    quitEffectSound[id] = {Sound = (LuaSound.LoadAndPlaySound)(id)}
  end
)}
        end
      end
    end
  end
  do
    local enterEffectsInfo = split((PlotPlayData.CurrentChapterDataConfig).departure_type or "", ",")
    local enterEffect = {}
    count = #enterEffectsInfo
    for i = 1, count do
      enterEffect[i] = split(enterEffectsInfo[i], ":")
    end
    ;
    (PlotPlayPanelWindow.ShowSingleBGEffect)(false, enterEffect, 1, function(...)
    -- function num : 0_84_1 , upvalues : _bgAnimPlaying, _ENV, keep, PlotPlayPanelWindow, needReset, _bgMask, callback
    _bgAnimPlaying = false
    if (PlotPlayData.HaveNextPlot)() and not keep then
      (PlotPlayPanelWindow.RecycleAllRes)()
    end
    if needReset then
      _bgMask.visible = true
    end
    callback()
  end
, keep)
  end
end

PlotPlayPanelWindow.ShowBlackBg = function(...)
  -- function num : 0_85 , upvalues : PlotPlayPanelWindow, _solidMask
  (PlotPlayPanelWindow.ResetSolidMask)()
  _solidMask.visible = true
end

PlotPlayPanelWindow.SetMaskDirection = function(enter, direction, ...)
  -- function num : 0_86 , upvalues : _ENV, _transitionalMask, _solidMask, PlotPlayPanelWindow, _originSolidMaskSize, TRANISITION_MASK_MODIFIER, MASK_GAP_FIXER
  ((FairyGUI.GTween).Kill)(_transitionalMask)
  ;
  ((FairyGUI.GTween).Kill)(_solidMask)
  ;
  (PlotPlayPanelWindow.ChangeMaskStatus)(_solidMask, _transitionalMask, true)
  if direction == PlotPlayBGDirection.LeftToRight then
    _solidMask.width = _originSolidMaskSize.x
    _solidMask.height = _originSolidMaskSize.y
    _solidMask.rotation = 0
    _transitionalMask.width = _solidMask.width * TRANISITION_MASK_MODIFIER
    _transitionalMask.height = _solidMask.height
    _transitionalMask.y = _solidMask.height * 0.5
    _transitionalMask.x = -_transitionalMask.width * 0.5
    if enter then
      _transitionalMask.rotation = 180
      _transitionalMask.x = _transitionalMask.x + MASK_GAP_FIXER
      _solidMask.x = _originSolidMaskSize.x * 0.5
      _solidMask.y = _originSolidMaskSize.y * 0.5
    else
      _transitionalMask.rotation = 0
      _solidMask.x = -(_transitionalMask.width + _solidMask.width * 0.5 - MASK_GAP_FIXER)
      _solidMask.y = _solidMask.height * 0.5
    end
  else
    if direction == PlotPlayBGDirection.TopToBottom then
      _solidMask.width = _originSolidMaskSize.x
      _solidMask.height = _originSolidMaskSize.y
      _solidMask.rotation = 0
      _transitionalMask.width = _solidMask.height * TRANISITION_MASK_MODIFIER
      _transitionalMask.height = _solidMask.width
      _transitionalMask.x = _solidMask.width * 0.5
      _transitionalMask.y = -_transitionalMask.width * 0.5
      if enter then
        _transitionalMask.rotation = -90
        _transitionalMask.y = _transitionalMask.y - MASK_GAP_FIXER
        _solidMask.x = _originSolidMaskSize.x * 0.5
        _solidMask.y = _originSolidMaskSize.y * 0.5
      else
        _transitionalMask.rotation = 90
        _solidMask.x = _solidMask.width * 0.5
        _solidMask.y = -(_transitionalMask.width + _solidMask.height * 0.5 - MASK_GAP_FIXER)
      end
    else
      if direction == PlotPlayBGDirection.LeftTopToRightBottom then
        _solidMask.width = (math.sqrt)(_originSolidMaskSize.x * _originSolidMaskSize.x + _originSolidMaskSize.y * _originSolidMaskSize.y)
        _solidMask.height = _solidMask.width
        _solidMask.rotation = -(math.atan)(_originSolidMaskSize.y / _originSolidMaskSize.x) * 180 / math.pi
        _transitionalMask.width = _solidMask.height * TRANISITION_MASK_MODIFIER
        _transitionalMask.height = _solidMask.width
        if enter then
          _solidMask.x = _originSolidMaskSize.x * 0.5
          _solidMask.y = _originSolidMaskSize.y * 0.5
          _transitionalMask.rotation = _solidMask.rotation - 90
          local triHeight = _transitionalMask.width * 0.5 + _solidMask.height * 0.5
          local triWidth = _solidMask.height * 0.5
          local angle = -(math.atan)(triHeight / triWidth) * 180 / math.pi
          local length = (math.sqrt)(triHeight * triHeight + triWidth * triWidth)
          angle = 180 - angle - _solidMask.rotation
          _transitionalMask.x = -(math.cos)((angle) * math.pi / 180) * length + MASK_GAP_FIXER
          _transitionalMask.y = -((math.abs)((math.sin)((angle) * math.pi / 180) * length) - _originSolidMaskSize.y) + MASK_GAP_FIXER
        else
          do
            _transitionalMask.rotation = _solidMask.rotation + 90
            local angle = 90 - (math.abs)(_solidMask.rotation)
            local sin = (math.sin)(angle * math.pi / 180)
            local cos = (math.cos)(angle * math.pi / 180)
            local length = _solidMask.height * 0.5 + _transitionalMask.width * 0.5
            local triWidth = cos * length
            local triHeight = sin * length
            _transitionalMask.x = _originSolidMaskSize.x * 0.5 - triWidth
            _transitionalMask.y = _originSolidMaskSize.y * 0.5 - triHeight
            length = _solidMask.height + _transitionalMask.width
            triWidth = cos * (length)
            triHeight = sin * (length)
            _solidMask.x = _originSolidMaskSize.x * 0.5 - triWidth + MASK_GAP_FIXER
            _solidMask.y = _originSolidMaskSize.y * 0.5 - triHeight + MASK_GAP_FIXER
          end
        end
      end
    end
  end
end

PlotPlayPanelWindow.MaskLinearMove = function(direction, enter, component1, component2, callback, quitMove, ...)
  -- function num : 0_87 , upvalues : _ENV, PlotPlayPanelWindow, MASK_GAP_FIXER, MASK_MOVE_DURATION, MASK_MOVE_PHASE_1
  local done = function(...)
    -- function num : 0_87_0 , upvalues : _ENV, PlotPlayPanelWindow, component1, component2, callback
    (SimpleTimer.setTimeout)(0.1, function(...)
      -- function num : 0_87_0_0 , upvalues : PlotPlayPanelWindow, component1, component2, callback
      (PlotPlayPanelWindow.ChangeMaskStatus)(component1, component2, false)
      if callback ~= nil then
        callback()
      end
    end
)
  end

  if direction == PlotPlayBGDirection.LeftToRight then
    local distance = component1.width + component2.width - MASK_GAP_FIXER
    do
      (((component1:TweenMoveX(component1.x + distance, MASK_MOVE_DURATION)):SetEase((FairyGUI.EaseType).Linear)):OnUpdate(function(...)
    -- function num : 0_87_1 , upvalues : component1
    component1:InvalidateBatchingState()
  end
)):OnComplete(done)
      ;
      ((component2:TweenMoveX(component2.x + distance, MASK_MOVE_DURATION)):SetEase((FairyGUI.EaseType).Linear)):OnUpdate(function(...)
    -- function num : 0_87_2 , upvalues : component2
    component2:InvalidateBatchingState()
  end
)
    end
  else
    do
      if direction == PlotPlayBGDirection.TopToBottom then
        local distance = component1.height + component2.width - MASK_GAP_FIXER
        ;
        (((component1:TweenMoveY(component1.y + distance, MASK_MOVE_DURATION)):SetEase((FairyGUI.EaseType).Linear)):OnUpdate(function(...)
    -- function num : 0_87_3 , upvalues : component1
    component1:InvalidateBatchingState()
  end
)):OnComplete(done)
        ;
        ((component2:TweenMoveY(component2.y + distance, MASK_MOVE_DURATION)):SetEase((FairyGUI.EaseType).Linear)):OnUpdate(function(...)
    -- function num : 0_87_4 , upvalues : component2
    component2:InvalidateBatchingState()
  end
)
      else
        do
          if direction == PlotPlayBGDirection.LeftTopToRightBottom then
            local distance = (component1.xy - component2.xy).normalized * (component1.width + component2.width)
            if not enter then
              distance = -distance
            end
            ;
            ((component1:TweenMove(component1.xy + distance * 0.2, MASK_MOVE_PHASE_1)):SetEase((FairyGUI.EaseType).Linear)):OnComplete(function(...)
    -- function num : 0_87_5 , upvalues : component1, distance, MASK_MOVE_DURATION, MASK_MOVE_PHASE_1, _ENV, done
    ((component1:TweenMove(component1.xy + distance * 0.8, MASK_MOVE_DURATION - MASK_MOVE_PHASE_1)):SetEase((FairyGUI.EaseType).Linear)):OnComplete(done)
  end
)
            ;
            ((component2:TweenMove(component2.xy + distance * 0.2, MASK_MOVE_PHASE_1)):SetEase((FairyGUI.EaseType).Linear)):OnComplete(function(...)
    -- function num : 0_87_6 , upvalues : component2, distance, MASK_MOVE_DURATION, MASK_MOVE_PHASE_1, _ENV
    (component2:TweenMove(component2.xy + distance * 0.8, MASK_MOVE_DURATION - MASK_MOVE_PHASE_1)):SetEase((FairyGUI.EaseType).Linear)
  end
)
          end
        end
      end
    end
  end
end

PlotPlayPanelWindow.ShowWhiteScreenEffect = function(fadeOut, callback, ...)
  -- function num : 0_88 , upvalues : PlotPlayPanelWindow, _solidMask, _ENV, DEFAULT_WHITE_SCREEN_DURATION
  (PlotPlayPanelWindow.ResetSolidMask)()
  _solidMask.color = ((CS.UnityEngine).Color).white
  _solidMask.visible = true
  local finishCallback = function(...)
    -- function num : 0_88_0 , upvalues : _solidMask, callback
    _solidMask.alpha = 1
    _solidMask.visible = false
    if callback ~= nil then
      callback()
    end
  end

  if fadeOut then
    _solidMask.alpha = 1
    ;
    (((LeanTween.value)(1, 0, DEFAULT_WHITE_SCREEN_DURATION)):setOnUpdate(function(x, ...)
    -- function num : 0_88_1 , upvalues : _solidMask
    _solidMask.alpha = x
  end
)):setOnComplete(finishCallback)
  else
    _solidMask.alpha = 0
    ;
    (((LeanTween.value)(0, 1, DEFAULT_WHITE_SCREEN_DURATION)):setOnUpdate(function(x, ...)
    -- function num : 0_88_2 , upvalues : _solidMask
    _solidMask.alpha = x
  end
)):setOnComplete(finishCallback)
  end
end

PlotPlayPanelWindow.ShakeCamera = function(callback, ...)
  -- function num : 0_89 , upvalues : _ENV, PlotPlayPanelWindow
  local dialogueConfig = (TableData.GetBaseStoryDialogueData)(PlotPlayData.CurrentDialogueID)
  ;
  (PlotPlayPanelWindow.ShowCamerShake)(dialogueConfig.carmera, callback)
end

PlotPlayPanelWindow.ShowCamerShake = function(type, callback, ...)
  -- function num : 0_90 , upvalues : _ENV, PlotPlayPanelWindow, PlotPlayRoleNameTxtStatus, uis, _contentFadeOutTween, _shaking, _solidMask, _currentSceneEffect, _currentCharacters, _currentExpressionEffect
  if type ~= PlotPlayCameraEffect.Horizontal and type ~= PlotPlayCameraEffect.Vertical and type ~= PlotPlayCameraEffect.Multiply then
    callback()
  else
    ;
    (PlotPlayPanelWindow.ChangeRoleNameTxtStatus)(PlotPlayRoleNameTxtStatus.None)
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((uis.TalkWordGrp).talkTxt).text = ""
    if _contentFadeOutTween ~= nil then
      _contentFadeOutTween:Kill(true)
      _contentFadeOutTween = nil
    end
    _shaking = true
    local index = (uis.root):GetChildIndex(_solidMask)
    do
      (uis.root):SetChildIndex(_solidMask, 0)
      ;
      (PlotPlayPanelWindow.ResetSolidMask)()
      _solidMask.visible = true
      ;
      (Util.Shake)(uis.backsceneLoader, type, 20, 1, function(...)
    -- function num : 0_90_0 , upvalues : _shaking, uis, _solidMask, index, callback
    _shaking = false
    ;
    (uis.root):SetChildIndex(_solidMask, index)
    _solidMask.visible = false
    callback()
  end
)
      for k,v in pairs(_currentSceneEffect) do
        (Util.Shake)(v, type, 20, 1)
      end
      for k,v in pairs(_currentCharacters) do
        (Util.Shake)(v.Loader, type, 20, 1)
      end
      for k,v in pairs(_currentExpressionEffect) do
        (Util.Shake)(v, type, 20, 1)
      end
    end
  end
end

PlotPlayPanelWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_91 , upvalues : _ENV, PlotPlayPanelWindow, _currentMode, PlotPlayPlayMode, _currentRole, uis, _currentExpressionEffect, _contentOutAnim, _nameOutAnim, _contentFadeOutTween, _dialogueConfig, _lastRoleId
  if msgId == (WindowMsgEnum.PlotPlay).E_MSG_PLAY_CHAPTER_NAME then
    (PlotPlayPanelWindow.PlayChapterName)(para)
  else
    if msgId == (WindowMsgEnum.PlotPlay).E_MSG_SET_BTN then
      if OvertureMgr.isPlaying == true and (OvertureMgr.HideSetBtn)() == true then
        return 
      end
      if _currentMode == PlotPlayPlayMode.Auto then
        (PlotPlayPanelWindow.HandleBtns)(PlotPlayBtnStatus.Hide)
      else
        ;
        (PlotPlayPanelWindow.HandleBtns)(para)
      end
    else
      if msgId == (WindowMsgEnum.PlotPlay).E_MSG_PLAY_DIALOGUE then
        (PlotPlayPanelWindow.PlayOneDialogue)(para)
      else
        if msgId == (WindowMsgEnum.PlotPlay).E_MSG_SHOW_ASIDE then
          (PlotPlayPanelWindow.ShowAside)(para)
        else
          if msgId == (WindowMsgEnum.PlotPlay).E_MSG_SET_BACKGROUND then
            (PlotPlayPanelWindow.SetBackground)(para)
          else
            if msgId == (WindowMsgEnum.PlotPlay).E_MSG_CAMERA_SHAKE then
              (PlotPlayPanelWindow.ShakeCamera)(para)
            else
              if msgId == (WindowMsgEnum.PlotPlay).E_MSG_BACKGROUND_ENTER then
                (PlotPlayPanelWindow.ShowBGEnter)(para)
              else
                if msgId == (WindowMsgEnum.PlotPlay).E_MSG_FINISH then
                  _currentRole = nil
                  -- DECOMPILER ERROR at PC90: Confused about usage of register: R2 in 'UnsetPending'

                  ;
                  (uis.BlankBtn).touchable = false
                  for k,v in pairs(_currentExpressionEffect) do
                    if v ~= nil then
                      v:Dispose()
                    end
                  end
                  _currentExpressionEffect = {}
                  if para.Skip then
                    (PlotPlayPanelWindow.ShowBGQuit)(para.Callback)
                  else
                    ;
                    (PlotPlayPanelWindow.RecycleUnusedRole)(false, function(...)
    -- function num : 0_91_0 , upvalues : PlotPlayPanelWindow, para
    (PlotPlayPanelWindow.ShowBGQuit)(para.Callback, false, true)
  end
)
                    -- DECOMPILER ERROR at PC116: Confused about usage of register: R2 in 'UnsetPending'

                    ;
                    ((uis.TalkWordGrp).arowGrp).visible = false
                    _contentOutAnim:Play()
                    if (((uis.TalkWordGrp).CardName_01_Grp).root).visible then
                      _nameOutAnim:Play()
                      _contentFadeOutTween = (((uis.TalkWordGrp).talkTxt):TweenFade(0, 0.5)):OnComplete(function(...)
    -- function num : 0_91_1 , upvalues : uis, _contentFadeOutTween
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    ((uis.TalkWordGrp).talkTxt).text = ""
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.TalkWordGrp).talkTxt).alpha = 1
    _contentFadeOutTween = nil
  end
)
                    end
                  end
                else
                  if msgId == (WindowMsgEnum.PlotPlay).E_MSG_CALLBACK_KEEP then
                    (PlotPlayPanelWindow.ShowBGQuit)(PlotPlayMgr.Callback, true)
                  else
                    if msgId == (WindowMsgEnum.PlotPlay).E_MSG_STOP_SOUND then
                      (PlotPlayPanelWindow.RemoveSound)(para)
                      if _dialogueConfig ~= nil then
                        _lastRoleId = _dialogueConfig.role_type
                      end
                    else
                      if msgId == (WindowMsgEnum.PlotPlay).E_MSG_RECYCLE_ROLE_RES then
                        (PlotPlayPanelWindow.RecycleUnusedRole)(false)
                        -- DECOMPILER ERROR at PC178: Confused about usage of register: R2 in 'UnsetPending'

                        if uis.TalkWordGrp then
                          ((uis.TalkWordGrp).root).visible = false
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

return PlotPlayPanelWindow

