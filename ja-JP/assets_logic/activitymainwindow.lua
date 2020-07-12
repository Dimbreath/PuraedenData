-- params : ...
-- function num : 0 , upvalues : _ENV
require("Activity_ActivityMainByName")
require("Activity_ActivityBtnByName")
local ActivityMainWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local openIndex = 1
local viewRefer = {}
local winInformation = {}
local windowObj = {}
local currentObj = nil
local btnList = {}
local isBackOpen = false
ActivityMainWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, isBackOpen, winInformation, viewRefer, uis, ActivityMainWindow, btnList, openIndex
  bridgeObj:SetView((WinResConfig.ActivityMainWindow).package, (WinResConfig.ActivityMainWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  isBackOpen = bridgeObj.OpenFromClose
  for _,v in pairs(ActivityWindowName) do
    local isOpen = (ActivityMgr.GetIsOpenByMsgID)(v.MsgID)
    if (Util.StringIsNullOrEmpty)(v.name) or winInformation[v.MsgID] or v.isOpen == false or isOpen == false then
      loge("活动msg" .. v.MsgID .. "未开启")
    else
      local req = require(v.name)
      viewRefer[v.MsgID] = req
      winInformation[v.MsgID] = v
    end
  end
  uis = GetActivity_ActivityMainUis(contentPane)
  ;
  (ActivityMainWindow.InitAssetStrip)()
  -- DECOMPILER ERROR at PC61: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.ButtonList).itemRenderer = ActivityMainWindow.BtnRender
  ;
  (ActivityMainWindow.RefreshBtnList)()
  if isBackOpen then
    local wordID = btnList[openIndex]
    ;
    (ActivityMainWindow.OnClickFun)(wordID.name)
  end
end

ActivityMainWindow.RefreshBtnList = function(...)
  -- function num : 0_1 , upvalues : btnList, _ENV, winInformation, uis, openIndex
  btnList = {}
  for _,v in pairs(winInformation) do
    (table.insert)(btnList, v)
  end
  ;
  (table.sort)(btnList, function(a, b, ...)
    -- function num : 0_1_0
    do return a.BtnSort < b.BtnSort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.ButtonList).numItems = #btnList
  openIndex = (Umath.Clamp)(openIndex, 1, #btnList)
  ;
  (RedDotMgr.RefreshTreeUI)((WinResConfig.ActivityMainWindow).name)
end

ActivityMainWindow.BtnRender = function(index, obj, ...)
  -- function num : 0_2 , upvalues : btnList, _ENV, uis, ActivityMainWindow
  local wordID = btnList[index + 1]
  local model = GetActivity_ActivityBtnUis(obj)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (model.PicLoader).url = (Util.GetItemUrl)(wordID.btnBg)
  if wordID.RedDotID then
    (RedDotMgr.BindingUI)((WinResConfig.ActivityMainWindow).name, wordID.RedDotID, obj)
  end
  ;
  (obj.onClick):Set(function(...)
    -- function num : 0_2_0 , upvalues : uis, index, ActivityMainWindow, wordID
    if (uis.ButtonList).selectedIndex == index then
      return 
    end
    ;
    (ActivityMainWindow.OnClickFun)(wordID.name)
  end
)
end

ActivityMainWindow.OnClickFun = function(viewName, ...)
  -- function num : 0_3 , upvalues : _ENV
  if viewName == (ActivityWindowName.ActivitySignView).name then
    (ActivityService.OnReqSignInInit)()
  else
    if viewName == (ActivityWindowName.ActivityCakeView).name then
      (ActivityService.OnReqVitGetInit)()
    else
      if viewName == (ActivityWindowName.ActivityBindingView).name then
        UIMgr:SendWindowMessage((WinResConfig.ActivityMainWindow).name, (WindowMsgEnum.ActivityMainWindow).BINDING)
      else
        if viewName == (ActivityWindowName.ActivityGiftCodeView).name then
          UIMgr:SendWindowMessage((WinResConfig.ActivityMainWindow).name, (WindowMsgEnum.ActivityMainWindow).GIFT_CODE)
        else
          if viewName == (ActivityWindowName.ActivitySevenDayView).name then
            (ActivityService.ReqLoginAct)()
          end
        end
      end
    end
  end
end

ActivityMainWindow.OnShown = function(...)
  -- function num : 0_4
end

ActivityMainWindow.OnHide = function(...)
  -- function num : 0_5
end

ActivityMainWindow.SetOnCloseFun = function(index, ...)
  -- function num : 0_6 , upvalues : btnList, viewRefer, _ENV
  local data = btnList[index]
  if not data then
    return 
  end
  local closeFun = (viewRefer[data.MsgID]).OnClose
  if closeFun and type(closeFun) == "function" then
    closeFun()
  end
end

ActivityMainWindow.OnClose = function(...)
  -- function num : 0_7 , upvalues : ActivityMainWindow, openIndex, viewRefer, winInformation, btnList, windowObj, currentObj, _ENV, uis, contentPane, argTable
  (ActivityMainWindow.SetOnCloseFun)(openIndex)
  viewRefer = {}
  winInformation = {}
  btnList = {}
  windowObj = {}
  currentObj = nil
  ;
  (RedDotMgr.EliminateRedDot)((WinResConfig.ActivityMainWindow).name)
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.ActivityMainWindow).name)
  uis = nil
  contentPane = nil
  argTable = {}
end

ActivityMainWindow.InitAssetStrip = function(...)
  -- function num : 0_8 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.ActivityMainWindow).name
  m.Tip = (PUtil.get)(20000154)
  m.model = uis.AssetStripGrp
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

ActivityMainWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_9 , upvalues : ActivityMainWindow, _ENV
  if msgId < 100 then
    (ActivityMainWindow.SetWindowShow)(msgId)
  else
    if msgId == (WindowMsgEnum.ActivityMainWindow).INFORM_CHILD_VIEW then
      local viewName = para[1]
      local msgID = para[2]
      local param = para[3]
      ;
      (ActivityMainWindow.SetViewMessageHandle)(viewName, msgID, param)
    end
  end
end

ActivityMainWindow.SetViewMessageHandle = function(viewName, msgID, param, ...)
  -- function num : 0_10 , upvalues : _ENV, winInformation, viewRefer
  local magID = -1
  for _,v in pairs(winInformation) do
    if v.name == viewName then
      magID = v.MsgID
    end
  end
  local luaFile = viewRefer[magID]
  if not luaFile then
    return 
  end
  local Message = luaFile.HandleMessage
  if Message and type(Message) == "function" then
    Message(msgID, param)
  end
end

ActivityMainWindow.GetBtnListIndexBy = function(msgID, ...)
  -- function num : 0_11 , upvalues : _ENV, btnList
  for i,v in ipairs(btnList) do
    if v.MsgID == msgID then
      return i
    end
  end
end

ActivityMainWindow.SetWindowShow = function(msgID, ...)
  -- function num : 0_12 , upvalues : winInformation, viewRefer, _ENV, ActivityMainWindow, openIndex, uis, windowObj, currentObj
  local winData = winInformation[msgID]
  local luaFile = viewRefer[msgID]
  if winData == nil or luaFile == nil then
    loge(msgID .. "未注册")
    return 
  end
  ;
  (ActivityMainWindow.SetOnCloseFun)(openIndex)
  local index = (ActivityMainWindow.GetBtnListIndexBy)(msgID)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (uis.ButtonList).selectedIndex = index - 1
  openIndex = index
  local obj = windowObj[msgID]
  if obj == nil then
    obj = UIMgr:CreateObject(winData.PkgName, winData.resName)
    windowObj[msgID] = obj
    ;
    ((uis.ActivityContent).root):AddChild(obj)
  end
  ;
  (luaFile.OnInit)(obj)
  obj.visible = true
  if currentObj then
    currentObj.visible = false
  end
  currentObj = obj
end

return ActivityMainWindow

