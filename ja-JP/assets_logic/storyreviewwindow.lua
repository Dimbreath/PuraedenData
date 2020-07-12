-- params : ...
-- function num : 0 , upvalues : _ENV
require("PlotPlay_StoryReviewByName")
require("PlotPlay_StoryReviewWindowByName")
local StoryReviewWindow = {}
local uis, contentPane, _popInAnim, _popOutAnim = nil, nil, nil, nil
local _dialogues = {}
local _gap = 4
StoryReviewWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, uis, StoryReviewWindow
  bridgeObj:SetView((WinResConfig.StoryReviewWindow).package, (WinResConfig.StoryReviewWindow).comName)
  contentPane = bridgeObj.contentPane
  contentPane:Center()
  uis = GetPlotPlay_StoryReviewWindowUis(contentPane)
  ;
  (StoryReviewWindow.InitText)()
  ;
  (StoryReviewWindow.InitVariable)()
  ;
  (StoryReviewWindow.InitButtonEvent)()
end

StoryReviewWindow.InitText = function(...)
  -- function num : 0_1 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.ClearingPanelComp).confirmBtn).text = (PUtil.get)(30)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.ClearingPanelComp).NameTxt).text = (PUtil.get)(60000455)
end

StoryReviewWindow.InitVariable = function(...)
  -- function num : 0_2 , upvalues : _popInAnim, uis, _popOutAnim, StoryReviewWindow
  _popInAnim = (uis.root):GetTransition("in")
  _popOutAnim = (uis.root):GetTransition("out")
  ;
  ((uis.ClearingPanelComp).itemList):SetVirtual()
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.ClearingPanelComp).itemList).itemRenderer = StoryReviewWindow.RefreshChoiceItem
end

StoryReviewWindow.InitButtonEvent = function(...)
  -- function num : 0_3 , upvalues : uis, StoryReviewWindow
  (((uis.ClearingPanelComp).confirmBtn).onClick):Add(StoryReviewWindow.ClickConfrimBtn)
  ;
  (((uis.ClearingPanelComp).CloseBtn).onClick):Add(StoryReviewWindow.ClickConfrimBtn)
end

StoryReviewWindow.InitEvent = function(...)
  -- function num : 0_4
end

StoryReviewWindow.RemoveEvent = function(...)
  -- function num : 0_5
end

StoryReviewWindow.OnShown = function(...)
  -- function num : 0_6 , upvalues : StoryReviewWindow
  (StoryReviewWindow.InitEvent)()
  ;
  (StoryReviewWindow.Init)()
end

StoryReviewWindow.OnHide = function(...)
  -- function num : 0_7 , upvalues : StoryReviewWindow
  (StoryReviewWindow.RemoveEvent)()
end

StoryReviewWindow.Init = function(...)
  -- function num : 0_8 , upvalues : _dialogues, _ENV, uis
  _dialogues = (PlotPlayData.GetCurrentDialogues)()
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.ClearingPanelComp).itemList).numItems = #_dialogues
  ;
  (((uis.ClearingPanelComp).itemList).scrollPane):ScrollBottom()
end

StoryReviewWindow.RefreshChoiceItem = function(index, item, ...)
  -- function num : 0_9 , upvalues : _ENV, _dialogues, _gap
  local dialogueConfig = (TableData.GetBaseStoryDialogueData)(_dialogues[index + 1])
  local roleConfig = ((TableData.gTable).BaseStoryRoleData)[dialogueConfig.role_type]
  ;
  (item:GetChild("CharacterWordTxt")).text = dialogueConfig.remark
  ;
  (item:GetChild("CharacterNameTxt")).text = roleConfig.name
  local bg = item:GetChild("n7")
  if item.minHeight < bg.y + bg.height + _gap then
    item:SetSize(item.width, bg.y + bg.height + _gap)
  else
    item:SetSize(item.width, item.minHeight)
  end
  local head = item:GetChild("StoryBaner")
  ;
  (head:GetChild("LevelTxt")).text = ""
  ;
  (head:GetChild("StageTxt")).text = ""
  for i = 1, Const.MaxRoleStar do
    (head:GetChild("Star_0" .. tostring(i) .. "_smallImage")).visible = false
  end
  local config = ((TableData.gTable).BaseFashionData)[tonumber(roleConfig.fashion_id)]
  if config ~= nil and not (Util.StringIsNullOrEmpty)(config.head_icon_square) then
    (head:GetChild("IconLoader")).url = (Util.GetItemUrl)(config.head_icon_square)
  else
    ;
    (head:GetChild("IconLoader")).url = nil
  end
end

StoryReviewWindow.OnClose = function(...)
  -- function num : 0_10 , upvalues : uis, contentPane, _popInAnim, _popOutAnim, _dialogues
  uis = nil
  contentPane = nil
  _popInAnim = nil
  _popOutAnim = nil
  _dialogues = {}
end

StoryReviewWindow.ClickConfrimBtn = function(...)
  -- function num : 0_11 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.StoryReviewWindow).name)
end

StoryReviewWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_12
end

return StoryReviewWindow

