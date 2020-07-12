-- params : ...
-- function num : 0 , upvalues : _ENV
require("CardPop_CardPlotCGShowByName")
local HandBookCGShowWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local CGid = 0
local isGet = false
local isCloseUI = false
local closeFun = nil
HandBookCGShowWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, CGid, isGet, closeFun, uis, HandBookCGShowWindow
  bridgeObj:SetView((WinResConfig.HandBookCGShowWindow).package, (WinResConfig.HandBookCGShowWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  CGid = argTable[1]
  isGet = argTable[2]
  closeFun = argTable[3]
  uis = GetCardPop_CardPlotCGShowUis(contentPane)
  ;
  (HandBookCGShowWindow.OnInitClick)()
  ;
  (Util.RegistCaptureScreenShot)((uis.Information).ShotBtn, (uis.Information).LogoImage, (uis.Information).CodeImage, 1334, 750)
end

HandBookCGShowWindow.OnShown = function(...)
  -- function num : 0_1 , upvalues : _ENV, CGid, uis, isGet
  local data = ((TableData.gTable).BaseHandbookCGData)[CGid]
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.NameTxt).text = data.name
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.CGWordTxt).text = data.remark
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  if isGet then
    (uis.c1Ctr).selectedIndex = 0
    ;
    (LuaSound.PlaySound)(LuaSound.UNLOCK_NEW_CG, SoundBank.OTHER)
    PlayUITrans(uis.root, "get")
  else
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.c1Ctr).selectedIndex = 1
    PlayUITrans(uis.root, "hide")
  end
  local texture = (ResHelper.LoadTexture)(data.fashion_id)
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R2 in 'UnsetPending'

  if texture ~= nil then
    (uis.PictureLoader).texture = (FairyGUI.NTexture)(texture)
  end
end

HandBookCGShowWindow.OnInitClick = function(...)
  -- function num : 0_2 , upvalues : uis, isGet, closeFun, _ENV, isCloseUI
  ((uis.TouchScreenBtn).onClick):Set(function(...)
    -- function num : 0_2_0 , upvalues : isGet, closeFun, _ENV, isCloseUI, uis
    if isGet then
      local closeFun = closeFun
      UIMgr:CloseWindow((WinResConfig.HandBookCGShowWindow).name)
      if closeFun then
        closeFun()
      end
    else
      do
        isCloseUI = not isCloseUI
        local trans = (uis.root):GetTransition("hide")
        if trans then
          if isCloseUI then
            trans:PlayReverse(function(...)
      -- function num : 0_2_0_0 , upvalues : uis
      -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

      (uis.TouchScreenBtn).visible = true
    end
)
          else
            UIMgr:CloseWindow((WinResConfig.HandBookCGShowWindow).name)
          end
        end
      end
    end
  end
)
end

HandBookCGShowWindow.OnHide = function(...)
  -- function num : 0_3
end

HandBookCGShowWindow.OnClose = function(...)
  -- function num : 0_4 , upvalues : uis, _ENV, isCloseUI, contentPane, closeFun, argTable
  if (uis.PictureLoader).texture ~= nil then
    (ResHelper.UnloadTexture)(((uis.PictureLoader).texture).nativeTexture)
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.PictureLoader).texture = nil
  end
  isCloseUI = false
  uis = nil
  contentPane = nil
  closeFun = nil
  argTable = {}
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.HandBookCGShowWindow).name)
end

HandBookCGShowWindow.InitAssetStrip = function(...)
  -- function num : 0_5 , upvalues : _ENV, uis, isGet, CGid
  local m = {}
  m.windowName = (WinResConfig.HandBookCGShowWindow).name
  m.Tip = (PUtil.get)(20000132)
  m.model = uis.AssetStripGrp
  m.moneyTypes = {}
  m.BackBtnFun = function(...)
    -- function num : 0_5_0 , upvalues : isGet, _ENV, CGid
    if not isGet then
      UIMgr:SendWindowMessage((WinResConfig.HandBookAlbumWindow).name, 2, CGid)
    end
  end

  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.AssetStripGrp).CloseBtn).visible = false
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

HandBookCGShowWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_6
end

return HandBookCGShowWindow

