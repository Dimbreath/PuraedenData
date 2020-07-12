-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_BuyResultWindowByName")
require("Guild_BuyResultTipsByName")
local GuildGuessRecordWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local argData = {}
local specialItems = {}
GuildGuessRecordWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, argData, specialItems, uis, GuildGuessRecordWindow
  bridgeObj:SetView((WinResConfig.GuildGuessRecordWindow).package, (WinResConfig.GuildGuessRecordWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  argData = argTable[1]
  specialItems = argTable[2]
  uis = GetGuild_BuyResultWindowUis(contentPane)
  uis = uis.BuyResultGrp
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.RewardTxt).text = (PUtil.get)(20000178)
  ;
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.GuildGuessRecordWindow).name)
  end
)
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.SureBtn).text = (PUtil.get)(20000016)
  ;
  ((uis.SureBtn).onClick):Set(function(...)
    -- function num : 0_0_1 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.GuildGuessRecordWindow).name)
  end
)
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R1 in 'UnsetPending'

  if #argData > 0 then
    (uis.c1Ctr).selectedIndex = 0
    ;
    (uis.BuyResultList):SetBeginAnim()
    ;
    (uis.BuyResultList):SetVirtual()
    -- DECOMPILER ERROR at PC58: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.BuyResultList).itemRenderer = GuildGuessRecordWindow.ItemRenderer
    -- DECOMPILER ERROR at PC62: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.BuyResultList).numItems = #argData
    if specialItems[1] then
      local data = ((TableData.gTable).BasePropData)[(specialItems[1]).id]
      -- DECOMPILER ERROR at PC77: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (uis.DebrisLoader).url = (Util.GetItemUrl)(data.icon)
      -- DECOMPILER ERROR at PC81: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (uis.DebrisNumberTxt).text = (specialItems[1]).value
    else
      do
        local prizeID = (((TableData.gTable).BaseFixedData)[Const.GUILD_GUESS_PRIZE]).int_value
        do
          local data = ((TableData.gTable).BasePropData)[prizeID]
          -- DECOMPILER ERROR at PC99: Confused about usage of register: R3 in 'UnsetPending'

          ;
          (uis.DebrisLoader).url = (Util.GetItemUrl)(data.icon)
          -- DECOMPILER ERROR at PC101: Confused about usage of register: R3 in 'UnsetPending'

          ;
          (uis.DebrisNumberTxt).text = 0
          -- DECOMPILER ERROR at PC104: Confused about usage of register: R1 in 'UnsetPending'

          ;
          (uis.c1Ctr).selectedIndex = 1
          ;
          (Util.SetNotFoundEffect)(uis.AnimationLoader)
          -- DECOMPILER ERROR at PC115: Confused about usage of register: R1 in 'UnsetPending'

          ;
          ((uis.TalkGrp).WordTxt).text = (PUtil.get)(20000197)
          -- DECOMPILER ERROR at PC121: Confused about usage of register: R1 in 'UnsetPending'

          ;
          (uis.GetWordTxt).text = (PUtil.get)(20000396)
        end
      end
    end
  end
end

GuildGuessRecordWindow.ItemRenderer = function(index, obj, ...)
  -- function num : 0_1 , upvalues : argData, _ENV
  local data = argData[index + 1]
  local model = GetGuild_BuyResultTipsUis(obj)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (model.NumberTxt).text = (PUtil.get)(20000176, data.num)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (model.ItemList).numItems = 0
  for _,v in ipairs(data.goods) do
    (Util.SetFrame)(v.id, v.value, model.ItemList)
  end
end

GuildGuessRecordWindow.OnShown = function(...)
  -- function num : 0_2
end

GuildGuessRecordWindow.OnHide = function(...)
  -- function num : 0_3
end

GuildGuessRecordWindow.OnClose = function(...)
  -- function num : 0_4 , upvalues : _ENV, uis, contentPane, argTable
  (Util.RecycleUIModel)(uis.AnimationLoader)
  uis = nil
  contentPane = nil
  argTable = {}
end

GuildGuessRecordWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_5
end

return GuildGuessRecordWindow

