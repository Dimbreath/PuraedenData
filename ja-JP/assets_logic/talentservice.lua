-- params : ...
-- function num : 0 , upvalues : _ENV
TalentService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

TalentService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResMatrixTreeInfo, TalentService.OnResMatrixTreeInfo)
  ;
  (Net.AddListener)((Proto.MsgName).ResActivateMatrixNode, TalentService.OnResActivateMatrixNode)
  ;
  (Net.AddListener)((Proto.MsgName).ResLevelUpMatrixSeal, TalentService.OnResLevelUpMatrixSeal)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

TalentService.ReqMatrixTreeInfo = function(...)
  -- function num : 0_1 , upvalues : _ENV
  print("----天赋初始化消息请求")
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqMatrixTreeInfo, m, (Proto.MsgName).ResMatrixTreeInfo)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

TalentService.OnResMatrixTreeInfo = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV
  if msg.matrixTreeInfo then
    (TalentData.TalentDataInit)(msg.matrixTreeInfo)
  end
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

TalentService.ReqActivateMatrixNode = function(matrixId, ...)
  -- function num : 0_3 , upvalues : _ENV
  print("--天赋激活节点", matrixId)
  local m = {}
  m.matrixId = matrixId
  ;
  (Net.Send)((Proto.MsgName).ReqActivateMatrixNode, m, (Proto.MsgName).ResActivateMatrixNode)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

TalentService.OnResActivateMatrixNode = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV
  print("--天赋激活节点返回", msg.matrixId, msg.nodeId)
  ;
  (CommonWinMgr.OpenCommonFcUp)()
  UIMgr:SendWindowMessage("TalentMainWindow", (WindowMsgEnum.Talent).E_MSG_TALENT_UP_NODE, {msg = msg})
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

TalentService.ReqLevelUpMatrixSeal = function(matrixId, sealType, ...)
  -- function num : 0_5 , upvalues : _ENV
  print("--天赋激活封印", matrixId, sealType)
  local m = {}
  m.matrixId = matrixId
  m.sealType = sealType
  ;
  (Net.Send)((Proto.MsgName).ReqLevelUpMatrixSeal, m, (Proto.MsgName).ResLevelUpMatrixSeal)
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

TalentService.OnResLevelUpMatrixSeal = function(msg, ...)
  -- function num : 0_6 , upvalues : _ENV
  print("天赋激活封印 返回", msg.matrixId, msg.sealType, msg.sealId)
  ;
  (CommonWinMgr.OpenCommonFcUp)()
  UIMgr:SendWindowMessage("TalentStarUpWindow", (WindowMsgEnum.Talent).E_MSG_TALENT_UP_SEAL, {msg = msg})
end

;
(TalentService.Init)()

