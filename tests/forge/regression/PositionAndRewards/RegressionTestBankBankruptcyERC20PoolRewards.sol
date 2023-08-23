// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.18;

import { BucketBankruptcyERC20PoolRewardsInvariants } from "../../invariants/PositionsAndRewards/BucketBankruptcyERC20PoolRewardsInvariants.t.sol";

contract RegressionTestBankBankruptcyERC20PoolRewards is BucketBankruptcyERC20PoolRewardsInvariants { 

    function setUp() public override { 
        super.setUp();
    }

    // Test was failing because token needs to be reapproved for stake after unstaking
    // Fixed with approving token before stake
    function test_regression_position_evm_revert_1() external {
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(3, 1, 4456004777645809093369137635038884732841, 115792089237316195423570985008687907853269984665640564039457584007913129639933, 40687908950166026711192);
    }

    // Test was failing because of unbounded bucket used for `fromBucketIndex`
    // Fixed with bounding `fromBucketIndex`
    function test_regression_max_less_than_min() external {
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(115792089237316195423570985008687907853269984665640564039457584007913129639934, 47501406159061048326781, 110986208267306903569458210414739750843311008184499947884172946209775740554);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(1881514382560036936235, 3, 14814387297039010985037823532);
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(797766346153846154214, 41446531673892822322, 11701, 27835018298679073652989722292632508325056543016077421626954570959368347669749);
    }

    // Test was failing because of incorrect borrower index from borrowers array
    // Fixed with bounding index to use from 0 to `length - 1` instead of `length`
    function test_regression_index_out_of_bounds() external {
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(8350, 38563772714580316601477528168172448197192851223481495804140163882250050756970, 2631419556349366366777984756718, 1211945352);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(211495175470613993028534000000, 278145600165504025408587, 27529661686764881266950946609980959649419024772429123428587103668572353435463);
        _bucketBankruptcyerc20poolrewardsHandler.lenderKickAuction(115792089237316195423570985008687907853269984665640564039457584007913129639932, 6893553321768, 0);
        _bucketBankruptcyerc20poolrewardsHandler.lenderKickAuction(999993651401512530, 102781931937447242982, 270951946802940031780297034197);
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(142908941962660588271918613275457408417799350540, 2, 7499, 21259944100462201457856802765711375950508);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(10312411154, 11741, 808194882698130156430790172156918);

        invariant_positions_PM1_PM2_PM3();
    }

    // Test was failing because of `(((tu + mau102 - 1e18) / 1e9) ** 2)` becoming more than max limit of uint256 due to high debt
    // Fixed with reducing time skipped in setup from 100000 days to 1000 days
    function test_regression_arithmetic_overflow() external {
        _bucketBankruptcyerc20poolrewardsHandler.stake(6896318739925897886189247783689616912, 1590163, 2, 5688123131144312514755107);
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(17317, 82811632090972520860339125222186388174810191857321772017180113650309637681174, 36183411359542968180819498843191329944675962195184522815400173109497640045084, 36183411359542968180819498843191329944675962195184522815400173109497640045125, 19228192993203316367726728173133990710204659);
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(886000000000000, 112677305303603608793464000990919617579761525091244043308691041092632466068329, 3966754565367876880350885451679960164951761383523769778082696271101602, 2039, 952915384615384615824);
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(2849871794357244235869, 3966754565367876879428138587689740691886557263849923988907562808019157, 90722805810612960, 2407, 15129);
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(177039972880383490828179033660932658535136887032468656, 115792089237316195423570985008687907853269984665640564039457584007913129639935, 38713024359055902250662472670480188719905855, 1);
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(1647740717046213962030928987916339867520444123409750393400408, 115792089237316195423570985008687907853269984665640564039457584007913129639935, 92438060068404637120570616271893238026003952273845567189711565754357678, 2, 740729473877833425174185945952031582872090596768955274878);
        _bucketBankruptcyerc20poolrewardsHandler.lenderKickAuction(12280, 100059799535193028234836608013586712161184179292262900980302289180450773349084, 39906399523299059107967942071142446494738195742899699015085450065764556124872);
        _bucketBankruptcyerc20poolrewardsHandler.lenderKickAuction(563808366315521888139814758131568062747410028498, 717762288499217961103026455619904233444784602603, 639614423076923077217);
        _bucketBankruptcyerc20poolrewardsHandler.lenderKickAuction(179970444047069616, 3966754565367876879135983927223377519202887228228036839903452619493402, 4733);
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(7077, 2849871794357244236815, 89565878125998494124776859909564617778044840185111596024548341691824014913081, 67510848143351065130353186739542299459422428500681234436222588824509516955128);
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(345331730769230769391, 1153129030861181662264128353544855947712724763189, 13746, 10698843914281808001296099412637890910894001332208464018741338351061051465914, 100847138996028487776982507526530541183387119239170631100097115978417618128629);
        _bucketBankruptcyerc20poolrewardsHandler.failed();
        _bucketBankruptcyerc20poolrewardsHandler.stake(36183411359542968180819498843191329944675962195184522815400173109497640045129, 48819922315949799267070624682529131378372410957, 4181, 112677305303603608793464000990919617579761525091244043308691041092632466068152);
        _bucketBankruptcyerc20poolrewardsHandler.stake(2244, 995, 58606104743229720510079823024387185916963550951287480571399502469054769761605, 76550499216257555889321112575510855021078684718864441654047861970454785529430);
        _bucketBankruptcyerc20poolrewardsHandler.lenderKickAuction(37559901722735453672500465593449923350885790554902835, 551970007141884604422321369676694640861689485316027729520843135985700546, 47661766323110);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(283600966131550275, 4225, 3054);
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(3305681070264227794977, 74106, 12559999863349, 3, 115792089237316195423570985008687907853269984665640564039457584007913129639933);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(537, 13076, 13358);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(923000000000000, 5118315719793605164353342667742056876611746894854750490526105565680017101203, 66382540837033874);
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(3, 115792089237316195423570985008687907853269984665640564039457584007913129639933, 10266341061973857960018410655132814, 1, 1);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(16522, 24995945723326373875772837096154005408860764913638412228031745013630478857018, 512011103318869781848676);
        _bucketBankruptcyerc20poolrewardsHandler.failed();
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(2, 350590244621993631975269433997674629739798644299962688761173, 1344692490437700114798712237992600701, 11956262);
        _bucketBankruptcyerc20poolrewardsHandler.lenderKickAuction(73624586998592616701514720900276129068340183692521862970378800053138201630477, 68710165003106503923300701473932010517182965684103004549833568373358389724401, 71800436766229664078026657500885479541081649751618083508801195706457245577220);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(9453, 19205, 66868048033817959774686748497699809781406078236372444649234275513206538861672);
        _bucketBankruptcyerc20poolrewardsHandler.stake(8925811310805445351997878058708827307181477404039834765939848102762107933524, 15396, 333333333333333335, 112677305303603608793464000990919617579761525091244043308691041092632466067970);
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(49354806076664609737639320143283225715325929918170457855370734498987169336, 0, 0, 224207154149060304368571539032, 115792089237316195423570985008687907853269984665640564039457584007913129639932);
        _bucketBankruptcyerc20poolrewardsHandler.stake(115792089237316195423570985008687907853269984665640564039457584007913129639934, 1238008048, 115792089237316195423570985008687907853269984665640564039457584007913129639934, 2169063360537137360112800101939791654946494300546407780004241577631164);
        _bucketBankruptcyerc20poolrewardsHandler.stake(115792089237316195423570985008687907853269984665640564039457584007913129639934, 2345851545937962757778643762496267029085540856037776148147808038944642, 5957091736115285211, 27985731991685908798232634683132989817806071982114803741897441260168560867);
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(3, 1, 770986253285442867064880897583817379708, 92781664698833630287489852236611504234525413121274842462364219872);
        _bucketBankruptcyerc20poolrewardsHandler.stake(1594, 107191883964854757344296271860238969622927688664914404668659378108385854836026, 3966754565367876873370423057737583368405849023294119111275034969686468, 19958575429898560154085169419221224945725333143564312471139253950974388039284);
        _bucketBankruptcyerc20poolrewardsHandler.lenderKickAuction(115792089237316195423570985008687907853269984665640564039457584007913129639932, 1, 2);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(77052356306827782713422247930543027861392973120644625016, 1798476982980588193703723436375810811222069733299353125141863312, 1098297152145905559672257161091692);
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(2, 342041592964680825954896142059203952628580209831935619634002805536, 39846960399867003370202173839379955192, 822343706632112, 3);
        _bucketBankruptcyerc20poolrewardsHandler.stake(7984294068074609994912921437324, 7838, 15189, 175000000000000);
        _bucketBankruptcyerc20poolrewardsHandler.stake(24962334191555090884200901697709326249765046066909050188293351411730598993973, 2147483648, 393502552471956099440181996575832631444286908472, 14802);
        _bucketBankruptcyerc20poolrewardsHandler.stake(7256, 929000000000000, 675412562135798344425486121401750, 13510);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(109677534373829370582420891034109789248617180581764663703953628089987520264326, 2573764082904, 2908);
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(0, 115792089237316195423570985008687907853269984665640564039457584007913129639935, 115792089237316195423570985008687907853269984665640564039457584007913129639934, 115792089237316195423570985008687907853269984665640564039457584007913129639935, 115792089237316195423570985008687907853269984665640564039457584007913129639933);
        _bucketBankruptcyerc20poolrewardsHandler.failed();
        _bucketBankruptcyerc20poolrewardsHandler.failed();
        _bucketBankruptcyerc20poolrewardsHandler.stake(1587, 11728, 20371, 1761736553);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(2849871794357244224888, 21613,36183411359542968180819498843191329944675962195184522815400173109497640045063);
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(115792089237316195423570985008687907853269984665640564039457584007913129639933, 7816592721461, 547796365072063422163463132831470635072549324118139340225274709, 23239411057593528819373457684352214287995257450694130149326937362);
        _bucketBankruptcyerc20poolrewardsHandler.failed();
        _bucketBankruptcyerc20poolrewardsHandler.lenderKickAuction(601672641157204830463731144581, 1, 10);
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(0, 1, 115792089237316195423570985008687907853269984665640564039457584007913129639935, 3844156373059697976150225328289758, 21067959307417482890549604370787421964344610209838270154238906991002);
        _bucketBankruptcyerc20poolrewardsHandler.failed();
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(68710165003106503923300701473932010517182965684103004549833568373358389724401, 36183411359542968180819498843191329944675962195184522815400173109497640044952, 27681604022032244008232927876918610662012006233608617573888982434118344074872);
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(115792089237316195423570985008687907853269984665640564039457584007913129639932, 546249949564771975556206661259711240, 2, 198775369677794427185735801472315926769782965724);
        _bucketBankruptcyerc20poolrewardsHandler.stake(500000000000001, 112677305303603608793464000990919617579761525091244043308691041092632466068117, 7746, 917812924747606707090506589076440198415899010589);
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(47390443050477, 2, 24907716377757111202952223651177368542, 99036046654470658779217472134, 223412317271864254);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(584150118814135535797598359987484192650707686887, 4759, 27314416541679884417682362568089041974037272849399973641581125802989563555875);
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(2849871794357244244015, 264054995773979190, 447, 451433653846153846362, 9648);
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(21050, 7775694,154085490025371729225110012928624230180770264485398324359658277233, 57927770334825);
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(27314416541679884417682362568089041974037272849399973641581125802989563556154, 741712500000000000341, 102395000692947319608275989700597991885819255417485385121140134029182011063769, 12630);
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(0, 115792089237316195423570985008687907853269984665640564039457584007913129639933, 3, 440744070881956564449467649, 115792089237316195423570985008687907853269984665640564039457584007913129639934);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(10000000000000000000000000001, 740, 7258);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(88726916073212290156777326422200, 115792089237316195423570985008687907853269984665640564039457584007913129639935, 34199279288);
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(17214, 73384897344814417155958327430359004483378729061591027007351093540094357466111, 51206296630672440992795321509376579418034509656975184376065889683943438593770, 5884, 8262);
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(2044562291296528291030625278429523218566755073094910438325803240354, 1, 15304323218114486738795227081682471, 19829306);
        _bucketBankruptcyerc20poolrewardsHandler.lenderKickAuction(115792089237316195423570985008687907853269984665640564039457584007913129639934, 124837474259495102675939548974323950, 329054301975170069286574921653462268546056642575848355092114042163);
        _bucketBankruptcyerc20poolrewardsHandler.stake(199147622511101623, 789000000000001,231, 33101730025310197535578397667035503858659584593443933073973462411188265487645);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(32357, 162121775210335745176768462891133518974, 2);
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(3, 235172445463430520134164649932838126511768787911883505, 2, 115792089237316195423570985008687907853269984665640564039457584007913129639934, 1);
        _bucketBankruptcyerc20poolrewardsHandler.failed();
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(115792089237316195423570985008687907853269984665640564039457584007913129639934, 0, 115792089237316195423570985008687907853269984665640564039457584007913129639933, 8556272701020798093908796721428703862785571616320106889880411706632, 898342879931592588219);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(6871437890782, 22722437225746852199549, 115792089237316195423570985008687907853269984665640564039457584007913129639932);
        _bucketBankruptcyerc20poolrewardsHandler.failed();
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(115792089237316195423570985008687907853269984665640564039457584007913129639932, 115792089237316195423570985008687907853269984665640564039457584007913129639932, 2, 49335930053431267338133128938678, 12312700374952538413699663457513300906362172890995955163025450435265437519460);
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(115792089237316195423570985008687907853269984665640564039457584007913129639935, 115792089237316195423570985008687907853269984665640564039457584007913129639932, 867997253226679023134472172637178866960140585025356872075477020, 115792089237316195423570985008687907853269984665640564039457584007913129639935);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(14195, 4120126606, 892000000000001);
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(53143361220254641097319023834726093633429636617299696, 0, 115792089237316195423570985008687907853269984665640564039457584007913129639932, 115792089237316195423570985008687907853269984665640564039457584007913129639932, 3008666890405061958087053360596855);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(2849871794357244241734, 7376, 4733);
        _bucketBankruptcyerc20poolrewardsHandler.stake(491801577241747986710629564741072784295090200116, 4666, 336338206907638295, 3966754565367876869122227334475572820434993478726803479380549997488878);
        _bucketBankruptcyerc20poolrewardsHandler.failed();
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(588, 9789, 5083);
        _bucketBankruptcyerc20poolrewardsHandler.failed();
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(975573743, 2, 7486511129908263831530464268126, 115792089237316195423570985008687907853269984665640564039457584007913129639933);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(115792089237316195423570985008687907853269984665640564039457584007913129639932, 408377816173582479794442004131690473732206230537105633285620578233, 0);
        _bucketBankruptcyerc20poolrewardsHandler.stake(115792089237316195423570985008687907853269984665640564039457584007913129639932, 115792089237316195423570985008687907853269984665640564039457584007913129639934, 3193830813357417, 240);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(0, 115792089237316195423570985008687907853269984665640564039457584007913129639934, 115792089237316195423570985008687907853269984665640564039457584007913129639933);
        _bucketBankruptcyerc20poolrewardsHandler.lenderKickAuction(234667819334761949964119092206494130890231852099316545331, 11931498178817218152978210620161711035796631751178664213653196, 6840034619969503616899963423366754377629584809987338693684203);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(0, 1, 2823373119980992364828421558687377775878598015914019948);
        _bucketBankruptcyerc20poolrewardsHandler.failed();
        _bucketBankruptcyerc20poolrewardsHandler.failed();
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(63937, 16773945002237412540693101797847272493598737453594325081026067588528, 115792089237316195423570985008687907853269984665640564039457584007913129639934);
    }
    
}


contract RegressionTestBankBankruptcyERC20PoolRewardsWith12QuotePrecision is BucketBankruptcyERC20PoolRewardsInvariants { 

    function setUp() public override {
        // failures repoduces with Quote Precision 12
        vm.setEnv("QUOTE_PRECISION", "12");
        super.setUp();
    }

    // Test was failing because of `(((tu + mau102 - 1e18) / 1e9) ** 2)` becoming more than max limit of uint256 due to high debt
    // Fixed with reducing time skipped in setup from 100000 days to 1000 days
    function test_regression_arithmetic_overflow() external {
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(3966754565367876882011475305970374373581843216523327606696944469982560, 23951, 27342775513801048612025508136217148135354231891871249189205419889059958895920, 5764);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(115792089237316195423570985008687907853269984665640564039457584007913129639935, 115792089237316195423570985008687907853269984665640564039457584007913129639933, 277955739357896056509186172170724926307041);
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(115792089237316195423570985008687907853269984665640564039457584007913129639934, 1410631634716305975327239311667501746230064938363700, 165627380598340247145446842744163, 3, 115792089237316195423570985008687907853269984665640564039457584007913129639933);
        _bucketBankruptcyerc20poolrewardsHandler.lenderKickAuction(19, 2530080042266327931552762435318905970448414613174692360332206645244, 1);
        _bucketBankruptcyerc20poolrewardsHandler.stake(8666801014510249463714719779804008890723512, 1,83443108184118454880135593969467466093223604269, 15883848302414522401895);
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(12882, 7777, 6629, 97879245264338194306861131699634660522218295410970784557138028426270717400370, 8368);
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(13483626428470537411264656142812, 3, 43261357659, 115792089237316195423570985008687907853269984665640564039457584007913129639934, 1388408991433152321764177891234838153250463504820877);
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(1, 2, 20563013357962289806221756347401611786110937543040356031901156, 447919006151828756764428252561915147896770196082188602773330761, 798396599462289786815989310634148690896897281016819117397861);
        _bucketBankruptcyerc20poolrewardsHandler.lenderKickAuction(92248702659654157400825310446726854110696903499169410212619700758795452822, 37604, 3);
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(3966754565367876873053743387718720534708426719378234395015112294331820, 1891, 6354, 6407738580936730947617400026186481015907031668070029619638042254901247);
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(155528622244088217616721520914751415058731841773, 115792089237316195423570985008687907853269984665640564039457584007913129639933, 517704163087, 288990527056564619478);
        _bucketBankruptcyerc20poolrewardsHandler.stake(0, 103562875210896097905879456787026624674683989786414355636238913207580190275, 4449509262329152679, 2);
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(115792089237316195423570985008687907853269984665640564039457584007913129639932, 115792089237316195423570985008687907853269984665640564039457584007913129639933, 115792089237316195423570985008687907853269984665640564039457584007913129639933, 0, 1);
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(12789, 516496153846153846391, 1373, 2432);
        _bucketBankruptcyerc20poolrewardsHandler.stake(17298, 2520288506, 3966754565367876862909903626043389090569250934025238262077644133072068, 70048973491614882813651882306278555733916041147);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(14730549569217254337324272971273439639, 10712676910574077307719914120290505539758384452430355043102986598551, 25861299350166086615951335);
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(19490, 3145, 100958019455552403241513419952879830954846771871560814580751995001715468196982, 4320);
        _bucketBankruptcyerc20poolrewardsHandler.lenderKickAuction(18380078816620787637106444195826167006943,9105121993717164823200252859, 39582079114752207760062142810162);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(102938198731890455483, 3, 52050632211266);
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(500, 924977286184975233873859450789056758036024240832241462431898388643636693224, 232003688276085664164189481417956820170145390, 504095117088782794907830496954549563124074003355);
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(10009, 522, 229781691635202364607605263483, 13964, 6303);
        _bucketBankruptcyerc20poolrewardsHandler.lenderKickAuction(2585532, 30263717, 295729539);
        _bucketBankruptcyerc20poolrewardsHandler.lenderKickAuction(1984, 4652, 2725046678043704335544);
        _bucketBankruptcyerc20poolrewardsHandler.lenderKickAuction(349, 10557, 401731786528032649302150062457257044539448918705);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(94291391897249807881798731698058020996506531563934658123907732088334042997896, 1683, 922886538461538461965);
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(115792089237316195423570985008687907853269984665640564039457584007913129639935, 3, 115792089237316195423570985008687907853269984665640564039457584007913129639934, 5009532820319301678432792599939739);
        _bucketBankruptcyerc20poolrewardsHandler.lenderKickAuction(1368179552630450116, 115792089237316195423570985008687907853269984665640564039457584007913129639933, 34412996693170762789699607283878930530798448071823276400203849362089566);
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(30743674041281512912789390937090188969141866220723941124963519834291052939594, 3966754565367876873053743387718720534708426719378234395015112294331821, 3693, 199999999999999999999);
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(2849871794357244233297, 5729, 9436, 3966754565367876848917250723019599313865029386375836114489444464347617);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(13336, 751722115384615384961, 79902525729132112172182628727403585636031841353378040928728196869469094823677);
        _bucketBankruptcyerc20poolrewardsHandler.lenderKickAuction(11848, 88935689212870099548894352559477176008817225920440919577532104643626259385686, 1626);
        _bucketBankruptcyerc20poolrewardsHandler.lenderKickAuction(58606104743229720510079823024387185916963550951287480571399502469054769761570, 15156, 216879045993470961471641212581);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(115792089237316195423570985008687907853269984665640564039457584007913129639934, 115792089237316195423570985008687907853269984665640564039457584007913129639934, 883524181985928268306667951943684061963202522679192596148943284885177111);
        _bucketBankruptcyerc20poolrewardsHandler.failed();
        _bucketBankruptcyerc20poolrewardsHandler.failed();
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(2924, 15953431440961698465116049405554517352474802910093790483384259164665308441857, 11379, 3966754565367876865848146090991267689838419410304387485907095558443874);
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(30743674041281512912789390937090188969141866220723941124963519834291052939594, 24095571472578277997716226198122273937443180744573574132530939729041516935842, 3966754565367876862304666055471450811092813038866066209363567991707702, 938000000000000000001);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(194697860333279706454142791011527465766470841248150462925425546902865792, 10918718947124557284093286805184333760565060406738006519481479722466762779012, 168468217510963482200654846013032790275226);
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(58347301615953207705596250146, 115792089237316195423570985008687907853269984665640564039457584007913129639934, 3, 0, 115792089237316195423570985008687907853269984665640564039457584007913129639935);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(115792089237316195423570985008687907853269984665640564039457584007913129639935, 940844563678598855758006578093833226886661828778784869140315469182111914414, 319314552411346300225910579);
        _bucketBankruptcyerc20poolrewardsHandler.stake(112677305303603608793464000990919617579761525091244043308691041092632466067904, 9141, 76550499216257555889321112575510855021078684718864441654047861970454785529449, 90156338318561149845207557102717525639219958457419849688382040762167829323088);
        _bucketBankruptcyerc20poolrewardsHandler.stake(485466346153846154070, 4047, 41236831521177614171812965194954188943377267884762881554238952423602296083644, 748928859761915073403783232409846872252823377512);
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(1842, 814000000000000000000, 7386, 8949, 41793232874593872983939891402504271449042722654854023829157932315219071622588);
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(112677305303603608793464000990919617579761525091244043308691041092632466068159, 2849871794357244244502, 104081267022762746751665747606660, 71229933733954908637545747917262425351075939551041697044067017386326458518973);
        _bucketBankruptcyerc20poolrewardsHandler.failed();
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(24517088812426303533366187430638951177066673723059003443596328868588485096503, 58606104743229720510079823024387185916963550951287480571399502469054769761351, 64416168674241980143640578666243527631773805575549605444878358964770079875198, 857, 1500);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(3626, 88054211744890545047854682720362692474121698843596563640244510813389729172929, 1428317552094315315517906204753391481814958706674);
        _bucketBankruptcyerc20poolrewardsHandler.lenderKickAuction(5152, 1112, 114255409676579882224300171557671234047763533365509370065937802142537610636077);
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(115792089237316195423570985008687907853269984665640564039457584007913129639934, 418054629776517004596675, 3, 1, 35279645324127465272326759608);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(6728, 82093671015361185348901971732692156706718930259320396354351606002076191819315, 956999999999999999999);
        _bucketBankruptcyerc20poolrewardsHandler.lenderKickAuction(35118430032806250297491677757753828041611787435033927125054378068651577059830, 6369317236171228082814892, 7387);
        _bucketBankruptcyerc20poolrewardsHandler.stake(11817, 9275, 5385, 1207369317);
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(51953396903491667884348938599208174393962381719940333807794356892097124201559, 684, 10657, 76550499216257555889321112575510855021078684718864441654047861970454785529116);
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(115792089237316195423570985008687907853269984665640564039457584007913129639934, 2, 1, 148281571130219420965533181191380429225208794627, 0);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(1, 4239153815896722593765078521373119840402276014176812838, 322);
        _bucketBankruptcyerc20poolrewardsHandler.failed();
        _bucketBankruptcyerc20poolrewardsHandler.stake(5832, 114325486997113895, 25771513998157767631206, 58606104743229720510079823024387185916963550951287480571399502469054769761640);
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(115792089237316195423570985008687907853269984665640564039457584007913129639932, 115792089237316195423570985008687907853269984665640564039457584007913129639934, 1, 206482);
        _bucketBankruptcyerc20poolrewardsHandler.stake(7927883901223247210108134121974524593936498558593831315905690, 1021983417944036249199635837038396943666727341096303405788220, 767087832347197496171017453170, 115792089237316195423570985008687907853269984665640564039457584007913129639934);
        _bucketBankruptcyerc20poolrewardsHandler.stake(115792089237316195423570985008687907853269984665640564039457584007913129639933, 115792089237316195423570985008687907853269984665640564039457584007913129639933, 1, 2874117576384309917899907813356673917244578826423882407945693049513858301);
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(115792089237316195423570985008687907853269984665640564039457584007913129639932, 1, 115792089237316195423570985008687907853269984665640564039457584007913129639935, 513981014459270617692452615619057434252871630198349563427);
        _bucketBankruptcyerc20poolrewardsHandler.failed();
        _bucketBankruptcyerc20poolrewardsHandler.lenderKickAuction(6300000000000042791841612, 19286837295908603553266787544912289890662357020459285979135247069961616838694, 6000000000000000001214045);
        _bucketBankruptcyerc20poolrewardsHandler.stake(3, 582489990557683665156778587139, 3, 115792089237316195423570985008687907853269984665640564039457584007913129639934);
        _bucketBankruptcyerc20poolrewardsHandler.lenderKickAuction(3, 0, 35168320991909411639035941130092257126013094953);
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(14813, 37985565034524940, 2145, 20082);
        _bucketBankruptcyerc20poolrewardsHandler.stake(4709, 27314416541679884417682362568089041974037272849399973641581125802989563556408, 12840, 12086);
        _bucketBankruptcyerc20poolrewardsHandler.stake(69038858858407874287609809184671540840387410961394619992844383524920134424318, 36183411359542968180819498843191329944675962195184522815400173109497640044724, 3966754565367876866196088114064796746224277022091850411132522280259220, 12791511181959941491752949292075057207018412420834161138452224935883231372655);
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(18192533247055195113309035583539, 1, 328582664058452398603332112189467575863731833506487867823485836, 4602471638333068831301900889260476934074379204208975, 115792089237316195423570985008687907853269984665640564039457584007913129639932);
        _bucketBankruptcyerc20poolrewardsHandler.stake(0, 115792089237316195423570985008687907853269984665640564039457584007913129639935, 56337316561494319009393836013630587683761391839374494258944738437916245958839, 2640259112854475455524369794554852490061268235127682838018933103811);
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(5492450293033381591765430790693418, 137254969503698002491565595388909, 0, 20988469343989249870821526948977277703231799942855);
        _bucketBankruptcyerc20poolrewardsHandler.failed();
        _bucketBankruptcyerc20poolrewardsHandler.failed();
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(3349, 9610, 76550499216257555889321112575510855021078684718864441654047861970454785529360, 82356314548626890097785557483647633355000630013025733579942984190419831216102);
        _bucketBankruptcyerc20poolrewardsHandler.moveQuoteTokenToLowerBucket(115792089237316195423570985008687907853269984665640564039457584007913129639935, 2, 3, 114146396809673629522339599);
        _bucketBankruptcyerc20poolrewardsHandler.lenderKickAuction(115792089237316195423570985008687907853269984665640564039457584007913129639934, 126618531077782339112782240609126751547958141385, 115792089237316195423570985008687907853269984665640564039457584007913129639934);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(115792089237316195423570985008687907853269984665640564039457584007913129639934, 3, 115792089237316195423570985008687907853269984665640564039457584007913129639934);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(3, 115792089237316195423570985008687907853269984665640564039457584007913129639933, 115792089237316195423570985008687907853269984665640564039457584007913129639933);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(115792089237316195423570985008687907853269984665640564039457584007913129639932, 0, 12162819707221123631400623212);
        _bucketBankruptcyerc20poolrewardsHandler.stake(105121213529450126323853881532755536544144710500048612197500352815038325229734, 112677305303603608793464000990919617579761525091244043308691041092632466068251, 293033093642118704626758970120533267875914812703, 371788002);
        _bucketBankruptcyerc20poolrewardsHandler.lenderKickAuction(115792089237316195423570985008687907853269984665640564039457584007913129639933, 0, 20429554514719932257185316611193961084030832868502);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(676552018761914467, 115792089237316195423570985008687907853269984665640564039457584007913129639932, 59118278259681);
        _bucketBankruptcyerc20poolrewardsHandler.moveStakedLiquidity(2156, 7545246309671992862734104294126293323679086381417630106133956125163420559268, 4364969487729155111838774393422, 132396289780528671, 8264);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(112677305303603608793464000990919617579761525091244043308691041092632466068059, 2082, 14781);
        _bucketBankruptcyerc20poolrewardsHandler.failed();
        _bucketBankruptcyerc20poolrewardsHandler.lenderKickAuction(337194160126177136918766792240, 3, 1313730499206179905094243898173812338722150955516328682874207);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(115792089237316195423570985008687907853269984665640564039457584007913129639933, 2, 0);
        _bucketBankruptcyerc20poolrewardsHandler.lenderKickAuction(471865840740346309280830746508987758285335124696, 13021983620616879922120557237553195351332782342710477424375088385066717568307, 436588081726929394630979089567144071868327424332);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(17374180793863161866451563901603790046833465309545825925601, 115792089237316195423570985008687907853269984665640564039457584007913129639935, 855794879660868210624);
        _bucketBankruptcyerc20poolrewardsHandler.takeOrSettleAuction(0, 115792089237316195423570985008687907853269984665640564039457584007913129639933, 439349802057718495654968534586028);
    }

}