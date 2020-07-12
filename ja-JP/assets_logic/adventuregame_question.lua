-- params : ...
-- function num : 0 , upvalues : _ENV
require("AdventureGame_AnswerWindowByName")
local AdventureGame_Question = {}
local uis, contentPane = nil, nil
local argTable = {}
local nodeId, questionType = nil, nil
local tableCount = 0
local rdQues = {}
local quesCount = 5
local curQuesIndex = 0
local rightNum = 0
local isCheack = false
local isPlayAnim = false
local notFoundEffect, finishFunc = nil, nil
AdventureGame_Question.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, nodeId, questionType, uis, rdQues, finishFunc, quesCount, AdventureGame_Question, isCheack
  bridgeObj:SetView((WinResConfig.AdventureGame_Question).package, (WinResConfig.AdventureGame_Question).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  nodeId = argTable[1]
  if argTable[2] then
    questionType = argTable[2]
  else
    questionType = 1
  end
  uis = GetAdventureGame_AnswerWindowUis(contentPane)
  if nodeId == -1 then
    rdQues = {}
    local ques = argTable[3]
    finishFunc = argTable[4]
    for _,v in ipairs(ques) do
      local QuestionData = ((TableData.gTable).BaseAdventureGameQuestionData)[tonumber(v)]
      ;
      (table.insert)(rdQues, QuestionData)
    end
    quesCount = #rdQues
    -- DECOMPILER ERROR at PC62: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((uis.AnswerGrp).OrderTxt).visible = #ques > 1
  else
    quesCount = tonumber((((TableData.gTable).BaseAdventureEventData)[76420301]).parameter)
    ;
    (AdventureGame_Question.RandomGetSomeQuestions)()
  end
  ;
  (LuaSound.LoadAndPlayBGM)(1010004)
  ;
  (AdventureGame_Question.InitWindow)()
  isCheack = false
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

AdventureGame_Question.InitWindow = function(...)
  -- function num : 0_1 , upvalues : uis, _ENV, curQuesIndex, rightNum, quesCount, notFoundEffect, AdventureGame_Question
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.AnswerGrp).Tips_01_Txt).text = (PUtil.get)(152)
  curQuesIndex = 1
  rightNum = 0
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.AnswerGrp).Tips_02_Txt).text = rightNum .. "/" .. quesCount
  notFoundEffect = (Util.SetNotFoundEffect)((uis.AnswerGrp).CardQLoader)
  ;
  (AdventureGame_Question.RefreshWindow)()
end

AdventureGame_Question.RefreshWindow = function(...)
  -- function num : 0_2 , upvalues : rdQues, curQuesIndex, AdventureGame_Question, uis, _ENV
  local curQuesData = rdQues[curQuesIndex]
  ;
  (AdventureGame_Question.ClearButtonSelectedState)()
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.AnswerGrp).OrderTxt).text = (PUtil.get)(153, tostring(curQuesIndex))
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.AnswerGrp).WordTxt).text = curQuesData.description
  local rightSelect = tonumber(curQuesData.right_answer)
  local tab = {}
  ;
  (table.insert)(tab, {ques = curQuesData.answer1, ans = false})
  ;
  (table.insert)(tab, {ques = curQuesData.answer2, ans = false})
  ;
  (table.insert)(tab, {ques = curQuesData.answer3, ans = false})
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (tab[rightSelect]).ans = true
  local rdIndex = (AdventureGame_Question.Randomx)(1, 3, 3)
  local tab2 = {}
  ;
  (table.insert)(tab2, tab[rdIndex[1]])
  ;
  (table.insert)(tab2, tab[rdIndex[2]])
  ;
  (table.insert)(tab2, tab[rdIndex[3]])
  ;
  (AdventureGame_Question.SetButtonInfo)((uis.AnswerGrp).OneBtn, (tab2[1]).ques, "A.", (tab2[1]).ans)
  ;
  (AdventureGame_Question.SetButtonInfo)((uis.AnswerGrp).TwoBtn, (tab2[2]).ques, "B.", (tab2[2]).ans)
  ;
  (AdventureGame_Question.SetButtonInfo)((uis.AnswerGrp).ThreeBtn, (tab2[3]).ques, "C.", (tab2[3]).ans)
  ;
  (((uis.AnswerGrp).OneBtn).onClick):Clear()
  ;
  (((uis.AnswerGrp).TwoBtn).onClick):Clear()
  ;
  (((uis.AnswerGrp).ThreeBtn).onClick):Clear()
  ;
  (((uis.AnswerGrp).OneBtn).onClick):Add(function(...)
    -- function num : 0_2_0 , upvalues : AdventureGame_Question, tab2, uis
    (AdventureGame_Question.CheckAnswerFinish)(tab2[1], (uis.AnswerGrp).OneBtn)
  end
)
  ;
  (((uis.AnswerGrp).TwoBtn).onClick):Add(function(...)
    -- function num : 0_2_1 , upvalues : AdventureGame_Question, tab2, uis
    (AdventureGame_Question.CheckAnswerFinish)(tab2[2], (uis.AnswerGrp).TwoBtn)
  end
)
  ;
  (((uis.AnswerGrp).ThreeBtn).onClick):Add(function(...)
    -- function num : 0_2_2 , upvalues : AdventureGame_Question, tab2, uis
    (AdventureGame_Question.CheckAnswerFinish)(tab2[3], (uis.AnswerGrp).ThreeBtn)
  end
)
end

AdventureGame_Question.SetButtonInfo = function(btn, ques, sign, ans, ...)
  -- function num : 0_3
  if ques then
    btn.visible = true
    ;
    (btn:GetChild("OrderTxt")).text = sign
    ;
    (btn:GetChild("WordTxt")).text = ques
    if ans then
      (btn:GetController("c1")).selectedIndex = 0
    else
      ;
      (btn:GetController("c1")).selectedIndex = 1
    end
  else
    btn.visible = false
  end
end

AdventureGame_Question.ClearButtonSelectedState = function(...)
  -- function num : 0_4 , upvalues : uis
  (((uis.AnswerGrp).OneBtn):GetChild("SelectedImage")).visible = false
  ;
  (((uis.AnswerGrp).TwoBtn):GetChild("SelectedImage")).visible = false
  ;
  (((uis.AnswerGrp).ThreeBtn):GetChild("SelectedImage")).visible = false
end

AdventureGame_Question.CheckAnswerFinish = function(select, clickedBtn, otherBtn, ...)
  -- function num : 0_5 , upvalues : isPlayAnim, AdventureGame_Question, rightNum, uis, quesCount, _ENV, notFoundEffect, curQuesIndex, isCheack, nodeId, finishFunc
  if isPlayAnim then
    return 
  end
  ;
  (AdventureGame_Question.ClearButtonSelectedState)()
  ;
  (clickedBtn:GetChild("SelectedImage")).visible = true
  if select.ans then
    rightNum = rightNum + 1
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((uis.AnswerGrp).Tips_02_Txt).text = rightNum .. "/" .. quesCount
    ;
    (SkeletonAnimationUtil.SetAnimation)(notFoundEffect, 0, "hi", false, function(...)
    -- function num : 0_5_0 , upvalues : _ENV, notFoundEffect
    (SkeletonAnimationUtil.SetAnimation)(notFoundEffect, 0, "idle", true)
  end
)
  end
  curQuesIndex = curQuesIndex + 1
  isPlayAnim = true
  PlayUITrans((uis.AnswerGrp).OneBtn, "in")
  PlayUITrans((uis.AnswerGrp).TwoBtn, "in")
  PlayUITrans((uis.AnswerGrp).ThreeBtn, "in")
  ;
  (SimpleTimer.setTimeout)(2, function(...)
    -- function num : 0_5_1 , upvalues : curQuesIndex, quesCount, isCheack, nodeId, finishFunc, rightNum, _ENV, isPlayAnim, AdventureGame_Question
    if quesCount < curQuesIndex then
      if isCheack == false then
        isCheack = true
      else
        return 
      end
      -- DECOMPILER ERROR at PC19: Unhandled construct in 'MakeBoolean' P1

      if nodeId == -1 and finishFunc ~= nil then
        finishFunc(rightNum)
      end
      local result = nil
      if rightNum == 0 then
        result = AdventureRewardType.Right0
      else
        if rightNum == 1 then
          result = AdventureRewardType.Right1
        else
          if rightNum == 2 then
            result = AdventureRewardType.Right2
          else
            if rightNum == 3 then
              result = AdventureRewardType.Right3
            else
              if rightNum == 4 then
                result = AdventureRewardType.Right4
              else
                if rightNum == 5 then
                  result = AdventureRewardType.RightAll
                end
              end
            end
          end
        end
      end
      print("result", result)
      do
        local rewardInfo = (AdventureData.GetMiniGameRewardInfo)(AdventureEventType.Question, result)
        ;
        (AdventureService.ReqAdventureEventReward)(nodeId, AdventureEventType.Question, false, {[1] = rewardInfo.Id})
        ;
        (SimpleTimer.setTimeout)(0.5, function(...)
      -- function num : 0_5_1_0 , upvalues : _ENV
      UIMgr:CloseWindow((WinResConfig.AdventureGame_Question).name)
    end
)
        isPlayAnim = false
        ;
        (AdventureGame_Question.RefreshWindow)()
      end
    end
  end
)
end

AdventureGame_Question.RandomGetSomeQuestions = function(...)
  -- function num : 0_6 , upvalues : _ENV, tableCount, rdQues, AdventureGame_Question, quesCount
  print("随机抽取一些题目随机抽取一些题目", tableCount)
  rdQues = {}
  local tmpIndex = 1
  local allQues = {}
  local mLvl = (ActorData.GetLevel)()
  local qType = 1
  for k,v in pairs((TableData.gTable).BaseAdventureGameQuestionData) do
    if v.type == qType then
      local minLvl = tonumber((split(v.open_range, ":"))[1])
      local maxLvl = tonumber((split(v.open_range, ":"))[2])
      if minLvl <= mLvl and mLvl <= maxLvl then
        (table.insert)(allQues, v)
      end
    end
  end
  local rdIndex = (AdventureGame_Question.Randomx)(1, #allQues, quesCount)
  for k,v in pairs(allQues) do
    for i,j in ipairs(rdIndex) do
      if tmpIndex == rdIndex[i] then
        (table.insert)(rdQues, v)
        break
      end
    end
    do
      do
        tmpIndex = tmpIndex + 1
        -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
end

AdventureGame_Question.Randomx = function(m, n, cnt, ...)
  -- function num : 0_7 , upvalues : _ENV
  if n - m + 1 < cnt then
    return {}
  end
  local t = {}
  local tmp = {}
  ;
  (math.randomseed)((os.time)())
  do
    while cnt > 0 do
      local x = (math.random)(m, n)
      if not tmp[x] then
        t[#t + 1] = x
        tmp[x] = 1
        cnt = cnt - 1
      end
    end
    return t
  end
end

AdventureGame_Question.Table_Rand = function(t, ...)
  -- function num : 0_8 , upvalues : _ENV
  if t == nil then
    return 
  end
  local tRet = {}
  local Total = #t
  do
    while Total > 0 do
      local i = (math.random)(1, Total)
      ;
      (table.insert)(tRet, t[i])
      t[i] = t[Total]
      Total = Total - 1
    end
    return tRet
  end
end

AdventureGame_Question.HandleMessage = function(msgId, para, ...)
  -- function num : 0_9 , upvalues : _ENV
  local windowMsgEnum = WindowMsgEnum.Adventure
  if msgId == windowMsgEnum.E_MSG_QUESTION_REWARDS then
    (AdventureMgr.AfterShowResult)()
  end
end

AdventureGame_Question.OnClose = function(...)
  -- function num : 0_10 , upvalues : _ENV, uis, contentPane, argTable, rdQues, rightNum, curQuesIndex, tableCount, isCheack, notFoundEffect, isPlayAnim, finishFunc
  (LuaSound.LoadAndPlayBGM)(1010005)
  uis = nil
  contentPane = nil
  argTable = {}
  rdQues = {}
  rightNum = 0
  curQuesIndex = 1
  rightNum = 0
  tableCount = 0
  isCheack = false
  notFoundEffect = nil
  isPlayAnim = false
  finishFunc = nil
end

return AdventureGame_Question

