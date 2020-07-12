-- params : ...
-- function num : 0 , upvalues : _ENV
require("Mail_MailByName")
require("Mail_WordByName")
local uis, contentPane = nil, nil
local MailWindow = {}
local mailScroll, itemScroll = nil, nil
local mailList = {}
local isDelete = false
local MAX_MAIL_NUM = 100
local constTenIndex = 0
local MailItemState = {NoItemNoRead = 0, NoItemIsRead = 1, IsItemNoReadNoGet = 2, IsItemIsReadNoGet = 3, IsItemIsReadIsGet = 4}
MailWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, uis, MailWindow, mailScroll, itemScroll, MAX_MAIL_NUM
  bridgeObj:SetView((WinResConfig.MailWindow).package, (WinResConfig.MailWindow).comName)
  contentPane = bridgeObj.contentPane
  contentPane:Center()
  uis = GetMail_MailUis(contentPane)
  local m = {}
  m.windowName = (WinResConfig.MailWindow).name
  m.Tip = (PUtil.get)(75)
  m.model = uis.AssetStripGrp
  m.closeToWindow = (WinResConfig.HomeWindow).name
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.MailNumberWordTxt).text = (PUtil.get)(76)
  ;
  ((uis.AllGetBtn):GetChild("title")).text = (PUtil.get)(77)
  ;
  ((uis.AllGetBtn).onClick):Add(MailWindow.ReqGetAllMailItems)
  -- DECOMPILER ERROR at PC69: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.AllGetBtn).visible = false
  mailScroll = uis.MailList
  itemScroll = uis.ItemList
  -- DECOMPILER ERROR at PC78: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.MailNumberTxt).text = "0/" .. MAX_MAIL_NUM
  ;
  (MailData.SaveClickedIndex)(-1)
  ;
  (MailWindow.SetListVirtual)()
  ;
  (MailWindow.UpdateTaskSpine)()
  ;
  (MailService.ReqMailList)()
end

MailWindow.SetListVirtual = function(...)
  -- function num : 0_1 , upvalues : mailScroll, MailWindow
  mailScroll:SetVirtual()
  mailScroll.itemRenderer = MailWindow.RefreshMailItem
  mailScroll:SetBeginAnim(true, "up", 0.05, 0.05, true)
end

MailWindow.RefreshMailItem = function(index, item, ...)
  -- function num : 0_2 , upvalues : mailList, _ENV, MailWindow
  local data = mailList[index + 1]
  ;
  ((item:GetChild("MailDetailed")):GetChild("SendPeopleWordTxt")).text = (PUtil.get)(81)
  ;
  ((item:GetChild("MailDetailed")):GetChild("SendTimeWordTxt")).text = (PUtil.get)(96)
  local mailData = {}
  if data.cId > 0 then
    mailData.title = (PUtil.get)(tonumber(data.title))
    mailData.sender = (PUtil.get)(tonumber(data.sender))
    mailData.live = data.live
  else
    mailData.title = data.title
    mailData.sender = data.sender
    mailData.live = data.live
  end
  ;
  ((item:GetChild("MailDetailed")):GetChild("MailNameTxt")).text = mailData.title
  ;
  ((item:GetChild("MailDetailed")):GetChild("SendPeopleNameTxt")).text = mailData.sender
  if data.live < 0 then
    ((item:GetChild("MailDetailed")):GetChild("SendTimeTxt")).text = (PUtil.get)(211)
  else
    ;
    ((item:GetChild("MailDetailed")):GetChild("SendTimeTxt")).text = (LuaTime.GetLeftTimeStr)((math.floor)(data.live * 0.001), true)
  end
  local mailState = (MailWindow.CheckMailState)(data)
  ;
  ((item:GetChild("MailDetailed")):GetController("c2")).selectedIndex = mailState
  ;
  ((item:GetChild("MailDetailed")):GetController("c1")).selectedIndex = 0
  ;
  (((item:GetChild("MailDetailed")):GetChild("MailTouchBtn")).onClick):Clear()
  ;
  (((item:GetChild("MailDetailed")):GetChild("MailTouchBtn")).onClick):Add(function(...)
    -- function num : 0_2_0 , upvalues : _ENV, index, data
    (MailData.SaveClickedIndex)(index)
    ;
    (MailService.ReqReadMail)(data.id)
  end
)
  if (MailData.GetClickedIndex)() == index then
    ((item:GetChild("MailDetailed")):GetController("c1")).selectedIndex = 1
  end
end

MailWindow.CheckMailState = function(data, ...)
  -- function num : 0_3 , upvalues : MailItemState
  local mailState = nil
  if data.hasAnnex == false and data.read == false then
    mailState = MailItemState.NoItemNoRead
  end
  if data.hasAnnex == false and data.read == true then
    mailState = MailItemState.NoItemIsRead
  end
  if data.hasAnnex == true and data.read == false and data.received == false then
    mailState = MailItemState.IsItemNoReadNoGet
  end
  if data.hasAnnex == true and data.read == true and data.received == false then
    mailState = MailItemState.IsItemIsReadNoGet
  end
  if data.hasAnnex == true and data.read == true and data.received == true then
    mailState = MailItemState.IsItemIsReadIsGet
  end
  return mailState
end

MailWindow.RefreshMailNumber = function(number, ...)
  -- function num : 0_4 , upvalues : mailScroll, MAX_MAIL_NUM, uis, _ENV, MailWindow
  mailScroll.numItems = number
  local color = nil
  if MAX_MAIL_NUM <= number then
    color = "[color=#ff5f7b]"
  else
    color = "[color=#3dffbd]"
  end
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.MailNumberTxt).text = color .. tostring(number) .. "[/color]/" .. MAX_MAIL_NUM
  do
    if (MailData.GetClickedIndex)() < 0 then
      local selectedIndex = 0
      if number > 0 then
        selectedIndex = 0
      else
        selectedIndex = 3
      end
      ;
      (MailWindow.SetMainWindowState)(selectedIndex)
    end
    if (MailWindow.CheckDisposeRedDot)() then
      (RedDotMgr.EliminateRedDot)((WinResConfig.MailWindow).name, RedDotComID.Mail_MainList)
    end
    ;
    (MailWindow.CheckUnGetItem)()
  end
end

MailWindow.RefreshMailDetail = function(detailInfo, ...)
  -- function num : 0_5 , upvalues : MailWindow, _ENV, uis
  local selectedIndex = 0
  if detailInfo.hasAnnex == true then
    selectedIndex = 2
  else
    selectedIndex = 1
  end
  ;
  (MailWindow.SetMainWindowState)(selectedIndex)
  local mailData = {}
  if detailInfo.cId > 0 then
    mailData.title = (PUtil.get)(tonumber(detailInfo.title))
    mailData.sender = (PUtil.get)(tonumber(detailInfo.sender))
    mailData.live = detailInfo.live
    local content = (PUtil.get)(tonumber(detailInfo.content))
    for i,v in ipairs(detailInfo.params) do
      content = (string.gsub)(content, "{" .. tostring(i - 1) .. "}", v)
    end
    mailData.content = content
    mailData.receive = detailInfo.receive
  else
    do
      mailData.title = detailInfo.title
      mailData.sender = detailInfo.sender
      mailData.live = detailInfo.live
      mailData.content = detailInfo.content
      mailData.receive = detailInfo.receive
      -- DECOMPILER ERROR at PC70: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (uis.TitleTxt).text = mailData.title
      -- DECOMPILER ERROR at PC79: Confused about usage of register: R3 in 'UnsetPending'

      if mailData.live < 0 then
        (uis.TimeTxt).text = (PUtil.get)(211)
      else
        -- DECOMPILER ERROR at PC97: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (uis.TimeTxt).text = (PUtil.get)(96) .. "  " .. (LuaTime.GetLeftTimeStr)((math.floor)(mailData.live * 0.001), true)
      end
      -- DECOMPILER ERROR at PC100: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (uis.SendPeopleNameTxt).text = mailData.sender
      -- DECOMPILER ERROR at PC107: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (uis.SendTimeTxt).text = (LuaTime.GetFormatTimeStr)("%Y-%m-%d", mailData.receive)
      -- DECOMPILER ERROR at PC113: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (uis.SendTimeWordTxt).text = (PUtil.get)(82)
      -- DECOMPILER ERROR at PC119: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (uis.SendPeopleWordTxt).text = (PUtil.get)(81)
      -- DECOMPILER ERROR at PC125: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (uis.EnclosureWordTxt).text = (PUtil.get)(204)
      -- DECOMPILER ERROR at PC129: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (uis.GetBtn).visible = not detailInfo.received
      ;
      ((uis.GetBtn):GetChild("title")).text = (PUtil.get)(60000023)
      ;
      ((uis.GetBtn).onClick):Clear()
      ;
      ((uis.GetBtn).onClick):Add(function(...)
    -- function num : 0_5_0 , upvalues : _ENV, detailInfo
    (MailService.ReqGetAllMailAnnex)(detailInfo.id)
  end
)
      -- DECOMPILER ERROR at PC150: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (uis.DeleteBtn).visible = detailInfo.canDel
      ;
      ((uis.DeleteBtn).onClick):Clear()
      ;
      ((uis.DeleteBtn).onClick):Add(function(...)
    -- function num : 0_5_1 , upvalues : detailInfo, _ENV
    if detailInfo.hasAnnex == true then
      if detailInfo.received == false then
        (MessageMgr.OpenConfirmWindow)((PUtil.get)(95), function(...)
      -- function num : 0_5_1_0 , upvalues : _ENV, detailInfo
      (MailService.ReqDeleteMail)(detailInfo.id)
    end
)
      else
        ;
        (MailService.ReqDeleteMail)(detailInfo.id)
      end
    else
      ;
      (MailService.ReqDeleteMail)(detailInfo.id)
    end
  end
)
      ;
      (MailWindow.SetWorldList)(mailData.content)
      ;
      (MailWindow.SetItemList)(detailInfo.annexList)
    end
  end
end

MailWindow.SetMainWindowState = function(selectedIndex, ...)
  -- function num : 0_6 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (uis.c1Ctr).selectedIndex = selectedIndex
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  if selectedIndex == 0 then
    (uis.UnHaveMailTxt).text = (PUtil.get)(198)
  else
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.UnHaveMailTxt).text = (PUtil.get)(199)
  end
end

MailWindow.SetWorldList = function(wordInfo, ...)
  -- function num : 0_7 , upvalues : uis, _ENV, MailWindow
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (uis.WordList).numItems = 0
  local rule = split(wordInfo, "::")
  for i,v in ipairs(rule) do
    if not (Util.StringIsNullOrEmpty)(v) then
      local line = (MailWindow.CreateLine)(v)
      if line then
        (uis.WordList):AddChild(line)
      end
    end
  end
end

MailWindow.CreateLine = function(content, ...)
  -- function num : 0_8 , upvalues : _ENV
  if (Util.StringIsNullOrEmpty)(content) then
    return 
  end
  local lineModel = UIMgr:CreateObject("Mail", "Word")
  local model = GetMail_WordUis(lineModel)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (model.ContentTxt).UBBEnabled = true
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'

  if (string.sub)(content, 0, 2) == "%%" then
    (model.TabImage).visible = false
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (model.ContentTxt).text = (string.sub)(content, 3)
  else
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (model.ContentTxt).text = content
  end
  return lineModel
end

MailWindow.SetItemList = function(itemList, ...)
  -- function num : 0_9 , upvalues : uis, _ENV
  (uis.ItemList):RemoveChildrenToPool()
  itemList = (Util.MajorSort)(itemList, 1207)
  for i,v in pairs(itemList) do
    (Util.SetFrame)(v.id, v.value, uis.ItemList, false, false)
  end
end

MailWindow.ReqGetAllMailItems = function(...)
  -- function num : 0_10 , upvalues : MailWindow, _ENV
  if (MailWindow.CheckUnGetItem)() == true then
    (MailService.ReqGetAllMailAnnex)()
  else
    ;
    (MessageMgr.SendCenterTips)((PUtil.get)(83))
  end
end

MailWindow.CheckUnGetItem = function(...)
  -- function num : 0_11 , upvalues : _ENV, mailList, uis
  local ishv = false
  for i,v in ipairs(mailList) do
    if v.received == false and v.hasAnnex == true then
      ishv = true
      break
    end
  end
  do
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.AllGetBtn).visible = ishv or not #mailList == 0
    do return ishv end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

MailWindow.SortMailList = function(list, ...)
  -- function num : 0_12 , upvalues : _ENV
  (table.sort)(list, function(a, b, ...)
    -- function num : 0_12_0
    local aWeight = 0
    local bWeight = 0
    if a.read == false then
      aWeight = aWeight + 100
    else
      if a.hasAnnex == true then
        aWeight = aWeight + 50
      end
      if a.received == false then
        aWeight = aWeight + 20
      end
    end
    if b.read == false then
      bWeight = bWeight + 100
    else
      if b.hasAnnex == true then
        bWeight = bWeight + 50
      end
      if b.received == false then
        bWeight = bWeight + 20
      end
    end
    if b.live < a.live then
      aWeight = aWeight + 10
    else
      bWeight = bWeight + 10
    end
    do return bWeight < aWeight end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

MailWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_13 , upvalues : _ENV, mailList, MailWindow, isDelete, constTenIndex, uis
  local windowMsgEnum = WindowMsgEnum.Mail
  if msgId == windowMsgEnum.E_MSG_MAIL_LIST then
    mailList = {}
    mailList = para.mailList
    ;
    (MailWindow.SortMailList)(mailList)
    if isDelete == false then
      (MailData.SaveClickedIndex)(-1)
    else
      isDelete = true
    end
    ;
    (MailData.SaveMailData)(mailList)
    local constTenId = (ActorService.RegisterMail)()
    if constTenId ~= nil and constTenId ~= 0 then
      local isRecive = (MailData.GetMailIsRecive)(constTenId)
      if isRecive == false then
        constTenIndex = (MailData.GetMailIndex)(constTenId)
        ;
        (MailData.SaveClickedIndex)(constTenIndex)
        ;
        (MailService.ReqReadMail)(constTenId)
      else
        ;
        (MailWindow.RefreshMailNumber)(#mailList)
      end
    else
      do
        do
          ;
          (MailWindow.RefreshMailNumber)(#mailList)
          -- DECOMPILER ERROR at PC71: Unhandled construct in 'MakeBoolean' P1

          if msgId == windowMsgEnum.E_MSG_MAIL_DETAIL and para.detailInfo ~= nil then
            (MailWindow.RefreshMailDetail)(para.detailInfo)
            local isCurRead = (MailData.GetMailIsRead)((para.detailInfo).id)
            ;
            (MailData.ChangeMailIsRead)((para.detailInfo).id, true)
            mailList = {}
            mailList = (MailData.GetMailData)()
            ;
            (MailWindow.RefreshMailNumber)(#mailList)
          end
          do
            if msgId == windowMsgEnum.E_MSG_MAIL_DELETE then
              isDelete = true
              mailList = {}
              mailList = (MailData.GetMailData)()
              ;
              (MailWindow.DeletMail)(mailList, para.id)
              ;
              (MailData.SaveMailData)(mailList)
              if #mailList > 0 then
                (MailData.SaveClickedIndex)(0)
                ;
                (MailService.ReqReadMail)((mailList[1]).id)
              else
                -- DECOMPILER ERROR at PC128: Confused about usage of register: R3 in 'UnsetPending'

                ;
                (uis.c1Ctr).selectedIndex = 3
                ;
                (MailWindow.RefreshMailNumber)(#mailList)
              end
            end
          end
        end
      end
    end
  end
end

MailWindow.DeletMail = function(list, mailId, ...)
  -- function num : 0_14 , upvalues : _ENV
  local index = 1
  for i,v in ipairs(list) do
    if v.id ~= mailId then
      do
        index = index + 1
        -- DECOMPILER ERROR at PC9: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC9: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  ;
  (table.remove)(list, index)
end

MailWindow.CheckDisposeRedDot = function(...)
  -- function num : 0_15 , upvalues : _ENV, mailList
  for _,v in pairs(mailList) do
    if (v.hasAnnex == true and v.received == false) or v.read == false then
      return false
    end
  end
  return true
end

MailWindow.UpdateTaskSpine = function(...)
  -- function num : 0_16 , upvalues : _ENV, uis
  (Util.SetNotFoundEffect)(uis.CardLoader)
end

MailWindow.OnClose = function(...)
  -- function num : 0_17 , upvalues : _ENV, uis, contentPane, mailScroll, itemScroll, constTenIndex, mailList, isDelete
  (CommonWinMgr.RemoveAssets)((WinResConfig.MailWindow).name)
  uis = nil
  contentPane = nil
  mailScroll = nil
  itemScroll = nil
  constTenIndex = 0
  mailList = nil
  isDelete = false
end

return MailWindow

