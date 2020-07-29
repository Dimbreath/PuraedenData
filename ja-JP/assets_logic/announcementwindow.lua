-- params : ...
-- function num : 0 , upvalues : _ENV
require("Announcement_AnnouncementWindowByName")
local AnnouncementWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _luaBridge, _textOffsetX, _textOffsetY, _lineGap, _currentId, _lastPos, _originPos = nil, nil, nil, nil, nil, nil, nil
AnnouncementWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, _luaBridge, uis, AnnouncementWindow
  bridgeObj:SetView((WinResConfig.AnnouncementWindow).package, (WinResConfig.AnnouncementWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  _luaBridge = bridgeObj
  uis = GetAnnouncement_AnnouncementWindowUis(contentPane)
  ;
  (AnnouncementWindow.InitVariable)()
  ;
  (AnnouncementWindow.InitText)()
  ;
  (AnnouncementWindow.InitList)()
  ;
  (AnnouncementWindow.BindingUI)()
  ;
  (AnnouncementWindow.InitButtonEvent)()
  ;
  (LuaSound.PlaySound)(LuaSound.COMMON_POP_WIN, SoundBank.OTHER)
end

AnnouncementWindow.InitVariable = function(...)
  -- function num : 0_1
end

AnnouncementWindow.BindingUI = function(...)
  -- function num : 0_2 , upvalues : _ENV, uis
  local winName = (WinResConfig.AnnouncementWindow).name
  local BindingUI = RedDotMgr.BindingUI
  BindingUI(winName, RedDotComID.Announcement_List, (uis.Announcement).BtnList, true)
end

AnnouncementWindow.InitText = function(...)
  -- function num : 0_3 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.Announcement).TitleTxt).text = (PUtil.get)(113)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.Announcement).SureBtn).text = (PUtil.get)(60000004)
end

AnnouncementWindow.InitList = function(...)
  -- function num : 0_4 , upvalues : uis, AnnouncementWindow
  ((uis.Announcement).BtnList):SetVirtual()
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.Announcement).BtnList).itemRenderer = AnnouncementWindow.RefreshTitleItem
  ;
  ((((uis.Announcement).BtnList).scrollPane).onScroll):Add(function(...)
    -- function num : 0_4_0 , upvalues : AnnouncementWindow
    (AnnouncementWindow.CheckArrow)()
  end
)
end

AnnouncementWindow.InitButtonEvent = function(...)
  -- function num : 0_5 , upvalues : uis, AnnouncementWindow
  (((uis.Announcement).CloseBtn).onClick):Set(AnnouncementWindow.ClickCloseBtn)
  ;
  (((uis.Announcement).SureBtn).onClick):Set(AnnouncementWindow.ClickCloseBtn)
end

AnnouncementWindow.InitEvent = function(...)
  -- function num : 0_6
end

AnnouncementWindow.RemoveEvent = function(...)
  -- function num : 0_7
end

AnnouncementWindow.OnShown = function(...)
  -- function num : 0_8 , upvalues : AnnouncementWindow
  (AnnouncementWindow.InitEvent)()
  ;
  (AnnouncementWindow.Init)()
end

AnnouncementWindow.OnHide = function(...)
  -- function num : 0_9
end

AnnouncementWindow.Init = function(...)
  -- function num : 0_10 , upvalues : _ENV, _luaBridge, _currentId, AnnouncementWindow, uis, _lastPos
  local count = #AnnouncementData.ListData
  if count > 0 then
    if not _luaBridge.OpenFromClose then
      _currentId = ((AnnouncementData.ListData)[1]).id
    end
    ;
    (SimpleTimer.setTimeout)(0.4, function(...)
    -- function num : 0_10_0 , upvalues : AnnouncementWindow, _currentId
    (AnnouncementWindow.ClickTitleItem)(_currentId)
  end
)
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

    if _luaBridge.OpenFromClose then
      (((uis.Announcement).ContentList).scrollPane).posY = _lastPos
    end
  end
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.Announcement).BtnList).numItems = count
  ;
  (AnnouncementWindow.CheckArrow)()
  ;
  (RedDotMgr.RefreshTreeUI)((WinResConfig.AnnouncementWindow).name)
end

AnnouncementWindow.CheckArrow = function(...)
  -- function num : 0_11 , upvalues : uis
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  if (((uis.Announcement).BtnList).scrollPane).contentHeight <= (((uis.Announcement).BtnList).scrollPane).viewHeight then
    (((uis.Announcement).Up).root).visible = false
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (((uis.Announcement).Down).root).visible = false
  else
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

    if (((uis.Announcement).BtnList).scrollPane).isTopMost then
      (((uis.Announcement).Down).root).visible = true
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (((uis.Announcement).Up).root).visible = false
    else
      -- DECOMPILER ERROR at PC43: Confused about usage of register: R0 in 'UnsetPending'

      if (((uis.Announcement).BtnList).scrollPane).isBottomMost then
        (((uis.Announcement).Down).root).visible = false
        -- DECOMPILER ERROR at PC47: Confused about usage of register: R0 in 'UnsetPending'

        ;
        (((uis.Announcement).Up).root).visible = true
      else
        -- DECOMPILER ERROR at PC52: Confused about usage of register: R0 in 'UnsetPending'

        ;
        (((uis.Announcement).Up).root).visible = true
        -- DECOMPILER ERROR at PC56: Confused about usage of register: R0 in 'UnsetPending'

        ;
        (((uis.Announcement).Down).root).visible = true
      end
    end
  end
end

AnnouncementWindow.OnClose = function(...)
  -- function num : 0_12 , upvalues : AnnouncementWindow, uis, contentPane, argTable
  (AnnouncementWindow.RemoveEvent)()
  uis = nil
  contentPane = nil
  argTable = {}
end

AnnouncementWindow.RefreshTitleItem = function(index, item, ...)
  -- function num : 0_13 , upvalues : _ENV, _currentId, AnnouncementWindow, uis
  local data = (AnnouncementData.ListData)[index + 1]
  item.selected = data.id == _currentId
  if (data.title):find("http") then
    (item:GetChild("ButtonIconLoader")).url = data.title
  end
  ;
  ((item:GetChild("LabelTips")):GetChild("TipsLoader")).url = data.subscript
  ;
  (item.onClick):Set(function(...)
    -- function num : 0_13_0 , upvalues : _currentId, data, AnnouncementWindow, uis
    _currentId = data.id
    ;
    (AnnouncementWindow.ClickTitleItem)(data.id)
    ;
    ((uis.Announcement).BtnList):RefreshVirtualList()
  end
)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

AnnouncementWindow.ClickTitleItem = function(id, ...)
  -- function num : 0_14 , upvalues : _ENV, AnnouncementWindow
  if (AnnouncementData.ContentData)[id] == nil then
    (AnnouncementMgr.ReqAnnouncementContent)(id)
  else
    ;
    (AnnouncementWindow.RefreshContent)((AnnouncementData.ContentData)[id])
  end
end

AnnouncementWindow.SetDatePanel = function(panel, ...)
  -- function num : 0_15 , upvalues : argTable, _ENV
  local datePanel = panel:GetChild("Date")
  datePanel.visible = not argTable[1]
  ;
  (datePanel:GetChild("WordTxt")).text = (PUtil.get)(60000442)
  ;
  (datePanel:GetChild("DateTxt")).text = (os.date)("%m" .. (PUtil.get)(60000032) .. "%d" .. (PUtil.get)(60000033), (LuaTime.GetTimeStamp)())
end

AnnouncementWindow.RefreshContent = function(content, ...)
  -- function num : 0_16 , upvalues : uis, _ENV, argTable, AnnouncementWindow, _lastPos, _originPos, _textOffsetX
  ((uis.Announcement).ContentList):RemoveChildrenToPool()
  ;
  ((uis.Announcement).ImageList):RemoveChildrenToPool()
  local contentData = (AnnouncementData.GetAnalyzedContent)(content.content, argTable[1])
  -- DECOMPILER ERROR at PC41: Unhandled construct in 'MakeBoolean' P3

  -- DECOMPILER ERROR at PC41: Unhandled construct in 'MakeBoolean' P3

  local onlyImage = (#contentData ~= 1 or (contentData[1]).Type ~= AnnouncementDataContentType.BigImage) and #contentData == 2 and (contentData[1]).Type ~= AnnouncementDataContentType.BigImage
  local list = nil
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R4 in 'UnsetPending'

  if onlyImage then
    ((uis.Announcement).c1Ctr).selectedIndex = 1
    list = (uis.Announcement).ImageList
  else
    -- DECOMPILER ERROR at PC55: Confused about usage of register: R4 in 'UnsetPending'

    ((uis.Announcement).c1Ctr).selectedIndex = 0
    list = (uis.Announcement).ContentList
    local titleCom = list:AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.AnnouncementWindow).package, AnnouncementData.CONTENT_TITLE_RESOURCE))
    ;
    (titleCom:GetChild("TitleTxt")).text = content.subtitle
    ;
    (AnnouncementWindow.SetDatePanel)(titleCom)
  end
  local imgPanel = nil
  local count = #contentData
  for i = 1, count do
    do
      local eachData = contentData[i]
      if eachData.Type == AnnouncementDataContentType.Image and not onlyImage then
        imgPanel = list:AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.AnnouncementWindow).package, AnnouncementData.CONTENT_IMG_RESOURCE))
        local loader = imgPanel:GetChild("ImageLoader")
        loader.loaded = function(...)
    -- function num : 0_16_0 , upvalues : loader
    loader:SetSize(loader.width, (loader.texture).height)
  end

        loge("load:" .. eachData.Img)
        loader.url = eachData.Img
        ;
        (imgPanel.onClick):Clear()
        eachData.Component = imgPanel
      elseif eachData.Type == AnnouncementDataContentType.BigImage or onlyImage and eachData.Type == AnnouncementDataContentType.Image then
        imgPanel = list:AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.AnnouncementWindow).package, AnnouncementData.CONTENT_BIG_IMG_RESOURCE))
        local loader = imgPanel:GetChild("ImageLoader")
        loader.loaded = function(...)
    -- function num : 0_16_1 , upvalues : loader
    loader:SetSize(loader.width, (loader.texture).height)
  end

        loge("load:" .. eachData.Img)
        loader.url = eachData.Img
        eachData.Component = imgPanel
        ;
        (imgPanel:GetController("c1")).selectedIndex = 0
        ;
        (AnnouncementWindow.SetDatePanel)(imgPanel)
      else
        local component, text = nil, nil
        if eachData.Type == AnnouncementDataContentType.Button then
          component = list:AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.AnnouncementWindow).package, AnnouncementData.CONTENT_BUTTON_RESOURCE))
          local btn = component:GetChild("FunctionBtn")
          ;
          (btn:GetChild("title")).UBBEnabled = true
          btn.text = (PUtil.get)(60000072)
          ;
          (btn.onClick):Set(function(...)
    -- function num : 0_16_2 , upvalues : _lastPos, uis, _ENV, eachData
    _lastPos = (((uis.Announcement).ContentList).scrollPane).posY
    ld("GetWay")
    ;
    (GetWayMgr.Goto)(eachData.Goto)
  end
)
          eachData.Component = component
          component.x = list.viewWidth - btn.width - 20
        elseif eachData.Type == AnnouncementDataContentType.ImageBtn then
          local imgPanel = (contentData[i - 1]).Component
          if eachData.BtnType == AnnouncementDataBtnType.NoShow then
            (imgPanel:GetController("c1")).selectedIndex = 0
            ;
            (imgPanel.onClick):Set(function(...)
    -- function num : 0_16_3 , upvalues : _lastPos, uis, _ENV, eachData
    _lastPos = (((uis.Announcement).ContentList).scrollPane).posY
    ld("GetWay")
    ;
    (GetWayMgr.Goto)(eachData.Goto)
  end
)
          else
            local btn = nil
            ;
            (imgPanel:GetController("c1")).selectedIndex = 2
            btn = imgPanel:GetChild("RightBtn")
            if _originPos == nil then
              _originPos = btn.xy
            end
            if eachData.Offset ~= nil then
              if (eachData.Offset).x ~= nil then
                btn.x = _originPos.x + (eachData.Offset).x
              end
              if (eachData.Offset).y ~= nil then
                btn.y = _originPos.y + (eachData.Offset).y
              end
            end
            ;
            (btn:GetChild("title")).UBBEnabled = true
            btn.text = (PUtil.get)(60000072)
            ;
            (btn.onClick):Set(function(...)
    -- function num : 0_16_4 , upvalues : _lastPos, uis, _ENV, eachData
    _lastPos = (((uis.Announcement).ContentList).scrollPane).posY
    ld("GetWay")
    ;
    (GetWayMgr.Goto)(eachData.Goto)
  end
)
          end
        else
          component = list:AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.AnnouncementWindow).package, AnnouncementData.CONTENT_WORD_RESOURCE))
          text = component:GetChild("WordTxt")
          if _textOffsetX == nil then
            _textOffsetX = text.x
          end
          ;
          (text.onClick):Clear()
          text.text = eachData.Text
          if eachData.Align == AnnouncementDataAlignType.Center then
            text.x = (list.viewWidth - text.textWidth) * 0.5
          elseif eachData.Align == AnnouncementDataAlignType.Right then
            text.x = list.viewWidth - text.textWidth - _textOffsetX
          else
            text.x = _textOffsetX
          end
        end
      end
    end
  end
  -- DECOMPILER ERROR: 17 unprocessed JMP targets
end

AnnouncementWindow.SetTextFormat = function(text, format, ...)
  -- function num : 0_17 , upvalues : _textOffsetY, _lineGap, _ENV
  if _textOffsetY == nil then
    _textOffsetY = {top = text.y, bottom = (text.parent).height - text.y - text.height}
    _lineGap = -5
  end
  if format == AnnouncementTextFormat.Top then
    text.y = _lineGap
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (text.parent).height = text.y + text.textHeight + _textOffsetY.bottom
  else
    if format == AnnouncementTextFormat.Bottom then
      text.y = _textOffsetY.top
      -- DECOMPILER ERROR at PC40: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (text.parent).height = text.textHeight + _textOffsetY.top
    else
      if format == AnnouncementTextFormat.Both then
        text.y = _lineGap
        -- DECOMPILER ERROR at PC52: Confused about usage of register: R2 in 'UnsetPending'

        ;
        (text.parent).height = text.y + text.textHeight
      else
        text.y = _textOffsetY.top
        -- DECOMPILER ERROR at PC62: Confused about usage of register: R2 in 'UnsetPending'

        ;
        (text.parent).height = text.textHeight + _textOffsetY.top + _textOffsetY.bottom
      end
    end
  end
end

AnnouncementWindow.ClickCloseBtn = function(...)
  -- function num : 0_18 , upvalues : _ENV
  (RedDotMgr.RefreshTreeUI)((WinResConfig.HomeWindow).name)
  UIMgr:CloseWindow((WinResConfig.AnnouncementWindow).name)
end

AnnouncementWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_19 , upvalues : _ENV, AnnouncementWindow
  if msgId == (WindowMsgEnum.Announcement).E_MSG_REFRESH then
    (AnnouncementWindow.RefreshContent)(para)
  else
    if msgId == (WindowMsgEnum.Announcement).E_MSG_REFRESH_TITLE then
      (AnnouncementWindow.Init)()
    end
  end
end

return AnnouncementWindow

