-- params : ...
-- function num : 0 , upvalues : _ENV
local ActivitySevenDayView = {}
local Obj = nil
local spineName = {"ui_aeolian_bells_1day", "ui_aeolian_bells_2day", "ui_aeolian_bells_3day", "ui_aeolian_bells_4day", "ui_aeolian_bells_5day", "ui_aeolian_bells_6day", "ui_aeolian_bells_7day"}
local spineAni = {"idle", "idle2", "idle3"}
local holder = nil
local sfxPosY = {100, 220, 145, 185, 75, 215, 125}
ActivitySevenDayView.OnInit = function(obj, ...)
  -- function num : 0_0 , upvalues : Obj, ActivitySevenDayView
  Obj = obj
  ;
  (ActivitySevenDayView.SetLoaderContent)()
  ;
  (ActivitySevenDayView.SetShow)()
end

ActivitySevenDayView.SetLoaderContent = function(...)
  -- function num : 0_1 , upvalues : Obj, _ENV, spineName
  for i = 1, 7 do
    local dayObj = (Obj:GetChild("Day_" .. i)):GetChild("RewardLoader")
    if dayObj.Model == nil then
      (Util.ShowUIModel)(spineName[i], dayObj)
    end
  end
end

ActivitySevenDayView.SetShow = function(...)
  -- function num : 0_2 , upvalues : _ENV, holder, Obj, spineAni, sfxPosY
  (LuaEffect.DestroyEffect)(holder)
  local loginData = (ActivityMgr.InitSevenLoginData)()
  local day = loginData.day
  local get = loginData.dayGet
  for i = 1, 7 do
    do
      local dayObj = Obj:GetChild("Day_" .. i)
      local loader = dayObj:GetChild("RewardLoader")
      local model = (loader.Model).gameObject
      if i < day then
        (SkeletonAnimationUtil.SetAnimation)(model, 0, spineAni[3], true)
      else
        if i == day then
          if get then
            (SkeletonAnimationUtil.SetAnimation)(model, 0, spineAni[3], true)
          else
            ;
            (SkeletonAnimationUtil.SetAnimation)(model, 0, spineAni[2], true)
            local pos = Vector2(loader.width / 2, sfxPosY[i])
            holder = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_SEVEN_LOGIN, false, dayObj, pos)
          end
        else
          do
            do
              ;
              (SkeletonAnimationUtil.SetAnimation)(model, 0, spineAni[1], true)
              ;
              (dayObj.onClick):Set(function(...)
    -- function num : 0_2_0 , upvalues : i, day, get, _ENV
    if i == day and not get then
      (ActivityService.ReqLoginActGet)(day)
    else
      if i == day + 1 then
        (MessageMgr.SendCenterTips)((PUtil.get)(20000409))
      else
        if day < i then
          (MessageMgr.SendCenterTips)((PUtil.get)(20000380))
        end
      end
    end
  end
)
            end
            -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out DO_STMT

          end
        end
      end
    end
  end
end

ActivitySevenDayView.OnClose = function(...)
  -- function num : 0_3 , upvalues : Obj, _ENV, holder
  Obj = nil
  ;
  (LuaEffect.DestroyEffect)(holder)
  holder = nil
end

ActivitySevenDayView.HandleMessage = function(msgId, para, ...)
  -- function num : 0_4 , upvalues : _ENV, ActivitySevenDayView
  if msgId == 1 then
    loge("刷新了界面")
    ;
    (ActivitySevenDayView.SetShow)()
  else
  end
  if msgId == 2 then
  end
end

return ActivitySevenDayView

