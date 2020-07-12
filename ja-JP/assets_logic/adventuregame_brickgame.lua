-- params : ...
-- function num : 0 , upvalues : _ENV
require("AdventureGame_BrickGameByName")
local AdventureGame_BrickGame = {}
local uis, contentPane = nil, nil
local argTable = {}
local nodeId = nil
local brickGrps = {}
local countDown = 10
local totalBricks = (((TableData.gTable).BaseFixedData)[Const.MAX_BRICK]).int_value
local curBricks = 0
local timer = nil
local GameState = {init = 1, talk = 2, startCountDown = 3, gaming = 4, gameover = 5}
local gameState = GameState.init
local getRewards = {}
local rdIndex = {}
AdventureGame_BrickGame.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, nodeId, uis, brickGrps, AdventureGame_BrickGame
  bridgeObj:SetView((WinResConfig.AdventureGame_BrickGame).package, (WinResConfig.AdventureGame_BrickGame).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  nodeId = argTable[1]
  uis = GetAdventureGame_BrickGameUis(contentPane)
  brickGrps = {uis.Brick_01_Grp, uis.Brick_02_Grp, uis.Brick_03_Grp, uis.Brick_04_Grp, uis.Brick_05_Grp, uis.Brick_06_Grp, uis.Brick_07_Grp, uis.Brick_08_Grp, uis.Brick_09_Grp, uis.Brick_10_Grp, uis.Brick_11_Grp, uis.Brick_12_Grp, uis.Brick_13_Grp}
  ;
  (AdventureGame_BrickGame.InitAttr)()
  ;
  (LuaSound.LoadAndPlayBGM)(1010004)
end

AdventureGame_BrickGame.InitAttr = function(...)
  -- function num : 0_1 , upvalues : uis, _ENV, gameState, GameState, timer, countDown, AdventureGame_BrickGame, rdIndex, brickGrps, curBricks, totalBricks, getRewards
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.BrickTalkGrp).root).visible = true
  ;
  (Util.RecycleUIModel)((uis.BrickTalkGrp).CardLoader)
  ;
  (Util.ShowUIModel)("l2d_11301004", (uis.BrickTalkGrp).CardLoader)
  UIMgr:ShowGrabBloom((((uis.BrickTalkGrp).root):GetChild("PopBg")).displayObject)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.TouchScreenBtn).visible = true
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.Animation_StartGrp).root).visible = false
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.Animation_OverGrp).root).visible = false
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.ReduceTimeTxt).visible = false
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.TimeTxt).visible = false
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.ClockImage).visible = false
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.BrickTalkGrp).TalkTxt).text = (PUtil.get)(155)
  gameState = GameState.talk
  ;
  ((uis.TouchScreenBtn).onClick):Clear()
  ;
  ((uis.TouchScreenBtn).onClick):Add(function(...)
    -- function num : 0_1_0 , upvalues : gameState, GameState, uis, _ENV, timer, countDown, AdventureGame_BrickGame
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

    if gameState == GameState.talk then
      ((uis.BrickTalkGrp).root).visible = false
      UIMgr:HideGrabBloom((((uis.BrickTalkGrp).root):GetChild("PopBg")).displayObject)
      -- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

      ;
      ((uis.Animation_StartGrp).root).visible = true
      gameState = GameState.startCountDown
      PlayUITrans((uis.Animation_StartGrp).root, "Start", function(...)
      -- function num : 0_1_0_0 , upvalues : gameState, GameState, uis, timer, _ENV, countDown, AdventureGame_BrickGame
      gameState = GameState.gaming
      -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

      ;
      ((uis.Animation_StartGrp).root).visible = false
      -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (uis.TouchScreenBtn).visible = false
      -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (uis.TimeTxt).visible = true
      -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (uis.ClockImage).visible = true
      local issue = 0.01
      timer = (SimpleTimer.new)(issue, -1, function(...)
        -- function num : 0_1_0_0_0 , upvalues : countDown, issue, _ENV, uis, timer
        countDown = countDown - issue
        local str = split(tostring(countDown), ".")
        local s1 = "0" .. str[1]
        local s2 = (string.sub)(str[2], 0, 2)
        if (string.len)(s2) < 2 then
          s2 = s2 .. "0"
        end
        local finals = s1 .. "：" .. s2
        -- DECOMPILER ERROR at PC33: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (uis.TimeTxt).text = finals
        if countDown <= 0 then
          timer:Comp()
          timer = nil
        end
      end
, function(...)
        -- function num : 0_1_0_0_1 , upvalues : uis, _ENV, gameState, GameState, AdventureGame_BrickGame
        -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

        (uis.TimeTxt).text = "00：00"
        -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

        ;
        ((uis.Animation_OverGrp).root).visible = true
        -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

        ;
        (uis.TouchScreenBtn).visible = true
        PlayUITrans((uis.Animation_OverGrp).root, "Over", function(...)
          -- function num : 0_1_0_0_1_0 , upvalues : _ENV, gameState, GameState, AdventureGame_BrickGame
          (SimpleTimer.setTimeout)(1.5, function(...)
            -- function num : 0_1_0_0_1_0_0 , upvalues : gameState, GameState
            gameState = GameState.gameover
          end
)
          ;
          (AdventureGame_BrickGame.OnGameOver)()
        end
)
      end
)
      timer:start()
    end
)
    else
      if gameState == GameState.gameover then
        UIMgr:CloseWindow((WinResConfig.AdventureGame_BrickGame).name)
      end
    end
  end
)
  rdIndex = (AdventureGame_BrickGame.Randomx)(76450001, 76450013, 13)
  for i,v in ipairs(brickGrps) do
    do
      -- DECOMPILER ERROR at PC66: Confused about usage of register: R5 in 'UnsetPending'

      (v.c1Ctr).selectedIndex = 0
      ;
      ((v.root).onClick):Clear()
      ;
      ((v.root).onClick):Add(function(...)
    -- function num : 0_1_1 , upvalues : v, _ENV, rdIndex, i, curBricks, totalBricks, countDown, uis, getRewards
    ((v.root).onClick):Clear()
    local brickData = ((TableData.gTable).BaseAdventureGameBrickData)[rdIndex[i]]
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (v.c1Ctr).selectedIndex = 1
    local holder = (Util.ShowUIModel)(UIEffectEnum.UI_ADVENTUREGAME_BRICK, v.ItemLoader)
    ;
    (SkeletonAnimationUtil.SetAnimation)(holder, 0, "in", false)
    curBricks = curBricks + 1
    if totalBricks <= curBricks then
      countDown = 0
    end
    if brickData.type ~= "0" or brickData.type == "1" then
      (LuaSound.PlaySound)(LuaSound.ADVENTURE_BOOM, SoundBank.OTHER)
      local lod = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_ADVENTUREGAME_BOOM, true)
      lod:SetXY((v.root).width / 2, (v.root).height / 2)
      ;
      (v.root):AddChild(lod)
      countDown = countDown + brickData.parameter
      PlayUITrans(uis.root, "ReduceTime")
      -- DECOMPILER ERROR at PC75: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (uis.ReduceTimeTxt).visible = true
    else
      do
        if brickData.type == "2" then
          local rewardData = (AdventureData.GetMiniGameRewardInfo)(AdventureEventType.Brick, brickData.reward_pool)
          if rewardData == nil then
            return 
          end
          ;
          (LuaSound.PlaySound)(LuaSound.ADVENTURE_KNOCK_BRICK, SoundBank.OTHER)
          ;
          (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_BRICKGAME_REWARD_EFFECT, true, v.root, (Vector2((v.root).width / 2, (v.root).height / 2)), nil, 1, true)
          ;
          (table.insert)(getRewards, rewardData.Id)
          if rewardData ~= nil and rewardData.Rewards ~= nil then
            local str = split(rewardData.Rewards, ":")
            -- DECOMPILER ERROR at PC138: Confused about usage of register: R4 in 'UnsetPending'

            ;
            (v.ItemLoader).url = (Util.GetUrlFromItemID)(tonumber(str[2]), tonumber(str[1]))
          end
        end
      end
    end
  end
)
    end
  end
end

AdventureGame_BrickGame.OnGameOver = function(...)
  -- function num : 0_2 , upvalues : _ENV, nodeId, getRewards, brickGrps, rdIndex
  (AdventureService.ReqAdventureEventReward)(nodeId, AdventureEventType.Brick, false, getRewards)
  for i,v in ipairs(brickGrps) do
    if (v.c1Ctr).selectedIndex == 0 then
      local brickData = ((TableData.gTable).BaseAdventureGameBrickData)[rdIndex[i]]
      -- DECOMPILER ERROR at PC22: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (v.c1Ctr).selectedIndex = 1
      if brickData.type == "0" then
        print("brickData.type ==0")
      else
        if brickData.type == "1" then
          print("brickData.type ==1")
        else
          if brickData.type == "2" then
            local rewardData = (AdventureData.GetMiniGameRewardInfo)(AdventureEventType.Brick, brickData.reward_pool)
            print("brickData.type ==2", rewardData)
            if rewardData ~= nil and rewardData.Rewards ~= nil then
              local str = split(rewardData.Rewards, ":")
              -- DECOMPILER ERROR at PC69: Confused about usage of register: R8 in 'UnsetPending'

              ;
              (v.ItemLoader).url = (Util.GetUrlFromItemID)(tonumber(str[2]), tonumber(str[1]))
            end
          end
        end
      end
    end
  end
end

AdventureGame_BrickGame.RefreshWindow = function(...)
  -- function num : 0_3
end

AdventureGame_BrickGame.OnClose = function(...)
  -- function num : 0_4 , upvalues : _ENV, uis, contentPane, argTable, nodeId, brickGrps, gameState, GameState, countDown, timer, getRewards, rdIndex, curBricks
  (LuaSound.LoadAndPlayBGM)(1010005)
  uis = nil
  contentPane = nil
  argTable = {}
  nodeId = nil
  brickGrps = {}
  gameState = GameState.init
  countDown = 10
  timer = nil
  getRewards = {}
  rdIndex = {}
  curBricks = 0
end

AdventureGame_BrickGame.Randomx = function(m, n, cnt, ...)
  -- function num : 0_5 , upvalues : _ENV
  if n - m + 1 < cnt then
    return {}
  end
  local t = {}
  local tmp = {}
  ;
  (math.randomseed)((os.time)())
  do
    while cnt > 0 do
      local x = (math.random)(m, n)
      if not tmp[x] then
        t[#t + 1] = x
        tmp[x] = 1
        cnt = cnt - 1
      end
    end
    return t
  end
end

AdventureGame_BrickGame.HandleMessage = function(msgId, para, ...)
  -- function num : 0_6 , upvalues : _ENV
  local windowMsgEnum = WindowMsgEnum.Adventure
  if msgId == windowMsgEnum.E_MSG_CLOSE_REWARDGET_WINDOW then
    UIMgr:CloseWindow((WinResConfig.AdventureGame_BrickGame).name)
  else
    if msgId == windowMsgEnum.E_MSG_BRICK_REWARDS then
      (AdventureMgr.AfterShowResult)()
    end
  end
end

return AdventureGame_BrickGame

