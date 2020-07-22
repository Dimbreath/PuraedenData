-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_NoticeWindowByName")
local RelationType = FairyGUI.RelationType
GTween = FairyGUI.GTween
local FairyGUI_Timer = (FairyGUI.Timers).inst
local rollSpeed = 100
local waitForSeconds = 3
local switchTime = 1
local NoticeWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local rolling = false
local PlayingTxt, PrepareTxt = nil, nil
local bgWidth = 0
local bgHeight = 0
local contentWidth = 0
local prepareList = {}
local initPreparePosX = 0
local timer = nil
local ForbiddenReplace = false
NoticeWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, initPreparePosX, bgWidth, bgHeight, NoticeWindow, rolling
  bridgeObj:SetView((WinResConfig.NoticeWindow).package, (WinResConfig.NoticeWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  local playingTxt = argTable[1]
  local replace = argTable[2] or false
  uis = GetCommonResource_NoticeWindowUis(contentPane)
  contentPane.touchable = false
  uis = uis.n0
  initPreparePosX = ((uis.NoticeWordGrp).PrepareTxt).x
  bgWidth = ((uis.NoticeWordGrp).root).width
  bgHeight = ((uis.NoticeWordGrp).root).height
  ;
  (UpdateMgr.AddUpdateHandler)(NoticeWindow.Update)
  ;
  (NoticeWindow.SetPlayContent)(playingTxt, replace)
  rolling = true
end

NoticeWindow.Update = function(...)
  -- function num : 0_1 , upvalues : rolling, PlayingTxt, _ENV, rollSpeed, prepareList, ForbiddenReplace, NoticeWindow, bgWidth, contentWidth, FairyGUI_Timer, waitForSeconds
  if rolling then
    PlayingTxt.x = PlayingTxt.x - Time.deltaTime * rollSpeed
    if PlayingTxt.x <= 0 and #prepareList > 0 and not ForbiddenReplace then
      rolling = false
      ;
      (NoticeWindow.SwitchNextNotice)()
      return 
    end
    if (contentWidth <= bgWidth and PlayingTxt.x <= 0) or bgWidth < contentWidth and PlayingTxt.x <= bgWidth - contentWidth then
      rolling = false
      if #prepareList == 0 then
        FairyGUI_Timer:Add(waitForSeconds, 1, NoticeWindow.CloseWindow)
      else
        ;
        (NoticeWindow.SwitchNextNotice)()
      end
    end
  end
end

NoticeWindow.CloseWindow = function(...)
  -- function num : 0_2 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.NoticeWindow).name)
end

NoticeWindow.SwitchNextNotice = function(...)
  -- function num : 0_3 , upvalues : prepareList, _ENV, NoticeWindow, PlayingTxt, PrepareTxt, RelationType, bgHeight, switchTime, rolling, initPreparePosX
  local mTable = prepareList[1]
  local content = mTable.content
  local replace = mTable.replace
  ;
  (table.remove)(prepareList, 1)
  ;
  (NoticeWindow.SetPlayContent)(content, replace)
  ;
  (PlayingTxt.relations):ClearAll()
  ;
  (PrepareTxt.relations):ClearAll()
  PlayingTxt:AddRelation(PrepareTxt, RelationType.Top_Bottom)
  local gt = (GTween.To)(0, -bgHeight, switchTime)
  gt:OnUpdate(function(...)
    -- function num : 0_3_0 , upvalues : PrepareTxt, gt
    if PrepareTxt then
      PrepareTxt.y = (gt.value).x
    end
  end
)
  gt:OnComplete(function(...)
    -- function num : 0_3_1 , upvalues : rolling, PlayingTxt, PrepareTxt, initPreparePosX, bgHeight
    rolling = true
    if PlayingTxt and PrepareTxt then
      (PlayingTxt.relations):ClearAll()
      PrepareTxt.x = initPreparePosX
      PrepareTxt.y = bgHeight
    end
  end
)
end

NoticeWindow.SetPlayContent = function(content, replace, ...)
  -- function num : 0_4 , upvalues : PlayingTxt, uis, PrepareTxt, contentWidth, ForbiddenReplace
  if PlayingTxt == nil then
    PlayingTxt = (uis.NoticeWordGrp).PlayingTxt
    PrepareTxt = (uis.NoticeWordGrp).PrepareTxt
  else
    if PlayingTxt == (uis.NoticeWordGrp).PlayingTxt then
      PlayingTxt = (uis.NoticeWordGrp).PrepareTxt
      PrepareTxt = (uis.NoticeWordGrp).PlayingTxt
    else
      if PlayingTxt == (uis.NoticeWordGrp).PrepareTxt then
        PlayingTxt = (uis.NoticeWordGrp).PlayingTxt
        PrepareTxt = (uis.NoticeWordGrp).PrepareTxt
      end
    end
  end
  PlayingTxt.text = content
  contentWidth = PlayingTxt.width
  ForbiddenReplace = replace
end

NoticeWindow.OnShown = function(...)
  -- function num : 0_5
end

NoticeWindow.OnHide = function(...)
  -- function num : 0_6
end

NoticeWindow.OnClose = function(...)
  -- function num : 0_7 , upvalues : FairyGUI_Timer, NoticeWindow, rolling, PlayingTxt, PrepareTxt, uis, contentPane, argTable, _ENV
  if FairyGUI_Timer:Exists(NoticeWindow.CloseWindow) then
    FairyGUI_Timer:Remove(NoticeWindow.CloseWindow)
  end
  rolling = false
  PlayingTxt = nil
  PrepareTxt = nil
  uis = nil
  contentPane = nil
  argTable = {}
  ;
  (UpdateMgr.RemoveUpdateHandler)(NoticeWindow.Update)
end

NoticeWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_8 , upvalues : _ENV, prepareList, FairyGUI_Timer, NoticeWindow
  if msgId == 1 then
    local txt = para[1]
    local temp = para[2] or false
    if txt and type(txt) == "string" and not (Util.StringIsNullOrEmpty)(txt) then
      (table.insert)(prepareList, {content = txt, replace = temp})
      if FairyGUI_Timer:Exists(NoticeWindow.CloseWindow) then
        FairyGUI_Timer:Remove(NoticeWindow.CloseWindow)
        ;
        (NoticeWindow.SwitchNextNotice)()
      end
    end
  end
end

return NoticeWindow

