-- params : ...
-- function num : 0 , upvalues : _ENV
require("Activity_TouristPassWordWindowByName")
require("Message_TextContentByName")
local ActivityPassWordWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local minLength = 8
local maxLength = 8
ActivityPassWordWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, ActivityPassWordWindow
  bridgeObj:SetView((WinResConfig.ActivityPassWordWindow).package, (WinResConfig.ActivityPassWordWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetActivity_TouristPassWordWindowUis(contentPane)
  uis = uis.TouristPassWord
  ;
  (ActivityPassWordWindow.SetEvent)()
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.IDNumberTxt).text = (ActorData.GetPlayerIndex)()
  local content = (PUtil.get)(89102005)
  ;
  (Util.SetTxt)(content, uis.ContentList)
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.Input_02_Txt).inputTextField).RestrictRow = 0
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.Input_01_Txt).inputTextField).RestrictRow = 0
  ;
  (ActivityPassWordWindow.SetTxt)()
end

ActivityPassWordWindow.SetTxt = function(...)
  -- function num : 0_1 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.TitleTxt).text = (PUtil.get)(20000425)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.IDTxt).text = (PUtil.get)(20000426)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.PassWord_01_Txt).text = (PUtil.get)(20000427)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.PassWord_02_Txt).text = (PUtil.get)(20000428)
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.Input_01_Txt).promptText = (PUtil.get)(20000429)
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.Input_02_Txt).promptText = (PUtil.get)(20000430)
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.TipsTxt).text = (PUtil.get)(20000431)
end

ActivityPassWordWindow.SetEvent = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV, minLength, maxLength
  ((uis.SureBtn).onClick):Set(function(...)
    -- function num : 0_2_0 , upvalues : uis, _ENV, minLength, maxLength
    local input1 = (uis.Input_01_Txt).text
    local input2 = (uis.Input_02_Txt).text
    if input1 ~= input2 then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000340))
    else
      local condition = (Util.CheckPassWordLegal)(input1, true, minLength, maxLength)
      if condition then
        if (uis.ChoiceBtn).selected then
          (ActivityService.ReqSetYJCode)(input1)
        else
          ;
          (MessageMgr.SendCenterTips)((PUtil.get)(20000338))
        end
      end
    end
  end
)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.SureBtn).text = (PUtil.get)(20000016)
  ;
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_2_1 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.ActivityPassWordWindow).name)
  end
)
  ;
  ((uis.CopyBtn).onClick):Set(function(...)
    -- function num : 0_2_2 , upvalues : _ENV
    ((CS.UniClipboard).SetText)(tostring((ActorData.GetPlayerIndex)()))
    ;
    (MessageMgr.SendCenterTips)((PUtil.get)(128))
  end
)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.CopyBtn).text = (PUtil.get)(112)
end

ActivityPassWordWindow.OnShown = function(...)
  -- function num : 0_3
end

ActivityPassWordWindow.OnHide = function(...)
  -- function num : 0_4
end

ActivityPassWordWindow.OnClose = function(...)
  -- function num : 0_5 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

ActivityPassWordWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_6
end

return ActivityPassWordWindow

