-- params : ...
-- function num : 0 , upvalues : _ENV
require("DescriptionTips_DoubleRewardTipsWindowByName")
local DoubleRewardTipsWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local OffsetNum = 60
local timer = nil
DoubleRewardTipsWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, DoubleRewardTipsWindow
  bridgeObj:SetView((WinResConfig.DoubleRewardTipsWindow).package, (WinResConfig.DoubleRewardTipsWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetDescriptionTips_DoubleRewardTipsWindowUis(contentPane)
  ;
  (DoubleRewardTipsWindow.SetInfo)(argTable[1], argTable[2], argTable[3], argTable[4])
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.DoubleRewardTips).TimeWordTxtTxt).text = (PUtil.get)(225)
  ;
  (DoubleRewardTipsWindow.SetWindowPos)()
end

DoubleRewardTipsWindow.SetInfo = function(name, content, icon, endTime, ...)
  -- function num : 0_1 , upvalues : uis, timer, _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R4 in 'UnsetPending'

  ((uis.DoubleRewardTips).NameTxt).text = name
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((uis.DoubleRewardTips).DoubleNumberTxt).text = content
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((uis.DoubleRewardTips).Time_02_Txt).text = ""
  if timer then
    timer:Stop()
    timer = nil
  end
  ;
  (LuaTime.CountDown)(endTime * 0.001 - (ActorData.GetServerTime)() * 0.001, (uis.DoubleRewardTips).Time_01_Txt, nil, true)
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((uis.DoubleRewardTips).IconLoader).url = icon
end

DoubleRewardTipsWindow.SetWindowPos = function(...)
  -- function num : 0_2 , upvalues : _ENV, argTable, contentPane, OffsetNum, uis
  local data, propType = (Util.GetConfigDataByID)(argTable[1])
  local v2 = contentPane:GlobalToLocal(Vector2((Input.mousePosition).x, (Input.mousePosition).y))
  local verticalDis = (GRoot.inst).height - v2.y + OffsetNum
  local horizontalDis = v2.x - ((uis.DoubleRewardTips).TipsImage).width * 0.5
  contentPane:SetXY(horizontalDis, verticalDis)
end

DoubleRewardTipsWindow.OnClose = function(...)
  -- function num : 0_3 , upvalues : timer, uis, contentPane
  if timer then
    timer:Stop()
    timer = nil
  end
  uis = nil
  contentPane = nil
end

return DoubleRewardTipsWindow

