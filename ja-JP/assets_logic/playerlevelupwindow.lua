-- params : ...
-- function num : 0 , upvalues : _ENV
require("Message_LevelUpByName")
local PlayerLevelUpWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
PlayerLevelUpWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, PlayerLevelUpWindow
  bridgeObj:SetView((WinResConfig.PlayerLevelUpWindow).package, (WinResConfig.PlayerLevelUpWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetMessage_LevelUpUis(contentPane)
  ;
  (LuaSound.PlaySound)(LuaSound.COMMON_SHOW_REWARD, SoundBank.OTHER)
  ;
  (Util.SetNotFoundEffect)(uis.CardLoader)
  ;
  (GuideData.RegisterGuideAndControl)(ControlID.LevelUp_SureBtn, uis.TouchScreenBtn, (WinResConfig.PlayerLevelUpWindow).name)
  ;
  ((uis.TouchScreenBtn).onClick):Set(PlayerLevelUpWindow.OnCloseWindow)
  ;
  (MessageMgr.OnRegisterBackWinFunc)((WinResConfig.PlayerLevelUpWindow).name, PlayerLevelUpWindow.OnCloseWindow)
end

PlayerLevelUpWindow.OnCloseWindow = function(...)
  -- function num : 0_1 , upvalues : _ENV
  (FunctionControlMgr.OpenFunctionWindow)()
  UIMgr:CloseWindow((WinResConfig.PlayerLevelUpWindow).name)
  UIMgr:SendWindowMessage((WinResConfig.BattleWinConvergeWindow).name, 1)
end

PlayerLevelUpWindow.OnShown = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV, PlayerLevelUpWindow
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.WordTxt).text = (PUtil.get)(20000222)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.NumberWordTxt).text = (PUtil.get)(20000223)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.TouchTxt).text = (PUtil.get)(20000224)
  local currentLevel = (ActorData.GetLevel)()
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.LevelTxt).text = currentLevel
  local LevelUpData = ((TableData.gTable).BasePlayerLevelUpData)[currentLevel + 72300000]
  local currentVit = LevelUpData.max_vit
  local PreData = ((TableData.gTable).BasePlayerLevelUpData)[currentLevel + 72300000 - 1]
  local preVit = PreData.max_vit
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (uis.Number_A_Txt).text = preVit
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (uis.Number_B_Txt).text = currentVit
  ;
  (Util.IsPrepareLevelUpWindow)(false)
  ;
  (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_CHARACTER_LEVEL_UP, false, uis.root, Vector2((GRoot.inst).width / 2, (GRoot.inst).height * 1 / 2))
  local title = uis.Decorate_01_Image
  local pos = Vector2(title.x + title.width / 2, title.y + title.height / 2)
  ;
  (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_UNLOCK, true, uis.root, pos)
  ;
  (PlayerLevelUpWindow.CheckGuideTips)()
end

PlayerLevelUpWindow.CheckGuideTips = function(...)
  -- function num : 0_3 , upvalues : _ENV
  local dungeonChecker = function(checker, type, ...)
    -- function num : 0_3_0 , upvalues : _ENV
    local chapter = checker()
    if chapter == nil then
      return 
    end
    local nextChapter = (((TableData.gTable).BaseChapterData)[chapter]).next
    local config = ((TableData.gTable).BaseChapterData)[nextChapter]
    if config == nil then
      return 
    end
    local condition = (Util.ParseConfigStr)(config.open_condition)
    for _,v in pairs(condition) do
      local conditionID = tonumber(v[1])
      local conditionType = tonumber(v[2])
      local conditionValue = tonumber(v[3])
      -- DECOMPILER ERROR at PC54: Unhandled construct in 'MakeBoolean' P1

      if conditionID == ConditionType.PLAYER_LEVEL and (ActorData.GetLevel)() == conditionValue and (Util.CheckCondition)(config.open_condition, true) then
        (Util.ShowGuideTips)(type, config.name)
      end
      do break end
    end
  end

  local dailydungeonChecker = function(controlID, type, ...)
    -- function num : 0_3_1 , upvalues : _ENV
    local config = ((TableData.gTable).BaseFunctionData)[controlID]
    local condition = split(config.open_condition, ":")
    if tonumber(condition[3]) == (ActorData.GetLevel)() and (Util.CheckCondition)(config.open_condition, true) then
      (Util.ShowGuideTips)(type, controlID)
    end
  end

end

PlayerLevelUpWindow.OnHide = function(...)
  -- function num : 0_4
end

PlayerLevelUpWindow.OnClose = function(...)
  -- function num : 0_5 , upvalues : _ENV, uis, contentPane, argTable
  (GuideData.AbolishControlRefer)((WinResConfig.PlayerLevelUpWindow).name)
  ;
  (Util.RecycleUIModel)(uis.CardLoader)
  uis = nil
  contentPane = nil
  argTable = {}
end

PlayerLevelUpWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_6
end

return PlayerLevelUpWindow

