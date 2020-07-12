-- params : ...
-- function num : 0 , upvalues : _ENV
require("Land_ShiftWindowByName")
local ShiftWindow = {}
local uis, contentPane = nil, nil
ShiftWindow.ReInitData = function(...)
  -- function num : 0_0
end

ShiftWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_1 , upvalues : _ENV, contentPane, uis, ShiftWindow
  bridgeObj:SetView((WinResConfig.ShiftWindow).package, (WinResConfig.ShiftWindow).comName)
  contentPane = bridgeObj.contentPane
  contentPane:Center()
  uis = GetLand_ShiftWindowUis(contentPane)
  ;
  (ShiftWindow.InitText)()
  ;
  (ShiftWindow.InitBtn)()
end

ShiftWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  local Shift = uis.Shift
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (Shift.NameTxt).text = (PUtil.get)(40002037)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (Shift.WordTxt).text = (PUtil.get)(40002038)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (Shift.IDTxt).text = (PUtil.get)(40002039)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (Shift.PassWordTxt).text = (PUtil.get)(40002040)
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (Shift.TipsTxt).text = (PUtil.get)(40002041)
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (Shift.InputIDTxt).text = ""
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (Shift.InputPassWordTxt).text = ""
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (Shift.CancelBtn).text = (PUtil.get)(60000005)
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (Shift.SureBtn).text = (PUtil.get)(60000004)
end

ShiftWindow.OnClickSureBtn = function(...)
  -- function num : 0_3 , upvalues : _ENV, ShiftWindow
  local ticket = (LoginMgr.GetTicket)()
  local isGuest = (SuperSDKUtil.IsGuest)()
  local code = (Shift.InputIDTxt).text
  local passWord = (Shift.InputPassWordTxt).text
  ;
  (ShiftWindow.SendMsg)(ticket, code, passWord, isGuest)
end

ShiftWindow.SendMsg = function(ticket, code, passWord, isGuest, ...)
  -- function num : 0_4 , upvalues : _ENV, ShiftWindow
  local url = GetAuthUrl() .. "/yj/player"
  local formData = {ticket = ticket, code = code, password = passWord, guest = isGuest}
  ;
  ((CS.WWWManager).Singleton):PostWebRequestForm(url, formData, function(...)
    -- function num : 0_4_0 , upvalues : _ENV, ShiftWindow, ticket, code, passWord, isGuest
    loge("引继失败")
    ;
    (MsgWaiterObj.PromptMsgTimeout)(1, function(...)
      -- function num : 0_4_0_0 , upvalues : ShiftWindow, ticket, code, passWord, isGuest
      (ShiftWindow.SendMsg)(ticket, code, passWord, isGuest)
    end
)
  end
, function(str, ...)
    -- function num : 0_4_1 , upvalues : _ENV
    local result_table = (Json.decode)(str)
    PrintTable(result_table)
    if result_table.code == "success" then
      loge("引继成功")
      local yjAccount = (result_table.data).yjAccount
      local account = (result_table.data).account
      loge(yjAccount)
      loge(account)
    end
  end
)
end

ShiftWindow.InitBtn = function(...)
  -- function num : 0_5 , upvalues : uis, ShiftWindow
  local Shift = uis.Shift
  ;
  ((Shift.CloseBtn).onClick):Set(ShiftWindow.onClickClose)
  ;
  ((Shift.CancelBtn).onClick):Set(ShiftWindow.onClickClose)
  ;
  ((Shift.SureBtn).onClick):Set(ShiftWindow.OnClickSureBtn)
end

ShiftWindow.onClickClose = function(...)
  -- function num : 0_6 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.ShiftWindow).name)
end

ShiftWindow.OnShown = function(...)
  -- function num : 0_7
end

ShiftWindow.OnHide = function(...)
  -- function num : 0_8
end

ShiftWindow.OnClose = function(...)
  -- function num : 0_9 , upvalues : uis, contentPane
  uis = nil
  contentPane = nil
end

ShiftWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_10
  if msgId ~= 1 or msgId == 2 then
  end
end

return ShiftWindow

