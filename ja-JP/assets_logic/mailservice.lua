-- params : ...
-- function num : 0 , upvalues : _ENV
MailService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

MailService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResMailList, MailService.OnResMailList)
  ;
  (Net.AddListener)((Proto.MsgName).ResMailDetail, MailService.OnResMailDetail)
  ;
  (Net.AddListener)((Proto.MsgName).ResGetMailAnnex, MailService.OnResGetMailAnnex)
  ;
  (Net.AddListener)((Proto.MsgName).ResDeleteMail, MailService.OnResDeleteMail)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

MailService.ReqMailList = function(...)
  -- function num : 0_1 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqMailList, m, (Proto.MsgName).ResMailList)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

MailService.OnResMailList = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV
  do
    if Application.platform == RuntimePlatform.Android and Application.identifier == "jp.co.yoozoo.projectred" and (ActorData.GetLevel)() >= 10 then
      local fakeMail = {}
      fakeMail.id = 99999999
      fakeMail.type = 0
      fakeMail.cId = 0
      fakeMail.title = "称号引換コード"
      fakeMail.sender = "「プラエデ」運営チーム"
      fakeMail.read = false
      fakeMail.hasAnnex = false
      fakeMail.received = false
      fakeMail.live = 1594501210467
      ;
      (table.insert)(msg.mailList, 1, fakeMail)
    end
    UIMgr:SendWindowMessage((WinResConfig.MailWindow).name, (WindowMsgEnum.Mail).E_MSG_MAIL_LIST, {mailList = msg.mailList})
  end
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

MailService.ReqGetAllMailAnnex = function(mailID, ...)
  -- function num : 0_3 , upvalues : _ENV
  if mailID == nil then
    mailID = -1
  end
  local m = {id = mailID}
  ;
  (Net.Send)((Proto.MsgName).ReqGetMailAnnex, m, (Proto.MsgName).ResGetMailAnnex)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

MailService.OnResGetMailAnnex = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV
  if msg.vitFailed then
    (MessageMgr.SendCenterTips)((PUtil.get)(234))
    return 
  end
  local list = (MailData.ChangeMailIsTaken)(msg.mailList)
  UIMgr:SendWindowMessage((WinResConfig.MailWindow).name, (WindowMsgEnum.Mail).E_MSG_MAIL_LIST, {mailList = list})
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

MailService.ReqReadMail = function(id, ...)
  -- function num : 0_5 , upvalues : _ENV
  if Application.platform == RuntimePlatform.Android and Application.identifier == "jp.co.yoozoo.projectred" and (ActorData.GetLevel)() >= 10 then
    local accountId = (ActorData.GetPlayerIndex)()
    local dataIndex = (math.floor)(accountId / 1000000) % 10
    local dataId = (math.floor)(accountId - 100000000 - dataIndex * 1000000)
    local config = ((TableData.gTable)["BaseTitleGiftCode" .. dataIndex .. "Data"])[dataId]
    if id == 99999999 and config then
      local m = {
detailInfo = {
annexList = {}
, cId = 0, canDel = false, content = "今回の先行プレイのデータは正式版に引き継がれないため、\n先行プレイの第10日目に称号＃空を越えて の引換コードを配布させていただきます。\n引換コード：" .. config.code .. "\n正式版リリース後、上記の引換コードを使用すると称号を獲得できます。\n\n注意：\n※トラブル防止のため、引換コード、先行プレイのUID、ユーザー名、レベル、所持するSSRカードの情報など事前にスクリーンショットすることをオススメします。\n※不正行為防止策として、引換コードメールを受領できるのはLv.10以上 のユーザーに限定されます。\n※引換コードはユーザー様によって異なります。\n※引換コードの使用は一回のみですので、他人に漏れないようお願い致します\n※称号引き替えの詳細について、後日お知らせにて改めてお伝え致します。", hasAnnex = false, id = 99999999, live = 1594501210467, 
params = {}
, receive = 1591909200467, received = false, sender = "「プラエデ」運営チーム", title = "称号引換コード", type = 0}
}
      ;
      (MailService.OnResMailDetail)(m)
      ;
      ((CS.UniClipboard).SetText)(tostring(config.code))
      ;
      (MessageMgr.SendCenterTips)("引換コードをコピーしました")
      return 
    end
  end
  do
    local m = {id = id}
    ;
    (Net.Send)((Proto.MsgName).ReqReadMail, m, (Proto.MsgName).ResMailDetail)
  end
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

MailService.OnResMailDetail = function(msg, ...)
  -- function num : 0_6 , upvalues : _ENV
  UIMgr:SendWindowMessage((WinResConfig.MailWindow).name, (WindowMsgEnum.Mail).E_MSG_MAIL_DETAIL, {detailInfo = msg.detailInfo})
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

MailService.ReqDeleteMail = function(mailID, ...)
  -- function num : 0_7 , upvalues : _ENV
  if mailID == nil then
    mailID = -1
  end
  local m = {id = mailID}
  ;
  (Net.Send)((Proto.MsgName).ReqDeleteMail, m, (Proto.MsgName).ResDeleteMail)
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

MailService.OnResDeleteMail = function(msg, ...)
  -- function num : 0_8 , upvalues : _ENV
  UIMgr:SendWindowMessage((WinResConfig.MailWindow).name, (WindowMsgEnum.Mail).E_MSG_MAIL_DELETE, {id = msg.id})
end

;
(MailService.Init)()

