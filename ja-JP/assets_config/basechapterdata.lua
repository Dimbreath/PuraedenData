-- params : ...
-- function num : 0 , upvalues : _ENV
BaseChapterData = {
[51100000] = {id = 51100000, type = 1, stages = "52100001:52100002", open_condition = "72501001:0:1", pre = 0, next = "0", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon001", story_id = "0", story_times = "0"}
, 
[51100001] = {id = 51100001, name = (PUtil.get)(85110000, (PUtil.get)(86400001), (PUtil.get)(85110001)), type = 1, stages = "52100101:52100102:52100103:52100104:52100105", open_condition = "72501001:0:1", pre = 0, next = "51100002", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon001", story_id = "75001521", story_times = "101"}
, 
[51100002] = {id = 51100002, name = (PUtil.get)(85110000, (PUtil.get)(86400002), (PUtil.get)(85110002)), type = 1, stages = "52100201:52100202:52100203:52100204:52100205", open_condition = "72501001:0:1,72504111:52100105:1", pre = 51100001, next = "51100003", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon006", unlock_id = 11100001, unlock_des = "86400002:85170001", story_id = "75002111:75002521", story_times = "100:101"}
, 
[51100003] = {id = 51100003, name = (PUtil.get)(85110000, (PUtil.get)(86400003), (PUtil.get)(85110003)), type = 1, stages = "52100301:52100302:52100303:52100304:52100305", open_condition = "72501001:0:1,72504111:52100205:1", pre = 51100002, next = "51100004", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon002", unlock_id = 11100004, unlock_des = "86400003:85170002", story_id = "75003111", story_times = "100"}
, 
[51100004] = {id = 51100004, name = (PUtil.get)(85110000, (PUtil.get)(86400004), (PUtil.get)(85110004)), type = 1, stages = "52100401:52100402:52100403:52100404:52100405", open_condition = "72501001:0:1,72504111:52100305:1", pre = 51100003, next = "51100005", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon005", story_id = "75004111:75004521:75004522", story_times = "100:101:101"}
, 
[51100005] = {id = 51100005, name = (PUtil.get)(85110000, (PUtil.get)(86400005), (PUtil.get)(85110005)), type = 1, stages = "52100501:52100502:52100503:52100504:52100505", open_condition = "72501001:0:1,72504111:52100405:1", pre = 51100004, next = "51100006", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon003", story_id = "75005111", story_times = "100"}
, 
[51100006] = {id = 51100006, name = (PUtil.get)(85110000, (PUtil.get)(86400006), (PUtil.get)(85110006)), type = 1, stages = "52100601:52100602:52100603:52100604:52100605", open_condition = "72501001:0:10,72504111:52100505:1", pre = 51100005, next = "51100007", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon007", story_id = "75006111:75006521", story_times = "100:101"}
, 
[51100007] = {id = 51100007, name = (PUtil.get)(85110000, (PUtil.get)(86400007), (PUtil.get)(85110007)), type = 1, stages = "52100701:52100702:52100703:52100704:52100705", open_condition = "72501001:0:10,72504111:52100605:1", pre = 51100006, next = "51100008", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon004", story_id = "75007111", story_times = "100"}
, 
[51100008] = {id = 51100008, name = (PUtil.get)(85110000, (PUtil.get)(86400008), (PUtil.get)(85110008)), type = 1, stages = "52100801:52100802:52100803:52100804:52100805", open_condition = "72501001:0:16,72504111:52100705:1", pre = 51100007, next = "51100009", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon006", story_id = "75008111:75008112", story_times = "100:100"}
, 
[51100009] = {id = 51100009, name = (PUtil.get)(85110000, (PUtil.get)(86400009), (PUtil.get)(85110009)), type = 1, stages = "52100901:52100902:52100903:52100904:52100905", open_condition = "72501001:0:18,72504111:52100805:1", pre = 51100008, next = "51100010", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon001", story_id = "75009111", story_times = "100"}
, 
[51100010] = {id = 51100010, name = (PUtil.get)(85110000, (PUtil.get)(86400010), (PUtil.get)(85110010)), type = 1, stages = "52101001:52101002:52101003:52101004:52101005", open_condition = "72501001:0:20,72504111:52100905:1", pre = 51100009, next = "51100011", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon004", story_id = "75010111:75010521", story_times = "100:101"}
, 
[51100011] = {id = 51100011, name = (PUtil.get)(85110000, (PUtil.get)(86400011), (PUtil.get)(85110011)), type = 1, stages = "52101101:52101102:52101103:52101104:52101105", open_condition = "72501001:0:22,72504111:52101005:1", pre = 51100010, next = "51100012", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon007", story_id = "75011111", story_times = "100"}
, 
[51100012] = {id = 51100012, name = (PUtil.get)(85110000, (PUtil.get)(86400012), (PUtil.get)(85110012)), type = 1, stages = "52101201:52101202:52101203:52101204:52101205", open_condition = "72501001:0:24,72504111:52101105:1", pre = 51100011, next = "51100013", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon005", story_id = "75012111:75012521", story_times = "100:101"}
, 
[51100013] = {id = 51100013, name = (PUtil.get)(85110000, (PUtil.get)(86400013), (PUtil.get)(85110013)), type = 1, stages = "52101301:52101302:52101303:52101304:52101305", open_condition = "72501001:0:26,72504111:52101205:1", pre = 51100012, next = "51100014", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon002", story_id = "75013111", story_times = "100"}
, 
[51100014] = {id = 51100014, name = (PUtil.get)(85110000, (PUtil.get)(86400014), (PUtil.get)(85110014)), type = 1, stages = "52101401:52101402:52101403:52101404:52101405", open_condition = "72501001:0:28,72504111:52101305:1", pre = 51100013, next = "51100015", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon004", story_id = "75014111:75014521", story_times = "100:101"}
, 
[51100015] = {id = 51100015, name = (PUtil.get)(85110000, (PUtil.get)(86400015), (PUtil.get)(85110015)), type = 1, stages = "52101501:52101502:52101503:52101504:52101505", open_condition = "72501001:0:30,72504111:52101405:1", pre = 51100014, next = "51100016", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon003", story_id = "75015111", story_times = "100"}
, 
[51100016] = {id = 51100016, name = (PUtil.get)(85110000, (PUtil.get)(86400016), (PUtil.get)(85110016)), type = 1, stages = "52101601:52101602:52101603:52101604:52101605", open_condition = "72501001:0:33,72504111:52101505:1", pre = 51100015, next = "51100017", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon006", story_id = "75016111:75016521", story_times = "100:101"}
, 
[51100017] = {id = 51100017, name = (PUtil.get)(85110000, (PUtil.get)(86400017), (PUtil.get)(85110017)), type = 1, stages = "52101701:52101702:52101703:52101704:52101705", open_condition = "72501001:0:35,72504111:52101605:1", pre = 51100016, next = "51100018", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon005", story_id = "75017111", story_times = "100"}
, 
[51100018] = {id = 51100018, name = (PUtil.get)(85110000, (PUtil.get)(86400018), (PUtil.get)(85110018)), type = 1, stages = "52101801:52101802:52101803:52101804:52101805", open_condition = "72501001:0:38,72504111:52101705:1", pre = 51100017, next = "51100019", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon001", story_id = "75018111", story_times = "100"}
, 
[51100019] = {id = 51100019, name = (PUtil.get)(85110000, (PUtil.get)(86400019), (PUtil.get)(85110019)), type = 1, stages = "52101901:52101902:52101903:52101904:52101905", open_condition = "72501001:0:40,72504111:52101805:1", pre = 51100018, next = "51100020", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon007", story_id = "75019111", story_times = "100"}
, 
[51100020] = {id = 51100020, name = (PUtil.get)(85110000, (PUtil.get)(86400020), (PUtil.get)(85110020)), type = 1, stages = "52102001:52102002:52102003:52102004:52102005", open_condition = "72501001:0:43,72504111:52101905:1", pre = 51100019, next = "51100021", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon002", story_id = "75020111:75020521", story_times = "100:101"}
, 
[51100021] = {id = 51100021, name = (PUtil.get)(85110000, (PUtil.get)(86400021), (PUtil.get)(85110021)), type = 1, stages = "52102101:52102102:52102103:52102104:52102105", open_condition = "72501001:0:45,72504111:52102005:1", pre = 51100020, next = "51100022", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon003", story_id = "75021111", story_times = "100"}
, 
[51100022] = {id = 51100022, name = (PUtil.get)(85110000, (PUtil.get)(86400022), (PUtil.get)(85110022)), type = 1, stages = "52102201:52102202:52102203:52102204:52102205", open_condition = "72501001:0:48,72504111:52102105:1", pre = 51100021, next = "51100023", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon006", story_id = "75022111:75022521:75022522", story_times = "100:101:101"}
, 
[51100023] = {id = 51100023, name = (PUtil.get)(85110000, (PUtil.get)(86400023), (PUtil.get)(85110023)), type = 1, stages = "52102301:52102302:52102303:52102304:52102305", open_condition = "72501001:0:50,72504111:52102205:1", pre = 51100022, next = "51100024", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon002", story_id = "75023111", story_times = "100"}
, 
[51100024] = {id = 51100024, name = (PUtil.get)(85110000, (PUtil.get)(86400024), (PUtil.get)(85110024)), type = 1, stages = "52102401:52102402:52102403:52102404:52102405", open_condition = "72501001:0:52,72504111:52102305:1", pre = 51100023, next = "51100025", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon005", story_id = "75024111:75024521:75024522", story_times = "100:101:101"}
, 
[51100025] = {id = 51100025, name = (PUtil.get)(85110000, (PUtil.get)(86400025), (PUtil.get)(85110025)), type = 1, stages = "52102501:52102502:52102503:52102504:52102505", open_condition = "72501001:0:55,72504111:52102405:1", pre = 51100024, next = "51100026", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon007", story_id = "75025111:75025521", story_times = "100:101"}
, 
[51100026] = {id = 51100026, name = (PUtil.get)(85110000, (PUtil.get)(86400026), (PUtil.get)(85110026)), type = 1, stages = "52102601:52102602:52102603:52102604:52102605", open_condition = "72501001:0:56,72504111:52102505:1", pre = 51100025, next = "51100027", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon004", story_id = "75026111", story_times = "100"}
, 
[51100027] = {id = 51100027, name = (PUtil.get)(85110000, (PUtil.get)(86400027), (PUtil.get)(85110027)), type = 1, stages = "52102701:52102702:52102703:52102704:52102705", open_condition = "72501001:0:57,72504111:52102605:1", pre = 51100026, next = "51100028", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon001", story_id = "75027111", story_times = "100"}
, 
[51100028] = {id = 51100028, name = (PUtil.get)(85110000, (PUtil.get)(86400028), (PUtil.get)(85110028)), type = 1, stages = "52102801:52102802:52102803:52102804:52102805", open_condition = "72501001:0:58,72504111:52102705:1", pre = 51100027, next = "51100029", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon006", story_id = "75028111", story_times = "100"}
, 
[51100029] = {id = 51100029, name = (PUtil.get)(85110000, (PUtil.get)(86400029), (PUtil.get)(85110029)), type = 1, stages = "52102901:52102902:52102903:52102904:52102905", open_condition = "72501001:0:59,72504111:52102805:1", pre = 51100028, next = "51100030", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon001", story_id = "75029111", story_times = "100"}
, 
[51100030] = {id = 51100030, name = (PUtil.get)(85110000, (PUtil.get)(86400030), (PUtil.get)(85110030)), type = 1, stages = "52103001:52103002:52103003:52103004:52103005", open_condition = "72501001:0:60,72504111:52102905:1", pre = 51100029, next = "51100031", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon005", story_id = "75030111:75030521", story_times = "100:101"}
, 
[51100031] = {id = 51100031, name = (PUtil.get)(85110000, (PUtil.get)(86400031), (PUtil.get)(85110031)), type = 1, stages = "52103101:52103102:52103103:52103104:52103105", open_condition = "72501001:0:61,72504111:52103005:1", pre = 51100030, next = "51100032", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon002", story_id = "75031111", story_times = "100"}
, 
[51100032] = {id = 51100032, name = (PUtil.get)(85110000, (PUtil.get)(86400032), (PUtil.get)(85110032)), type = 1, stages = "52103201:52103202:52103203:52103204:52103205", open_condition = "72501001:0:62,72504111:52103105:1", pre = 51100031, next = "51100033", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon007", story_id = "75032111:75032521", story_times = "100:101"}
, 
[51100033] = {id = 51100033, name = (PUtil.get)(85110000, (PUtil.get)(86400033), (PUtil.get)(85110033)), type = 1, stages = "52103301:52103302:52103303:52103304:52103305", open_condition = "72501001:0:63,72504111:52103205:1", pre = 51100032, next = "51100034", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon003", story_id = "75033111:75033521", story_times = "100:101"}
, 
[51100034] = {id = 51100034, name = (PUtil.get)(85110000, (PUtil.get)(86400034), (PUtil.get)(85110034)), type = 1, stages = "52103401:52103402:52103403:52103404:52103405", open_condition = "72501001:0:64,72504111:52103305:1", pre = 51100033, next = "51100035", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon004", story_id = "75034111:75034521", story_times = "100:101"}
, 
[51100035] = {id = 51100035, name = (PUtil.get)(85110000, (PUtil.get)(86400035), (PUtil.get)(85110035)), type = 1, stages = "52103501:52103502:52103503:52103504:52103505", open_condition = "72501001:0:65,72504111:52103405:1", pre = 51100034, next = "51100036", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon002", story_id = "75035111", story_times = "100"}
, 
[51100036] = {id = 51100036, name = (PUtil.get)(85110000, (PUtil.get)(86400036), (PUtil.get)(85110036)), type = 1, stages = "52103601:52103602:52103603:52103604:52103605", open_condition = "72501001:0:66,72504111:52103505:1", pre = 51100035, next = "51100037", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon001", story_id = "75036111:75036521", story_times = "100:101"}
, 
[51100037] = {id = 51100037, name = (PUtil.get)(85110000, (PUtil.get)(86400037), (PUtil.get)(85110037)), type = 1, stages = "52103701:52103702:52103703:52103704:52103705", open_condition = "72501001:0:67,72504111:52103605:1", pre = 51100036, next = "51100038", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon005", story_id = "75037111", story_times = "100"}
, 
[51100038] = {id = 51100038, name = (PUtil.get)(85110000, (PUtil.get)(86400038), (PUtil.get)(85110038)), type = 1, stages = "52103801:52103802:52103803:52103804:52103805", open_condition = "72501001:0:68,72504111:52103705:1", pre = 51100037, next = "51100039", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon007", story_id = "75038111:75038521", story_times = "100:101"}
, 
[51100039] = {id = 51100039, name = (PUtil.get)(85110000, (PUtil.get)(86400039), (PUtil.get)(85110039)), type = 1, stages = "52103901:52103902:52103903:52103904:52103905", open_condition = "72501001:0:69,72504111:52103805:1", pre = 51100038, next = "51100040", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon003", story_id = "75039111", story_times = "100"}
, 
[51100040] = {id = 51100040, name = (PUtil.get)(85110000, (PUtil.get)(86400040), (PUtil.get)(85110040)), type = 1, stages = "52104001:52104002:52104003:52104004:52104005", open_condition = "72501001:0:70,72504111:52103905:1", pre = 51100039, next = "0", activity_id = 0, bg_res = "PlotDungeon:PlotDungeon006", story_id = "75040111:75040521", story_times = "100:101"}
, 
[51200001] = {id = 51200001, name = (PUtil.get)(85120001), type = 2, stages = "52200101:52200102:52200103:52200104:52200105:52200106:52200107:52200108:52200109:52200110", open_condition = "72501001:0:9", pre = 0, next = "51200002", activity_id = 0, bg_res = "HeroDungeon:HeroPlotMap001", book_show = "plot_book001", book_monter_show = "CardSpine_11202001", story_id = "0", story_times = "0"}
, 
[51200002] = {id = 51200002, name = (PUtil.get)(85120002), type = 2, stages = "52200201:52200202:52200203:52200204:52200205:52200206:52200207:52200208:52200209:52200210:52200211:52200212:52200213:52200214:52200215:52200216:52200217:52200218", open_condition = "72501001:0:20,72504211:52200110:1", pre = 51200001, next = "51200003", activity_id = 0, bg_res = "HeroDungeon:HeroPlotMap002", book_show = "plot_book002", book_monter_show = "Cardspine_11300007", story_id = "0", story_times = "0"}
, 
[51200003] = {id = 51200003, name = (PUtil.get)(85120003), type = 2, stages = "52200301:52200302:52200303:52200304:52200305:52200306:52200307:52200308:52200309:52200310:52200311:52200312:52200313:52200314:52200315:52200316:52200317:52200318:52200319:52200320:52200321:52200322:52200323:52200324:52200325:52200326:52200327:52200328:52200329:52200330", open_condition = "72501001:0:32,72504211:52200218:1", pre = 51200002, next = "51200004", activity_id = 0, bg_res = "HeroDungeon:HeroPlotMap003", book_show = "plot_book003", book_monter_show = "Cardspine_11300005", story_id = "0", story_times = "0"}
, 
[51200004] = {id = 51200004, name = (PUtil.get)(85120004), type = 2, stages = "52200401:52200402:52200403:52200404:52200405:52200406:52200407:52200408:52200409:52200410:52200411:52200412:52200413:52200414:52200415:52200416:52200417:52200418:52200419:52200420:52200421:52200422:52200423:52200424:52200425:52200426:52200427", open_condition = "72501001:0:51,72504211:52200330:1", pre = 51200003, next = "51200005", activity_id = 0, bg_res = "HeroDungeon:HeroPlotMap004", book_show = "plot_book001", book_monter_show = "CardSpine_11300002", story_id = "0", story_times = "0"}
, 
[51200005] = {id = 51200005, name = (PUtil.get)(85120005), type = 2, stages = "52200501:52200502:52200503:52200504:52200505:52200506:52200507:52200508:52200509:52200510:52200511:52200512:52200513:52200514:52200515:52200516:52200517:52200518:52200519:52200520:52200521", open_condition = "72501001:0:64,72504211:52200427:1", pre = 51200004, next = "0", activity_id = 0, bg_res = "HeroDungeon:HeroPlotMap005", book_show = "plot_book002", book_monter_show = "CardSpine_11300004", story_id = "0", story_times = "0"}
, 
[51410001] = {id = 51410001, name = (PUtil.get)(85110001), type = 101, stages = "52500101:52500102:52500103:52500104:52500105:52500106:52500107:52500108:52500109:52500110:52500111:52500112:52500113:52500114:52500115", open_condition = "72501001:0:1", pre = 0, next = "51420001", activity_id = 33000101, bg_res = "ActivityDungeon:Map_01", story_id = "0", story_times = "0"}
, 
[51420001] = {id = 51420001, name = (PUtil.get)(85120001), type = 101, stages = "52510101:52510102:52510103:52510104:52510105:52510106", open_condition = "72501001:0:1,72504611:52500105:1", pre = 51410001, next = "0", activity_id = 33000101, bg_res = "ActivityDungeon:Map_01", story_id = "0", story_times = "0"}
}
return BaseChapterData

