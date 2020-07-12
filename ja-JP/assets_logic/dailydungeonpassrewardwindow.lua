-- params : ...
-- function num : 0 , upvalues : _ENV
require("DailyDungeon_ChoiceWifeByName")
require("DailyDungeon_RewardTipsByName")
local objectPool = nil
local DailyDungeonPassRewardWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local settleData = nil
local PANEL_INDEX = {BEFORE_CHOOSE = 0, AFTER_CHOOSE = 1}
local changeTimer, CardLoader = nil, nil
DailyDungeonPassRewardWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, settleData, uis, CardLoader, DailyDungeonPassRewardWindow, PANEL_INDEX
  bridgeObj:SetView((WinResConfig.DailyDungeonPassRewardWindow).package, (WinResConfig.DailyDungeonPassRewardWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  contentPane:Center()
  settleData = not argTable or argTable[1]
  uis = GetDailyDungeon_ChoiceWifeUis(contentPane)
  CardLoader = uis.CardLoader
  ;
  (DailyDungeonPassRewardWindow.UpdateCurControl)(PANEL_INDEX.BEFORE_CHOOSE)
  ;
  ((uis.BackgroundEffectLoader).onClick):Set(DailyDungeonPassRewardWindow.TouchStart)
  ;
  (DailyDungeonPassRewardWindow.StartChangeImg)()
end

DailyDungeonPassRewardWindow.UpdateCurControl = function(index, ...)
  -- function num : 0_1 , upvalues : _ENV, uis
  if index then
    ChangeUIController(uis.root, "c1", index)
  end
end

DailyDungeonPassRewardWindow.TouchStart = function(...)
  -- function num : 0_2 , upvalues : DailyDungeonPassRewardWindow
  (DailyDungeonPassRewardWindow.TouchScreenshot)()
end

DailyDungeonPassRewardWindow.TouchScreenshot = function(...)
  -- function num : 0_3 , upvalues : DailyDungeonPassRewardWindow, PANEL_INDEX, settleData, uis, _ENV
  (DailyDungeonPassRewardWindow.StopChangeImg)()
  ;
  (DailyDungeonPassRewardWindow.UpdateCurControl)(PANEL_INDEX.AFTER_CHOOSE)
  if settleData then
    local rewardList = uis.RewardItemList
    local drawDrop = settleData.drawDrop
    for _,v in ipairs(drawDrop) do
      local data = v
      if tonumber(data.id) ~= AssetType.ACTOR_EXP and tonumber(data.id) ~= AssetType.CARD_EXP then
        local frame = (DailyDungeonPassRewardWindow.CreateOneReward)(data.id, data.value)
        rewardList:AddChild(frame)
      end
    end
  end
  do
    ;
    ((uis.BackgroundEffectLoader).onClick):Set(function(...)
    -- function num : 0_3_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.DailyDungeonPassRewardWindow).name)
  end
)
  end
end

DailyDungeonPassRewardWindow.CreateOneReward = function(id, count, ...)
  -- function num : 0_4 , upvalues : _ENV
  local rewardHand = UIMgr:CreateObject("DailyDungeon", "RewardTips")
  if rewardHand then
    local rewardUis = GetDailyDungeon_RewardTipsUis(rewardHand)
    local config = (Util.GetConfigDataByID)(id)
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R5 in 'UnsetPending'

    if config then
      (rewardUis.NumberTxt).text = count
      -- DECOMPILER ERROR at PC23: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (rewardUis.IconLoader).url = (Util.GetItemUrl)(config.icon)
    end
  end
  do
    return rewardHand
  end
end

DailyDungeonPassRewardWindow.StartChangeImg = function(...)
  -- function num : 0_5 , upvalues : _ENV, DailyDungeonPassRewardWindow, changeTimer, CardLoader
  local pathList = {}
  local allCardConfig = (TableData.gTable).BaseCardData
  local random = math.random
  local max = math.max
  local insert = table.insert
  local GetHeadIconBanner = CardMgr.GetHeadIconBanner
  for _,v in pairs(allCardConfig) do
    local index = random(1, max(#pathList, 1))
    local url = GetHeadIconBanner(v)
    insert(pathList, index, url)
  end
  ;
  (DailyDungeonPassRewardWindow.StopChangeImg)()
  changeTimer = (SimpleTimer.setInterval)(0.1, -1, function(timer, count, ...)
    -- function num : 0_5_0 , upvalues : CardLoader, pathList
    if CardLoader then
      local index = count % #pathList
      if index == 0 then
        index = #pathList
      end
      CardLoader.url = pathList[index]
    end
  end
)
end

DailyDungeonPassRewardWindow.StopChangeImg = function(...)
  -- function num : 0_6 , upvalues : changeTimer
  if changeTimer ~= nil then
    changeTimer:stop()
    changeTimer = nil
  end
end

DailyDungeonPassRewardWindow.OnShown = function(...)
  -- function num : 0_7
end

DailyDungeonPassRewardWindow.OnHide = function(...)
  -- function num : 0_8
end

DailyDungeonPassRewardWindow.OnClose = function(...)
  -- function num : 0_9 , upvalues : settleData, DailyDungeonPassRewardWindow, CardLoader, uis, contentPane
  settleData = nil
  ;
  (DailyDungeonPassRewardWindow.StopChangeImg)()
  CardLoader = nil
  uis = nil
  contentPane = nil
end

DailyDungeonPassRewardWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_10
end

return DailyDungeonPassRewardWindow

