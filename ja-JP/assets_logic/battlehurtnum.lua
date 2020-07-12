-- params : ...
-- function num : 0 , upvalues : _ENV
if IsBattleServer == nil then
  require("Battle_BattleCharacterBloodByName")
  require("Battle_BuffWordByName")
  require("Battle_StateWordNumberByName")
  require("Battle_AbsorbWordNumberByName")
  require("Battle_CritWordNumberByName")
  require("Battle_StateWordNumberCompByName")
  require("Battle_AbsorbWordNumberCompByName")
  require("Battle_CritWordNumberCompByName")
end
local BattleBuffWordType = BattleBuffWordType
local HurtNumType = HurtNumType
local random = math.random
local battleHurtObjectPool = nil
if IsBattleServer == nil then
  battleHurtObjectPool = ((CS.FairyGUI).GObjectPool)(((CS.Launch).Singleton).transform)
end
local BattleHurtNum = {NOR_HURT = "NormalHitNumber", MISS_HURT = "BattleMissWord", NOR_TREATMENT = "GreenNumber", DANDER = "TestBfWord", BUFF_HURT = "BuffHitNumber"}
local BattleHurtNumExportFile = {NOR_HURT = "BattleArtNumber_NormalHitNumberByName", MISS_HURT = "BattleArtNumber_BattleMissWordByName", NOR_TREATMENT = "BattleArtNumber_GreenNumberByName", DANDER = "BattleArtNumber_TestBfWordByName", BUFF_HURT = "BattleArtNumber_BuffHitNumberByName"}
BattleHurtNum.ClearPool = function(...)
  -- function num : 0_0 , upvalues : battleHurtObjectPool
  if battleHurtObjectPool then
    battleHurtObjectPool:Clear()
  end
end

BattleHurtNum.GetHurtNumRes = function(hurt_type, ...)
  -- function num : 0_1 , upvalues : BattleHurtNum, _ENV, battleHurtObjectPool, BattleHurtNumExportFile
  local res = BattleHurtNum[hurt_type]
  local url = UIMgr:GetItemUrl("BattleArtNumber", res)
  local hurtObject = battleHurtObjectPool:GetObject(url)
  require(BattleHurtNumExportFile[hurt_type])
  local uis = nil
  local func = _G["GetBattleArtNumber_" .. res .. "Uis"]
  if func then
    uis = func(hurtObject)
  end
  local text = nil
  if uis then
    text = uis.NumberTxt
  end
  return hurtObject, text
end

ShowHurtNum = function(hurt_type, num, bindObject, ...)
  -- function num : 0_2 , upvalues : HurtNumType, _ENV, BattleBuffWordType, BattleHurtNum, random, battleHurtObjectPool
  if hurt_type == HurtNumType.ABSORB_HURT then
    ShowStateWord(BattleBuffWordType.ABSORB, num, bindObject)
    return 
  else
    if hurt_type == HurtNumType.MOVE_FAIL then
      ShowBuffWord(BattleBuffWordType.MOVE_FAIL, bindObject)
      return 
    else
      if hurt_type == HurtNumType.IMMUNE then
        ShowBuffWord(BattleBuffWordType.IMMUNE, bindObject)
        return 
      else
        if hurt_type == HurtNumType.BLOCK_HURT then
          ShowStateWord(BattleBuffWordType.BLOCK, num, bindObject)
          return 
        else
          if hurt_type == HurtNumType.CRI_HURT then
            ShowStateWord(BattleBuffWordType.CRIT, num, bindObject)
            return 
          else
            if hurt_type == HurtNumType.INVINCIBLE then
              ShowBuffWord(BattleBuffWordType.INVINCIBLE, bindObject)
              return 
            else
              if hurt_type == HurtNumType.DOUBLE_ATTACK then
                ShowBuffWord(BattleBuffWordType.DOUBLE_ATTACK, bindObject)
                return 
              else
                if hurt_type == HurtNumType.KEEP_ALIVE then
                  ShowBuffWord(BattleBuffWordType.KEEP_ALIVE, bindObject)
                  return 
                else
                  if hurt_type == HurtNumType.UNTREATMENT then
                    ShowBuffWord(BattleBuffWordType.UNTREATMENT, bindObject)
                    return 
                  else
                    if hurt_type == HurtNumType.RESIST then
                      ShowBuffWord(BattleBuffWordType.RESIST, bindObject)
                      return 
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  local hurtObject, text = nil, nil
  hurtObject = (BattleHurtNum.GetHurtNumRes)(hurt_type)
  if text then
    num = (math.floor)((math.abs)(num))
    text.text = num
    if hurt_type == HurtNumType.DANDER then
      text.text = num .. " / " .. bindObject:GetDander()
    end
  end
  local battleCamera = (Game.battleCamera):GetComponent("Camera")
  local comp = UIMgr:GetLayerRoot("HUD")
  hurtObject:RemoveFromParent()
  comp:AddChild(hurtObject)
  local camera = battleCamera
  local skillCamera = Game.skillCamera
  if skillCamera and skillCamera.activeSelf == true then
    camera = skillCamera:GetComponent("Camera")
  end
  local pt = ((CS.TransformExtensionOrigin).Get3DPositionToUIPosition)(bindObject:GetModel(), camera, comp)
  hurtObject:SetXY((Umath.RoundToInt)(pt.x) + random(-10, 10), (Umath.RoundToInt)(pt.y - 200) + random(-10, 10))
  local trans = hurtObject:GetTransition("NumberUpAni")
  if trans then
    trans:Play(function(...)
    -- function num : 0_2_0 , upvalues : hurtObject, battleHurtObjectPool
    if hurtObject then
      battleHurtObjectPool:ReturnObject(hurtObject)
    end
  end
)
  end
end

ShowStateWord = function(path, num, bindObject, ...)
  -- function num : 0_3 , upvalues : BattleBuffWordType, battleHurtObjectPool, _ENV, random
  if bindObject == nil then
    return 
  end
  if bindObject:GetModel() == nil then
    return 
  end
  local resStr = ""
  if path == BattleBuffWordType.CRIT then
    resStr = "Battle:CritWordNumber"
  else
    if path == BattleBuffWordType.BLOCK then
      resStr = "Battle:StateWordNumber"
    else
      if path == BattleBuffWordType.ABSORB then
        resStr = "Battle:AbsorbWordNumber"
      end
    end
  end
  local wordObject = (battleHurtObjectPool:GetObject((Util.GetItemUrl)(resStr)))
  local uis, comp = nil, nil
  if path == BattleBuffWordType.CRIT then
    uis = GetBattle_CritWordNumberUis(wordObject)
    comp = uis.CritWordNumberComp
  else
    if path == BattleBuffWordType.BLOCK then
      uis = GetBattle_StateWordNumberUis(wordObject)
      comp = uis.StateWordNumberComp
    else
      if path == BattleBuffWordType.ABSORB then
        uis = GetBattle_AbsorbWordNumberUis(wordObject)
        comp = uis.AbsorbWordNumberComp
      end
    end
  end
  if comp == nil then
    return 
  end
  local wordUrl = (Util.GetItemUrl)(path)
  -- DECOMPILER ERROR at PC65: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (comp.StateLoader).url = wordUrl
  -- DECOMPILER ERROR at PC74: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (comp.NumberTxt).text = (math.floor)((math.abs)(num))
  local battleCamera = (Game.battleCamera):GetComponent("Camera")
  local comp = UIMgr:GetLayerRoot("HUD")
  wordObject:RemoveFromParent()
  comp:AddChild(wordObject)
  local camera = battleCamera
  local skillCamera = Game.skillCamera
  if skillCamera and skillCamera.activeSelf == true then
    camera = skillCamera:GetComponent("Camera")
  end
  local pt = ((CS.TransformExtensionOrigin).Get3DPositionToUIPosition)(bindObject:GetModel(), camera, comp)
  wordObject:SetXY((Umath.RoundToInt)(pt.x) + random(-10, 10), (Umath.RoundToInt)(pt.y - 200) + random(-10, 10))
  local trans = wordObject:GetTransition("in")
  if trans then
    trans:Play(function(...)
    -- function num : 0_3_0 , upvalues : wordObject, battleHurtObjectPool
    if wordObject then
      battleHurtObjectPool:ReturnObject(wordObject)
    end
  end
)
  end
end

ShowBuffWord = function(path, bindObject, ...)
  -- function num : 0_4 , upvalues : battleHurtObjectPool, _ENV, random
  local wordObject = battleHurtObjectPool:GetObject((Util.GetItemUrl)("Battle:BuffWord"))
  local uis = GetBattle_BuffWordUis(wordObject)
  local wordUrl = (Util.GetItemUrl)(path)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (uis.BattleWordLoader).url = wordUrl
  local battleCamera = (Game.battleCamera):GetComponent("Camera")
  local comp = UIMgr:GetLayerRoot("HUD")
  wordObject:RemoveFromParent()
  comp:AddChild(wordObject)
  local camera = battleCamera
  local skillCamera = Game.skillCamera
  if skillCamera and skillCamera.activeSelf == true then
    camera = skillCamera:GetComponent("Camera")
  end
  local pt = ((CS.TransformExtensionOrigin).Get3DPositionToUIPosition)(bindObject:GetModel(), camera, comp)
  wordObject:SetXY((Umath.RoundToInt)(pt.x) + random(-10, 10), (Umath.RoundToInt)(pt.y - 200) + random(-10, 10))
  local trans = wordObject:GetTransition("in")
  if trans then
    trans:Play(function(...)
    -- function num : 0_4_0 , upvalues : wordObject, battleHurtObjectPool
    if wordObject then
      battleHurtObjectPool:ReturnObject(wordObject)
    end
  end
)
  end
end

ClearHurtNum = function(...)
  -- function num : 0_5 , upvalues : BattleHurtNum
  (BattleHurtNum.ClearPool)()
end


