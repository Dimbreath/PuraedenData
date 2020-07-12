-- params : ...
-- function num : 0 , upvalues : _ENV
GuideService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

GuideService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResNormalGuide, GuideService.OnResNewHand)
  ;
  (Net.AddListener)((Proto.MsgName).ResImageGuide, GuideService.OnResGuideId)
  ;
  (Net.AddListener)((Proto.MsgName).ResSaveNormalGuide, GuideService.OnResSaveNewHand)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

GuideService.OnResSaveNewHand = function(...)
  -- function num : 0_1 , upvalues : _ENV
  loge("服务器接收成功")
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

GuideService.SaveBasicGuideData = function(gid, sgID, sid, ...)
  -- function num : 0_2 , upvalues : _ENV
  if OvertureMgr.isPlaying == true then
    return 
  end
  local m = {}
  m.gId = gid
  m.sgId = sgID
  m.sId = sid
  m.type = 1
  ;
  (Net.Send)((Proto.MsgName).ReqSaveNormalGuide, m, (Proto.MsgName).ResSaveNormalGuide, function(...)
    -- function num : 0_2_0 , upvalues : _ENV, gid, sgID, sid
    (GuideService.SaveBasicGuideData)(gid, sgID, sid)
    loge("重发了记录消息" .. gid .. "    " .. sgID .. "     " .. sid)
  end
)
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

GuideService.SavePlotGuideData = function(PGid, PsgID, PSid, ...)
  -- function num : 0_3 , upvalues : _ENV
  if OvertureMgr.isPlaying == true then
    return 
  end
  local m = {}
  m.pgId = PGid
  m.psgId = PsgID
  m.psId = PSid
  m.type = 2
  ;
  (Net.Send)((Proto.MsgName).ReqSaveNormalGuide, m, (Proto.MsgName).ResSaveNormalGuide, function(...)
    -- function num : 0_3_0 , upvalues : _ENV, PGid, PsgID, PSid
    (GuideService.SavePlotGuideData)(PGid, PsgID, PSid)
    loge("重发了记录消息" .. PGid .. "    " .. PsgID .. "     " .. PSid)
  end
)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

GuideService.ReqNewHand = function(needResend, ...)
  -- function num : 0_4 , upvalues : _ENV
  if OvertureMgr.isPlaying == true then
    return 
  end
  local m = {}
  if needResend then
    (Net.Send)((Proto.MsgName).ReqNormalGuide, m, (Proto.MsgName).ResNormalGuide, function(...)
    -- function num : 0_4_0 , upvalues : _ENV, needResend
    (GuideService.ReqNewHand)(needResend)
  end
)
  else
    ;
    (Net.Send)((Proto.MsgName).ReqNormalGuide, m, (Proto.MsgName).ResNormalGuide)
  end
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

GuideService.OnResNewHand = function(msg, ...)
  -- function num : 0_5 , upvalues : _ENV
  PrintTable(msg, "", "收到玩家新手引导:")
  ;
  (GuideMgr.InItServiceData)(msg.gId, msg.sgId, msg.sId, false)
  if msg.psgId == -1 then
    (GuideMgr.SetStartGuideData)(msg.pgId, true)
  else
    ;
    (GuideMgr.InItServiceData)(msg.pgId, msg.psgId, msg.psId, true)
  end
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

GuideService.ReqPictureNewHand = function(save, id, needResend, ...)
  -- function num : 0_6 , upvalues : _ENV
  local m = {}
  m.save = save
  m.id = id
  if needResend then
    (Net.Send)((Proto.MsgName).ReqImageGuide, m, (Proto.MsgName).ResImageGuide, function(...)
    -- function num : 0_6_0 , upvalues : _ENV, save, id, needResend
    (GuideService.ReqPictureNewHand)(save, id, needResend)
  end
)
  else
    ;
    (Net.Send)((Proto.MsgName).ReqImageGuide, m)
  end
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

GuideService.OnResGuideId = function(msg, ...)
  -- function num : 0_7 , upvalues : _ENV
  if msg.idList then
    for _,v in ipairs(msg.idList) do
      (GuideMgr.AddPictureGuideID)(tonumber(v))
    end
  end
end

;
(GuideService.Init)()

