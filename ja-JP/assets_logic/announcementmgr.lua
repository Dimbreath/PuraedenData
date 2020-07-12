-- params : ...
-- function num : 0 , upvalues : _ENV
AnnouncementMgr = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

AnnouncementMgr.OpenAnnouncement = function(forbiddenJump, forbiddenTips, ...)
  -- function num : 0_0 , upvalues : _ENV
  OpenWindow((WinResConfig.AnnouncementWindow).name, UILayer.HUD, forbiddenJump)
  loge("AnnouncementURL.List:" .. AnnouncementURL.List)
  ;
  ((CS.WWWManager).Singleton):PostWebRequestForm(AnnouncementURL.List, "", function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    loge("post failed")
  end
, function(str, ...)
    -- function num : 0_0_1 , upvalues : _ENV, forbiddenTips
    local result_table = (Json.decode)(str)
    ;
    (AnnouncementMgr.SetListData)(result_table.data)
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

    AnnouncementData.ContentData = {}
    -- DECOMPILER ERROR at PC25: Unhandled construct in 'MakeBoolean' P1

    if #AnnouncementData.ListData == 0 and forbiddenTips ~= true then
      (MessageMgr.SendCenterTips)((PUtil.get)(60000439))
    end
    if #AnnouncementData.ListData ~= #AnnouncementData.RedDot then
      (AnnouncementMgr.InitRedDotData)()
    end
    UIMgr:SendWindowMessage((WinResConfig.AnnouncementWindow).name, (WindowMsgEnum.Announcement).E_MSG_REFRESH_TITLE)
  end
)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

AnnouncementMgr.InitAnnouncementRedDot = function(...)
  -- function num : 0_1 , upvalues : _ENV
  ((CS.WWWManager).Singleton):PostWebRequestForm(AnnouncementURL.List, "", function(...)
    -- function num : 0_1_0 , upvalues : _ENV
    loge("post failed")
  end
, function(str, ...)
    -- function num : 0_1_1 , upvalues : _ENV
    local result_table = (Json.decode)(str)
    ;
    (AnnouncementMgr.SetListData)(result_table.data)
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

    AnnouncementData.ContentData = {}
    ;
    (AnnouncementMgr.InitRedDotData)()
    ;
    (RedDotMgr.ProcessRedDot)(RedDotComID.Announcement_List, AnnouncementData.RedDot, true)
    ;
    (RedDotMgr.RefreshTreeUI)((WinResConfig.AnnouncementWindow).name)
  end
)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

AnnouncementMgr.InitRedDotData = function(...)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  AnnouncementData.RedDot = {}
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  AnnouncementData.RedDotIndex = {}
  local count = #AnnouncementData.ListData
  for i = 1, count do
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R5 in 'UnsetPending'

    (AnnouncementData.RedDot)[i] = (Util.GetIntPlayerSetting)(PlayerPrefsKeyName.ANNOUNCEMENT .. ((AnnouncementData.ListData)[i]).id) == 0
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (AnnouncementData.RedDotIndex)[((AnnouncementData.ListData)[i]).id] = i
  end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

AnnouncementMgr.SetListData = function(data, ...)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  AnnouncementData.ListData = {}
  local count = #data
  local date, time, startIndex, endIndex, finalTime = nil, nil, nil, nil, nil
  if not (LuaTime.GetTimeStamp)() then
    local curTime = (os.time)()
  end
  for i = 1, count do
    if (Util.StringIsNullOrEmpty)((data[i]).endTime) or (data[i]).endTime == 0 then
      (table.insert)(AnnouncementData.ListData, data[i])
      -- DECOMPILER ERROR at PC39: Confused about usage of register: R12 in 'UnsetPending'

      ;
      (data[i]).sort = tonumber((data[i]).sort)
    else
      if curTime < (data[i]).endTime * 0.001 then
        (table.insert)(AnnouncementData.ListData, data[i])
        -- DECOMPILER ERROR at PC57: Confused about usage of register: R12 in 'UnsetPending'

        ;
        (data[i]).sort = tonumber((data[i]).sort)
      end
    end
  end
  ;
  (table.sort)(AnnouncementData.ListData, function(x, y, ...)
    -- function num : 0_3_0
    if x.sort == y.sort then
      return false
    else
      return y.sort < x.sort
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

AnnouncementMgr.ReqAnnouncementContent = function(id, ...)
  -- function num : 0_4 , upvalues : _ENV
  loge("request id:" .. tostring(id))
  ;
  ((CS.WWWManager).Singleton):PostWebRequestForm(AnnouncementURL.Content, {id = tostring(id)}, function(...)
    -- function num : 0_4_0 , upvalues : _ENV
    loge("post failed")
  end
, function(str, ...)
    -- function num : 0_4_1 , upvalues : _ENV
    local result_table = (Json.decode)(str)
    ;
    (Util.SetIntPlayerSetting)(PlayerPrefsKeyName.ANNOUNCEMENT .. (result_table.data).id, 1)
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (AnnouncementData.ContentData)[(result_table.data).id] = result_table.data
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (AnnouncementData.RedDot)[(AnnouncementData.RedDotIndex)[(result_table.data).id]] = false
    ;
    (RedDotMgr.ProcessRedDot)(RedDotComID.Announcement_List, AnnouncementData.RedDot, false)
    ;
    (RedDotMgr.RefreshTreeUI)((WinResConfig.AnnouncementWindow).name)
    UIMgr:SendWindowMessage((WinResConfig.AnnouncementWindow).name, (WindowMsgEnum.Announcement).E_MSG_REFRESH, result_table.data)
  end
)
end


