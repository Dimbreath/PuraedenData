-- params : ...
-- function num : 0 , upvalues : _ENV
require("Message_RewardShowByName")
local contentPane = nil
local uis = {}
local RewardShowWindow = {}
local args, mergeItems = nil, nil
local externalData = {}
RewardShowWindow.OnInit = function(bridge, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, uis, args, externalData, RewardShowWindow
  bridge:SetView((WinResConfig.RewardShowWindow).package, (WinResConfig.RewardShowWindow).comName)
  contentPane = bridge.contentPane
  uis = GetMessage_RewardShowUis(contentPane)
  args = bridge.argTable
  local fun = args[2]
  externalData = {}
  local closeFunc = function(...)
    -- function num : 0_0_0 , upvalues : _ENV, fun
    UIMgr:CloseWindow((WinResConfig.RewardShowWindow).name)
    if fun and type(fun) == "function" then
      fun()
    end
  end

  -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (uis.TipsTxt).text = (PUtil.get)(20000268)
  ;
  ((uis.TouchScreenBtn).onClick):Set(closeFunc)
  ;
  ((uis.ItemIconList).onClick):Set(closeFunc)
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (uis.ItemIconList).itemRenderer = RewardShowWindow.ItemRenderer
  ;
  (uis.ItemIconList):SetVirtual()
  ;
  (RewardShowWindow.SetRewardList)()
  local tran = contentPane:GetTransition("in")
  if tran then
    tran.invalidateBatchingEveryFrame = true
  end
  -- DECOMPILER ERROR at PC56: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (uis.TipsTxt).text = (PUtil.get)(20000268)
  ;
  (LuaSound.PlaySound)(LuaSound.COMMON_SHOW_REWARD, SoundBank.OTHER)
  ;
  (Util.SetOnClickDelay)(0.2)
  ;
  (MessageMgr.OnRegisterBackWinFunc)((WinResConfig.RewardShowWindow).name, closeFunc)
end

RewardShowWindow.ItemRenderer = function(index, obj, ...)
  -- function num : 0_1 , upvalues : mergeItems, _ENV, externalData
  local data = mergeItems[index + 1]
  local ConfigData, type = (Util.GetConfigDataByID)(data.id)
  if type == PropType.CARD then
    (obj:GetController("c1")).selectedIndex = 3
    ;
    (Util.SetShowHeadFrame)(obj:GetChild("HeadFrame"), data.id, false, externalData[data.id])
  else
    if type == PropType.TITLE then
      (obj:GetController("c1")).selectedIndex = 0
      local item = obj:GetChild("ItemFrameGrp")
      local loader = item:GetChild("IconLoader")
      loader.url = (Util.GetItemUrl)(ConfigData.goods_icon)
      ;
      (item:GetChild("NumberTxt")).visible = false
    else
      do
        ;
        (Util.SetAllItemIcon)(obj, data.id, data.Num)
      end
    end
  end
end

RewardShowWindow.SetRewardList = function(...)
  -- function num : 0_2 , upvalues : args, mergeItems, RewardShowWindow, _ENV, uis
  local items = args[1]
  mergeItems = (RewardShowWindow.MergeItem)(items)
  mergeItems = (Util.MajorSort)(mergeItems)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.ItemIconList).numItems = #mergeItems
end

RewardShowWindow.MergeItem = function(items, ...)
  -- function num : 0_3 , upvalues : _ENV, externalData, RewardShowWindow
  local mergeItems = {}
  for _,v in ipairs(items) do
    local data, itemType = (Util.GetConfigDataByID)(v.id)
    if itemType == PropType.EQUIP then
      local item = {}
      item.id = v.id
      item.Num = 1
      item.Type = itemType
      ;
      (table.insert)(mergeItems, item)
    else
      do
        if itemType == PropType.CARD and v.attr then
          externalData[v.id] = v.attr
        end
        do
          if not (RewardShowWindow.IsContainId)(mergeItems, v.id) then
            local item = {}
            item.id = v.id
            item.Num = (RewardShowWindow.GetCountNum)(items, v.id)
            item.Type = itemType
            ;
            (table.insert)(mergeItems, item)
          end
          -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  return mergeItems
end

RewardShowWindow.IsContainId = function(list, id, ...)
  -- function num : 0_4 , upvalues : _ENV
  for _,v in ipairs(list) do
    if v.id == id then
      return true
    end
  end
  return false
end

RewardShowWindow.GetCountNum = function(list, id, ...)
  -- function num : 0_5 , upvalues : _ENV
  local count = 0
  for _,v in ipairs(list) do
    if v.id == id then
      count = count + tonumber(v.Num)
    end
  end
  return count
end

RewardShowWindow.OnShown = function(...)
  -- function num : 0_6 , upvalues : uis, _ENV, contentPane
  local title = uis.Decorate_11_Image
  local pos = Vector2(title.x, title.y)
  ;
  (Util.PlayUIEffect)(uis, contentPane, 1)
end

RewardShowWindow.OnHide = function(...)
  -- function num : 0_7
end

RewardShowWindow.OnClose = function(...)
  -- function num : 0_8 , upvalues : _ENV, uis, contentPane, args
  if (Util.IsPrepareLevelUpWindow)() then
    OpenWindow((WinResConfig.PlayerLevelUpWindow).name, UILayer.HUD1)
  end
  uis = nil
  contentPane = nil
  args = {}
  UIMgr:SendWindowMessage("AdventureGame_BrickGame", (WindowMsgEnum.Adventure).E_MSG_CLOSE_REWARDGET_WINDOW, {})
  UIMgr:SendWindowMessage("AdventureGame_GoldGame", (WindowMsgEnum.Adventure).E_MSG_CLOSE_REWARDGET_WINDOW, {})
end

RewardShowWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_9
  if msgId ~= 1 or msgId == 2 then
  end
end

return RewardShowWindow

