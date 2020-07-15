-- params : ...
-- function num : 0 , upvalues : _ENV
BaseAlertData = {
auth_fail = {id = "auth_fail", name = "ログインに失敗しました"}
, 
access_not_enough = {id = "access_not_enough", name = "権限なし"}
, 
activity_config_error = {id = "activity_config_error", name = "イベントデータエラー"}
, 
activity_not_exist = {id = "activity_not_exist", name = "イベント未開催です"}
, 
activity_server_error = {id = "activity_server_error", name = "イベントサーバーエラー"}
, 
already_apply_guild = {id = "already_apply_guild", name = "ギルドに加入申請をしました"}
, 
already_have_guild = {id = "already_have_guild", name = "ギルド加入済み"}
, 
arena_day_score_deficiency = {id = "arena_day_score_deficiency", name = "ポイント不足"}
, 
arena_rank_deficiency = {id = "arena_rank_deficiency", name = "闘技場ボーナス獲得可能のランキングに入らなかった"}
, 
arena_reward_month_no_match = {id = "arena_reward_month_no_match", name = "シーズンボーナスは当月と合わない"}
, 
arena_reward_type_wrong = {id = "arena_reward_type_wrong", name = "闘技場ボーナスタイプエラー"}
, 
arena_reward_yet_draw = {id = "arena_reward_yet_draw", name = "闘技場デイリーボーナス受取済み"}
, 
asset_not_enough = {id = "asset_not_enough", name = "資源不足"}
, 
battle_failure = {id = "battle_failure"}
, 
buy_num_exceed_max = {id = "buy_num_exceed_max", name = "購入可能回数MAX"}
, 
card_group_not_null = {id = "card_group_not_null", name = "パーティーを編成してください"}
, 
card_include = {id = "card_include"}
, 
card_is_exist = {id = "card_is_exist", name = "キャラ獲得済み"}
, 
card_level_error = {id = "card_level_error", name = "キャラレベルが不足しているから、レベルを上げてください"}
, 
card_level_max = {id = "card_level_max", name = "キャラレベルMAX"}
, 
card_level_over_player = {id = "card_level_over_player", name = "キャラのレベルは冒険団を超えてはいけない"}
, 
card_not_exist = {id = "card_not_exist", name = "検索キャラなし"}
, 
card_num_big = {id = "card_num_big", name = "出陣キャラが満員になっています"}
, 
card_quality_max = {id = "card_quality_max", name = "キャラ突破MAX"}
, 
card_skill_level_over = {id = "card_skill_level_over", name = "才能レベルはキャラレベルを超えてはいけない"}
, 
card_skill_max_level = {id = "card_skill_max_level", name = "才能MAX"}
, 
card_skill_not_exist = {id = "card_skill_not_exist", name = "才能ロック中"}
, 
card_star_max = {id = "card_star_max", name = "キャラ覚醒MAX"}
, 
cd_error = {id = "cd_error", name = "制限時間経過後、ギルドに再加入できます"}
, 
cd_time_no_arrived = {id = "cd_time_no_arrived", name = "ステージ挑戦が冷却中ですから、お待ちください"}
, 
config_error = {id = "config_error", name = "配置エラー"}
, 
diamond_not_enough = {id = "diamond_not_enough", name = "ダイヤ不足"}
, 
embattle_no_card = {id = "embattle_no_card", name = "少なくとも1名キャラが出陣必須です"}
, 
equip_already_identify = {id = "equip_already_identify", name = "装備未鑑定"}
, 
equip_exp_not_enough = {id = "equip_exp_not_enough", name = "星の砂不足"}
, 
equip_max_level = {id = "equip_max_level"}
, 
equip_no_identify = {id = "equip_no_identify", name = "装備未鑑定"}
, 
equip_not_exist = {id = "equip_not_exist", name = "この装備なし"}
, 
equip_only_card = {id = "equip_only_card", name = "キャラ専用装備です"}
, 
equip_position_no_unlock = {id = "equip_position_no_unlock", name = "装備欄ロック中"}
, 
expedition_exist = {id = "expedition_exist", name = "遠征区域を選択しました、再選定できません"}
, 
expedition_sweep_condition_no_pass = {id = "expedition_sweep_condition_no_pass", name = "掃討条件が未満足ですから、掃討できません"}
, 
failed = {id = "failed", name = "何か問題があるようです"}
, 
fc_not_enough = {id = "fc_not_enough", name = "現在の戦力がまだ足りない"}
, 
func_not_open = {id = "func_not_open", name = "機能未開放"}
, 
gm_close = {id = "gm_close", name = "サーバーに接続できません"}
, 
gold_not_enough = {id = "gold_not_enough", name = "コイン不足"}
, 
goods_no_enough = {id = "goods_no_enough", name = "素材不足"}
, 
guild_apply_max = {id = "guild_apply_max", name = "申請を十分に出しました、ご返事をお待ちください"}
, 
guild_building_max_num = {id = "guild_building_max_num", name = "ギルド建設MAX"}
, 
guild_building_plan_not_enough = {id = "guild_building_plan_not_enough", name = "ギルド建設進度不足"}
, 
guild_draw_reward_num_up = {id = "guild_draw_reward_num_up"}
, 
guild_join_error = {id = "guild_join_error", name = "ギルドが忙しいので、後ほどお試しください"}
, 
guild_member_max = {id = "guild_member_max", name = "ギルドメンバー人数MAX"}
, 
guild_member_not_exist = {id = "guild_member_not_exist", name = "検索ギルドメンバーなし"}
, 
guild_name_repeated = {id = "guild_name_repeated", name = "ギルド名が使用されました"}
, 
guild_not_exist = {id = "guild_not_exist", name = "検索ギルドなし"}
, 
guild_reward_yet_draw = {id = "guild_reward_yet_draw", name = "ギルドボーナス受取済み"}
, 
illegal_error = {id = "illegal_error", name = "不正エラー"}
, 
init_error = {id = "init_error", name = "初期化エラー"}
, 
insufficient_player_level = {id = "insufficient_player_level", name = "冒険団レベルが不足しています"}
, 
intimacy_gift_num_max = {id = "intimacy_gift_num_max", name = "十分なギフトを贈りしました"}
, 
lottery_cd_error = {id = "lottery_cd_error"}
, 
lottery_max_num = {id = "lottery_max_num", name = "本日の募集回数が使用切れです"}
, 
max_buy_num_zero = {id = "max_buy_num_zero", name = "最大購入可能回数はゼロです"}
, 
no_arena_cd = {id = "no_arena_cd", name = "闘技場挑戦が冷却中ですから、お待ちください"}
, 
no_arena_player = {id = "no_arena_player", name = "適当な相手を見つけられなかった"}
, 
no_arena_sweep = {id = "no_arena_sweep", name = "自分の順位より高いプレヤーを抑えられない"}
, 
no_arena_time = {id = "no_arena_time", name = "挑戦回数不足"}
, 
no_battle_data = {id = "no_battle_data", name = "検索バトルデータなし"}
, 
no_battle_stage = {id = "no_battle_stage"}
, 
no_draw_reward = {id = "no_draw_reward", name = "受取可能ボーナスなし"}
, 
no_enough = {id = "no_enough", name = "%s不足"}
, 
no_get_reward_coefficient = {id = "no_get_reward_coefficient", name = "ボーナスデータがなくなりました"}
, 
no_next_stage = {id = "no_next_stage", name = "最後のステージです"}
, 
no_shop_buy_time = {id = "no_shop_buy_time", name = "購入回数MAX"}
, 
no_type_shop = {id = "no_type_shop", name = "ショップ整理中、しばらくお待ちください"}
, 
no_use_sweep_num = {id = "no_use_sweep_num"}
, 
not_exist_apply = {id = "not_exist_apply"}
, 
not_have_guild = {id = "not_have_guild", name = "ギルド未所属"}
, 
not_same_guild = {id = "not_same_guild"}
, 
oneself_apply_max = {id = "oneself_apply_max", name = "申請をしたギルド数が上限に達しました"}
, 
open_condition_no_meet = {id = "open_condition_no_meet", name = "開放条件未満足"}
, 
other_login = {id = "other_login", name = "アカウントが他の端末にログインされました"}
, 
param_error = {id = "param_error", name = "おや、問題があるようです"}
, 
param_length_error = {id = "param_length_error", name = "おや、問題があるようです"}
, 
play_off_time = {id = "play_off_time", name = "イベント未開催です"}
, 
player_del_error = {id = "player_del_error", name = "アカウントがロックされています"}
, 
player_no_clear_cd = {id = "player_no_clear_cd", name = "イベントCDリセット不要"}
, 
player_not_exist = {id = "player_not_exist", name = "検索プレヤーなし"}
, 
player_over_max_level = {id = "player_over_max_level", name = "冒険団レベルMAX！"}
, 
post_count_max = {id = "post_count_max", name = "この役職の任命人数が上限に達しました"}
, 
post_repeat_error = {id = "post_repeat_error", name = "この役職は任命できません"}
, 
pre_task_is_not_completed = {id = "pre_task_is_not_completed", name = "まだクエストがあります"}
, 
prop_add_failed = {id = "prop_add_failed", name = "アイテム追加に失敗しました"}
, 
prop_count_error = {id = "prop_count_error", name = "アイテムの数が間違いました"}
, 
prop_debris_exchange_intelligence_error = {id = "prop_debris_exchange_intelligence_error", name = "証明書のレベルが不足しています"}
, 
prop_not_exist = {id = "prop_not_exist", name = "このアイテムなし"}
, 
prop_not_sell = {id = "prop_not_sell", name = "このアイテムを売ることができません"}
, 
prop_not_use = {id = "prop_not_use", name = "このアイテムが使用できません"}
, 
register_repeated = {id = "register_repeated", name = "すでに登録されているのですから、ログインしてください"}
, 
reward_no_repetition = {id = "reward_no_repetition", name = "ボーナス受取済み"}
, 
rmi_exception = {id = "rmi_exception"}
, 
rmi_result_error = {id = "rmi_result_error", name = "サーバーにエラーが発生しました、後ほど再試行してください"}
, 
rmi_result_param_error = {id = "rmi_result_param_error", name = "サーバーにエラーが発生しました、後ほど再試行してください"}
, 
server_busy = {id = "server_busy", name = "サーバーが忙しいです"}
, 
server_close = {id = "server_close", name = "サーバーとの接続が切断されました"}
, 
server_error = {id = "server_error", name = "サーバーにエラーが発生しました、後ほど再試行してください"}
, 
shop_not_hand_refresh = {id = "shop_not_hand_refresh", name = "このショップには手動で更新できません"}
, 
shop_not_match = {id = "shop_not_match", name = "アイテムが間違いました、もう一度お試しください"}
, 
shop_type_not_match = {id = "shop_type_not_match", name = "ショップは何か問題があるようですが、もう一度お試しください"}
, 
sign_in_count_error = {id = "sign_in_count_error", name = "累計冒険の日数が不足しています"}
, 
sign_in_ed = {id = "sign_in_ed", name = "本日サインインをしました"}
, 
stage_no_pass = {id = "stage_no_pass", name = "未クリアのステージは掃討できません"}
, 
stage_no_sweep = {id = "stage_no_sweep", name = "このステージが掃討できません"}
, 
stage_num_of_less = {id = "stage_num_of_less", name = "挑戦回数不足"}
, 
stage_rewarded = {id = "stage_rewarded", name = "ボーナス受取済み"}
, 
stage_up_no_pass = {id = "stage_up_no_pass", name = "前のステージをクリアしてください"}
, 
status_error = {id = "status_error", name = "ステータスエラー"}
, 
success = {id = "success", name = "成功しました"}
, 
talent_energy_max = {id = "talent_energy_max"}
, 
talent_level_max = {id = "talent_level_max"}
, 
talent_no_unlock = {id = "talent_no_unlock"}
, 
talent_tree_lock = {id = "talent_tree_lock"}
, 
talent_tree_star_max = {id = "talent_tree_star_max"}
, 
target_not_reached = {id = "target_not_reached", name = "目標未達成"}
, 
task_group_cal_error = {id = "task_group_cal_error", name = "タスクグループ計算エラー"}
, 
task_group_not_exist = {id = "task_group_not_exist", name = "タスクグループなし"}
, 
task_item_eno = {id = "task_item_eno", name = "タスク完了"}
, 
task_not_exist = {id = "task_not_exist", name = "タスクなし"}
, 
test_param = {id = "test_param", name = "テストパラメータ{0}パラメータ{1}"}
, 
type_error = {id = "type_error", name = "タイプエラー"}
, 
unknown_error = {id = "unknown_error", name = "未知エラー"}
, 
vip_not_enough = {id = "vip_not_enough", name = "VIPレベル不足"}
, 
vit_define = {id = "vit_define", name = "体力不足"}
, 
vit_get_ed = {id = "vit_get_ed", name = "受取済み"}
, 
wish_point_no_enough = {id = "wish_point_no_enough"}
, 
server_full = {id = "server_full", name = "サーバーフル"}
, 
http_result_error = {id = "http_result_error", name = "http戻るエラー"}
, 
server_close_ing = {id = "server_close_ing", name = "サーバーロック中"}
, 
player_level_not_enough = {id = "player_level_not_enough", name = "冒険団レベル不足"}
, 
card_fetter_activated = {id = "card_fetter_activated", name = "絆スキル解放"}
, 
card_fetter_error = {id = "card_fetter_error", name = "解放条件未満足"}
, 
prop_not_use_level = {id = "prop_not_use_level", name = "アイテムレベル不足"}
, 
arena_rank_deficiency = {id = "arena_rank_deficiency", name = "闘技場ボーナス獲得可能のランキングに入らなかった"}
, 
player_no_clear_cd = {id = "player_no_clear_cd", name = "イベントCDリセット不要"}
, 
yet_draw_guild_gift = {id = "yet_draw_guild_gift", name = "ギルド整理ボーナス受取済み"}
, 
guild_gift_finish = {id = "guild_gift_finish"}
, 
guild_member_data_error = {id = "guild_member_data_error", name = "ギルドメンバー検索に失敗しました"}
, 
reward_not_exist = {id = "reward_not_exist", name = "ボーナスなし"}
, 
reward_send_failed = {id = "reward_send_failed", name = "ボーナス配給に失敗しました"}
, 
activity_type_error = {id = "activity_type_error", name = "イベントタイプエラー"}
, 
activity_is_end = {id = "activity_is_end", name = "イベント終了です"}
, 
task_group_unopened = {id = "task_group_unopened", name = "タスク未開放"}
, 
equip_bag_max = {id = "equip_bag_max", name = "装備バッグMAX、これ以上購入できない、整理しますか"}
, 
activity_player_is_null = {id = "activity_player_is_null", name = "イベント参加プレヤーなし"}
, 
WORLD_LIMIT = {id = "WORLD_LIMIT", name = "内容が少し多いです"}
, 
world_null = {id = "world_null", name = "内容なし"}
, 
NO_CHAT_CONTENT = {id = "NO_CHAT_CONTENT", name = "コメントなし"}
, 
no_like_card = {id = "no_like_card", name = "このキャラなし"}
, 
set_like_card_type_error = {id = "set_like_card_type_error", name = "お気に入りカードのタイプを間違って設置しました　1又は2の一つを選んでください"}
, 
like_card_exist = {id = "like_card_exist", name = "お気に入りキャラはリストにあります"}
, 
contains_sensitive_word = {id = "contains_sensitive_word", name = "特殊な文字が検出されました"}
, 
unlock_trial_lost = {id = "unlock_trial_lost", name = "ステージ開放に失敗しました"}
, 
guild_pos_discordant = {id = "guild_pos_discordant", name = "ギルド整理位置が正しくありません"}
, 
no_attach_get = {id = "no_attach_get", name = "受取可能アイテムなし"}
, 
password_error = {id = "password_error", name = "パスワードが間違っています"}
, 
please_logout_first = {id = "please_logout_first", name = "ゲームを終了してください"}
, 
limit_max = {id = "limit_max", name = "これ以上購入不可"}
, 
limit_gift_max = {id = "limit_gift_max", name = "これ以上購入不可"}
, 
moon_is_expired = {id = "moon_is_expired", name = "月間カード権限がすでに有効期限を過ぎました"}
, 
adventure_event_nodeid_no_fit = {id = "adventure_event_nodeid_no_fit", name = "キャンプ位置を検索できません"}
, 
trial_sweep_no_condition = {id = "trial_sweep_no_condition", name = "相手を完全に勝たないから、掃討ができません"}
, 
trial_sweep_no_num = {id = "trial_sweep_no_num", name = "掃討回数不足"}
, 
arena_rank_deficiency = {id = "arena_rank_deficiency", name = "闘技場ボーナス獲得可能のランキングに入らなかった"}
, 
player_no_clear_cd = {id = "player_no_clear_cd", name = "该活动不需要清理cd"}
, 
guild_name_repeated = {id = "guild_name_repeated", name = "ギルド名が使用されました"}
, 
no_init_battle_record = {id = "no_init_battle_record", name = "初期対戦履歴なし"}
, 
battle_not_like = {id = "battle_not_like", name = "初期対戦履歴が合わない"}
, 
guild_build_num_up = {id = "guild_build_num_up", name = "ギルド建設回数が上限に達しました"}
, 
arena_rival_myself = {id = "arena_rival_myself", name = "自分に挑戦できない"}
, 
guild_notice_is_same = {id = "guild_notice_is_same", name = "現在最新のお知らせはありません"}
, 
exp_goods_no_enough = {id = "exp_goods_no_enough", name = "経験薬剤が足りません"}
, 
vip_not_yj = {id = "vip_not_yj", name = "すでにチャージ済みのアカウントを引き継ぐことができません"}
, 
role_is_not_guest = {id = "role_is_not_guest", name = "正式アカウントを引き継ぐことができません"}
, 
gift_code_format_wrong = {id = "gift_code_format_wrong", name = "無効なコードです"}
, 
gift_code_is_use = {id = "gift_code_is_use", name = "このコードは既に使用済みです"}
, 
gift_code_invalid = {id = "gift_code_invalid", name = "無効なコードです"}
, 
guess_cup_no_num = {id = "guess_cup_no_num", name = "お祈り回数が足りません"}
, 
guess_cup_is_zero = {id = "guess_cup_is_zero", name = "お祈りのリセット回数が足りません"}
, 
guess_cup_upper = {id = "guess_cup_upper", name = "お祈り回数が足りません"}
, 
guild_level_no_enough = {id = "guild_level_no_enough", name = "ギルドレベルが足りません"}
}
return BaseAlertData

