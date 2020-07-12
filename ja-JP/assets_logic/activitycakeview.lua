-- params : ...
-- function num : 0 , upvalues : _ENV
require("Activity_CardItemByName")
require("Activity_CakeByName")
local ActivityCakeView = {}
local uis = nil
local cakeAction = {Normal = "open", Debris = "end", Black = "open", Eat = "ani"}
local content = nil
local enableClick = true
local wordPosY = 0
ActivityCakeView.OnInit = function(obj, ...)
  -- function num : 0_0 , upvalues : uis, _ENV, content, wordPosY, ActivityCakeView
  uis = GetActivity_CakeUis(obj)
  content = obj
  wordPosY = ((obj:GetChild("CardItem_01_Grp")):GetChild("WordTxt")).y
  local InitData = (ActivityMgr.GetVitConfigData)()
  local count = (Umath.Min)(4, #InitData)
  for i = 1, count do
    local comObj = obj:GetChild("CardItem_0" .. i .. "_Grp")
    ;
    (ActivityCakeView.SetCake)(InitData[i], comObj)
  end
  ;
  (ActivityCakeView.CheckBubbleShow)()
end

ActivityCakeView.GetVitDataIndexByID = function(ID, ...)
  -- function num : 0_1 , upvalues : _ENV
  local InitData = (ActivityMgr.GetVitConfigData)()
  for i,v in ipairs(InitData) do
    if v.id == ID then
      return i
    end
  end
end

ActivityCakeView.SetBubbleContent = function(wordID, ...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ((uis.CakeTalk).WordTxt).text = (PUtil.get)(wordID, ...)
end

ActivityCakeView.SetCake = function(data, obj, ...)
  -- function num : 0_3 , upvalues : _ENV, cakeAction, wordPosY, ActivityCakeView
  local model = GetActivity_CardItemUis(obj)
  local state = (ActivityMgr.GetVitState)(data.id)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (model.c1Ctr).selectedIndex = state
  local actionName = nil
  local startTime, endTime = (LuaTime.GetRangeTime)(data.time)
  local timeRange = (string.format)("%s-%s", startTime, endTime)
  if state == (ActivityMgr.VitGetState).MayGet then
    actionName = cakeAction.Normal
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (model.WordTxt).text = timeRange
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (model.WordTxt).y = wordPosY + 3
  else
    if state == (ActivityMgr.VitGetState).AlreadyGet then
      actionName = cakeAction.Debris
      -- DECOMPILER ERROR at PC42: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (model.WordTxt).y = wordPosY + 3
    else
      if state == (ActivityMgr.VitGetState).Unable then
        actionName = cakeAction.Black
        -- DECOMPILER ERROR at PC51: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (model.WordTxt).text = timeRange
        -- DECOMPILER ERROR at PC55: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (model.WordTxt).y = wordPosY + 3
      else
        -- DECOMPILER ERROR at PC64: Confused about usage of register: R8 in 'UnsetPending'

        if state == (ActivityMgr.VitGetState).Buy then
          (model.WordTxt).y = wordPosY
          actionName = cakeAction.Normal
          -- DECOMPILER ERROR at PC67: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (model.WordTxt).autoSize = 1
          -- DECOMPILER ERROR at PC69: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (model.WordTxt).UBBEnabled = true
          local cost = split(data.extra_cost, ":")
          local ConfigData = (Util.GetConfigByItemIDAndType)(tonumber(cost[2]), tonumber(cost[1]))
          local str = "<img src=\'" .. (Util.GetItemUrl)(ConfigData.icon) .. "\' "
          str = str .. "width=\'" .. "30" .. "\' "
          str = str .. "height=\'" .. "30" .. "\'/>"
          -- DECOMPILER ERROR at PC108: Confused about usage of register: R11 in 'UnsetPending'

          ;
          (model.WordTxt).text = str .. cost[3] .. (PUtil.get)(20000296)
        end
      end
    end
  end
  do
    local cake = (model.CakeLoader).Model
    if cake == nil then
      cake = ((Util.ShowUIModel)(data.icon, model.CakeLoader, nil, false, function(model, ...)
    -- function num : 0_3_0 , upvalues : _ENV, actionName
    (SkeletonAnimationUtil.SetAnimation)(model, 0, actionName, true)
  end
)).transform
      -- DECOMPILER ERROR at PC129: Confused about usage of register: R9 in 'UnsetPending'

      ;
      ((cake.gameObject).transform).localScale = Vector3(100, 100, 100)
    end
    ;
    ((model.BlankBtn).onClick):Set(function(...)
    -- function num : 0_3_1 , upvalues : state, _ENV, data, ActivityCakeView, cake
    if state == (ActivityMgr.VitGetState).Buy then
      (MessageMgr.OpenCostResConfirmWindow)(60000411, data.extra_cost, function(...)
      -- function num : 0_3_1_0 , upvalues : ActivityCakeView, cake, state, data
      (ActivityCakeView.OnClickCake)(cake.gameObject, state, data)
    end
)
    else
      ;
      (ActivityCakeView.OnClickCake)(cake.gameObject, state, data)
    end
  end
)
  end
end

ActivityCakeView.CheckBubbleShow = function(...)
  -- function num : 0_4 , upvalues : _ENV, ActivityCakeView
  local vitData = (ActivityMgr.VitGetInitData)()
  if vitData.canGetId and #vitData.canGetId > 0 then
    local mData = ((TableData.gTable).BaseVitGetData)[(vitData.canGetId)[#vitData.canGetId]]
    local rewardS = split(mData.reward, ":")
    ;
    (ActivityCakeView.SetBubbleContent)(20000298, mData.name, tonumber(rewardS[3]))
  else
    do
      if vitData.extraId and #vitData.extraId > 0 then
        local mData = ((TableData.gTable).BaseVitGetData)[(vitData.extraId)[#vitData.extraId]]
        local rewardS = split(mData.reward, ":")
        ;
        (ActivityCakeView.SetBubbleContent)(20000299, mData.name, tonumber(rewardS[3]))
      else
        do
          local time = (math.floor)((ActorData.GetServerTime)() * 0.001)
          local hours = tonumber((os.date)("%H", time))
          if hours >= 0 and hours <= 6 then
            (ActivityCakeView.SetBubbleContent)(20000303)
          else
            ;
            (ActivityCakeView.SetBubbleContent)(20000302)
          end
        end
      end
    end
  end
end

ActivityCakeView.OnClickCake = function(model, state, data, ...)
  -- function num : 0_5 , upvalues : _ENV, ActivityCakeView
  if state == (ActivityMgr.VitGetState).MayGet then
    (ActivityCakeView.GetVit)(model, data.id, false)
  else
    if state == (ActivityMgr.VitGetState).AlreadyGet then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000159))
    else
      if state == (ActivityMgr.VitGetState).Unable then
        (MessageMgr.SendCenterTips)((PUtil.get)(20000160))
      else
        if state == (ActivityMgr.VitGetState).Buy then
          if (Util.CheckCostResources)({data.extra_cost}) == false then
            return 
          end
          ;
          (ActivityCakeView.GetVit)(model, data.id, true)
        end
      end
    end
  end
end

ActivityCakeView.GetVit = function(model, id, isBuy, ...)
  -- function num : 0_6 , upvalues : ActivityCakeView, _ENV, enableClick, cakeAction
  if (ActivityCakeView.CheckPhysicalPowerMax)(id) then
    (MessageMgr.SendCenterTips)((PUtil.get)(20000158))
    return 
  end
  if not enableClick then
    return 
  end
  if isBuy then
    (ActivityCakeView.SetBubbleContent)(20000300)
  else
    ;
    (ActivityCakeView.SetBubbleContent)(20000301)
  end
  enableClick = false
  ;
  (SkeletonAnimationUtil.SetAnimation)(model, 0, cakeAction.Eat, false, function(...)
    -- function num : 0_6_0 , upvalues : _ENV, id, enableClick
    (ActivityService.OnReqVitGet)(id)
    ;
    (SimpleTimer.setTimeout)(0.5, function(...)
      -- function num : 0_6_0_0 , upvalues : enableClick
      enableClick = true
    end
)
  end
)
end

ActivityCakeView.CheckPhysicalPowerMax = function(id, ...)
  -- function num : 0_7 , upvalues : _ENV
  local VitGetData = ((TableData.gTable).BaseVitGetData)[id]
  local rewardS = ((Util.ParseConfigStr)(VitGetData.reward))
  -- DECOMPILER ERROR at PC8: Overwrote pending register: R3 in 'AssignReg'

  local addNum = .end
  for _,v in ipairs(rewardS) do
    if tonumber(v[2]) == AssetType.PHYSICAL then
      addNum = tonumber(v[3])
    end
  end
  local FixedData = ((TableData.gTable).BaseFixedData)[Const.MaxPhysicalFixedID]
  local configData = split(FixedData.array_value, ":")
  local max = tonumber(configData[2])
  local possess = (ActorData.GetAssetCount)(AssetType.PHYSICAL)
  do return max < addNum + possess end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ActivityCakeView.OnClose = function(...)
  -- function num : 0_8 , upvalues : enableClick, content, uis
  enableClick = true
  content = nil
  uis = nil
end

ActivityCakeView.HandleMessage = function(msgId, para, ...)
  -- function num : 0_9 , upvalues : _ENV, ActivityCakeView, content, enableClick
  if msgId == 1 then
    print("收到消息了啊哥")
    print(para)
    local index = (ActivityCakeView.GetVitDataIndexByID)(para)
    local comObj = content:GetChild("CardItem_0" .. index .. "_Grp")
    local InitData = (ActivityMgr.GetVitConfigData)()
    ;
    (ActivityCakeView.SetCake)(InitData[index], comObj)
    enableClick = true
    ;
    (ActivityCakeView.CheckBubbleShow)()
  end
end

return ActivityCakeView

