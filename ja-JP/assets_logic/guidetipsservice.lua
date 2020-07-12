-- params : ...
-- function num : 0 , upvalues : _ENV
GuideTipsService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

GuideTipsService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResGuideNotice, GuideTipsService.RecvGuideNotice)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

GuideTipsService.RecvGuideNotice = function(msg, ...)
  -- function num : 0_1 , upvalues : _ENV
  if msg.type == (ProtoEnum.GUIDE_TYPE).COPY_STORY_TYPE then
    (Util.ShowGuideTips)(GuideTipsCheckPoint.UnlockStoryChapter, (((TableData.gTable).BaseChapterData)[(msg.params)[1]]).name)
  else
    if msg.type == (ProtoEnum.GUIDE_TYPE).COPY_HERO_TYPE then
      (Util.ShowGuideTips)(GuideTipsCheckPoint.UnlockHeroDungeon, (((TableData.gTable).BaseChapterData)[(msg.params)[1]]).name)
    else
      if msg.type == (ProtoEnum.GUIDE_TYPE).COPY_DAILY_TYPE then
        if (msg.params)[1] == PlayType.CoinDungeon then
          (Util.ShowGuideTips)(GuideTipsCheckPoint.UnlockAssaultTheif)
        else
          if (msg.params)[1] == PlayType.RoleExpDungeon then
            (Util.ShowGuideTips)(GuideTipsCheckPoint.UnlockAssaultLeader)
          else
            if (msg.params)[1] == PlayType.EquipmentExpDungeon then
              (Util.ShowGuideTips)(GuideTipsCheckPoint.UnlockChallengeMage)
            end
          end
        end
      else
        if msg.type == (ProtoEnum.GUIDE_TYPE).COPY_DAILY_STAGE_TYPE then
          if (msg.params)[1] == PlayType.CoinDungeon then
            (Util.ShowGuideTips)(GuideTipsCheckPoint.UnlockDailyDungeon, (PUtil.get)(40002001))
          else
            if (msg.params)[1] == PlayType.RoleExpDungeon then
              (Util.ShowGuideTips)(GuideTipsCheckPoint.UnlockDailyDungeon, (PUtil.get)(40002002))
            else
              if (msg.params)[1] == PlayType.EquipmentExpDungeon then
                (Util.ShowGuideTips)(GuideTipsCheckPoint.UnlockDailyDungeon, (PUtil.get)(40002003))
              end
            end
          end
        else
          if msg.type == (ProtoEnum.GUIDE_TYPE).COPY_EXPEDITION_TYPE then
            (Util.ShowGuideTips)(GuideTipsCheckPoint.UnlockExpedition, (((TableData.gTable).BaseExpeditionData)[(msg.params)[1]]).name)
          else
            if msg.type == (ProtoEnum.GUIDE_TYPE).TASK_TYPE then
              local config = ((TableData.gTable).BaseTaskData)[(msg.params)[1]]
              ld("Task")
              ;
              (Util.ShowGuideTips)(GuideTipsCheckPoint.QuestComplete, (TaskMgr.GetTaskTypeName)(config.type), config.remark, config.type)
            else
              do
                if msg.type == (ProtoEnum.GUIDE_TYPE).SHOP_TYPE then
                  (Util.ShowGuideTips)(GuideTipsCheckPoint.UnlockStorySlots, (PUtil.get)(20000064 + (msg.params)[1]))
                else
                  if msg.type == (ProtoEnum.GUIDE_TYPE).HANDBOOK_STAGE_TYPE then
                    (Util.ShowGuideTips)(GuideTipsCheckPoint.UnlcokFeelingStory, (((TableData.gTable).BaseCardData)[(msg.params)[1]]).name)
                  else
                    if msg.type == (ProtoEnum.GUIDE_TYPE).COPY_TOWER_TYPE then
                      (Util.ShowGuideTips)(GuideTipsCheckPoint.UnlockNewTower)
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

;
(GuideTipsService.Init)()

