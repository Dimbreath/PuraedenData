-- params : ...
-- function num : 0 , upvalues : _ENV
require("Equipt_EquiptByName")
require("Equipt_EquiptPopByName")
require("DescriptionTips_ItemTipsByName")
EquipmentWindowType = {Main = 0, Secondary = 1}
EquipmentSecondaryPageType = {Change = 0, Attribute = 1, Decompose = 2, Identify = 3}
EquipmentPanelPosType = {Left = 1, Right = 2, Middle = 3}
local EquipmentNewStatus = {None = 1, NeedShow = 2, Showed = 3}
local EquipmentWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local DEFAULT_CHOOSE_INDEX = 1
local DEFAULT_CHOOSE_TYPE = EquiptPartsType.All
local _currentRoleIndex = 0
local _equipmentSlotsMain = {}
local _currentChosedSlot, _detailMainPanelGrp = nil, nil
local _equipmentPartPos = {}
local _equipmentSlotsSecondary = {}
local _currentEquipmentType = 0
local _allEquipmentType = 0
local _currentIdentifyEquipmentType = EquiptPartsType.All
local _equipmentTypeFilterBtn = {}
local _detailReplacePanelGrp = nil
local _leftDetailPos = 0
local _rightDetailPos = 0
local _middleDetailPos = 0
local _detailUnidentifyPanelGrp, _originUnidentifyPanelYSize, _identifyCostComponent = nil, nil, nil
local _selectedInBag = 0
local _selectedInBagItem = nil
local _slotsEquipInfo = {}
local _noEquipmentsEffect, _noEquipEffect = nil, nil
local _newStatus = EquipmentNewStatus.None
local _secondEquipInit = false
local _bgEffect = nil
local _currentFashionId = 0
local shutterCount = nil
local FxManager = require("FxManager")
EquipmentWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, EquipmentWindow
  bridgeObj:SetView((WinResConfig.EquipmentWindow).package, (WinResConfig.EquipmentWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = {Type = (bridgeObj.argTable)[1], Arg = (bridgeObj.argTable)[2]}
  contentPane:Center()
  uis = GetEquipt_EquiptUis(contentPane)
  ;
  (EquipmentWindow.InitTopMenu)()
  ;
  (EquipmentWindow.InitVariable)()
  ;
  (EquipmentWindow.InitText)()
  ;
  (EquipmentWindow.InitUIStatus)()
  ;
  (EquipmentWindow.InitList)()
  ;
  (EquipmentWindow.InitButtonEvent)()
  ;
  (EquipmentWindow.BindingUI)()
  ;
  (EquipmentWindow.InitFunctionControl)()
end

EquipmentWindow.InitTopMenu = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis, EquipmentWindow
  local m = {}
  m.windowName = (WinResConfig.EquipmentWindow).name
  m.Tip = (PUtil.get)(20000029)
  m.model = uis.AssetStripGrp
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.EQUIP_EXP}
  m.BackBtnFun = function(...)
    -- function num : 0_1_0 , upvalues : uis, _ENV, EquipmentWindow
    if (uis.c1Ctr).selectedIndex == EquipmentWindowType.Main then
      UIMgr:CloseWindow((WinResConfig.EquipmentWindow).name)
    else
      ;
      (EquipmentWindow.CloseAllDetail)()
      ;
      (EquipmentWindow.RefreshEquipmentInfoMain)()
      ;
      (LuaSound.PlaySound)(LuaSound.COMMON_PANEL_IN, SoundBank.OTHER)
      ;
      (EquipmentWindow.ChangeStatus)(EquipmentWindowType.Main)
    end
  end

  m.CloseBtnFun = function(...)
    -- function num : 0_1_1 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.EquipmentWindow).name)
  end

  m.isSelfClose = true
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

EquipmentWindow.InitVariable = function(...)
  -- function num : 0_2 , upvalues : _detailMainPanelGrp, EquipmentWindow, _detailReplacePanelGrp, _detailUnidentifyPanelGrp, _equipmentSlotsMain, _ENV, uis, _equipmentPartPos, _equipmentSlotsSecondary, _equipmentTypeFilterBtn, _identifyCostComponent
  _detailMainPanelGrp = (EquipmentWindow.GetDefaultPanelGrp)(_detailMainPanelGrp)
  _detailReplacePanelGrp = (EquipmentWindow.GetDefaultPanelGrp)(_detailReplacePanelGrp)
  _detailUnidentifyPanelGrp = (EquipmentWindow.GetDefaultPanelGrp)(_detailUnidentifyPanelGrp)
  _equipmentSlotsMain[EquiptPartsType.Weapon] = uis.WeaponGrp
  _equipmentSlotsMain[EquiptPartsType.Chest] = uis.ClothesGrp
  _equipmentSlotsMain[EquiptPartsType.Ring] = uis.RingGrp
  _equipmentSlotsMain[EquiptPartsType.Necklace] = uis.NecklaceGrp
  _equipmentPartPos[EquiptPartsType.Weapon] = EquipmentPanelPosType.Right
  _equipmentPartPos[EquiptPartsType.Chest] = EquipmentPanelPosType.Left
  _equipmentPartPos[EquiptPartsType.Ring] = EquipmentPanelPosType.Left
  _equipmentPartPos[EquiptPartsType.Necklace] = EquipmentPanelPosType.Right
  _equipmentSlotsSecondary[EquiptPartsType.Weapon] = (uis.EquiptPanelGrp).WeaponGrp
  _equipmentSlotsSecondary[EquiptPartsType.Chest] = (uis.EquiptPanelGrp).ClothesGrp
  _equipmentSlotsSecondary[EquiptPartsType.Ring] = (uis.EquiptPanelGrp).RingGrp
  _equipmentSlotsSecondary[EquiptPartsType.Necklace] = (uis.EquiptPanelGrp).NecklaceGrp
  _equipmentTypeFilterBtn[EquiptPartsType.Weapon] = (((uis.EquiptPanelGrp).EquiptChangeGrp).EquiptChangeBtnPanelGrp).WeaponBtn
  _equipmentTypeFilterBtn[EquiptPartsType.Chest] = (((uis.EquiptPanelGrp).EquiptChangeGrp).EquiptChangeBtnPanelGrp).ClothesBtn
  _equipmentTypeFilterBtn[EquiptPartsType.Ring] = (((uis.EquiptPanelGrp).EquiptChangeGrp).EquiptChangeBtnPanelGrp).RingBtn
  _equipmentTypeFilterBtn[EquiptPartsType.Necklace] = (((uis.EquiptPanelGrp).EquiptChangeGrp).EquiptChangeBtnPanelGrp).NecklaceBtn
  _equipmentTypeFilterBtn[EquiptPartsType.All] = (((uis.EquiptPanelGrp).EquiptChangeGrp).EquiptChangeBtnPanelGrp).AllBtn
  _identifyCostComponent = {}
  _identifyCostComponent[1] = {Txt = (((uis.EquiptPanelGrp).AppraisalGrp).Appraisal).Spend_A_Txt, Loader = (((uis.EquiptPanelGrp).AppraisalGrp).Appraisal).Spend_A_Loader}
  _identifyCostComponent[2] = {Txt = (((uis.EquiptPanelGrp).AppraisalGrp).Appraisal).Spend_B_Txt, Loader = (((uis.EquiptPanelGrp).AppraisalGrp).Appraisal).Spend_B_Loader}
end

EquipmentWindow.InitText = function(...)
  -- function num : 0_3 , upvalues : uis, _ENV
  (((uis.EquiptPanelGrp).CleanUpBtn):GetChild("NameTxt")).text = (PUtil.get)(60000056)
  ;
  (((uis.EquiptPanelGrp).EquiptDetailedBtn):GetChild("NameTxt")).text = (PUtil.get)(60000054)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.EquiptPanelGrp).EquiptDetailedGrp).NothingTxt).text = (PUtil.get)(60000389)
  ;
  (((uis.EquiptPanelGrp).EquiptChangeBtn):GetChild("NameTxt")).text = (PUtil.get)(20000029)
  ;
  (((uis.EquiptPanelGrp).AppraisalBtn):GetChild("NameTxt")).text = (PUtil.get)(60000323)
  -- DECOMPILER ERROR at PC55: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.EquiptPanelGrp).EquiptChangeGrp).WordTxt).text = (PUtil.get)(60000319)
  -- DECOMPILER ERROR at PC63: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.EquiptPanelGrp).EquiptChangeGrp).AllChoiceTxt).text = (PUtil.get)(60000373)
  -- DECOMPILER ERROR at PC72: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((((uis.EquiptPanelGrp).EquiptChangeGrp).EquiptScreenGrp).titilenameTxt).text = (PUtil.get)(60000326)
  -- DECOMPILER ERROR at PC81: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((((uis.EquiptPanelGrp).EquiptChangeGrp).EquiptScreenGrp).SureBtn).text = (PUtil.get)(60000069)
  -- DECOMPILER ERROR at PC89: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.EquiptPanelGrp).EquiptDetailedGrp).TitleTxt).text = (PUtil.get)(60000054)
  -- DECOMPILER ERROR at PC98: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((((uis.EquiptPanelGrp).CleanUpGrp).CleanUpChoice).ResetBtn).text = (PUtil.get)(60000069)
  -- DECOMPILER ERROR at PC107: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((((uis.EquiptPanelGrp).CleanUpGrp).CleanUpChoice).titilenameTxt).text = (PUtil.get)(60000326)
  -- DECOMPILER ERROR at PC115: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.EquiptPanelGrp).CleanUpGrp).DecomposeBtn).text = (PUtil.get)(60000058)
  -- DECOMPILER ERROR at PC123: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.EquiptPanelGrp).CleanUpGrp).AllChoiceTxt).text = (PUtil.get)(60000335)
  -- DECOMPILER ERROR at PC132: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((((uis.EquiptPanelGrp).AppraisalGrp).Appraisal).CleanUp_01_Txt).text = (PUtil.get)(60000322)
  -- DECOMPILER ERROR at PC141: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((((uis.EquiptPanelGrp).AppraisalGrp).Appraisal).SureBtn).text = (PUtil.get)(60000323)
  -- DECOMPILER ERROR at PC150: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((((uis.EquiptPanelGrp).AppraisalGrp).Appraisal).titilenameTxt).text = (PUtil.get)(60000485)
  -- DECOMPILER ERROR at PC159: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((((uis.EquiptPanelGrp).AppraisalGrp).Appraisal).CleanBtn).text = (PUtil.get)(60000392)
end

EquipmentWindow.InitUIStatus = function(...)
  -- function num : 0_4 , upvalues : _ENV, _equipmentSlotsMain, _equipmentTypeFilterBtn, _equipmentSlotsSecondary
  for i = 1, EquiptData.EQUIPMENT_TYPE_COUNT do
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

    ((_equipmentSlotsMain[i]).c4Ctr).selectedIndex = i - 1
    ;
    ((_equipmentTypeFilterBtn[i]):GetController("c1")).selectedIndex = i - 1
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (((_equipmentSlotsSecondary[i]).FrameEffGrp).root).visible = false
  end
  ;
  ((_equipmentTypeFilterBtn[EquiptPartsType.All]):GetController("c1")).selectedIndex = 4
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((_equipmentSlotsSecondary[EquiptPartsType.Chest]).c4Ctr).selectedIndex = 1
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((_equipmentSlotsSecondary[EquiptPartsType.Ring]).c4Ctr).selectedIndex = 1
end

EquipmentWindow.InitList = function(...)
  -- function num : 0_5 , upvalues : uis, EquipmentWindow
  (((uis.EquiptPanelGrp).EquiptChangeGrp).EquiptList):SetVirtual()
  ;
  ((((uis.EquiptPanelGrp).AppraisalGrp).Appraisal).CleanUpList):SetVirtual()
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((((uis.EquiptPanelGrp).AppraisalGrp).Appraisal).CleanUpList).itemRenderer = EquipmentWindow.RefreshReadyToIdentifyItem
  ;
  (((uis.EquiptPanelGrp).CleanUpGrp).EquiptList):SetVirtual()
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.EquiptPanelGrp).CleanUpGrp).EquiptList).itemRenderer = EquipmentWindow.RefreshDecomposeItem
end

EquipmentWindow.InitButtonEvent = function(...)
  -- function num : 0_6 , upvalues : uis, EquipmentWindow
  ((uis.TouchScreenBtn).onClick):Add(EquipmentWindow.ClickBlankBtn)
  ;
  (((uis.EquiptPanelGrp).EquiptDetailedBtn).onClick):Add(EquipmentWindow.ClickDetailBtn)
  ;
  (((uis.EquiptPanelGrp).EquiptChangeBtn).onClick):Add(EquipmentWindow.ClickChangePageBtn)
  ;
  (((uis.EquiptPanelGrp).CleanUpBtn).onClick):Add(EquipmentWindow.ClickDecomposePageBtn)
  ;
  (((uis.EquiptPanelGrp).AppraisalBtn).onClick):Add(EquipmentWindow.ClickIdentifyPageBtn)
  ;
  (((((uis.EquiptPanelGrp).AppraisalGrp).Appraisal).SureBtn).onClick):Add(EquipmentWindow.ClickIdentifyBtn)
  ;
  (((((uis.EquiptPanelGrp).AppraisalGrp).Appraisal).CleanBtn).onClick):Add(EquipmentWindow.ClickIdentifyCancelAllBtn)
  ;
  ((((uis.EquiptPanelGrp).EquiptChangeGrp).AllChoiceBtn).onClick):Add(EquipmentWindow.ClickIdentifyAllChoseBtn)
  ;
  (((((uis.EquiptPanelGrp).EquiptChangeGrp).EquiptScreenGrp).CloseBtn).onClick):Add(EquipmentWindow.ClickCloseChangeFilterBtn)
  ;
  (((((uis.EquiptPanelGrp).EquiptChangeGrp).EquiptScreenGrp).SureBtn).onClick):Add(EquipmentWindow.ClickChangeFilterResetBtn)
  ;
  ((((uis.EquiptPanelGrp).CleanUpGrp).AllChoiceBtn).onClick):Add(EquipmentWindow.ClickAllChoseBtn)
  ;
  ((((uis.EquiptPanelGrp).CleanUpGrp).DecomposeBtn).onClick):Add(EquipmentWindow.ClickDecomposeBtn)
  ;
  (((((uis.EquiptPanelGrp).CleanUpGrp).CleanUpChoice).SortBtn).onClick):Add(EquipmentWindow.ClickDecomposeSortBtn)
  ;
  (((((uis.EquiptPanelGrp).CleanUpGrp).CleanUpChoice).ResetBtn).onClick):Add(EquipmentWindow.ClickDecomposeResetBtn)
end

EquipmentWindow.BindingUI = function(...)
  -- function num : 0_7 , upvalues : _ENV, uis, _equipmentSlotsMain
  local winName = (WinResConfig.EquipmentWindow).name
  local BindingUI = RedDotMgr.BindingUI
  local RedDotComID = RedDotComID
  BindingUI(winName, RedDotComID.Equipt_Role_List, uis.CardHeadList, true)
  local equipmentSlots = {}
  for i = 1, EquiptData.EQUIPMENT_TYPE_COUNT do
    (table.insert)(equipmentSlots, (_equipmentSlotsMain[i]).root)
  end
  BindingUI(winName, RedDotComID.Equipt_Equipment_List, equipmentSlots, true)
  BindingUI(winName, RedDotComID.Equipt_Equipment, (uis.EquiptPanelGrp).EquiptChangeBtn)
  BindingUI(winName, RedDotComID.Equipt_Weapon, ((uis.EquiptPanelGrp).WeaponGrp).root)
  BindingUI(winName, RedDotComID.Equipt_Chest, ((uis.EquiptPanelGrp).ClothesGrp).root)
  BindingUI(winName, RedDotComID.Equipt_Necklace, ((uis.EquiptPanelGrp).NecklaceGrp).root)
  BindingUI(winName, RedDotComID.Equipt_Ring, ((uis.EquiptPanelGrp).RingGrp).root)
  BindingUI(winName, RedDotComID.Equipt_Identify, (uis.EquiptPanelGrp).AppraisalBtn)
end

EquipmentWindow.InitFunctionControl = function(...)
  -- function num : 0_8 , upvalues : _ENV, uis
  local winName = (WinResConfig.EquipmentWindow).name
  local RegisterGuideAndControl = GuideData.RegisterGuideAndControl
  local ControlID = ControlID
  RegisterGuideAndControl(ControlID.Equipment_Detail, (uis.EquiptPanelGrp).EquiptDetailedBtn, winName)
  RegisterGuideAndControl(ControlID.Equipment_Equip, (uis.EquiptPanelGrp).EquiptChangeBtn, winName)
  RegisterGuideAndControl(ControlID.Equipment_Identify, (uis.EquiptPanelGrp).AppraisalBtn, winName)
  RegisterGuideAndControl(ControlID.Equipment_ClearUp, (uis.EquiptPanelGrp).CleanUpBtn, winName)
  RegisterGuideAndControl(ControlID.Equipment_IdentifyBag, ((uis.EquiptPanelGrp).EquiptChangeGrp).EquiptList, winName)
  RegisterGuideAndControl(ControlID.Equipment_IdentifyBtn, (((uis.EquiptPanelGrp).AppraisalGrp).Appraisal).SureBtn, winName)
  RegisterGuideAndControl(ControlID.Equipment_Weapon, (uis.WeaponGrp).root, winName)
  RegisterGuideAndControl(ControlID.Equipment_AllBag, ((uis.EquiptPanelGrp).EquiptChangeGrp).EquiptList, winName)
end

EquipmentWindow.InitEvent = function(...)
  -- function num : 0_9
end

EquipmentWindow.RemoveEvent = function(...)
  -- function num : 0_10
end

EquipmentWindow.OnShown = function(...)
  -- function num : 0_11 , upvalues : EquipmentWindow
  (EquipmentWindow.InitEvent)()
  ;
  (EquipmentWindow.Init)()
end

EquipmentWindow.OnHide = function(...)
  -- function num : 0_12
end

EquipmentWindow.Init = function(...)
  -- function num : 0_13 , upvalues : _bgEffect, _ENV, uis, _currentRoleIndex, EquipmentWindow, DEFAULT_CHOOSE_INDEX, argTable
  if _bgEffect == nil then
    _bgEffect = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_EQUIPMENT_BG)
    _bgEffect:SetXY((uis.root).width / 2, (uis.root).height / 2)
    ;
    (uis.root):AddChild(_bgEffect)
    ;
    (uis.root):SetChildIndex(_bgEffect, (uis.root):GetChildIndex(uis.DecorateImage) + 1)
  end
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (GRoot.inst).IgnoreItemClick = false
  ;
  (EquiptData.InitFilter)()
  if _currentRoleIndex == 0 then
    (EquipmentWindow.ChoseRole)(DEFAULT_CHOOSE_INDEX)
  else
    ;
    (EquipmentWindow.ChoseRole)(_currentRoleIndex)
  end
  ;
  (EquipmentWindow.InitRoleList)()
  ;
  (RedDotMgr.RefreshTreeUI)((WinResConfig.EquipmentWindow).name)
  ;
  (EquipmentWindow.RefreshIdentifyBtnRedDot)()
  if argTable.Type == EquiptOpenType.Decompose then
    (EquipmentWindow.ChangeStatus)(EquipmentWindowType.Secondary)
    ;
    (EquipmentWindow.ChoseEquipByType)(EquiptPartsType.Weapon)
    ;
    (EquipmentWindow.RefreshChangePage)()
    -- DECOMPILER ERROR at PC76: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.EquiptPanelGrp).c1Ctr).selectedIndex = EquipmentSecondaryPageType.Decompose
    ;
    (EquipmentWindow.ClickDecomposePageBtn)()
  else
    -- DECOMPILER ERROR at PC89: Confused about usage of register: R0 in 'UnsetPending'

    if argTable.Type == EquiptOpenType.Identify then
      ((uis.EquiptPanelGrp).c1Ctr).selectedIndex = EquipmentSecondaryPageType.Identify
      ;
      (EquipmentWindow.ChangeStatus)(EquipmentWindowType.Secondary)
      ;
      (EquipmentWindow.ChoseEquipByType)(EquiptPartsType.Weapon)
      ;
      (EquipmentWindow.RefreshIdentifyPage)()
    else
      if argTable.Type == EquiptOpenType.SpecifyEquipment then
        (EquipmentWindow.ChangeStatus)(EquipmentWindowType.Secondary)
        local config = ((TableData.gTable).BaseEquipData)[((EquiptData.Equipments)[(EquiptData.Equipments)[argTable.Arg]]).id]
        ;
        (EquipmentWindow.ChoseEquipByType)(config.type)
        ;
        (EquipmentWindow.RefreshChangePage)()
        if argTable.Arg ~= nil then
          local equipments = ((EquiptData.Filters)[EquiptSetType.Change]).Result
          local count = #equipments
          local data = nil
          for i = 1, count do
            data = (EquiptData.Equipments)[(EquiptData.Equipments)[equipments[i]]]
            if data.objectIndex == argTable.Arg then
              (EquipmentWindow.SetEquipInBagSelected)(data.objectIndex, nil)
              ;
              (EquipmentWindow.HandleEquipDetail)(data, (((TableData.gTable).BaseEquipData)[data.id]).type, false)
              ;
              (((uis.EquiptPanelGrp).EquiptChangeGrp).EquiptList):ScrollToView(i)
              argTable.Arg = nil
            end
          end
        end
      else
        do
          if argTable.Type == EquiptOpenType.ChangeRoldEquipts then
            (EquipmentWindow.ChangeStatus)(EquipmentWindowType.Secondary)
            ;
            (EquipmentWindow.ChoseEquipByType)(EquiptPartsType.Weapon)
            ;
            (EquipmentWindow.RefreshChangePage)()
            local cards = (CardData.GetObtainedCardList)()
            local count = #cards
            for i = 1, count do
              if (cards[i]).id == argTable.Arg then
                _currentRoleIndex = i
                ;
                (EquipmentWindow.ChoseRole)(_currentRoleIndex)
                ;
                (EquipmentWindow.InitRoleList)()
                break
              end
            end
          end
        end
      end
    end
  end
end

EquipmentWindow.OnClose = function(...)
  -- function num : 0_14 , upvalues : _bgEffect, _ENV, _currentFashionId, _secondEquipInit, _currentRoleIndex, _noEquipmentsEffect, _noEquipEffect, _selectedInBag, _selectedInBagItem, _currentIdentifyEquipmentType, EquipmentWindow, uis, _detailMainPanelGrp, _detailReplacePanelGrp, _detailUnidentifyPanelGrp, _currentChosedSlot, shutterCount, contentPane, _equipmentSlotsMain, _equipmentSlotsSecondary, _slotsEquipInfo
  if _bgEffect ~= nil then
    _bgEffect:Dispose()
    _bgEffect = nil
  end
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.EquipmentWindow).name)
  ;
  (GuideData.AbolishControlRefer)((WinResConfig.EquipmentWindow).name)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.NewEquipments = {}
  ;
  (EquiptData.ResetData)()
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (GRoot.inst).IgnoreItemClick = true
  _currentFashionId = 0
  _secondEquipInit = false
  _currentRoleIndex = 0
  _noEquipmentsEffect = nil
  _notEquiptEquipmentEffect = nil
  _noEquipEffect = nil
  _selectedInBag = nil
  _selectedInBagItem = nil
  _currentIdentifyEquipmentType = EquiptPartsType.All
  ;
  (GRoot.inst):ClearCustomPopups()
  ;
  (EquipmentWindow.RemoveEvent)()
  ;
  (Util.RecycleUIModel)(uis.CardShowLoader)
  _detailMainPanelGrp = (EquipmentWindow.GetDefaultPanelGrp)(_detailMainPanelGrp, true)
  _detailReplacePanelGrp = (EquipmentWindow.GetDefaultPanelGrp)(_detailReplacePanelGrp, true)
  _detailUnidentifyPanelGrp = (EquipmentWindow.GetDefaultPanelGrp)(_detailUnidentifyPanelGrp, true)
  _currentChosedSlot = nil
  uis = nil
  if shutterCount ~= nil then
    shutterCount:stop()
    shutterCount = nil
  end
  contentPane = nil
  _equipmentSlotsMain = {}
  _equipmentSlotsSecondary = {}
  _slotsEquipInfo = {}
end

EquipmentWindow.InitPanelPostition = function(panelSize, ...)
  -- function num : 0_15 , upvalues : _rightDetailPos, _leftDetailPos, _ENV, _middleDetailPos
  if _rightDetailPos == 0 then
    _leftDetailPos = 30 + (ResolutionHandler.AdaptOffset).X
    _rightDetailPos = _leftDetailPos + panelSize + 5
    _middleDetailPos = (DesignScreen.width - panelSize) * 0.5 + (ResolutionHandler.AdaptOffset).X
  end
end

EquipmentWindow.InitRoleList = function(...)
  -- function num : 0_16 , upvalues : _ENV, uis, EquipmentWindow, _currentRoleIndex
  (CardMgr.SetButtomRoleList)(uis.CardHeadList, function(index, data, ...)
    -- function num : 0_16_0 , upvalues : EquipmentWindow
    (EquipmentWindow.ChoseRole)(index, data, true)
  end
, _currentRoleIndex, uis.LeftBtn, uis.RightBtn, (WinResConfig.EquipmentWindow).name)
  ;
  (((uis.CardHeadList).scrollPane).onScroll):Add(function(...)
    -- function num : 0_16_1 , upvalues : _ENV
    RedDotManager:RefreshVirtualListReddot((WinResConfig.EquipmentWindow).name, RedDotComID.Equipt_Role_List)
  end
)
end

EquipmentWindow.ChoseRole = function(index, roleData, manualChose, ...)
  -- function num : 0_17 , upvalues : _currentRoleIndex, _ENV, EquipmentWindow
  _currentRoleIndex = index
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R3 in 'UnsetPending'

  if roleData ~= nil then
    EquiptData.CurrentRoleData = roleData
  else
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

    EquiptData.CurrentRoleData = ((CardData.GetObtainedCardList)())[index]
  end
  ;
  (EquipmentWindow.RefreshCurrentRoleInfo)(manualChose)
end

EquipmentWindow.RefreshCurrentRoleInfo = function(manualChose, ...)
  -- function num : 0_18 , upvalues : EquipmentWindow, uis, _ENV, _currentFashionId, shutterCount, FxManager
  (EquipmentWindow.CloseAllDetail)()
  if (uis.c1Ctr).selectedIndex == EquipmentWindowType.Main then
    (EquipmentWindow.RefreshEquipmentInfoMain)()
  else
    if manualChose then
      (EquipmentWindow.RefreshEquipmentInfoSecondary)(0)
    else
      ;
      (EquipmentWindow.RefreshEquipmentInfoSecondary)()
    end
    if ((uis.EquiptPanelGrp).c1Ctr).selectedIndex == EquipmentSecondaryPageType.Attribute then
      (EquipmentWindow.RefreshAttributesPanel)()
    else
      if ((uis.EquiptPanelGrp).c1Ctr).selectedIndex == EquipmentSecondaryPageType.Change then
        (EquiptMgr.AfterFilterChanged)(EquiptSetType.Change)
      end
    end
  end
  if _currentFashionId ~= (EquiptData.CurrentRoleData).fashionId then
    _currentFashionId = (EquiptData.CurrentRoleData).fashionId
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.CardShowLoader).alpha = 0
    ;
    (Util.RecycleUIModel)(uis.CardShowLoader)
    local obj = (Util.CreateShowModel)((EquiptData.CurrentRoleData).fashionId, uis.CardShowLoader)
    do
      if shutterCount ~= nil then
        shutterCount:stop()
        shutterCount = nil
      end
      shutterCount = (SimpleTimer.setTimeout)(0.001, function(...)
    -- function num : 0_18_0 , upvalues : uis, FxManager, obj
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

    (uis.CardShowLoader).alpha = 1
    FxManager:SetShutterEffect(obj, (uis.CardShowLoader).image)
  end
)
    end
  end
end

EquipmentWindow.ChangeStatus = function(status, ...)
  -- function num : 0_19 , upvalues : uis, _bgEffect, _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (uis.c1Ctr).selectedIndex = status
  if status ~= EquipmentWindowType.Main then
    _bgEffect.visible = _bgEffect == nil
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

EquipmentWindow.GetDefaultPanelGrp = function(panelGrp, destroy, ...)
  -- function num : 0_20 , upvalues : uis, _ENV
  if panelGrp ~= nil and panelGrp.Initiated then
    (uis.root):RemoveChild(panelGrp.root)
    if destroy then
      (panelGrp.root):Dispose()
    else
      ;
      (EquiptMgr.RecyclePanel)(panelGrp)
    end
  end
  return {Initiated = false, 
root = {visible = false}
}
end

EquipmentWindow.RefreshEquipmentInfoMain = function(...)
  -- function num : 0_21 , upvalues : _ENV, _equipmentSlotsMain, EquipmentWindow
  local equiped = {}
  local count = #(EquiptData.CurrentRoleData).equipInfo
  local redDot = {}
  for i = 1, count do
    local eachData = ((EquiptData.CurrentRoleData).equipInfo)[i]
    do
      local configData = ((TableData.gTable).BaseEquipData)[eachData.id]
      local slot = _equipmentSlotsMain[configData.type]
      do
        do
          if slot.Effect == nil then
            slot.Effect = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_EQUIPMENT_ICON)
            ;
            (slot.root):AddChild(slot.Effect)
            ;
            (slot.root):SetChildIndex(slot.Effect, (slot.root):GetChildIndex(slot.IconLoader))
            ;
            (slot.Effect):SetXY((slot.root).width / 2, (slot.root).height / 2)
          end
          -- DECOMPILER ERROR at PC52: Confused about usage of register: R10 in 'UnsetPending'

          ;
          (slot.Effect).visible = true
          -- DECOMPILER ERROR at PC54: Confused about usage of register: R10 in 'UnsetPending'

          ;
          (slot.c1Ctr).selectedIndex = 1
          ;
          (slot.StarList):RemoveChildrenToPool()
          for i = 1, configData.star do
            (slot.StarList):AddItemFromPool()
          end
          do
            -- DECOMPILER ERROR at PC81: Confused about usage of register: R10 in 'UnsetPending'

            if configData.type == EquiptPartsType.Weapon or configData.type == EquiptPartsType.Chest then
              (slot.IconLoader).url = (Util.GetItemUrl)(configData.big_icon)
            else
              -- DECOMPILER ERROR at PC88: Confused about usage of register: R10 in 'UnsetPending'

              ;
              (slot.IconLoader).url = (Util.GetItemUrl)(configData.icon)
            end
            -- DECOMPILER ERROR at PC90: Confused about usage of register: R10 in 'UnsetPending'

            ;
            (slot.c4Ctr).selectedIndex = 4
            ;
            ((slot.root).onClick):Set(function(...)
    -- function num : 0_21_0 , upvalues : EquipmentWindow, eachData, configData, slot
    (EquipmentWindow.ClickEquipmentMain)(eachData, configData)
    ;
    (EquipmentWindow.SetCurrentSlotStaute)(slot)
  end
)
            equiped[configData.type] = true
            redDot[configData.type] = false
          end
          -- DECOMPILER ERROR at PC101: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC101: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
  end
  local needShow = false
  local unlockSlots = (CardMgr.GetUnlockEquipmentNum)((EquiptData.CurrentRoleData).id, (EquiptData.CurrentRoleData).star)
  for i = 1, EquiptData.EQUIPMENT_TYPE_COUNT do
    local index = i
    local slot = equiped[i]
    if not slot then
      slot = _equipmentSlotsMain[i]
      -- DECOMPILER ERROR at PC126: Confused about usage of register: R11 in 'UnsetPending'

      if slot.Effect ~= nil then
        (slot.Effect).visible = false
      end
      -- DECOMPILER ERROR at PC128: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (slot.c1Ctr).selectedIndex = 0
      -- DECOMPILER ERROR at PC130: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (slot.c2Ctr).selectedIndex = 0
      -- DECOMPILER ERROR at PC134: Confused about usage of register: R11 in 'UnsetPending'

      if i <= unlockSlots then
        (slot.c3Ctr).selectedIndex = 1
      else
        -- DECOMPILER ERROR at PC137: Confused about usage of register: R11 in 'UnsetPending'

        ;
        (slot.c3Ctr).selectedIndex = 0
      end
      -- DECOMPILER ERROR at PC140: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (slot.c4Ctr).selectedIndex = i - 1
      ;
      ((slot.root).onClick):Set(function(...)
    -- function num : 0_21_1 , upvalues : slot, EquipmentWindow, index, _ENV
    if (slot.c3Ctr).selectedIndex == 1 then
      (EquipmentWindow.ClickChangeBtn)(index)
    else
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(60000086, (CardMgr.GetEquipmentUnlockStar)((EquiptData.CurrentRoleData).id, index)))
    end
  end
)
      redDot[index] = (EquiptData.CheckAvailableParts)(i, (EquiptData.CurrentRoleData).id)
      if redDot[index] then
        needShow = true
      end
    end
  end
  ;
  (RedDotMgr.ProcessRedDot)(RedDotComID.Equipt_Equipment_List, redDot, needShow)
  ;
  (RedDotMgr.RefreshTreeUI)((WinResConfig.EquipmentWindow).name)
end

EquipmentWindow.SetCurrentSlotStaute = function(slot, ...)
  -- function num : 0_22 , upvalues : _currentChosedSlot
  if _currentChosedSlot ~= nil then
    _currentChosedSlot = slot
    if _currentChosedSlot then
    end
  end
end

EquipmentWindow.ClickEquipmentMain = function(equipInfo, configData, ...)
  -- function num : 0_23 , upvalues : _detailMainPanelGrp, _ENV, EquipmentWindow, uis, _middleDetailPos
  if _detailMainPanelGrp.Initiated == false then
    _detailMainPanelGrp = (EquiptMgr.GetDetailPanel)()
    _detailMainPanelGrp.Initiated = true
    ;
    (EquipmentWindow.InitPanelPostition)((_detailMainPanelGrp.root).width)
  end
  ;
  (GRoot.inst):AddCustomPopups(_detailMainPanelGrp.root, function(...)
    -- function num : 0_23_0 , upvalues : _detailMainPanelGrp
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

    (_detailMainPanelGrp.root).visible = false
  end
)
  ;
  (uis.root):AddChild(_detailMainPanelGrp.root)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (_detailMainPanelGrp.ReplaceBtn).text = (PUtil.get)(60000055)
  ;
  ((_detailMainPanelGrp.ReplaceBtn).onClick):Set(function(...)
    -- function num : 0_23_1 , upvalues : EquipmentWindow, configData
    (EquipmentWindow.ClickChangeBtn)(configData.type)
  end
)
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (_detailMainPanelGrp.CarryImage).visible = false
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (_detailMainPanelGrp.root).visible = true
  ;
  (EquiptMgr.SetEquipDetailPanel)(_detailMainPanelGrp, equipInfo, configData, EquiptDetailPanelType.Change, (EquiptData.CurrentRoleData).id)
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (_detailMainPanelGrp.root).x = _middleDetailPos
  -- DECOMPILER ERROR at PC62: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (_detailMainPanelGrp.root).y = (DesignScreen.height - (_detailMainPanelGrp.PopImage).height) * 0.5 + (ResolutionHandler.AdaptOffset).Y
end

EquipmentWindow.ClickBlankBtn = function(...)
  -- function num : 0_24 , upvalues : uis, _ENV, EquipmentWindow, DEFAULT_CHOOSE_TYPE
  if (uis.c1Ctr).selectedIndex == EquipmentWindowType.Main then
    (EquipmentWindow.ClickChangeBtn)(DEFAULT_CHOOSE_TYPE)
  end
  ;
  (EquipmentWindow.SetCurrentSlotStaute)(nil)
end

EquipmentWindow.ClickChangeBtn = function(equipType, ...)
  -- function num : 0_25 , upvalues : uis, _ENV, EquipmentWindow
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ((uis.EquiptPanelGrp).c1Ctr).selectedIndex = EquipmentSecondaryPageType.Change
  ;
  (EquipmentWindow.CloseAllDetail)()
  ;
  (EquipmentWindow.RefreshEquipmentInfoSecondary)()
  ;
  (LuaSound.PlaySound)(LuaSound.COMMON_PANEL_IN, SoundBank.OTHER)
  ;
  (EquipmentWindow.ChangeStatus)(EquipmentWindowType.Secondary)
  ;
  (EquipmentWindow.ChoseEquipByType)(equipType)
end

EquipmentWindow.RefreshEquipmentInfoSecondary = function(equipmentType, ...)
  -- function num : 0_26 , upvalues : _secondEquipInit, _ENV, _slotsEquipInfo, _equipmentSlotsSecondary, EquipmentWindow
  _secondEquipInit = true
  local equiped = {}
  local count = #(EquiptData.CurrentRoleData).equipInfo
  _slotsEquipInfo = {}
  for i = 1, count do
    local eachData = ((EquiptData.CurrentRoleData).equipInfo)[i]
    do
      local configData = ((TableData.gTable).BaseEquipData)[eachData.id]
      do
        local slot = _equipmentSlotsSecondary[configData.type]
        _slotsEquipInfo[configData.type] = eachData
        -- DECOMPILER ERROR at PC27: Confused about usage of register: R10 in 'UnsetPending'

        ;
        (slot.c1Ctr).selectedIndex = 1
        -- DECOMPILER ERROR at PC30: Confused about usage of register: R10 in 'UnsetPending'

        ;
        (slot.c2Ctr).selectedIndex = configData.intelligence
        ;
        (slot.StarList):RemoveChildrenToPool()
        for i = 1, configData.star do
          (slot.StarList):AddItemFromPool()
        end
        do
          -- DECOMPILER ERROR at PC57: Confused about usage of register: R10 in 'UnsetPending'

          if configData.type == EquiptPartsType.Weapon or configData.type == EquiptPartsType.Chest then
            (slot.IconLoader).url = (Util.GetItemUrl)(configData.big_icon)
          else
            -- DECOMPILER ERROR at PC64: Confused about usage of register: R10 in 'UnsetPending'

            ;
            (slot.IconLoader).url = (Util.GetItemUrl)(configData.icon)
          end
          -- DECOMPILER ERROR at PC66: Confused about usage of register: R10 in 'UnsetPending'

          ;
          (slot.IconLoader).alpha = 1
          -- DECOMPILER ERROR at PC68: Confused about usage of register: R10 in 'UnsetPending'

          ;
          (slot.c4Ctr).selectedIndex = 2
          ;
          ((slot.root).onClick):Set(function(...)
    -- function num : 0_26_0 , upvalues : EquipmentWindow, configData, eachData
    (EquipmentWindow.ChoseEquipByType)(configData.type)
    ;
    (EquipmentWindow.HandleEquipDetail)(eachData, configData.type, true)
  end
)
          -- DECOMPILER ERROR at PC78: Confused about usage of register: R10 in 'UnsetPending'

          if eachData.lock then
            (slot.c3Ctr).selectedIndex = 0
          else
            -- DECOMPILER ERROR at PC81: Confused about usage of register: R10 in 'UnsetPending'

            ;
            (slot.c3Ctr).selectedIndex = 1
          end
          equiped[configData.type] = true
          ;
          (RedDotMgr.ProcessRedDot)(RedDotComID.Equipt_Equipment + configData.type, nil, false)
          if configData.type == equipmentType or equipmentType == 0 then
            local holder = nil
            if configData.type == EquiptPartsType.Weapon or configData.type == EquiptPartsType.Chest then
              holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_EQUIPMENT_REFRESH_BIG, true, true)
            else
              holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_EQUIPMENT_REFRESH, true, true)
            end
            ;
            (slot.root):AddChild(holder)
            holder:SetXY((slot.root).width * 0.5, (slot.root).height * 0.5)
          end
        end
        do
          -- DECOMPILER ERROR at PC139: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC139: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
  end
  local unlockSlots = (CardMgr.GetUnlockEquipmentNum)((EquiptData.CurrentRoleData).id, (EquiptData.CurrentRoleData).star)
  for i = 1, EquiptData.EQUIPMENT_TYPE_COUNT do
    local index = i
    local slot = equiped[i]
    if not slot then
      slot = _equipmentSlotsSecondary[i]
      -- DECOMPILER ERROR at PC160: Confused about usage of register: R10 in 'UnsetPending'

      ;
      (slot.c1Ctr).selectedIndex = 0
      -- DECOMPILER ERROR at PC162: Confused about usage of register: R10 in 'UnsetPending'

      ;
      (slot.c2Ctr).selectedIndex = 0
      -- DECOMPILER ERROR at PC167: Confused about usage of register: R10 in 'UnsetPending'

      if i <= 2 then
        (slot.c4Ctr).selectedIndex = i - 1
      else
        -- DECOMPILER ERROR at PC172: Confused about usage of register: R10 in 'UnsetPending'

        if i == 3 then
          (slot.c4Ctr).selectedIndex = 1
        else
          -- DECOMPILER ERROR at PC175: Confused about usage of register: R10 in 'UnsetPending'

          ;
          (slot.c4Ctr).selectedIndex = 0
        end
      end
      ;
      ((slot.root).onClick):Set(function(...)
    -- function num : 0_26_1 , upvalues : EquipmentWindow, index
    (EquipmentWindow.CloseAllDetail)()
    ;
    (EquipmentWindow.ChoseEquipByType)(index)
  end
)
      ;
      (RedDotMgr.ProcessRedDot)(RedDotComID.Equipt_Equipment + index, nil, (EquiptData.CheckAvailableParts)(i, (EquiptData.CurrentRoleData).id))
    end
  end
  ;
  (RedDotMgr.RefreshTreeUI)((WinResConfig.EquipmentWindow).name)
end

EquipmentWindow.RefreshEquipmentLockInfoSecondary = function(...)
  -- function num : 0_27 , upvalues : _ENV, _equipmentSlotsSecondary
  local equiped = {}
  local count = #(EquiptData.CurrentRoleData).equipInfo
  for i = 1, count do
    local eachData = ((EquiptData.CurrentRoleData).equipInfo)[i]
    local configData = ((TableData.gTable).BaseEquipData)[eachData.id]
    local slot = _equipmentSlotsSecondary[configData.type]
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R9 in 'UnsetPending'

    if eachData.lock then
      (slot.c3Ctr).selectedIndex = 0
    else
      -- DECOMPILER ERROR at PC27: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (slot.c3Ctr).selectedIndex = 1
    end
  end
end

EquipmentWindow.RefreshEquipmentInfoRedDot = function(...)
  -- function num : 0_28 , upvalues : _ENV, _equipmentSlotsSecondary
  local equiped = {}
  local count = #(EquiptData.CurrentRoleData).equipInfo
  local redDot = {}
  for i = 1, count do
    local eachData = ((EquiptData.CurrentRoleData).equipInfo)[i]
    local configData = ((TableData.gTable).BaseEquipData)[eachData.id]
    local slot = _equipmentSlotsSecondary[configData.type]
    equiped[configData.type] = true
    redDot[configData.type] = false
    ;
    (RedDotMgr.ProcessRedDot)(RedDotComID.Equipt_Equipment + configData.type, nil, false)
  end
  local unlockSlots = (CardMgr.GetUnlockEquipmentNum)((EquiptData.CurrentRoleData).id, (EquiptData.CurrentRoleData).star)
  local needShow = false
  for i = 1, EquiptData.EQUIPMENT_TYPE_COUNT do
    local index = i
    local slot = equiped[i]
    if not slot then
      redDot[index] = (EquiptData.CheckAvailableParts)(i, (EquiptData.CurrentRoleData).id)
      ;
      (RedDotMgr.ProcessRedDot)(RedDotComID.Equipt_Equipment + index, nil, redDot[index])
      if not needShow then
        needShow = redDot[index]
      end
    end
  end
  ;
  (RedDotMgr.ProcessRedDot)(RedDotComID.Equipt_Equipment_List, redDot, needShow)
  ;
  (EquiptMgr.InitEquiptMainRedDot)()
  ;
  (RedDotMgr.RefreshTreeUI)((WinResConfig.EquipmentWindow).name)
end

EquipmentWindow.ChoseEquipByType = function(type, ...)
  -- function num : 0_29 , upvalues : _currentEquipmentType, _equipmentSlotsSecondary, _equipmentTypeFilterBtn, _ENV
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  if _currentEquipmentType ~= 0 then
    if _equipmentSlotsSecondary[_currentEquipmentType] ~= nil then
      (((_equipmentSlotsSecondary[_currentEquipmentType]).FrameEffGrp).root).visible = false
    end
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

    if (_equipmentTypeFilterBtn[_currentEquipmentType]).selected then
      (_equipmentTypeFilterBtn[_currentEquipmentType]).selected = false
      ;
      ((_equipmentTypeFilterBtn[_currentEquipmentType]):GetTransition("ChangeBtnOut")):Play()
    end
  end
  _currentEquipmentType = type
  ;
  ((_equipmentTypeFilterBtn[_currentEquipmentType]):GetTransition("ChangeBtnIn")):Play()
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (_equipmentTypeFilterBtn[_currentEquipmentType]).selected = true
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R1 in 'UnsetPending'

  if _equipmentSlotsSecondary[_currentEquipmentType] ~= nil then
    (((_equipmentSlotsSecondary[_currentEquipmentType]).FrameEffGrp).root).visible = true
  end
  ;
  (EquiptMgr.ChangeFilter)(EquiptSetType.Change, EquiptFilterType.SinglePart, _currentEquipmentType)
end

EquipmentWindow.RefreshChangePage = function(scrollToTop, notReset, ...)
  -- function num : 0_30 , upvalues : EquipmentWindow, _currentIdentifyEquipmentType, _equipmentTypeFilterBtn, _currentEquipmentType, uis, _ENV
  (EquipmentWindow.CloseAllDetail)(notReset)
  ;
  (EquipmentWindow.RefreshEquipmentAmountInfo)()
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  if _currentIdentifyEquipmentType ~= 0 and (_equipmentTypeFilterBtn[_currentIdentifyEquipmentType]).selected then
    (_equipmentTypeFilterBtn[_currentIdentifyEquipmentType]).selected = false
    ;
    ((_equipmentTypeFilterBtn[_currentIdentifyEquipmentType]):GetTransition("ChangeBtnOut")):Play()
  end
  if not (_equipmentTypeFilterBtn[_currentEquipmentType]).selected then
    ((_equipmentTypeFilterBtn[_currentEquipmentType]):GetTransition("ChangeBtnIn")):Play()
  end
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (_equipmentTypeFilterBtn[_currentEquipmentType]).selected = true
  ;
  ((((uis.EquiptPanelGrp).EquiptChangeGrp).SortBtn).onClick):Set(function(...)
    -- function num : 0_30_0 , upvalues : uis, EquipmentWindow
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

    if (((uis.EquiptPanelGrp).EquiptChangeGrp).c1Ctr).selectedIndex == 0 then
      (((uis.EquiptPanelGrp).EquiptChangeGrp).c1Ctr).selectedIndex = 2
      ;
      ((((uis.EquiptPanelGrp).EquiptChangeGrp).SortBtn):GetController("button")).selectedIndex = 1
      ;
      (EquipmentWindow.InitChangeFilterPanel)()
    else
      ;
      (EquipmentWindow.ClickCloseChangeFilterBtn)()
    end
  end
)
  for i = 1, EquiptData.EQUIPMENT_TYPE_COUNT + 1 do
    local index = i
    do
      ((_equipmentTypeFilterBtn[index]).onClick):Set(function(...)
    -- function num : 0_30_1 , upvalues : _currentEquipmentType, index, EquipmentWindow, _ENV
    if _currentEquipmentType ~= index then
      (EquipmentWindow.CloseAllDetail)()
    end
    ;
    (EquipmentWindow.ChoseEquipByType)(index)
    ;
    (EquipmentWindow.SetAllEquipmentType)(EquiptPartsType.All)
  end
)
    end
  end
  if not scrollToTop then
    (EquipmentWindow.ClickCloseChangeFilterBtn)()
  end
  ;
  (EquiptData.FilteringEquiptSet)(EquiptSetType.Change)
  -- DECOMPILER ERROR at PC72: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((uis.EquiptPanelGrp).EquiptChangeGrp).EquiptList).itemRenderer = EquipmentWindow.RefreshEquipmentItem
  -- DECOMPILER ERROR at PC83: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((uis.EquiptPanelGrp).EquiptChangeGrp).EquiptList).numItems = #((EquiptData.Filters)[EquiptSetType.Change]).Result
  if scrollToTop then
    (((uis.EquiptPanelGrp).EquiptChangeGrp).EquiptList):ScrollToView(0)
  end
end

EquipmentWindow.RefreshEquipmentItem = function(index, item, ...)
  -- function num : 0_31 , upvalues : _ENV, _selectedInBag, _selectedInBagItem, EquipmentWindow
  index = index + 1
  local data = (EquiptData.Equipments)[(EquiptData.Equipments)[(((EquiptData.Filters)[EquiptSetType.Change]).Result)[index]]]
  local config = ((TableData.gTable).BaseEquipData)[data.id]
  ;
  (Util.SetEquipFrame)(item, data)
  ;
  (item:GetChild("FrameEffGrp")).visible = data.objectIndex == _selectedInBag
  if data.objectIndex == _selectedInBag then
    _selectedInBagItem = item
  end
  ;
  (item.onClick):SetFunc(function(...)
    -- function num : 0_31_0 , upvalues : item, _ENV, data, EquipmentWindow, config
    local newCompGrp = item:GetChild("NewCompGrp")
    if newCompGrp.visible then
      newCompGrp.visible = false
      -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (EquiptData.NewEquipments)[data.objectIndex] = nil
    end
    ;
    (EquipmentWindow.SetAllEquipmentType)(config.type)
    ;
    (EquipmentWindow.SetEquipInBagSelected)(data.objectIndex, item)
    ;
    (EquipmentWindow.HandleEquipDetail)(data, config.type, false)
  end
)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

EquipmentWindow.SetAllEquipmentType = function(type, ...)
  -- function num : 0_32 , upvalues : _equipmentSlotsSecondary, _allEquipmentType
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  if _equipmentSlotsSecondary[_allEquipmentType] ~= nil then
    (((_equipmentSlotsSecondary[_allEquipmentType]).FrameEffGrp).root).visible = false
  end
  _allEquipmentType = type
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  if _equipmentSlotsSecondary[_allEquipmentType] ~= nil then
    (((_equipmentSlotsSecondary[_allEquipmentType]).FrameEffGrp).root).visible = true
  end
end

EquipmentWindow.SetEquipInBagSelected = function(id, item, ...)
  -- function num : 0_33 , upvalues : _selectedInBag, _ENV, _selectedInBagItem
  if _selectedInBag == id then
    loge("same:" .. id)
    return 
  end
  if _selectedInBagItem ~= nil then
    (_selectedInBagItem:GetChild("FrameEffGrp")).visible = false
  end
  _selectedInBagItem = item
  if _selectedInBagItem ~= nil then
    (_selectedInBagItem:GetChild("FrameEffGrp")).visible = true
  end
  _selectedInBag = id
end

EquipmentWindow.HandleEquipDetail = function(equipInfo, equipType, isWearing, isDecompose, ...)
  -- function num : 0_34 , upvalues : EquipmentWindow, _ENV, _detailMainPanelGrp, _detailReplacePanelGrp, _equipmentPartPos, _slotsEquipInfo
  if isDecompose then
    (EquipmentWindow.showBagDetail)(equipInfo, EquipmentPanelPosType.Right, EquiptDetailPanelType.NoButton)
  else
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R4 in 'UnsetPending'

    if (_detailMainPanelGrp.root).visible and (_detailReplacePanelGrp.root).visible then
      if isWearing then
        (_detailReplacePanelGrp.root).visible = false
        ;
        (EquipmentWindow.showWearingDetail)(equipInfo, _equipmentPartPos[equipType], EquiptDetailPanelType.Disarm, equipType)
      else
        if _detailMainPanelGrp.EquipType ~= equipType then
          (EquipmentWindow.showWearingDetail)(_slotsEquipInfo[equipType], EquipmentPanelPosType.Left, EquiptDetailPanelType.NoButton, equipType)
        end
        ;
        (EquipmentWindow.showBagDetail)(equipInfo, EquipmentPanelPosType.Right, EquiptDetailPanelType.Change)
      end
    else
      -- DECOMPILER ERROR at PC62: Confused about usage of register: R4 in 'UnsetPending'

      if not (_detailMainPanelGrp.root).visible and (_detailReplacePanelGrp.root).visible then
        if isWearing then
          if equipInfo then
            (_detailReplacePanelGrp.root).visible = false
            ;
            (EquipmentWindow.showWearingDetail)(equipInfo, _equipmentPartPos[equipType], EquiptDetailPanelType.Disarm, equipType)
          else
            ;
            (EquipmentWindow.CloseAllDetail)()
          end
        else
          if _slotsEquipInfo[equipType] ~= nil and _detailReplacePanelGrp.EquipType ~= equipType then
            (EquipmentWindow.showWearingDetail)(_slotsEquipInfo[equipType], EquipmentPanelPosType.Left, EquiptDetailPanelType.NoButton, equipType)
          end
          ;
          (EquipmentWindow.showBagDetail)(equipInfo, EquipmentPanelPosType.Right, EquiptDetailPanelType.Equip)
        end
      else
        if (_detailMainPanelGrp.root).visible and not (_detailReplacePanelGrp.root).visible then
          if isWearing then
            if equipInfo then
              (EquipmentWindow.showWearingDetail)(equipInfo, _equipmentPartPos[equipType], EquiptDetailPanelType.Disarm, equipType)
            else
              ;
              (EquipmentWindow.CloseAllDetail)()
            end
          else
            ;
            (EquipmentWindow.showWearingDetail)(_slotsEquipInfo[equipType], EquipmentPanelPosType.Left, EquiptDetailPanelType.NoButton, equipType)
            ;
            (EquipmentWindow.showBagDetail)(equipInfo, EquipmentPanelPosType.Right, EquiptDetailPanelType.Change)
          end
        else
          if isWearing then
            if equipInfo then
              (EquipmentWindow.showWearingDetail)(equipInfo, _equipmentPartPos[equipType], EquiptDetailPanelType.Disarm, equipType)
            else
              ;
              (EquipmentWindow.CloseAllDetail)()
            end
          else
            if _slotsEquipInfo[equipType] ~= nil then
              (EquipmentWindow.showWearingDetail)(_slotsEquipInfo[equipType], EquipmentPanelPosType.Left, EquiptDetailPanelType.NoButton, equipType)
              ;
              (EquipmentWindow.showBagDetail)(equipInfo, EquipmentPanelPosType.Right, EquiptDetailPanelType.Change)
            else
              ;
              (EquipmentWindow.showBagDetail)(equipInfo, EquipmentPanelPosType.Right, EquiptDetailPanelType.Equip)
            end
          end
        end
      end
    end
  end
  local sID = (GuideMgr.GuideStepId)()
  local GuideStep = ((TableData.gTable).BaseGuideStepData)[tonumber(sID)]
  if GuideStep ~= nil and GuideStep.ctrl_id == ControlID.Equipment_TipsWear then
    UIMgr:SendWindowMessage((WinResConfig.GuideWindow).name, (WindowMsgEnum.GuideWindow).GUIDE_INFER, _detailReplacePanelGrp.ReplaceBtn)
  end
end

EquipmentWindow.showWearingDetail = function(equipInfo, posType, type, equipType, ...)
  -- function num : 0_35 , upvalues : _detailMainPanelGrp, _ENV, uis, EquipmentWindow, _leftDetailPos, _rightDetailPos
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R4 in 'UnsetPending'

  if equipInfo == nil and (_detailMainPanelGrp.root).visible then
    (_detailMainPanelGrp.root).visible = false
    return 
  end
  if _detailMainPanelGrp.Initiated == false then
    _detailMainPanelGrp = (EquiptMgr.GetDetailPanel)()
    _detailMainPanelGrp.Initiated = true
    ;
    (uis.root):AddChild(_detailMainPanelGrp.root)
    ;
    (EquipmentWindow.InitPanelPostition)((_detailMainPanelGrp.root).width)
  end
  ;
  (GRoot.inst):AddCustomPopups(_detailMainPanelGrp.root, function(...)
    -- function num : 0_35_0 , upvalues : EquipmentWindow
    (EquipmentWindow.CloseAllDetail)()
  end
)
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R4 in 'UnsetPending'

  if posType == EquipmentPanelPosType.Left then
    (_detailMainPanelGrp.root).x = _leftDetailPos
  else
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (_detailMainPanelGrp.root).x = _rightDetailPos
  end
  -- DECOMPILER ERROR at PC51: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (_detailMainPanelGrp.root).y = ((uis.EquiptPanelGrp).root).y + (((uis.EquiptPanelGrp).EquiptChangeGrp).root).y
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (_detailMainPanelGrp.CarryImage).visible = true
  _detailMainPanelGrp.EquipType = equipType
  -- DECOMPILER ERROR at PC56: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (_detailMainPanelGrp.root).visible = true
  -- DECOMPILER ERROR at PC66: Confused about usage of register: R4 in 'UnsetPending'

  if type == EquiptDetailPanelType.Disarm then
    (_detailMainPanelGrp.ReplaceBtn).text = (PUtil.get)(60000068)
    ;
    ((_detailMainPanelGrp.ReplaceBtn).onClick):Set(function(...)
    -- function num : 0_35_1 , upvalues : _ENV, equipInfo, EquipmentWindow
    (EquiptService.ReqPutOnEquip)(equipInfo.objectIndex, (EquiptData.CurrentRoleData).id, 0)
    ;
    (EquipmentWindow.CloseAllDetail)()
  end
)
  end
  ;
  (EquiptMgr.SetEquipDetailPanel)(_detailMainPanelGrp, equipInfo, nil, type, (EquiptData.CurrentRoleData).id)
end

EquipmentWindow.showBagDetail = function(equipInfo, posType, type, ...)
  -- function num : 0_36 , upvalues : _detailReplacePanelGrp, _ENV, uis, EquipmentWindow, _leftDetailPos, _rightDetailPos, _slotsEquipInfo, _currentEquipmentType, _detailMainPanelGrp
  if _detailReplacePanelGrp.Initiated == false then
    _detailReplacePanelGrp = (EquiptMgr.GetDetailPanel)()
    _detailReplacePanelGrp.Initiated = true
    ;
    (uis.root):AddChild(_detailReplacePanelGrp.root)
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (_detailReplacePanelGrp.root).y = ((uis.EquiptPanelGrp).root).y + (((uis.EquiptPanelGrp).EquiptChangeGrp).root).y
    ;
    (EquipmentWindow.InitPanelPostition)((_detailReplacePanelGrp.root).width)
  end
  ;
  (GRoot.inst):AddCustomPopups(_detailReplacePanelGrp.root, function(...)
    -- function num : 0_36_0 , upvalues : _ENV, EquipmentWindow
    if not (GuideMgr.IsInMainGuide)() then
      (EquipmentWindow.CloseAllDetail)()
    end
  end
)
  local srcEquiptInfo, equipConfig = nil, nil
  equipConfig = ((TableData.gTable).BaseEquipData)[equipInfo.id]
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R5 in 'UnsetPending'

  if posType == EquipmentPanelPosType.Left then
    (_detailReplacePanelGrp.root).x = _leftDetailPos
  else
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (_detailReplacePanelGrp.root).x = _rightDetailPos
    srcEquiptInfo = _slotsEquipInfo[equipConfig.type]
  end
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (_detailReplacePanelGrp.CarryImage).visible = false
  _detailReplacePanelGrp.EquipType = equipConfig.type
  -- DECOMPILER ERROR at PC56: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (_detailReplacePanelGrp.root).visible = true
  -- DECOMPILER ERROR at PC66: Confused about usage of register: R5 in 'UnsetPending'

  if type == EquiptDetailPanelType.Change then
    (_detailReplacePanelGrp.ReplaceBtn).text = (PUtil.get)(60000055)
  else
    -- DECOMPILER ERROR at PC77: Confused about usage of register: R5 in 'UnsetPending'

    if type == EquiptDetailPanelType.Equip then
      (_detailReplacePanelGrp.ReplaceBtn).text = (PUtil.get)(60000112)
    end
  end
  ;
  ((_detailReplacePanelGrp.ReplaceBtn).onClick):Set(function(...)
    -- function num : 0_36_1 , upvalues : _ENV, equipInfo, _currentEquipmentType, EquipmentWindow
    (EquiptMgr.TryChangeEquipment)(equipInfo.objectIndex, (EquiptData.CurrentRoleData).id, _currentEquipmentType)
    ;
    (EquipmentWindow.CloseAllDetail)(true)
  end
)
  if (_detailMainPanelGrp.root).visible then
    (EquiptMgr.SetEquipDetailPanel)(_detailReplacePanelGrp, equipInfo, equipConfig, type, 0, srcEquiptInfo)
  else
    ;
    (EquiptMgr.SetEquipDetailPanel)(_detailReplacePanelGrp, equipInfo, equipConfig, type, 0)
  end
end

EquipmentWindow.InitChangeFilterPanel = function(...)
  -- function num : 0_37 , upvalues : EquipmentWindow
  (EquipmentWindow.ShowSecondarySlots)(false)
  ;
  (EquipmentWindow.RefreshChangeFilterPanel)()
end

EquipmentWindow.RefreshChangeFilterPanel = function(...)
  -- function num : 0_38 , upvalues : uis, EquipmentWindow, _ENV
  ((((uis.EquiptPanelGrp).EquiptChangeGrp).EquiptScreenGrp).ScreenList):RemoveChildrenToPool()
  ;
  (EquipmentWindow.InitEquipmentTypeFilter)((((uis.EquiptPanelGrp).EquiptChangeGrp).EquiptScreenGrp).ScreenList, EquiptSetType.Change)
  ;
  (EquipmentWindow.InitEquipmentIntelligenceFilter)((((uis.EquiptPanelGrp).EquiptChangeGrp).EquiptScreenGrp).ScreenList, EquiptSetType.Change)
  ;
  (EquipmentWindow.InitEquipmentAttributeFilter)((((uis.EquiptPanelGrp).EquiptChangeGrp).EquiptScreenGrp).ScreenList, EquiptSetType.Change)
  ;
  (EquipmentWindow.InitEquipmentBuffFilter)((((uis.EquiptPanelGrp).EquiptChangeGrp).EquiptScreenGrp).ScreenList, EquiptSetType.Change)
  ;
  (EquipmentWindow.InitEquipmentAttributeAmountFilter)((((uis.EquiptPanelGrp).EquiptChangeGrp).EquiptScreenGrp).ScreenList, EquiptSetType.Change)
end

EquipmentWindow.ClickChangeFilterResetBtn = function(...)
  -- function num : 0_39 , upvalues : _ENV, EquipmentWindow
  (EquiptMgr.ResetFilter)(EquiptSetType.Change)
  ;
  (EquipmentWindow.RefreshChangeFilterPanel)()
end

EquipmentWindow.ClickCloseChangeFilterBtn = function(...)
  -- function num : 0_40 , upvalues : uis, EquipmentWindow
  if (((uis.EquiptPanelGrp).EquiptChangeGrp).c1Ctr).selectedIndex ~= 0 then
    (((uis.EquiptPanelGrp).root):GetTransition("in")):Play()
  end
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.EquiptPanelGrp).EquiptChangeGrp).c1Ctr).selectedIndex = 0
  ;
  ((((uis.EquiptPanelGrp).EquiptChangeGrp).SortBtn):GetController("button")).selectedIndex = 0
  ;
  (EquipmentWindow.ShowSecondarySlots)(true)
end

EquipmentWindow.RefreshAttributesPanel = function(...)
  -- function num : 0_41 , upvalues : _ENV, uis, _noEquipEffect, EquipmentWindow
  local fc = (EquiptData.GetEquipmentsFC)((EquiptData.CurrentRoleData).equipInfo)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  if fc == 0 then
    (((uis.EquiptPanelGrp).EquiptDetailedGrp).c1Ctr).selectedIndex = 1
    if _noEquipEffect == nil then
      _noEquipEffect = (Util.SetNotFoundEffect)(((uis.EquiptPanelGrp).EquiptDetailedGrp).CardQLoader)
    end
  else
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (((uis.EquiptPanelGrp).EquiptDetailedGrp).c1Ctr).selectedIndex = 0
    ;
    (((uis.EquiptPanelGrp).EquiptDetailedGrp).DetailedList):RemoveChildrenToPool()
    ;
    (EquipmentWindow.ShowEquipmentAttributes)((EquiptData.CurrentRoleData).equipInfo, fc)
    ;
    (EquipmentWindow.ShowEquipmentBuffs)((EquiptData.CurrentRoleData).equipInfo)
  end
end

EquipmentWindow.ShowEquipmentAttributes = function(equipInfos, fc, ...)
  -- function num : 0_42 , upvalues : _ENV, uis
  local attrs = (CardData.GetEquipAddAttrList)(equipInfos)
  local data = {}
  for k,v in pairs(attrs) do
    (table.insert)(data, v)
  end
  ;
  (table.sort)(data, function(x, y, ...)
    -- function num : 0_42_0
    if y.value >= x.value then
      do return x.id ~= y.id end
      do return x.id < y.id end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  local panel = (((uis.EquiptPanelGrp).EquiptDetailedGrp).DetailedList):AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.EquipmentWindow).package, EquiptData.EQUIPMENT_ATTRIBUTE_RESOURCE))
  ;
  (panel:GetChild("BattleTxt")).text = (PUtil.get)(60000469)
  ;
  (panel:GetChild("BattleNameTxt")).text = fc
  local list = panel:GetChild("TipsList")
  list:RemoveChildrenToPool()
  local item = nil
  local itemSize = 0
  local count = #data
  for i = 1, count do
    item = list:AddItemFromPool()
    itemSize = item.height
    ;
    (item:GetChild("NameTxt")).text = (((TableData.gTable).BaseAttributeData)[(data[i]).id]).display_name
    ;
    (item:GetChild("NumberTxt")).text = (data[i]).value
  end
  list.height = (itemSize + list.lineGap) * (math.ceil)(count / list.columnCount) - list.lineGap + (list.margin).top
  return list.height
end

EquipmentWindow.ShowEquipmentBuffs = function(equipInfos, ...)
  -- function num : 0_43 , upvalues : uis, _ENV
  local count = #equipInfos
  local subCount, item, wordTxt = nil, nil, nil
  local buffCount = 0
  for i = 1, count do
    buffCount = buffCount + #(equipInfos[i]).randomBuff
  end
  if count > 0 and buffCount > 0 then
    item = (((uis.EquiptPanelGrp).EquiptDetailedGrp).DetailedList):AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.EquipmentWindow).package, EquiptData.EQUIPMENT_BUFF_DETAIL_RESOURCE))
    wordTxt = item:GetChild("WordTxt")
    wordTxt.text = ""
  end
  local index = 0
  for i = 1, count do
    subCount = #(equipInfos[i]).randomBuff
    for j = 1, subCount do
      if index ~= 0 then
        wordTxt.text = wordTxt.text .. "\n\n"
      end
      wordTxt.text = wordTxt.text .. (((TableData.gTable).BaseBuffPreBattleData)[((equipInfos[i]).randomBuff)[j]]).remark
      index = index + 1
    end
  end
  if item ~= nil then
    (item:GetChild("Decorate_01_Image")).height = wordTxt.y * 2 + wordTxt.textHeight
  end
end

EquipmentWindow.RefreshDecomposePanel = function(...)
  -- function num : 0_44 , upvalues : EquipmentWindow
  (EquipmentWindow.RefreshDecomposeFilterPanel)()
  ;
  (EquipmentWindow.RefreshDecomposeList)()
end

EquipmentWindow.RefreshDecomposeFilterPanel = function(...)
  -- function num : 0_45 , upvalues : uis, EquipmentWindow, _ENV
  ((((uis.EquiptPanelGrp).CleanUpGrp).CleanUpChoice).CleanUpList):RemoveChildrenToPool()
  ;
  (EquipmentWindow.InitEquipmentTypeFilter)((((uis.EquiptPanelGrp).CleanUpGrp).CleanUpChoice).CleanUpList, EquiptSetType.Decompose)
  ;
  (EquipmentWindow.InitEquipmentPartsFilter)((((uis.EquiptPanelGrp).CleanUpGrp).CleanUpChoice).CleanUpList, EquiptSetType.Decompose)
  ;
  (EquipmentWindow.InitEquipmentIntelligenceFilter)((((uis.EquiptPanelGrp).CleanUpGrp).CleanUpChoice).CleanUpList, EquiptSetType.Decompose)
  ;
  (EquipmentWindow.InitEquipmentAttributeFilter)((((uis.EquiptPanelGrp).CleanUpGrp).CleanUpChoice).CleanUpList, EquiptSetType.Decompose)
  ;
  (EquipmentWindow.InitEquipmentBuffFilter)((((uis.EquiptPanelGrp).CleanUpGrp).CleanUpChoice).CleanUpList, EquiptSetType.Decompose)
  ;
  (EquipmentWindow.InitEquipmentAttributeAmountFilter)((((uis.EquiptPanelGrp).CleanUpGrp).CleanUpChoice).CleanUpList, EquiptSetType.Decompose)
end

EquipmentWindow.RefreshDecomposeList = function(...)
  -- function num : 0_46 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  (((uis.EquiptPanelGrp).CleanUpGrp).EquiptList).numItems = #((EquiptData.Filters)[EquiptSetType.Decompose]).Result
end

EquipmentWindow.RefreshDecomposeItem = function(index, item, ...)
  -- function num : 0_47 , upvalues : _ENV, _detailUnidentifyPanelGrp, EquipmentWindow, _detailReplacePanelGrp, uis
  index = index + 1
  local data = (EquiptData.Equipments)[(EquiptData.Equipments)[(((EquiptData.Filters)[EquiptSetType.Decompose]).Result)[index]]]
  local configData = ((TableData.gTable).BaseEquipData)[data.id]
  ;
  (Util.SetEquipFrame)(item, data)
  ;
  (item:GetController("c1")).selectedIndex = 2
  local choiceBtn = item:GetChild("ChoiceBtn")
  choiceBtn.visible = not data.lock
  choiceBtn.selected = (EquiptData.ReadyToDecompose)[data.objectIndex] ~= nil
  local onclick = function(eventContext, ...)
    -- function num : 0_47_0 , upvalues : item, _ENV, data, choiceBtn, _detailUnidentifyPanelGrp, EquipmentWindow, configData, _detailReplacePanelGrp, uis
    eventContext:StopPropagation()
    local newCompGrp = item:GetChild("NewCompGrp")
    if newCompGrp.visible then
      newCompGrp.visible = false
      -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (EquiptData.NewEquipments)[data.objectIndex] = nil
    end
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

    if choiceBtn.selected then
      if data.identify then
        (_detailUnidentifyPanelGrp.root).visible = false
        ;
        (EquipmentWindow.HandleEquipDetail)(data, configData.type, false, true)
      else
        -- DECOMPILER ERROR at PC30: Confused about usage of register: R2 in 'UnsetPending'

        ;
        (_detailReplacePanelGrp.root).visible = false
        ;
        (EquipmentWindow.ShowUnidentifyDetail)(configData)
      end
    else
      -- DECOMPILER ERROR at PC40: Confused about usage of register: R2 in 'UnsetPending'

      if (_detailUnidentifyPanelGrp.root).visible then
        (_detailUnidentifyPanelGrp.root).visible = false
      else
        -- DECOMPILER ERROR at PC47: Confused about usage of register: R2 in 'UnsetPending'

        if (_detailReplacePanelGrp.root).visible then
          (_detailReplacePanelGrp.root).visible = false
        end
      end
    end
    -- DECOMPILER ERROR at PC63: Confused about usage of register: R2 in 'UnsetPending'

    if data.lock == false then
      if choiceBtn.selected == false and (((uis.EquiptPanelGrp).CleanUpGrp).AllChoiceBtn).selected then
        (((uis.EquiptPanelGrp).CleanUpGrp).AllChoiceBtn).selected = false
      end
      ;
      (EquiptMgr.ChangeEquipDecomposeStatue)(data.objectIndex, data.id, choiceBtn.selected)
    end
  end

  ;
  (item.onClick):Set(function(eventContext, ...)
    -- function num : 0_47_1 , upvalues : choiceBtn, onclick
    choiceBtn.selected = not choiceBtn.selected
    onclick(eventContext)
  end
)
  ;
  (choiceBtn.onClick):Set(onclick)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

EquipmentWindow.ClickAllChoseBtn = function(...)
  -- function num : 0_48 , upvalues : _ENV, uis
  (EquiptMgr.SetAllEquipToDecomposeOrNot)((((uis.EquiptPanelGrp).CleanUpGrp).AllChoiceBtn).selected)
  ;
  (((uis.EquiptPanelGrp).CleanUpGrp).EquiptList):RefreshVirtualList()
end

EquipmentWindow.ClickDecomposeBtn = function(...)
  -- function num : 0_49 , upvalues : EquipmentWindow, _ENV
  (EquipmentWindow.CloseAllDetail)()
  ;
  (EquiptMgr.TryDecomposeEquips)()
end

EquipmentWindow.ClickDecomposeResetBtn = function(...)
  -- function num : 0_50 , upvalues : _ENV, EquipmentWindow
  (EquiptMgr.ResetFilter)(EquiptSetType.Decompose)
  ;
  (EquipmentWindow.RefreshDecomposeFilterPanel)()
end

EquipmentWindow.ClickDecomposeSortBtn = function(...)
  -- function num : 0_51 , upvalues : _ENV
  (EquiptMgr.ChangeFilterSortType)(EquiptSetType.Decompose)
end

EquipmentWindow.RefreshIdentifyPage = function(scrollToTop, ...)
  -- function num : 0_52 , upvalues : EquipmentWindow, _equipmentTypeFilterBtn, _currentEquipmentType, _currentIdentifyEquipmentType, uis, _ENV
  (EquipmentWindow.CloseAllDetail)()
  ;
  (EquipmentWindow.RefreshEquipmentAmountInfo)()
  ;
  (EquipmentWindow.ShowReadyToIdentifyEquipments)()
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  if _equipmentTypeFilterBtn[_currentEquipmentType] ~= nil and (_equipmentTypeFilterBtn[_currentEquipmentType]).selected then
    (_equipmentTypeFilterBtn[_currentEquipmentType]).selected = false
    ;
    ((_equipmentTypeFilterBtn[_currentEquipmentType]):GetTransition("ChangeBtnOut")):Play()
  end
  if _currentIdentifyEquipmentType ~= 0 then
    if not (_equipmentTypeFilterBtn[_currentIdentifyEquipmentType]).selected then
      ((_equipmentTypeFilterBtn[_currentIdentifyEquipmentType]):GetTransition("ChangeBtnIn")):Play()
    end
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (_equipmentTypeFilterBtn[_currentIdentifyEquipmentType]).selected = true
  end
  ;
  ((((uis.EquiptPanelGrp).EquiptChangeGrp).OrderBtn).onClick):Set(function(...)
    -- function num : 0_52_0 , upvalues : _ENV
    (EquiptMgr.ChangeFilterSortType)(EquiptSetType.Identify)
  end
)
  for i = 1, EquiptData.EQUIPMENT_TYPE_COUNT + 1 do
    local index = i
    do
      ((_equipmentTypeFilterBtn[index]).onClick):Set(function(...)
    -- function num : 0_52_1 , upvalues : EquipmentWindow, index
    (EquipmentWindow.ChoseUnidentifiedEquipByType)(index)
  end
)
    end
  end
  -- DECOMPILER ERROR at PC67: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((uis.EquiptPanelGrp).EquiptChangeGrp).c1Ctr).selectedIndex = 1
  ;
  ((((uis.EquiptPanelGrp).EquiptChangeGrp).SortBtn):GetController("button")).selectedIndex = 0
  ;
  (EquiptData.FilteringEquiptSet)(EquiptSetType.Identify)
  -- DECOMPILER ERROR at PC84: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((uis.EquiptPanelGrp).EquiptChangeGrp).EquiptList).itemRenderer = EquipmentWindow.RefreshUnidentifiedEquipmentItem
  -- DECOMPILER ERROR at PC95: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((uis.EquiptPanelGrp).EquiptChangeGrp).EquiptList).numItems = #((EquiptData.Filters)[EquiptSetType.Identify]).Result
  if scrollToTop then
    (((uis.EquiptPanelGrp).EquiptChangeGrp).EquiptList):ScrollToView(0)
  end
end

EquipmentWindow.ChoseUnidentifiedEquipByType = function(type, ...)
  -- function num : 0_53 , upvalues : _ENV, EquipmentWindow
  (EquiptMgr.ChangeFilter)(EquiptSetType.Identify, EquiptFilterType.SinglePart, type)
  ;
  (EquipmentWindow.SetIdentifyEquipmentTypeFilterBtn)()
end

EquipmentWindow.RefreshIdentifyBtnRedDot = function(...)
  -- function num : 0_54 , upvalues : uis, _ENV
  (((uis.EquiptPanelGrp).AppraisalBtn):GetChild("RedDot")).visible = #EquiptData.UnidentifiedEquipments > 0
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

EquipmentWindow.SetIdentifyEquipmentTypeFilterBtn = function(...)
  -- function num : 0_55 , upvalues : _ENV, _currentIdentifyEquipmentType, _equipmentTypeFilterBtn
  local type = (((EquiptData.Filters)[EquiptSetType.Identify]).FilterType)[EquiptFilterType.SinglePart]
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  if _currentIdentifyEquipmentType ~= 0 and (_equipmentTypeFilterBtn[_currentIdentifyEquipmentType]).selected then
    (_equipmentTypeFilterBtn[_currentIdentifyEquipmentType]).selected = false
    ;
    ((_equipmentTypeFilterBtn[_currentIdentifyEquipmentType]):GetTransition("ChangeBtnOut")):Play()
  end
  _currentIdentifyEquipmentType = type
  if _currentIdentifyEquipmentType ~= 0 then
    ((_equipmentTypeFilterBtn[_currentIdentifyEquipmentType]):GetTransition("ChangeBtnIn")):Play()
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (_equipmentTypeFilterBtn[_currentIdentifyEquipmentType]).selected = true
  end
end

EquipmentWindow.ShowReadyToIdentifyEquipments = function(...)
  -- function num : 0_56 , upvalues : _ENV, uis, _noEquipmentsEffect, _identifyCostComponent, EquipmentWindow
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

  if #EquiptData.ReadyToIdentify == 0 then
    ((((uis.EquiptPanelGrp).AppraisalGrp).Appraisal).c2Ctr).selectedIndex = 1
    if _noEquipmentsEffect == nil then
      _noEquipmentsEffect = (Util.SetNotFoundEffect)((((uis.EquiptPanelGrp).AppraisalGrp).Appraisal).AnimationLoader)
    end
    for k,v in pairs(_identifyCostComponent) do
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R5 in 'UnsetPending'

      (v.Loader).url = nil
    end
  else
    do
      -- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

      ;
      ((((uis.EquiptPanelGrp).AppraisalGrp).Appraisal).c2Ctr).selectedIndex = 0
      ;
      (EquipmentWindow.RefreshReadyToIdentifyEquipments)()
    end
  end
end

EquipmentWindow.RefreshReadyToIdentifyEquipments = function(...)
  -- function num : 0_57 , upvalues : uis, _ENV, _identifyCostComponent
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  ((((uis.EquiptPanelGrp).AppraisalGrp).Appraisal).CleanUpList).numItems = #EquiptData.ReadyToIdentify
  ;
  ((((uis.EquiptPanelGrp).AppraisalGrp).Appraisal).CleanUpList):ScrollToView(#EquiptData.ReadyToIdentify - 1, true)
  local index = 1
  local assets = nil
  for k,v in pairs(EquiptData.IdentifyCost) do
    loge("url:" .. (Util.GetUrlFromItemID)(k, v.Type))
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((_identifyCostComponent[index]).Loader).url = (Util.GetUrlFromItemID)(k, v.Type)
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((_identifyCostComponent[index]).Loader).alpha = 1
    assets = (ActorData.GetGoodsCount)(k, v.Type)
    -- DECOMPILER ERROR at PC64: Confused about usage of register: R7 in 'UnsetPending'

    if assets < v.Value then
      ((_identifyCostComponent[index]).Txt).text = "[color=" .. Const.RedColor .. "]" .. v.Value .. "[/color]"
    else
      -- DECOMPILER ERROR at PC69: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((_identifyCostComponent[index]).Txt).text = v.Value
    end
    index = index + 1
  end
end

EquipmentWindow.PlayIdentifyEffect = function(callback, ...)
  -- function num : 0_58 , upvalues : uis, _ENV, EquipmentWindow
  ((((uis.EquiptPanelGrp).AppraisalGrp).Appraisal).CleanUpList):TraversalItem(function(index, item, ...)
    -- function num : 0_58_0 , upvalues : _ENV, uis
    local lod = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_EQUIPMENT_IDENTIFY, true, true)
    item:AddChild(lod)
    lod:SetXY(item.width * 0.5, item.height * 0.5)
    ;
    (Util.SetSfxClipInList)((lod.displayObject).gameObject, (((uis.EquiptPanelGrp).AppraisalGrp).Appraisal).CleanUpList)
  end
)
  ;
  (SimpleTimer.setTimeout)(1, function(...)
    -- function num : 0_58_1 , upvalues : EquipmentWindow, callback
    (EquipmentWindow.RefreshReadyToIdentifyEquipments)()
    callback()
  end
)
end

EquipmentWindow.RefreshUnidentifiedEquipmentItem = function(index, item, ...)
  -- function num : 0_59 , upvalues : _ENV, EquipmentWindow, _detailUnidentifyPanelGrp
  index = index + 1
  local data = (EquiptData.Equipments)[(EquiptData.Equipments)[(((EquiptData.Filters)[EquiptSetType.Identify]).Result)[index]]]
  local configData = ((TableData.gTable).BaseEquipData)[data.id]
  ;
  (Util.SetEquipFrame)(item, data)
  ;
  (item:GetController("c1")).selectedIndex = 2
  ;
  (item.onClick):Clear()
  local choiceBtn = item:GetChild("ChoiceBtn")
  choiceBtn.selected = (EquiptData.ReadyToIdentify)[data.objectIndex] ~= nil
  local onClick = function(eventContext, ...)
    -- function num : 0_59_0 , upvalues : _ENV, choiceBtn, data, EquipmentWindow, _detailUnidentifyPanelGrp
    eventContext:StopPropagation()
    if (EquiptMgr.CheckIdentifyEquipmentsFull)() and choiceBtn.selected then
      choiceBtn.selected = not choiceBtn.selected
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(60000374))
      return 
    end
    ;
    (EquiptMgr.HandleEquipmentToIdentify)(data, choiceBtn.selected)
    if choiceBtn.selected == false then
      (EquipmentWindow.CheckIdentifyAllChoseBtn)()
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (_detailUnidentifyPanelGrp.root).visible = false
    end
  end

  ;
  (item.onClick):Set(function(eventContext, ...)
    -- function num : 0_59_1 , upvalues : _ENV, choiceBtn, onClick
    if (EquiptMgr.CheckIdentifyEquipmentsFull)() and not choiceBtn.selected then
      (MessageMgr.SendCenterTips)((PUtil.get)(60000374))
      return 
    end
    choiceBtn.selected = not choiceBtn.selected
    onClick(eventContext)
  end
)
  ;
  (choiceBtn.onClick):Set(onClick)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

EquipmentWindow.RefreshReadyToIdentifyItem = function(index, item, ...)
  -- function num : 0_60 , upvalues : _ENV, EquipmentWindow, uis
  local data = (EquiptData.ReadyToIdentify)[index + 1]
  ;
  (Util.SetEquipFrame)(item, data)
  ;
  (item.onClick):Set(function(...)
    -- function num : 0_60_0 , upvalues : EquipmentWindow, _ENV, data, uis
    (EquipmentWindow.CheckIdentifyAllChoseBtn)()
    ;
    (EquiptMgr.HandleEquipmentToIdentify)(data, false)
    ;
    (((uis.EquiptPanelGrp).EquiptChangeGrp).EquiptList):RefreshVirtualList()
  end
)
end

EquipmentWindow.CheckIdentifyAllChoseBtn = function(...)
  -- function num : 0_61 , upvalues : uis
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

  if (((uis.EquiptPanelGrp).EquiptChangeGrp).AllChoiceBtn).selected then
    (((uis.EquiptPanelGrp).EquiptChangeGrp).AllChoiceBtn).selected = false
  end
end

EquipmentWindow.ClearIdentifyEquipments = function(...)
  -- function num : 0_62 , upvalues : _ENV, EquipmentWindow
  (EquiptMgr.ResetIdentifyData)()
  ;
  (EquipmentWindow.ShowReadyToIdentifyEquipments)()
end

EquipmentWindow.ClickIdentifyBtn = function(...)
  -- function num : 0_63 , upvalues : _ENV
  (EquiptMgr.TryIdentifyEquips)()
end

EquipmentWindow.ClickIdentifyAllChoseBtn = function(...)
  -- function num : 0_64 , upvalues : _ENV, uis, EquipmentWindow
  (EquiptMgr.SetAllEquipToIdentifyOrNot)((((uis.EquiptPanelGrp).EquiptChangeGrp).AllChoiceBtn).selected)
  ;
  (((uis.EquiptPanelGrp).EquiptChangeGrp).EquiptList):RefreshVirtualList()
  if not (((uis.EquiptPanelGrp).EquiptChangeGrp).AllChoiceBtn).selected then
    (EquipmentWindow.ClearIdentifyEquipments)()
  end
end

EquipmentWindow.ClickIdentifyCancelAllBtn = function(...)
  -- function num : 0_65 , upvalues : EquipmentWindow, uis
  (EquipmentWindow.CloseAllDetail)()
  ;
  (EquipmentWindow.ClearIdentifyEquipments)()
  ;
  (EquipmentWindow.CheckIdentifyAllChoseBtn)()
  ;
  (((uis.EquiptPanelGrp).EquiptChangeGrp).EquiptList):RefreshVirtualList()
end

EquipmentWindow.InitEquipmentTypeFilter = function(list, setType, ...)
  -- function num : 0_66 , upvalues : uis, _ENV, EquipmentWindow
  local grp = ((((uis.EquiptPanelGrp).CleanUpGrp).CleanUpChoice).CleanUpList):AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.EquipmentWindow).package, EquiptData.EQUIPMENT_TYPE_FILTER_RESOURCE))
  ;
  (grp:GetChild("NameTxt")).text = (PUtil.get)(60000326)
  local panel = grp:GetChild("EquiptPanelGrp")
  ;
  (EquipmentWindow.InitTypeBtn)(panel, "CleanUp_01_Btn", (PUtil.get)(60000327), EquiptType.Normal, setType)
  ;
  (EquipmentWindow.InitTypeBtn)(panel, "CleanUp_02_Btn", (PUtil.get)(60000328), EquiptType.Privilege, setType)
  ;
  (EquipmentWindow.InitTypeBtn)(panel, "CleanUp_03_Btn", (PUtil.get)(60000329), EquiptType.Activity, setType)
end

EquipmentWindow.InitTypeBtn = function(panel, btnName, nameTxt, equiptType, setType, ...)
  -- function num : 0_67 , upvalues : _ENV
  local btn = panel:GetChild(btnName)
  ;
  (btn:GetChild("NameTxt")).text = nameTxt
  btn.selected = ((((EquiptData.Filters)[setType]).FilterType)[EquiptFilterType.Type])[equiptType] ~= nil
  ;
  (btn.onClick):Set(function(...)
    -- function num : 0_67_0 , upvalues : _ENV, setType, equiptType, btn
    (EquiptMgr.ChangeFilter)(setType, EquiptFilterType.Type, equiptType, btn.selected)
  end
)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

EquipmentWindow.InitEquipmentPartsFilter = function(list, setType, ...)
  -- function num : 0_68 , upvalues : _ENV, EquipmentWindow
  local grp = list:AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.EquipmentWindow).package, EquiptData.EQUIPMENT_PARTS_FILTER_RESOURCE))
  ;
  (grp:GetChild("NameTxt")).text = (PUtil.get)(60000336)
  ;
  (EquipmentWindow.RefreshEquipmentPartItem)(grp, "WeaponBtn", EquiptPartsType.Weapon, setType)
  ;
  (EquipmentWindow.RefreshEquipmentPartItem)(grp, "ClothesBtn", EquiptPartsType.Chest, setType)
  ;
  (EquipmentWindow.RefreshEquipmentPartItem)(grp, "NecklaceBtn", EquiptPartsType.Necklace, setType)
  ;
  (EquipmentWindow.RefreshEquipmentPartItem)(grp, "RingBtn", EquiptPartsType.Ring, setType)
end

EquipmentWindow.RefreshEquipmentPartItem = function(panel, name, equiptPartsType, setType, ...)
  -- function num : 0_69 , upvalues : _ENV
  local item = panel:GetChild(name)
  ;
  (item:GetController("c1")).selectedIndex = equiptPartsType - 1
  item.selected = ((((EquiptData.Filters)[setType]).FilterType)[EquiptFilterType.MultiplyParts])[equiptPartsType] ~= nil
  ;
  (item.onClick):Set(function(...)
    -- function num : 0_69_0 , upvalues : _ENV, setType, equiptPartsType, item
    (EquiptMgr.ChangeFilter)(setType, EquiptFilterType.MultiplyParts, equiptPartsType, item.selected)
  end
)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

EquipmentWindow.InitEquipmentIntelligenceFilter = function(list, setType, ...)
  -- function num : 0_70 , upvalues : _ENV, EquipmentWindow
  (EquiptData.InitMaxIntelligence)()
  local grp = list:AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.EquipmentWindow).package, EquiptData.EQUIPMENT_INTELLIGENCE_FILTER_RESOURCE))
  ;
  (grp:GetChild("NameTxt")).text = (PUtil.get)(60000330)
  local list = grp:GetChild("StageList")
  list:RemoveChildrenToPool()
  local item = nil
  local itemSize = 0
  for i = 1, EquiptData.MaxIntelligence do
    item = list:AddItemFromPool()
    itemSize = item.height
    ;
    (EquipmentWindow.RefreshIntelligenceItem)(i, item, setType)
  end
  list.height = (itemSize + list.lineGap) * (math.ceil)(EquiptData.MaxIntelligence / list.columnCount) - list.lineGap + (list.margin).top
end

EquipmentWindow.RefreshIntelligenceItem = function(index, item, setType, ...)
  -- function num : 0_71 , upvalues : _ENV
  index = index - 1
  ;
  (item:GetChild("NameTxt")).text = "★" .. tostring(index)
  item.selected = ((((EquiptData.Filters)[setType]).FilterType)[EquiptFilterType.Intelligence])[index] ~= nil
  ;
  (item.onClick):Set(function(...)
    -- function num : 0_71_0 , upvalues : item, _ENV, setType, index
    item.selected = not item.selected
    ;
    (EquiptMgr.ChangeFilter)(setType, EquiptFilterType.Intelligence, index, item.selected)
  end
)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

EquipmentWindow.InitEquipmentAttributeFilter = function(list, setType, ...)
  -- function num : 0_72 , upvalues : _ENV, EquipmentWindow
  (EquiptData.InitEquiptAttributes)()
  local grp = list:AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.EquipmentWindow).package, EquiptData.EQUIPMENT_FILTER_RESOURCE))
  ;
  (grp:GetChild("NameTxt")).text = (PUtil.get)(60000331)
  local list = grp:GetChild("SecondaryList")
  list:RemoveChildrenToPool()
  local item = nil
  local itemSize = 0
  local count = #EquiptData.Attributes
  for i = 1, count do
    item = list:AddItemFromPool()
    itemSize = item.height
    ;
    (EquipmentWindow.RefreshAttributeItem)(i, item, setType)
  end
  list.height = (itemSize + list.lineGap) * (math.ceil)(count / list.columnCount) - list.lineGap + (list.margin).top
end

EquipmentWindow.RefreshAttributeItem = function(index, item, setType, ...)
  -- function num : 0_73 , upvalues : _ENV
  local data = (EquiptData.Attributes)[index]
  local config = ((TableData.gTable).BaseAttributeData)[data]
  ;
  (item:GetChild("NameTxt")).text = config.display_name
  item.selected = ((((EquiptData.Filters)[setType]).FilterType)[EquiptFilterType.Attributes])[data] ~= nil
  ;
  (item.onClick):Set(function(...)
    -- function num : 0_73_0 , upvalues : item, _ENV, setType, data
    item.selected = not item.selected
    ;
    (EquiptMgr.ChangeFilter)(setType, EquiptFilterType.Attributes, data, item.selected)
  end
)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

EquipmentWindow.InitEquipmentBuffFilter = function(list, setType, ...)
  -- function num : 0_74 , upvalues : _ENV, EquipmentWindow
  (EquiptData.InitEquiptBuff)()
  local grp = list:AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.EquipmentWindow).package, EquiptData.EQUIPMENT_FILTER_RESOURCE))
  ;
  (grp:GetChild("NameTxt")).text = (PUtil.get)(60000332)
  local list = grp:GetChild("SecondaryList")
  list:RemoveChildrenToPool()
  local item = nil
  local itemSize = 0
  local count = #EquiptData.Buffs
  for i = 1, count do
    item = list:AddItemFromPool()
    itemSize = item.height
    ;
    (EquipmentWindow.RefreshBuffItem)(i, item, setType)
  end
  list.height = (itemSize + list.lineGap) * (math.ceil)(count / list.columnCount) - list.lineGap + (list.margin).top
end

EquipmentWindow.RefreshBuffItem = function(index, item, setType, ...)
  -- function num : 0_75 , upvalues : _ENV
  local data = (EquiptData.Buffs)[index]
  ;
  (item:GetChild("NameTxt")).text = (PUtil.get)(data)
  item.selected = ((((EquiptData.Filters)[setType]).FilterType)[EquiptFilterType.Buff])[data] ~= nil
  ;
  (item.onClick):Set(function(...)
    -- function num : 0_75_0 , upvalues : item, _ENV, setType, index
    item.selected = not item.selected
    ;
    (EquiptMgr.ChangeFilter)(setType, EquiptFilterType.Buff, index, item.selected)
  end
)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

EquipmentWindow.InitEquipmentAttributeAmountFilter = function(list, setType, ...)
  -- function num : 0_76 , upvalues : _ENV, EquipmentWindow
  local grp = list:AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.EquipmentWindow).package, EquiptData.EQUIPMENT_FILTER_RESOURCE))
  ;
  (grp:GetChild("NameTxt")).text = (PUtil.get)(60000333)
  local list = grp:GetChild("SecondaryList")
  list:RemoveChildrenToPool()
  local item = nil
  local itemSize = 0
  for i = 1, EquiptData.MAX_ATTRIBUTE_AMOUNT do
    item = list:AddItemFromPool()
    itemSize = item.height
    ;
    (EquipmentWindow.RefreshAttributeAmountItem)(i, item, setType)
  end
  list.height = (itemSize + list.lineGap) * (math.ceil)(EquiptData.MAX_ATTRIBUTE_AMOUNT / list.columnCount) - list.lineGap + (list.margin).top
end

EquipmentWindow.RefreshAttributeAmountItem = function(index, item, setType, ...)
  -- function num : 0_77 , upvalues : _ENV
  (item:GetChild("NameTxt")).text = (PUtil.get)(60000334, index)
  item.selected = ((((EquiptData.Filters)[setType]).FilterType)[EquiptFilterType.AttributeAmount])[index] ~= nil
  ;
  (item.onClick):Set(function(...)
    -- function num : 0_77_0 , upvalues : item, _ENV, setType, index
    item.selected = not item.selected
    ;
    (EquiptMgr.ChangeFilter)(setType, EquiptFilterType.AttributeAmount, index, item.selected)
  end
)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

EquipmentWindow.ShowUnidentifyDetail = function(equipConfig, ...)
  -- function num : 0_78 , upvalues : _detailUnidentifyPanelGrp, _ENV, uis, _originUnidentifyPanelYSize, EquipmentWindow
  if _detailUnidentifyPanelGrp.Initiated == false then
    UIMgr:LoadPackage((WinResConfig.ItemTipsWindow).package)
    local panel = (UIPackage.CreateObject)("DescriptionTips", "ItemTips")
    _detailUnidentifyPanelGrp = GetDescriptionTips_ItemTipsUis(panel)
    _detailUnidentifyPanelGrp.Initiated = true
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (_detailUnidentifyPanelGrp.ItemWordTxt).UBBEnabled = true
    ;
    (uis.root):AddChild(_detailUnidentifyPanelGrp.root)
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (_detailUnidentifyPanelGrp.root).y = ((uis.EquiptPanelGrp).root).y + (((uis.EquiptPanelGrp).EquiptChangeGrp).root).y
    _originUnidentifyPanelYSize = (_detailUnidentifyPanelGrp.root).height
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (_detailUnidentifyPanelGrp.root).x = ((((uis.EquiptPanelGrp).EquiptChangeGrp).EquiptChangeBtnPanelGrp).root).x - (_detailUnidentifyPanelGrp.root).width
  end
  do
    ;
    (GRoot.inst):AddCustomPopups(_detailUnidentifyPanelGrp.root, function(...)
    -- function num : 0_78_0 , upvalues : EquipmentWindow
    (EquipmentWindow.CloseAllDetail)()
  end
)
    -- DECOMPILER ERROR at PC55: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (_detailUnidentifyPanelGrp.root).visible = true
    ;
    (EquipmentWindow.InitUnidentifyPanel)(equipConfig)
  end
end

EquipmentWindow.InitUnidentifyPanel = function(config, ...)
  -- function num : 0_79 , upvalues : _detailUnidentifyPanelGrp, _ENV, _originUnidentifyPanelYSize
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (_detailUnidentifyPanelGrp.c1Ctr).selectedIndex = 2
  ;
  (Util.SetEquipFrameOnlyForShow)((_detailUnidentifyPanelGrp.EquiotIcon).root, config.id)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (_detailUnidentifyPanelGrp.Equipt_01_Txt).text = (PUtil.get)(60000461)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (_detailUnidentifyPanelGrp.Equipt_03_Txt).text = (PUtil.get)(20000208)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (_detailUnidentifyPanelGrp.c2Ctr).selectedIndex = config.type - 1
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (_detailUnidentifyPanelGrp.ItemNameTxt).text = "[color=#0099FF]" .. config.name .. "[/color]"
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (_detailUnidentifyPanelGrp.ItemWordTxt).text = "[color=#617992]" .. config.des .. "[/color]"
  local ySize = (_detailUnidentifyPanelGrp.ItemWordTxt).y + (_detailUnidentifyPanelGrp.ItemWordTxt).height + 10
  if ySize < _originUnidentifyPanelYSize then
    ySize = _originUnidentifyPanelYSize
  end
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (_detailUnidentifyPanelGrp.TipsImage).height = ySize
end

EquipmentWindow.RefreshEquipmentAmountInfo = function(...)
  -- function num : 0_80 , upvalues : _ENV, uis
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R0 in 'UnsetPending'

  if EquiptData.MaxBagSlots <= #EquiptData.Equipments then
    (((uis.EquiptPanelGrp).EquiptChangeGrp).NumberTxt).text = "[color=" .. Const.RedColor .. "]" .. tostring(#EquiptData.Equipments) .. "[/color]" .. "/" .. tostring(EquiptData.MaxBagSlots)
  else
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (((uis.EquiptPanelGrp).EquiptChangeGrp).NumberTxt).text = "[color=" .. Const.GreenColor .. "]" .. tostring(#EquiptData.Equipments) .. "[/color]" .. "/" .. tostring(EquiptData.MaxBagSlots)
  end
end

EquipmentWindow.ShowSecondarySlots = function(show, ...)
  -- function num : 0_81 , upvalues : _ENV, _equipmentSlotsSecondary
  for i = 1, EquiptData.EQUIPMENT_TYPE_COUNT do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R5 in 'UnsetPending'

    ((_equipmentSlotsSecondary[i]).root).visible = show
  end
end

EquipmentWindow.CloseAllDetail = function(notReset, ...)
  -- function num : 0_82 , upvalues : EquipmentWindow, _ENV, _selectedInBag, _selectedInBagItem, _detailMainPanelGrp, _detailReplacePanelGrp, _detailUnidentifyPanelGrp
  if not notReset then
    (EquipmentWindow.SetAllEquipmentType)(EquiptPartsType.All)
  end
  _selectedInBag = nil
  if _selectedInBagItem ~= nil then
    (_selectedInBagItem:GetChild("FrameEffGrp")).visible = false
  end
  _selectedInBagItem = nil
  UIMgr:CloseWindow((WinResConfig.ItemTipsWindow).name)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (_detailMainPanelGrp.root).visible = false
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (_detailReplacePanelGrp.root).visible = false
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (_detailUnidentifyPanelGrp.root).visible = false
end

EquipmentWindow.RefreshRightPage = function(scrollToTop, notReset, ...)
  -- function num : 0_83 , upvalues : uis, _ENV, EquipmentWindow
  if ((uis.EquiptPanelGrp).c1Ctr).selectedIndex == EquipmentSecondaryPageType.Change then
    (EquipmentWindow.RefreshChangePage)(scrollToTop, notReset)
  else
    if ((uis.EquiptPanelGrp).c1Ctr).selectedIndex == EquipmentSecondaryPageType.Decompose then
      (EquipmentWindow.CloseAllDetail)()
      ;
      (EquipmentWindow.RefreshDecomposeList)()
    else
      if ((uis.EquiptPanelGrp).c1Ctr).selectedIndex == EquipmentSecondaryPageType.Identify then
        (EquipmentWindow.RefreshIdentifyPage)(scrollToTop)
      else
        ;
        (EquipmentWindow.RefreshAttributesPanel)()
      end
    end
  end
end

EquipmentWindow.RefreshRightEquipmentList = function(...)
  -- function num : 0_84 , upvalues : uis, _ENV
  if ((uis.EquiptPanelGrp).c1Ctr).selectedIndex == EquipmentSecondaryPageType.Change then
    (((uis.EquiptPanelGrp).EquiptChangeGrp).EquiptList):RefreshVirtualList()
  else
    if ((uis.EquiptPanelGrp).c1Ctr).selectedIndex == EquipmentSecondaryPageType.Decompose then
      (((uis.EquiptPanelGrp).CleanUpGrp).EquiptList):RefreshVirtualList()
    end
  end
end

EquipmentWindow.CheckNewEquipmentsStatus = function(isChangeBtn, ...)
  -- function num : 0_85 , upvalues : _newStatus, EquipmentNewStatus, _ENV
  if isChangeBtn and _newStatus == EquipmentNewStatus.NeedShow then
    _newStatus = EquipmentNewStatus.Showed
  else
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

    if _newStatus == EquipmentNewStatus.Showed then
      EquiptData.NewEquipments = {}
      _newStatus = EquipmentNewStatus.None
    end
  end
end

EquipmentWindow.ClickDetailBtn = function(...)
  -- function num : 0_86 , upvalues : EquipmentWindow
  (EquipmentWindow.CheckNewEquipmentsStatus)()
  ;
  (EquipmentWindow.CloseAllDetail)()
  ;
  (EquipmentWindow.RefreshAttributesPanel)()
end

EquipmentWindow.ClickChangePageBtn = function(...)
  -- function num : 0_87 , upvalues : _secondEquipInit, EquipmentWindow, _ENV
  if _secondEquipInit == false then
    (EquipmentWindow.RefreshEquipmentInfoSecondary)()
  end
  ;
  (EquipmentWindow.CheckNewEquipmentsStatus)(true)
  ;
  (EquipmentWindow.CloseAllDetail)()
  ;
  (EquiptData.FilteringEquiptSet)(EquiptSetType.Change)
  ;
  (EquipmentWindow.RefreshChangePage)()
end

EquipmentWindow.ClickDecomposePageBtn = function(...)
  -- function num : 0_88 , upvalues : EquipmentWindow, _ENV, uis
  (EquipmentWindow.CheckNewEquipmentsStatus)()
  ;
  (EquipmentWindow.CloseAllDetail)()
  ;
  (EquiptData.ResetDecomposeData)()
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.EquiptPanelGrp).CleanUpGrp).AllChoiceBtn).selected = false
  ;
  (EquiptData.FilteringEquiptSet)(EquiptSetType.Decompose)
  ;
  (EquipmentWindow.RefreshDecomposePanel)()
end

EquipmentWindow.ClickIdentifyPageBtn = function(...)
  -- function num : 0_89 , upvalues : EquipmentWindow, _ENV
  (EquipmentWindow.CheckNewEquipmentsStatus)()
  ;
  (EquipmentWindow.CloseAllDetail)()
  ;
  (EquiptData.FilteringEquiptSet)(EquiptSetType.Identify)
  ;
  (EquipmentWindow.RefreshIdentifyPage)()
end

EquipmentWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_90 , upvalues : _ENV, uis, EquipmentWindow, _newStatus, EquipmentNewStatus
  if msgId == (WindowMsgEnum.Equipt).E_MSG_REFRESH_LOCK_EQUIPMENT then
    if (uis.c1Ctr).selectedIndex == EquipmentWindowType.Main then
      (EquipmentWindow.RefreshEquipmentInfoMain)()
    else
      ;
      (EquipmentWindow.RefreshEquipmentLockInfoSecondary)()
      ;
      (EquipmentWindow.RefreshRightEquipmentList)()
    end
  else
    if msgId == (WindowMsgEnum.Equipt).E_MSG_REFRESH_EQUIPMENT then
      (EquipmentWindow.RefreshEquipmentInfoSecondary)(para)
      ;
      (EquipmentWindow.RefreshEquipmentInfoRedDot)()
      ;
      (EquipmentWindow.RefreshRightPage)(false, true)
    else
      if msgId == (WindowMsgEnum.Equipt).E_MSG_REFRESH_EQUIPMENT_IN_BAG then
        (EquipmentWindow.RefreshRightPage)(true)
      else
        -- DECOMPILER ERROR at PC51: Confused about usage of register: R2 in 'UnsetPending'

        if msgId == (WindowMsgEnum.Equipt).E_MSG_DISABLE_ALL_DECOMPOSE then
          (((uis.EquiptPanelGrp).CleanUpGrp).AllChoiceBtn).selected = false
        else
          if msgId == (WindowMsgEnum.Equipt).E_MSG_REFRESH_EQUIPMENT_TO_IDENTIFY then
            (EquipmentWindow.ShowReadyToIdentifyEquipments)()
            ;
            (EquipmentWindow.RefreshIdentifyBtnRedDot)()
            ;
            (EquipmentWindow.RefreshEquipmentInfoRedDot)()
          else
            if msgId == (WindowMsgEnum.Equipt).E_MSG_PLAY_IDENTIFY_EFFECT then
              (EquipmentWindow.PlayIdentifyEffect)(para)
              ;
              (EquipmentWindow.RefreshIdentifyBtnRedDot)()
              ;
              (EquipmentWindow.RefreshEquipmentInfoRedDot)()
            else
              if msgId == (WindowMsgEnum.Equipt).E_MSG_REFRESH_EQUIPMENT_TO_DECOMPOSE then
                (EquipmentWindow.RefreshDecomposeList)()
                ;
                (EquipmentWindow.RefreshIdentifyBtnRedDot)()
                ;
                (EquipmentWindow.RefreshEquipmentInfoRedDot)()
              else
                if msgId == (WindowMsgEnum.Equipt).E_MSG_REFRESH_ALL_CHOOSE_BTN then
                  _newStatus = EquipmentNewStatus.NeedShow
                  ;
                  (EquipmentWindow.CheckIdentifyAllChoseBtn)()
                else
                  -- DECOMPILER ERROR at PC106: Confused about usage of register: R2 in 'UnsetPending'

                  if msgId == (WindowMsgEnum.NETBrokenReconnect).E_MSG_RECONNECT_Ok then
                    EquiptData.Identifying = false
                    ;
                    (EquiptData.InitFilter)()
                    ;
                    (EquiptData.FilteringEquiptSet)(EquiptSetType.Change)
                    ;
                    (EquiptData.FilteringEquiptSet)(EquiptSetType.Decompose)
                    ;
                    (EquiptData.FilteringEquiptSet)(EquiptSetType.Identify)
                    if (uis.c1Ctr).selectedIndex == EquipmentWindowType.Main then
                      (EquipmentWindow.RefreshEquipmentInfoMain)()
                    else
                      ;
                      (EquipmentWindow.RefreshRightPage)()
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
end

return EquipmentWindow

