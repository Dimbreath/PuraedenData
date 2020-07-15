-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_GuildMainByName")
local GTween = FairyGUI.GTween
local EmojiParser = CS.EmojiParser
local GuildMainWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _chatList = nil
local _timers = {}
local ExpressionUis = nil
local EmojiLisData = {}
local emojiIsOpen = false
local emojiGprHeight = nil
local ChatIsMax = false
local ChatMaxWidth = 650
local ChatMinWidth = 400
local _blurObj, _zoomInAnim, _zoomOutAnim = nil, nil, nil
GuildMainWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, GuildMainWindow
  bridgeObj:SetView((WinResConfig.GuildMainWindow).package, (WinResConfig.GuildMainWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetGuild_GuildMainUis(contentPane)
  ;
  (GuildMainWindow.InitTopMenu)()
  ;
  (GuildMainWindow.InitVariable)()
  ;
  (GuildMainWindow.InitText)()
  ;
  (GuildMainWindow.InitList)()
  ;
  (GuildMainWindow.InitButtonEvent)()
  ;
  (GuildMainWindow.InitEOMJICom)()
  ;
  (GuildMainWindow.BindingUI)()
  ;
  (GuildMainWindow.InitFunctionControl)()
end

GuildMainWindow.InitFunctionControl = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local winName = (WinResConfig.GuildMainWindow).name
  local RegisterGuideAndControl = GuideData.RegisterGuideAndControl
  local ControlID = ControlID
  RegisterGuideAndControl(ControlID.Guild_Guess, uis.GuessBtn, winName)
  RegisterGuideAndControl(ControlID.Guild_Construction, uis.BuildBtn, winName)
  RegisterGuideAndControl(ControlID.Guild_Gift, uis.LuckyBagBtn, winName)
end

GuildMainWindow.BindingUI = function(...)
  -- function num : 0_2 , upvalues : _ENV, uis
  local winName = (WinResConfig.GuildMainWindow).name
  local BindingUI = RedDotMgr.BindingUI
  local RedDotComID = RedDotComID
  BindingUI(winName, RedDotComID.Guild_Detail, (uis.MainInformationGrp).DetailsBtn)
  BindingUI(winName, RedDotComID.Guild_Construction, uis.BuildBtn)
  BindingUI(winName, RedDotComID.Guild_Guess, uis.GuessBtn)
  BindingUI(winName, RedDotComID.Guild_Gift, uis.LuckyBagBtn)
  ;
  (RedDotMgr.RefreshTreeUI)(winName)
end

GuildMainWindow.InitTopMenu = function(...)
  -- function num : 0_3 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.GuildMainWindow).name
  m.Tip = (PUtil.get)(60000254)
  m.model = uis.AssetStripGrp
  m.BackBtnFun = function(...)
    -- function num : 0_3_0 , upvalues : _ENV
    (GuildMgr.ReqChangeGuildChatStatus)(false)
  end

  m.CloseBtnFun = function(...)
    -- function num : 0_3_1 , upvalues : _ENV
    (GuildMgr.ReqChangeGuildChatStatus)(false)
  end

  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.SHOP_TOKEN}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

GuildMainWindow.InitVariable = function(...)
  -- function num : 0_4 , upvalues : _chatList, uis, _zoomInAnim, _zoomOutAnim, _blurObj
  _chatList = ((uis.ChatGrp).ChatFrameGrp).ChatList
  _zoomInAnim = (uis.root):GetTransition("ChatBig")
  _zoomOutAnim = (uis.root):GetTransition("ChatSmall")
  _blurObj = ((uis.ChatGrp).root):GetChild("PopBg")
end

GuildMainWindow.InitText = function(...)
  -- function num : 0_5 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  (((uis.ChatGrp).ChatFrameGrp).InputTxt).promptText = (PUtil.get)(60000460)
end

GuildMainWindow.InitButtonEvent = function(...)
  -- function num : 0_6 , upvalues : uis, GuildMainWindow, _ENV
  ((uis.BuildBtn).onClick):Add(GuildMainWindow.ClickBuildingBtn)
  ;
  ((uis.InformationBtn).onClick):Add(GuildMainWindow.ClickIntelligenceBtn)
  ;
  ((uis.LuckyBagBtn).onClick):Add(GuildMainWindow.ClickRewardBtn)
  ;
  ((uis.GuessBtn).onClick):Add(GuildMainWindow.ClickMiniGameBtn)
  ;
  ((((uis.ChatGrp).ChatFrameGrp).SwitchBtn).onClick):Set(GuildMainWindow.ClickSwitchChatStatusBtn)
  ;
  ((((uis.ChatGrp).ChatFrameGrp).EmojiBtn).onClick):Set(GuildMainWindow.ClickEmojiBtn)
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.ChatGrp).ChatFrameGrp).SureBtn).text = (PUtil.get)(20000179)
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((((uis.ChatGrp).ChatFrameGrp).InputTxt).inputTextField).RestrictRow = 9
  -- DECOMPILER ERROR at PC51: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((((uis.ChatGrp).ChatFrameGrp).InputTxt).inputTextField).ForbidSpace = false
  ;
  ((((uis.ChatGrp).ChatFrameGrp).SureBtn).onClick):Set(function(...)
    -- function num : 0_6_0 , upvalues : uis, _ENV
    local content = (((uis.ChatGrp).ChatFrameGrp).InputTxt).text
    if not (Util.StringIsNullOrEmpty)(content) then
      local content = ((CS.DirtyWordChecker).Singleton):Replace(content)
      ;
      (ChatService.ReqSetGuildChat)(content)
    else
      do
        ;
        (MessageMgr.SendCenterTips)((PUtil.get)(20000227))
        -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

        ;
        (((uis.ChatGrp).ChatFrameGrp).InputTxt).text = ""
      end
    end
  end
)
end

GuildMainWindow.InitEvent = function(...)
  -- function num : 0_7
end

GuildMainWindow.RemoveEvent = function(...)
  -- function num : 0_8
end

GuildMainWindow.OnShown = function(...)
  -- function num : 0_9 , upvalues : GuildMainWindow, _ENV
  (GuildMainWindow.InitEvent)()
  ;
  (GuildMainWindow.Init)()
  ;
  (GuideMgr.PictureTriggerGuide)((WinResConfig.GuildMainWindow).name)
end

GuildMainWindow.OnHide = function(...)
  -- function num : 0_10
end

GuildMainWindow.Init = function(...)
  -- function num : 0_11 , upvalues : _blurObj, argTable, GuildMainWindow, _ENV, uis
  _blurObj.visible = false
  ;
  (argTable[1])()
  ;
  (GuildMainWindow.RefreshGiftRedDot)()
  ;
  (GuildMgr.ReqChangeGuildChatStatus)(true)
  ;
  (GuildMgr.InitGuildBasicInfoPanel)(uis.MainInformationGrp, GuildDetailPanelType.Main)
end

GuildMainWindow.RefreshGiftRedDot = function(...)
  -- function num : 0_12 , upvalues : _ENV
  local hideRedNode = (_G.next)(GuildData.RewardStatus) ~= nil
  for k,v in pairs(GuildData.RewardStatus) do
    if not v.isDraw then
      hideRedNode = false
    end
  end
  if hideRedNode then
    (RedDotMgr.EliminateRedDot)((WinResConfig.GuildMainWindow).name, RedDotComID.Guild_Gift)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

GuildMainWindow.OnClose = function(...)
  -- function num : 0_13 , upvalues : _ENV, GuildMainWindow, uis, contentPane, argTable
  (CommonWinMgr.RemoveAssets)((WinResConfig.GuildMainWindow).name)
  ;
  (RedDotMgr.EliminateRedDot)((WinResConfig.GuildMainWindow).name)
  ;
  (GuideData.AbolishControlRefer)((WinResConfig.GuildMainWindow).name)
  ;
  (GuildMainWindow.RemoveEvent)()
  ;
  (GuildMainWindow.ClearChatTimers)()
  uis = nil
  contentPane = nil
  argTable = {}
  ;
  (GRoot.inst):ClearCustomPopups()
end

GuildMainWindow.ClickBuildingBtn = function(...)
  -- function num : 0_14 , upvalues : _ENV
  (GuildMgr.ReqGuildBuildingInfo)()
end

GuildMainWindow.ClickIntelligenceBtn = function(...)
  -- function num : 0_15 , upvalues : _ENV
  (GuildService.ReqGuildRank)()
end

GuildMainWindow.ClickRewardBtn = function(...)
  -- function num : 0_16 , upvalues : _ENV
  (GuildMgr.PreOpenGuildRewardStatus)()
end

GuildMainWindow.ClickMiniGameBtn = function(...)
  -- function num : 0_17 , upvalues : _ENV
  (GuildService.ReqGuildGameInit)()
end

GuildMainWindow.InitEOMJICom = function(...)
  -- function num : 0_18 , upvalues : _ENV, ExpressionUis, uis, GuildMainWindow, emojiGprHeight
  UIMgr:LoadPackage("Emoji")
  ;
  (GuildData.InitEmojiList)()
  ExpressionUis = ((uis.ChatGrp).ChatFrameGrp).EmojiChoiceGrp
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (ExpressionUis.TypeList).itemRenderer = GuildMainWindow.ExpressionGroupRender
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (ExpressionUis.EmojiList).itemRenderer = GuildMainWindow.ExpressionEmojiRender
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (ExpressionUis.TypeList).numItems = #GuildData.ExpressionGroup
  emojiGprHeight = ((((uis.ChatGrp).ChatFrameGrp).EmojiChoiceGrp).root).height
end

GuildMainWindow.ClickSwitchChatStatusBtn = function(...)
  -- function num : 0_19 , upvalues : ChatIsMax, _blurObj, uis, ExpressionUis, _zoomInAnim, _zoomOutAnim, _chatList
  ChatIsMax = not ChatIsMax
  if ChatIsMax then
    _blurObj.visible = true
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (((uis.ChatGrp).ChatFrameGrp).c1Ctr).selectedIndex = 1
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (ExpressionUis.c1Ctr).selectedIndex = 1
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.AssetStripGrp).root).visible = false
    _zoomInAnim:Play()
  else
    _blurObj.visible = false
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (((uis.ChatGrp).ChatFrameGrp).c1Ctr).selectedIndex = 0
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (ExpressionUis.c1Ctr).selectedIndex = 0
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.AssetStripGrp).root).visible = true
    _zoomOutAnim:Play()
  end
  ;
  (_chatList.scrollPane):ScrollBottom()
  _chatList:RefreshVirtualListImmediately()
end

GuildMainWindow.ExpressionGroupRender = function(index, obj, ...)
  -- function num : 0_20 , upvalues : _ENV, GuildMainWindow
  local data = (GuildData.ExpressionGroup)[index + 1]
  ;
  (obj:GetChild("WordTxt")).text = data.name
  ;
  (obj.onClick):Set(function(...)
    -- function num : 0_20_0 , upvalues : GuildMainWindow, data
    (GuildMainWindow.OnClickGroupBtn)(data.id)
  end
)
end

GuildMainWindow.ExpressionEmojiRender = function(index, obj, ...)
  -- function num : 0_21 , upvalues : EmojiLisData, _ENV, GuildMainWindow
  local data = EmojiLisData[index + 1]
  ;
  (obj:GetChild("EmojiLoader")).url = (Util.GetItemUrl)("Emoji:" .. data.name)
  ;
  ((obj:GetChild("EmojiLoader")).onClick):Set(function(context, ...)
    -- function num : 0_21_0 , upvalues : _ENV, data, GuildMainWindow
    local item = context.sender
    local name = "[:custom_" .. ((UIPackage.GetItemByURL)(item.icon)).name .. "]"
    ;
    (ChatService.ReqSetGuildChat)(name)
    ;
    (GuildData.AddEmojiToOftenList)(data.id)
    ;
    (GuildMainWindow.ClickEmojiBtn)()
    ;
    (GRoot.inst):ClearCustomPopups()
  end
)
end

GuildMainWindow.OnClickGroupBtn = function(id, ...)
  -- function num : 0_22 , upvalues : ExpressionUis, GuildMainWindow, EmojiLisData, _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  (ExpressionUis.TypeList).selectedIndex = (GuildMainWindow.GetGroupIndex)(id) - 1
  EmojiLisData = (GuildData.ExpressionList)[id]
  if EmojiLisData and #EmojiLisData > 0 then
    if id ~= GuildData.OFTEN_TYPE_KEY then
      (table.sort)(EmojiLisData, function(a, b, ...)
    -- function num : 0_22_0
    do return a.sort < b.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    end
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (ExpressionUis.EmojiList).numItems = #EmojiLisData
  else
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (ExpressionUis.EmojiList).numItems = 0
  end
end

GuildMainWindow.GetGroupIndex = function(id, ...)
  -- function num : 0_23 , upvalues : _ENV
  for i,v in ipairs(GuildData.ExpressionGroup) do
    if v.id == id then
      return i
    end
  end
end

GuildMainWindow.ClickEmojiBtn = function(...)
  -- function num : 0_24 , upvalues : emojiIsOpen, uis, emojiGprHeight, _ENV, ExpressionUis, GuildMainWindow, GTween
  emojiIsOpen = not emojiIsOpen
  local startPos = ((((uis.ChatGrp).ChatFrameGrp).root):GetChild("ChatFrame")).y
  local endPos = nil
  if emojiIsOpen then
    endPos = startPos - emojiGprHeight
    ;
    (GRoot.inst):AddCustomPopups(ExpressionUis.root, function(...)
    -- function num : 0_24_0 , upvalues : _ENV, uis, GuildMainWindow
    if (GRoot.inst).touchTarget ~= ((uis.ChatGrp).ChatFrameGrp).EmojiBtn then
      (GuildMainWindow.ClickEmojiBtn)()
    end
  end
)
    local often = ((GuildData.ExpressionGroup)[1]).id
    local EmojiLisData = (GuildData.ExpressionList)[often]
    if #EmojiLisData > 0 then
      (GuildMainWindow.OnClickGroupBtn)(often)
    else
      ;
      (GuildMainWindow.OnClickGroupBtn)(((GuildData.ExpressionGroup)[2]).id)
    end
  else
    do
      endPos = startPos + emojiGprHeight
      local gt = (GTween.To)(startPos, endPos, 0.3)
      gt:OnUpdate(function(...)
    -- function num : 0_24_1 , upvalues : uis, gt
    if uis then
      ((((uis.ChatGrp).ChatFrameGrp).root):GetChild("ChatFrame")).y = (gt.value).x
    end
  end
)
    end
  end
end

GuildMainWindow.GetChatItemUrl = function(index, ...)
  -- function num : 0_25 , upvalues : _ENV
  local data = (GuildData.ShowChats)[index + 1]
  if data.logType ~= nil then
    return (Util.GetResUrl)(GuildData.GUILD_CHAT_LOG_ITEM)
  else
    if data.pId == (ActorData.GetPlayerIndex)() then
      return (Util.GetResUrl)(GuildData.GUILD_CHAT_SELF_ITEM)
    else
      return (Util.GetResUrl)(GuildData.GUILD_CHAT_OTHER_ITEM)
    end
  end
end

GuildMainWindow.RefreshChatItem = function(index, item, ...)
  -- function num : 0_26 , upvalues : _ENV, _timers, EmojiParser, ChatIsMax, ChatMaxWidth, ChatMinWidth
  local data = (GuildData.ShowChats)[index + 1]
  if data.logType ~= nil then
    (item:GetChild("WordTxt")).text = (PUtil.get)(60000218, data.memberName)
  else
    if ((GuildData.BaseInfo).members)[data.pId] ~= nil and (ProtoEnum.GUILD_POST).ELDER_POST < ((GuildData.BaseInfo).members)[data.pId] then
      (item:GetChild("PlayerNameTxt")).text = data.pName .. (PUtil.get)(60000234, (GuildData.GetPositionName)(((GuildData.BaseInfo).members)[data.pId]))
    else
      ;
      (item:GetChild("PlayerNameTxt")).text = data.pName
    end
    ;
    (item:GetChild("TimeTxt")).text = (PUtil.get)(60000234, (LuaTime.GetLeftTimeStr)(data.time * 0.001))
    do
      if (LuaTime.GetTimeStamp)() - data.time < 3600 then
        local timer = (SimpleTimer.new)(60, -1, function(...)
    -- function num : 0_26_0 , upvalues : _ENV, data, item
    if (LuaTime.GetTimeStamp)() - data.time >= 3600 then
      timer:stop()
    end
    ;
    (item:GetChild("TimeTxt")).text = (PUtil.get)(60000234, (LuaTime.GetLeftTimeStr)(data.time * 0.001))
  end
)
        timer:start()
        ;
        (table.insert)(_timers, timer)
      end
      local headGrp, wordGrp = nil, nil
      if data.pId == (ActorData.GetPlayerIndex)() then
        headGrp = item:GetChild("OneSelfGrp")
        wordGrp = item:GetChild("OneSelfChatWordGrp")
      else
        headGrp = item:GetChild("OtherPlayerGrp")
        wordGrp = item:GetChild("OtherChatWordGrp")
        local ChatStatus = item:GetChild("ChatStatus")
        local PositionName = ((GuildData.BaseInfo).members)[data.pId]
        if PositionName ~= nil and PositionName == (ProtoEnum.GUILD_POST).LEADER_POST then
          ChangeUIController(ChatStatus, "c1", 0)
        else
          if PositionName ~= nil and PositionName == (ProtoEnum.GUILD_POST).VICE_LEADER_POST then
            ChangeUIController(ChatStatus, "c1", 1)
          else
            ChangeUIController(ChatStatus, "c1", 2)
          end
        end
      end
      do
        local content = wordGrp:GetChild("WordTxt")
        local mLoader = headGrp:GetChild("ActorHeadLoader")
        mLoader.url = (Util.GetHeadIconByFashionId)(data.fashionHead, HeadIconType.ROUND)
        mLoader:InvalidateBatchingState()
        content.text = (EmojiParser.inst):Parse(data.content)
        if ChatIsMax then
          content.width = ChatMaxWidth
          content.width = (math.min)(ChatMaxWidth, content.textWidth)
        else
          content.width = ChatMinWidth
          content.width = (math.min)(ChatMinWidth, content.textWidth)
        end
      end
    end
  end
end

GuildMainWindow.RefreshChatList = function(...)
  -- function num : 0_27 , upvalues : GuildMainWindow, _ENV, _chatList
  (GuildMainWindow.ClearChatTimers)()
  local count = #GuildData.ShowChats
  _chatList.numItems = count
  ;
  (_chatList.scrollPane):ScrollBottom()
end

GuildMainWindow.ClearChatTimers = function(...)
  -- function num : 0_28 , upvalues : _timers
  local count = #_timers
  for i = 1, count do
    (_timers[i]):stop()
  end
  _timers = {}
end

GuildMainWindow.InitList = function(...)
  -- function num : 0_29 , upvalues : _chatList, GuildMainWindow
  _chatList:SetVirtual()
  _chatList.itemRenderer = GuildMainWindow.RefreshChatItem
  _chatList.itemProvider = GuildMainWindow.GetChatItemUrl
end

GuildMainWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_30 , upvalues : _ENV, GuildMainWindow
  if msgId == (WindowMsgEnum.Guild).E_MSG_INIT_GUILD_CHAT then
    (GuildMainWindow.RefreshChatList)()
  end
end

return GuildMainWindow

