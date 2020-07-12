-- params : ...
-- function num : 0 , upvalues : _ENV
require("Activity_CodeByName")
local ActivityGiftCodeView = {}
local uis = nil
local UniClipboard = CS.UniClipboard
local canTouch = true
ActivityGiftCodeView.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : uis, _ENV, ActivityGiftCodeView, canTouch
  uis = GetActivity_CodeUis(bridgeObj)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.CodeTxt).promptText = (PUtil.get)(20000368)
  ;
  (ActivityGiftCodeView.SetBtnEvent)()
  canTouch = true
end

ActivityGiftCodeView.SetBtnEvent = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis, UniClipboard, canTouch
  (Util.StrUnicodeLength)()
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.PasteBtn).text = (PUtil.get)(20000369)
  ;
  ((uis.PasteBtn).onClick):Set(function(...)
    -- function num : 0_1_0 , upvalues : UniClipboard, uis
    local str = (UniClipboard.GetText)()
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.CodeTxt).text = str
  end
)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.SureBtn).text = (PUtil.get)(20000370)
  ;
  ((uis.SureBtn).onClick):Set(function(...)
    -- function num : 0_1_1 , upvalues : uis, _ENV, canTouch
    local content = (uis.CodeTxt).text
    if (Util.StringIsNullOrEmpty)(content) then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000384))
      return 
    else
      if not (Util.LimitContentType)(content, true, true) then
        (MessageMgr.SendCenterTips)((PUtil.get)(20000454))
        return 
      end
    end
    if (Util.NameCheck)(content, (PUtil.get)(20000435), 1, 20, true, true) then
      if canTouch == false then
        return 
      end
      ;
      (ActivityService.ReqGiftCode)(tostring(content))
      canTouch = false
      ;
      (SimpleTimer.setTimeout)(2, function(...)
      -- function num : 0_1_1_0 , upvalues : canTouch
      canTouch = true
    end
)
    end
  end
)
end

ActivityGiftCodeView.OnClose = function(...)
  -- function num : 0_2 , upvalues : uis
  uis = nil
end

ActivityGiftCodeView.HandleMessage = function(msgId, para, ...)
  -- function num : 0_3 , upvalues : uis
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  if msgId == 1 and uis and uis.CodeTxt then
    (uis.CodeTxt).text = ""
  end
end

return ActivityGiftCodeView

