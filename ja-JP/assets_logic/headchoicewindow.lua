-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActorInfo_HeadChoiceWindowByName")
local HeadChoiceWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local scrollView = nil
local heads = {}
HeadChoiceWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, heads, scrollView, HeadChoiceWindow
  bridgeObj:SetView((WinResConfig.HeadChoiceWindow).package, (WinResConfig.HeadChoiceWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetActorInfo_HeadChoiceWindowUis(contentPane)
  ;
  (((uis.HeadChoiceGrp).CloseBtn).onClick):Add(function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    UIMgr:CloseWindow("HeadChoiceWindow")
  end
)
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.HeadChoiceGrp).HeadChoiceTxt).text = (PUtil.get)(116)
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.HeadChoiceGrp).SureBtn).text = (PUtil.get)(30)
  ;
  (((uis.HeadChoiceGrp).SureBtn).onClick):Set(function(...)
    -- function num : 0_0_1 , upvalues : _ENV
    UIMgr:CloseWindow("HeadChoiceWindow")
  end
)
  if (_G.next)(heads) == nil then
    for k,v in pairs((TableData.gTable).BasePlayerHeadIconData) do
      (table.insert)(heads, v)
    end
  end
  do
    scrollView = (uis.HeadChoiceGrp).HeadList
    scrollView:SetVirtual()
    scrollView.itemRenderer = HeadChoiceWindow.RefreshHeadItem
    ;
    (HeadChoiceWindow.RefreshWindow)()
    ;
    (LuaSound.PlaySound)(LuaSound.COMMON_POP_WIN, SoundBank.OTHER)
  end
end

HeadChoiceWindow.RefreshWindow = function(...)
  -- function num : 0_1 , upvalues : HeadChoiceWindow, heads
  (HeadChoiceWindow.RefreshListNumber)(#heads)
end

HeadChoiceWindow.RefreshListNumber = function(number, ...)
  -- function num : 0_2 , upvalues : scrollView
  scrollView.numItems = number
end

HeadChoiceWindow.RefreshHeadItem = function(index, item, ...)
  -- function num : 0_3 , upvalues : heads, _ENV
  local data = heads[index + 1]
  local c1 = item:GetController("c1")
  ;
  ((item:GetChild("ActorHeadGrp")):GetController("c2")).selectedIndex = 1
  local headLoader = (item:GetChild("ActorHeadGrp")):GetChild("ActorHeadLoader")
  local curSelectedHeadID = (ActorData.GetFashionHead)()
  ;
  (item.onClick):Clear()
  if data.id == curSelectedHeadID then
    c1.selectedIndex = 1
    headLoader.color = ((CS.UnityEngine).Color).white
  else
    c1.selectedIndex = 0
    headLoader.color = ((CS.UnityEngine).Color).white
    ;
    (item.onClick):Add(function(...)
    -- function num : 0_3_0 , upvalues : _ENV, data
    (ActorInfoService.ReqSet)(1, tostring(data.id))
  end
)
  end
  headLoader.url = (Util.GetResUrl)(data.icon_path)
end

HeadChoiceWindow.OnShown = function(...)
  -- function num : 0_4
end

HeadChoiceWindow.OnHide = function(...)
  -- function num : 0_5
end

HeadChoiceWindow.OnClose = function(...)
  -- function num : 0_6 , upvalues : uis, contentPane, argTable, scrollView, _ENV
  uis = nil
  contentPane = nil
  argTable = {}
  scrollView = nil
  headIDs = {}
end

HeadChoiceWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_7 , upvalues : _ENV, HeadChoiceWindow
  local windowMsgEnum = WindowMsgEnum.ActorInfo
  if msgId == windowMsgEnum.E_MSG_SETFASHIONHEAD then
    (MessageMgr.SendCenterTips)((PUtil.get)(127))
    ;
    (HeadChoiceWindow.RefreshWindow)()
  end
end

return HeadChoiceWindow

