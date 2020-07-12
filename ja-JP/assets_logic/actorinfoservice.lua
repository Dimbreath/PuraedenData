-- params : ...
-- function num : 0 , upvalues : _ENV
ActorInfoService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

ActorInfoService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResSet, ActorInfoService.onResSet)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

ActorInfoService.ReqSet = function(t, value, ...)
  -- function num : 0_1 , upvalues : _ENV
  print("请求更改设置", t, value, type(value))
  local m = {}
  m.setObject = {
{type = t, value = tostring(value)}
}
  ;
  (Net.Send)((Proto.MsgName).ReqSet, m, (Proto.MsgName).ResSet)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

ActorInfoService.onResSet = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV
  print("返回更改设置", ((msg.setObject)[1]).type, ((msg.setObject)[1]).value)
  local count = #msg.setObject
  for i = 1, count do
    local type = ((msg.setObject)[i]).type
    local value = ((msg.setObject)[i]).value
    if type == (ProtoEnum.E_SET_TYPE).FASHION_HEAD then
      (ActorData.SetFashionHead)(tonumber(value))
      UIMgr:SendWindowMessage("HeadChoiceWindow", (WindowMsgEnum.ActorInfo).E_MSG_SETFASHIONHEAD, {})
      UIMgr:SendWindowMessage("ActorInfoWindow", (WindowMsgEnum.ActorInfo).E_MSG_SETFASHIONHEAD, {})
    else
    end
    if type ~= (ProtoEnum.E_SET_TYPE).FASHION_SHOW or type == (ProtoEnum.E_SET_TYPE).SIGNATURE then
      (ActorData.SetSignature)(value)
    else
      if type == (ProtoEnum.E_SET_TYPE).NICK_NAME or type == (ProtoEnum.E_SET_TYPE).NICK_NAME_NO_COST then
        (ActorData.SetNickname)(value)
        UIMgr:SendWindowMessage((WinResConfig.RenameWindow).name, (WindowMsgEnum.ActorInfo).E_MSG_SET_NEW_NICKNAME)
        UIMgr:SendWindowMessage((WinResConfig.ActorInfoWindow).name, (WindowMsgEnum.ActorInfo).E_MSG_SET_NEW_NICKNAME)
        UIMgr:SendWindowMessage((WinResConfig.NameWindow).name, (WindowMsgEnum.ActorInfo).E_MSG_SET_NEW_NICKNAME)
      end
    end
  end
end

;
(ActorInfoService.Init)()

