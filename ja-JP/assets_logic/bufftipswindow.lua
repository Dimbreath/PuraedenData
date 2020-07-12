-- params : ...
-- function num : 0 , upvalues : _ENV
require("Expedition_BuffTipsWindowByName")
local BuffTipsWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local buffID = 0
BuffTipsWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, buffID, uis, BuffTipsWindow
  bridgeObj:SetView((WinResConfig.BuffTipsWindow).package, (WinResConfig.BuffTipsWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  buffID = argTable[1]
  uis = GetExpedition_BuffTipsWindowUis(contentPane)
  uis = uis.BuffTipsGrp
  local BuffData = ((TableData.gTable).BaseBuffPreBattleData)[buffID]
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.BuffIconGrp).BuffIconLoader).url = (Util.GetItemUrl)(BuffData.icon)
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.BuffNameTxt).text = BuffData.name
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.BuffWord_02_Txt).text = BuffData.remark
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.BuffWord_01_Txt).text = (PUtil.get)(20000147)
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R2 in 'UnsetPending'

  if (uis.TipsImage).height < 232 then
    (uis.TipsImage).height = 232
  end
  ;
  ((GRoot.inst).onClick):Add(BuffTipsWindow.OnCloseThis)
  local v2 = contentPane:GlobalToLocal(Vector2((Input.mousePosition).x, (Input.mousePosition).y))
  contentPane:SetXY(v2.x + 50, 0)
end

BuffTipsWindow.OnCloseThis = function(...)
  -- function num : 0_1 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.BuffTipsWindow).name)
end

BuffTipsWindow.OnShown = function(...)
  -- function num : 0_2
end

BuffTipsWindow.OnHide = function(...)
  -- function num : 0_3
end

BuffTipsWindow.OnClose = function(...)
  -- function num : 0_4 , upvalues : _ENV, BuffTipsWindow, uis, contentPane, argTable
  ((GRoot.inst).onClick):Remove(BuffTipsWindow.OnCloseThis)
  uis = nil
  contentPane = nil
  argTable = {}
end

BuffTipsWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_5
end

return BuffTipsWindow

