-- params : ...
-- function num : 0 , upvalues : _ENV
require("Activity_SignByName")
require("Activity_SignItemByName")
local ActivitySignView = {}
local RelationType = FairyGUI.RelationType
local uis = nil
local signItemS = {}
local extraItemS = {}
local sfxHolder = nil
ActivitySignView.OnInit = function(obj, ...)
  -- function num : 0_0 , upvalues : uis, _ENV, ActivitySignView
  uis = GetActivity_SignUis(obj)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.ItemList).itemRenderer = ActivitySignView.SignItemRender
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.TotalItemList).itemRenderer = ActivitySignView.SignTotalRender
  ;
  (ActivitySignView.RefreshSingItemList)()
  ;
  (ActivitySignView.RefreshTotalItemList)()
  ;
  (ActivitySignView.RefreshText)()
end

ActivitySignView.RefreshSingItemList = function(...)
  -- function num : 0_1 , upvalues : _ENV, signItemS, sfxHolder, uis
  local configId = ((ActivityMgr.SingInitData)()).signInId
  local signInData = ((TableData.gTable).BaseSignInData)[configId]
  signItemS = {}
  signItemS = split(signInData.rewards, ",")
  ;
  (LuaEffect.DestroyEffect)(sfxHolder)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.ItemList).numItems = #signItemS
end

ActivitySignView.RefreshTotalItemList = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV, extraItemS
  (uis.TotalItemList):RemoveChildrenToPool()
  local configId = ((ActivityMgr.SingInitData)()).extraId
  local signInData = ((TableData.gTable).BaseSignInExtraData)[configId]
  extraItemS = {}
  extraItemS = (Util.ParseConfigStr)(signInData.rewards)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.TotalItemList).numItems = #extraItemS
end

ActivitySignView.SignTotalRender = function(index, obj, ...)
  -- function num : 0_3 , upvalues : extraItemS, _ENV
  local data = extraItemS[index + 1]
  if data == nil then
    return 
  end
  local icon = obj:GetChild("ItemLoader")
  local num = obj:GetChild("NumberTxt")
  local itemData = (Util.GetConfigDataByID)(data[2])
  icon.url = (Util.GetItemUrl)(itemData.icon)
  num.text = data[3]
  ;
  (CommonWinMgr.RegisterItemLongPress)(icon, tonumber(data[2]))
end

ActivitySignView.RefreshText = function(...)
  -- function num : 0_4 , upvalues : _ENV, uis
  local totalSignInDay = ((ActivityMgr.SingInitData)()).totalSignInDay
  local configId = ((ActivityMgr.SingInitData)()).extraId
  local signInData = ((TableData.gTable).BaseSignInExtraData)[configId]
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (uis.TotalDayTxt).text = signInData.count
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (uis.TotalNumberTxt).text = (PUtil.get)(20000157, totalSignInDay)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (uis.TotalGetBtn).text = (PUtil.get)(60000023)
  if totalSignInDay < signInData.count or not (ActivityMgr.EnableGetExtra)() then
    ChangeUIController(uis.TotalGetBtn, "c1", 1)
  else
    ChangeUIController(uis.TotalGetBtn, "c1", 0)
  end
  ;
  ((uis.TotalGetBtn).onClick):Set(function(...)
    -- function num : 0_4_0 , upvalues : totalSignInDay, signInData, _ENV
    if signInData.count <= totalSignInDay and (ActivityMgr.EnableGetExtra)() then
      (ActivityService.OnReqSignInReward)()
    else
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(20000161))
    end
  end
)
end

ActivitySignView.SignItemRender = function(index, mObj, ...)
  -- function num : 0_5 , upvalues : _ENV, signItemS, uis, sfxHolder
  local model = GetActivity_SignItemUis(mObj)
  local data = signItemS[index + 1]
  local configItem = split(data, ":")
  local itemData = (Util.GetConfigDataByID)(configItem[2])
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (model.ItemLoader).url = (Util.GetItemUrl)(itemData.icon)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (model.NumberTxt).text = configItem[3]
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (model.c2Ctr).selectedIndex = itemData.quality
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (model.OrderTxt).text = index + 1
  ;
  (CommonWinMgr.RegisterItemLongPress)(model.ItemLoader, tonumber(configItem[2]))
  local itemState = (ActivityMgr.GetSignState)(index)
  if itemState == (ActivityMgr.SignItemState).Enable then
    (SimpleTimer.setTimeout)(0.001, function(...)
    -- function num : 0_5_0 , upvalues : _ENV, mObj, uis, sfxHolder
    local mPos = Vector2(mObj.x + mObj.width / 2, mObj.y + mObj.height / 2 + 4)
    local pos = (uis.ItemList):TransformPoint(mPos, uis.root)
    sfxHolder = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_SIGN_CAN, false, uis.root, pos)
  end
)
  end
  ;
  (mObj.onClick):Set(function(...)
    -- function num : 0_5_1 , upvalues : itemState, _ENV
    if itemState == (ActivityMgr.SignItemState).Enable then
      (ActivityService.OnReqSignIn)()
    else
      if itemState == (ActivityMgr.SignItemState).UnEnable then
        if ((ActivityMgr.SingInitData)()).canSignIn then
          (MessageMgr.SendCenterTips)((PUtil.get)(20000231))
        else
          ;
          (MessageMgr.SendCenterTips)((PUtil.get)(20000196))
        end
      end
    end
  end
)
  -- DECOMPILER ERROR at PC59: Confused about usage of register: R7 in 'UnsetPending'

  if itemState == (ActivityMgr.SignItemState).Already then
    (model.c1Ctr).selectedIndex = 1
  else
    -- DECOMPILER ERROR at PC62: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (model.c1Ctr).selectedIndex = 0
  end
end

ActivitySignView.OnClose = function(...)
  -- function num : 0_6 , upvalues : signItemS, extraItemS, uis, _ENV, sfxHolder
  signItemS = {}
  extraItemS = {}
  uis = nil
  ;
  (LuaEffect.DestroyEffect)(sfxHolder)
  sfxHolder = nil
end

ActivitySignView.HandleMessage = function(msgId, para, ...)
  -- function num : 0_7 , upvalues : ActivitySignView
  if msgId == 1 then
    (ActivitySignView.RefreshSingItemList)()
    ;
    (ActivitySignView.RefreshText)()
  else
    if msgId == 2 then
      (ActivitySignView.RefreshTotalItemList)()
      ;
      (ActivitySignView.RefreshText)()
    end
  end
end

return ActivitySignView

