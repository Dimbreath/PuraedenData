-- params : ...
-- function num : 0 , upvalues : _ENV
GetWayMgr = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

GetWayMgr.Goto = function(id, ...)
  -- function num : 0_0 , upvalues : _ENV
  if (FunctionControlMgr.GetFunctionState)(id, true) == false then
    return 
  end
  print("go to " .. tostring(id))
  if id == ControlID.Adventure_Arena then
    ld("Arena")
    ;
    (ArenaMgr.TryOpenArenaUI)()
  else
    if id == ControlID.Arena_Career_Reward then
      ld("Arena")
      ;
      (ArenaMgr.TryOpenArenaUI)(function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    (ArenaMgr.OpenRewardUI)(ArenaRewardType.CareerReward)
  end
)
    else
      if id == ControlID.Adventure_Plot then
        (PlotDungeonMgr.ExternalGotoStage)((ProtoEnum.E_CHALLENGE_TYPE).STORE_CHALLENGE, ...)
      else
        if id == ControlID.Adventure_Hero then
          (PlotDungeonMgr.ExternalGotoStage)((ProtoEnum.E_CHALLENGE_TYPE).ELITE_CHALLENGE, ...)
        else
          if id == ControlID.Adventure_Daily then
            ld("DailyDungeon")
            ;
            (DailyDungeonMgr.OpenDailyDungeonChapterList)()
          else
            if id == ControlID.Daily_Gold then
              ld("DailyDungeon")
              ;
              (DailyDungeonMgr.OpenDailyDungeonDifficulty)(PlayType.CoinDungeon)
            else
              if id == ControlID.Daily_Medical then
                ld("DailyDungeon")
                ;
                (DailyDungeonMgr.OpenDailyDungeonDifficulty)(PlayType.RoleExpDungeon)
              else
                if id == ControlID.Daily_Crystal then
                  ld("DailyDungeon")
                  ;
                  (DailyDungeonMgr.OpenDailyDungeonDifficulty)(PlayType.EquipmentExpDungeon)
                else
                  if ControlID.Shop_Grocer <= id and id <= ControlID.Shop_Expedition then
                    ld("Shop", function(...)
    -- function num : 0_0_1 , upvalues : _ENV, id
    (ShopMgr.ExternalGotoShop)(id - 102000)
  end
)
                  else
                    if id == ControlID.Equipment_Detail or id == ControlID.Equipment_Equip then
                      ld("Equipt")
                      ;
                      (EquiptMgr.OpenEquipmentWindow)()
                    else
                      if id == ControlID.Equipment_Identify then
                        ld("Equipt")
                        ;
                        (EquiptMgr.OpenEquipmentWindow)(EquiptOpenType.Identify)
                      else
                        if ControlID.Card_Strength <= id and id <= ControlID.Card_Talent then
                          ld("Card", function(...)
    -- function num : 0_0_2 , upvalues : id, _ENV
    if id == ControlID.Card_Break then
      (CardMgr.OpenCardWindowWithTag)(0)
    else
      if id == ControlID.Card_Strength then
        (CardMgr.OpenCardWindowWithTag)(1)
      else
        ;
        (CardMgr.OpenCardWindowWithTag)(id % 200201)
      end
    end
  end
)
                        else
                          if id == ControlID.Adventure_Rich then
                            ld("Adventure", function(...)
    -- function num : 0_0_3 , upvalues : _ENV
    (AdventureMgr.TryOpenAdventureUI)()
  end
)
                          else
                            if id == ControlID.BigAdventure_Wish then
                              ld("Adventure")
                              ;
                              (AdventureMgr.TryOpenSubFunc)(function(...)
    -- function num : 0_0_4 , upvalues : _ENV
    (AdventureMgr.EnterMakeWish)()
  end
)
                            else
                              if id == ControlID.Home_LotteryBtn then
                                (ActorService.ReqActivityLottery)()
                              else
                                if id == ControlID.Adventure_Expedition then
                                  ld("Expedition", function(...)
    -- function num : 0_0_5 , upvalues : _ENV
    (ExpeditionService.OnReqExpeditionData)()
  end
)
                                else
                                  if id == ControlID.Home_UnionBtn then
                                    ld("Guild", function(...)
    -- function num : 0_0_6 , upvalues : _ENV
    (GuildMgr.OpenGuild)()
  end
)
                                  else
                                    if id == ControlID.HandBook_AdventureRecode then
                                      OpenWindow((WinResConfig.HandBookStoryPlotWindow).name, UILayer.HUD)
                                    else
                                      if id == ControlID.HandBook_Story then
                                        (HandBookService.OnReqCGCopySummary)((HandBookMgr.CardPlotWinType).Story)
                                      else
                                        if id == ControlID.HandBook_Album then
                                          OpenWindow((WinResConfig.HandBookAlbumWindow).name, UILayer.HUD)
                                        else
                                          if id == ControlID.HandBook_Intimacy then
                                            (HandBookService.OnReqCGCopySummary)((HandBookMgr.CardPlotWinType).Intimacy)
                                          else
                                            if id == ControlID.Equipment_Detail then
                                              (EquiptMgr.OpenEquipmentWindow)(EquiptOpenType.Identify)
                                            else
                                              if id == ControlID.Lottery_Part or id == ControlID.Lottery_Equip or id == ControlID.Lottery_Card then
                                                (ActorService.ReqActivityLottery)()
                                              else
                                                if id == ControlID.Adventure_Tower then
                                                  ld("Tower", function(...)
    -- function num : 0_0_7 , upvalues : _ENV
    (TowerMgr.TryOpenTowerUI)()
  end
)
                                                else
                                                  if id == ControlID.AssetShop_Physical then
                                                    (AssetShopService.ReqGetBuyAssistNum)((ProtoEnum.BUY_ASSIST_TYPE).VIT_BUY_TIME_TYPE)
                                                  else
                                                    if id == ControlID.Activity_Sign then
                                                      (ActivityService.OnReqSignInInit)()
                                                    else
                                                      if id == ControlID.Activity_Cake then
                                                        (ActivityService.OnReqVitGetInit)()
                                                      else
                                                        if id == ControlID.Task_Daily then
                                                          (TaskService.ReqTaskData)(TaskType.Daily)
                                                        else
                                                          if id == ControlID.Task_Week then
                                                            (TaskService.ReqTaskData)(TaskType.Weekly)
                                                          else
                                                            if id == ControlID.Task_GrowUp then
                                                              (TaskService.ReqTaskData)(TaskType.GrowUp)
                                                            else
                                                              if id == ControlID.AssetShop_Gold then
                                                                (AssetShopService.ReqGetBuyAssistNum)((ProtoEnum.BUY_ASSIST_TYPE).GOLD_BUY_TIME_TYPE)
                                                              else
                                                                if id == ControlID.AssetShop_ENDURANCE then
                                                                  (AssetShopService.ReqGetBuyAssistNum)((ProtoEnum.BUY_ASSIST_TYPE).STA_BUY_TIME_TYPE)
                                                                else
                                                                  if id == ControlID.AssetShop_SPIRIT then
                                                                    (AssetShopService.ReqGetBuyAssistNum)((ProtoEnum.BUY_ASSIST_TYPE).ENERGY_BUY_TIME_TYPE)
                                                                  else
                                                                    if id == ControlID.Guild_Guess then
                                                                      ld("Guild", function(...)
    -- function num : 0_0_8 , upvalues : _ENV
    if (ActorData.GetGuildID)() == 0 then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000280))
    else
      ;
      (GuildService.ExternalOpenGuess)()
    end
  end
)
                                                                    else
                                                                      if id == ControlID.Guild_Construction then
                                                                        ld("Guild", function(...)
    -- function num : 0_0_9 , upvalues : _ENV
    if (ActorData.GetGuildID)() == 0 then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000280))
    else
      ;
      (GuildMgr.ReqGuildBuildingInfo)(true)
    end
  end
)
                                                                      else
                                                                        if id == ControlID.Talent_Uplevel then
                                                                          OpenWindow((WinResConfig.TalentMainWindow).name, UILayer.HUD)
                                                                        else
                                                                          if id == ControlID.Home_MailBtn then
                                                                            ld("Mail", function(...)
    -- function num : 0_0_10 , upvalues : _ENV
    OpenWindow((WinResConfig.MailWindow).name, UILayer.HUD)
  end
)
                                                                          else
                                                                            if id == ControlID.Shop_Recharge then
                                                                              ld("Shop", function(...)
    -- function num : 0_0_11 , upvalues : _ENV
    (ShopMgr.ExternalGotoShop)(ShopType.Recharge)
  end
)
                                                                            else
                                                                              if id == ControlID.Shop_Gift then
                                                                                ld("Shop", function(...)
    -- function num : 0_0_12 , upvalues : _ENV
    (ShopMgr.ExternalGotoShop)(ShopType.GiftBuy)
  end
)
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
            end
          end
        end
      end
    end
  end
end


