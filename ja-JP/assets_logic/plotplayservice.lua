-- params : ...
-- function num : 0 , upvalues : _ENV
PlotPlayService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

PlotPlayService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResCheckStoryFinish, PlotPlayService.RecvCheckStoryFinish)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

PlotPlayService.ReqFinishStory = function(type, id, ...)
  -- function num : 0_1 , upvalues : _ENV
  if OvertureMgr.isPlaying == true then
    return 
  end
  for k,v in pairs(id) do
    loge("ReqFinishStory:" .. v)
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (PlotPlayData.PlayedPlot)[v] = true
  end
  local m = {}
  m.type = type
  m.ids = id
  ;
  (Net.Send)((Proto.MsgName).ReqFinishStory, m)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

PlotPlayService.ReqCheckStoryFinish = function(chapterIds, ...)
  -- function num : 0_2 , upvalues : _ENV
  if OvertureMgr.isPlaying == true then
    return 
  end
  for k,v in pairs(chapterIds) do
    loge("ReqCheckStoryFinish:" .. v)
  end
  local m = {}
  m.chapterIds = chapterIds
  ;
  (Net.Send)((Proto.MsgName).ReqCheckStoryFinish, m, (Proto.MsgName).ResCheckStoryFinish)
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

PlotPlayService.RecvCheckStoryFinish = function(msg, ...)
  -- function num : 0_3 , upvalues : _ENV
  for k,v in pairs(msg.chapters) do
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R6 in 'UnsetPending'

    (PlotPlayData.PlayedPlot)[v.chapterId] = v.result
    loge("RecvCheckStoryFinish:" .. v.chapterId .. " " .. tostring(v.result))
    if not v.result then
      (PlotPlayData.Enqueue)(v.chapterId)
    end
  end
  ;
  (PlotPlayMgr.PlayNextPlot)()
end

;
(PlotPlayService.Init)()

