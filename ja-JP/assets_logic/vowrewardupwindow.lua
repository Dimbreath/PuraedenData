-- params : ...
-- function num : 0 , upvalues : _ENV
require("AdventureGame_VowRewardUpWindowByName")
require("AdventureGame_VowRewardByName")
local VowRewardUpWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _vowPoint = {}
VowRewardUpWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, VowRewardUpWindow
  bridgeObj:SetView((WinResConfig.VowRewardUpWindow).package, (WinResConfig.VowRewardUpWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetAdventureGame_VowRewardUpWindowUis(contentPane)
  ;
  (VowRewardUpWindow.InitVariable)()
  ;
  (VowRewardUpWindow.InitText)()
  ;
  (VowRewardUpWindow.InitButtonEvent)()
end

VowRewardUpWindow.InitVariable = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis, _vowPoint
  local pointInfo = nil
  for i = 1, AdventureData.MaxWishTimes do
    pointInfo = {}
    pointInfo.Root = ((uis.VowRewardUpGrp).root):GetChild("VP_0" .. i)
    pointInfo.Ctrl = (pointInfo.Root):GetController("c1")
    pointInfo.Anim = (pointInfo.Root):GetTransition("open")
    _vowPoint[i] = pointInfo
  end
end

VowRewardUpWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.VowRewardUpGrp).SureBtn).text = (PUtil.get)(60000004)
end

VowRewardUpWindow.InitButtonEvent = function(...)
  -- function num : 0_3 , upvalues : uis, VowRewardUpWindow
  (((uis.VowRewardUpGrp).SureBtn).onClick):Add(VowRewardUpWindow.ClickCloseBtn)
end

VowRewardUpWindow.InitEvent = function(...)
  -- function num : 0_4
end

VowRewardUpWindow.RemoveEvent = function(...)
  -- function num : 0_5
end

VowRewardUpWindow.OnShown = function(...)
  -- function num : 0_6 , upvalues : VowRewardUpWindow
  (VowRewardUpWindow.InitEvent)()
  ;
  (VowRewardUpWindow.Init)()
end

VowRewardUpWindow.OnHide = function(...)
  -- function num : 0_7
end

VowRewardUpWindow.Init = function(...)
  -- function num : 0_8 , upvalues : VowRewardUpWindow
  (VowRewardUpWindow.InitWishPoint)()
  ;
  (VowRewardUpWindow.RefreshRewards)()
  ;
  (VowRewardUpWindow.RefreshTips)()
end

VowRewardUpWindow.InitWishPoint = function(...)
  -- function num : 0_9 , upvalues : _ENV, _vowPoint
  local progress = AdventureData.WishPoint / AdventureData.MaxWishTimes
  for i = 1, AdventureData.MaxWishTimes do
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R5 in 'UnsetPending'

    if i <= AdventureData.WishPoint then
      ((_vowPoint[i]).Ctrl).selectedIndex = 1
    else
      -- DECOMPILER ERROR at PC20: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((_vowPoint[i]).Ctrl).selectedIndex = 0
    end
    if AdventureData.PlayWishPointAnim and i == AdventureData.WishPoint then
      ((_vowPoint[i]).Anim):Play()
      -- DECOMPILER ERROR at PC34: Confused about usage of register: R5 in 'UnsetPending'

      AdventureData.PlayWishPointAnim = false
    end
  end
end

VowRewardUpWindow.RefreshRewards = function(...)
  -- function num : 0_10 , upvalues : uis, argTable, VowRewardUpWindow
  ((uis.VowRewardUpGrp).TipsList):RemoveChildrenToPool()
  local count = #argTable[1]
  local item = nil
  for i = 1, count do
    item = ((uis.VowRewardUpGrp).TipsList):AddItemFromPool()
    ;
    (VowRewardUpWindow.RefreshWishItem)(i, item)
  end
end

VowRewardUpWindow.RefreshTips = function(...)
  -- function num : 0_11 , upvalues : _ENV, uis
  local point = nil
  local count = #AdventureData.WishPointCheckPoint
  for i = 1, count do
    if AdventureData.WishPoint < (AdventureData.WishPointCheckPoint)[i] then
      point = (AdventureData.WishPointCheckPoint)[i]
      break
    end
  end
  do
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

    if point == nil then
      ((uis.VowRewardUpGrp).RewardUpTxt).text = ""
    else
      -- DECOMPILER ERROR at PC33: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((uis.VowRewardUpGrp).RewardUpTxt).text = (PUtil.get)(60000433, point)
    end
  end
end

VowRewardUpWindow.RefreshWishItem = function(index, item, ...)
  -- function num : 0_12 , upvalues : argTable, _ENV, uis
  local data = ((((argTable[1])[index]).Data).Reward)[1]
  local config, type = (Util.GetConfigDataByID)(data.id)
  item = GetAdventureGame_VowRewardUis(item)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (item.NameTxt).text = config.name
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (item.NumberTxt).text = data.value
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (item.IconLoader).url = (Util.GetItemUrl)(config.icon)
  ;
  ((item.root).onClick):Set(function(...)
    -- function num : 0_12_0 , upvalues : _ENV, uis
    if (Util.CheckNullString)(((uis.VowRewardUpGrp).RewardUpTxt).text) then
      (MessageMgr.SendCenterTips)((PUtil.get)(60000474))
    else
      ;
      (MessageMgr.SendCenterTips)(((uis.VowRewardUpGrp).RewardUpTxt).text)
    end
  end
)
end

VowRewardUpWindow.OnClose = function(...)
  -- function num : 0_13 , upvalues : VowRewardUpWindow, uis, contentPane, argTable, _vowPoint
  (VowRewardUpWindow.RemoveEvent)()
  uis = nil
  contentPane = nil
  argTable = {}
  _vowPoint = {}
end

VowRewardUpWindow.ClickCloseBtn = function(...)
  -- function num : 0_14 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.VowRewardUpWindow).name)
end

VowRewardUpWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_15
end

return VowRewardUpWindow

