import 'package:mmc/bean/master_class_entity.dart';
import 'package:mmc/bean/master_class_videos_entity.dart';

class MasterData{
  static List<String> category = ["Free Education","Paid Education","tuition","study material"];

  static Map<String,List<MasterClassEntity>> masterData = {
    "Free Education": [
      MasterClassEntity(
        title: "90天企业危机处理",
        poster: "https://drive.google.com/file/d/1VMAG6EPMFCg-qNeC15mgFBKLLXYBAe_A/view?usp=sharing",
        introduction: "90天企业危机处理18道问题，Adrian Wee老师为你的企业把脉！在短短90天内，有效解决企业危机。。销售、营销、团队，甚至是内部经济，都能一一迎刃而解",
        type: 1,
        videos: [
          MasterClassVideosEntity(
            title: "90天企业危机处理 Q1",
            url: "https://youtu.be/UqVkH1ftIjg?list=PL8ctfChTZiKo2qhFeW6WETbvXWLD6Mn8U"
          ),
          MasterClassVideosEntity(
              title: "90天企业危机处理 Q1 b",
              url: "https://www.youtube.com/watch?v=qiu2IWBccoA&list=PL8ctfChTZiKo2qhFeW6WETbvXWLD6Mn8U&index=20"
          ),
          MasterClassVideosEntity(
              title: "90天企业危机处理 Q2",
              url: "https://www.youtube.com/watch?v=oVYFLe9DEek&list=PL8ctfChTZiKo2qhFeW6WETbvXWLD6Mn8U&index=18"
          ),
          MasterClassVideosEntity(
              title: "90天企业危机处理 Q3",
              url: "https://www.youtube.com/watch?v=VtgmQ9wu17A&list=PL8ctfChTZiKo2qhFeW6WETbvXWLD6Mn8U&index=16"
          )
        ],
      ),
      MasterClassEntity(
        title: "Business 911",
        poster: "https://drive.google.com/file/d/1k94uoKCFOWDD4Z4M2Oe-obS4JlhQoRFS/view?usp=sharing",
        introduction: "SiiFoo Adrian Wee为现场Call in 学生指导企业、事业或生意难题。",
        type: 1,
        videos: [
          MasterClassVideosEntity(
              title: "LIVE: Business 911",
              url: "https://www.youtube.com/watch?v=i81714igUB4&list=PL8ctfChTZiKrgensW_Wmapx5ky9wNiBwb&index=2"
          )
        ]
      ),
      MasterClassEntity(
          title: "MMM",
          poster: "https://drive.google.com/file/d/1KBrDILDYczBCVxv62ZSBXqkXr0ewrFgb/view?usp=sharing",
          introduction: "做生意，到底什么时候才是个句点？ 《精通商企模式2。0》 亚洲唯一结合营销、销售和人才模式的商企教育，以最稳固的商企根基应万变的危机！ 营销模式 在茫茫人海中，顾客为什么会找上你，你有什么比同行更优秀呢？ 7大模式，让你的营销事半功倍，精通其一就让你更为特出！ 销售模式 盈利是由产品和市场的结合所带来的成果，怎么样才能打造一个让人“无法拒绝”的产品呢？ 3大模式，让顾客不止一次跟你产生交易，还会主动带入更多的客源，让生意额节节上升。 人才模式 打造战斗团队，一个团队如果全部一定要具备“冲锋”和“后盾＂, 领导人该如何精准地布局，让每个人都能把潜能发挥得淋漓至尽！ 用人类行为科学，打造属于你的成功方程式！ 。",
          type: 1,
          videos: [
            MasterClassVideosEntity(
                title: "5 Hours MMM",
                url: "https://youtu.be/5ii5gQ1RhuQ"
            )
          ]
      ),
      MasterClassEntity(
          title: "O2O",
          poster: "https://drive.google.com/file/d/1-5htmVxOtpi1YAzZXMx6dH5bb3tZqH8s/view?usp=sharing",
          introduction: "O2O 盈利大会 “线下传统业务变得非常具有挑战性。立即前往#ONLINE 并获得奖励” Adrian Wee老师带你发掘线上生意模式，帮你的生意转型。 8大支柱包含： - O2O 探讨整合流程 - O2O 系统整合 - O2O 品牌整合 - O2O 内容与媒体整合 -O2O 营销与销售整合 （上） - O2O 营销与销售整合 （下） - O2O 团体与管理整合 - O2O 生意模式整合",
          type: 1,
          videos: [
            MasterClassVideosEntity(
                title: "O2O - Session 1",
                url: "https://www.youtube.com/watch?v=r978RUwAv6c&list=PL8ctfChTZiKo-4FBZHmoEwJznX6F_WiqT&index=46"
            ),
            MasterClassVideosEntity(
                title: "O2O - Session 2",
                url: "https://www.youtube.com/watch?v=515GoIt2Y1Q&list=PL8ctfChTZiKo-4FBZHmoEwJznX6F_WiqT&index=45&t=2758s"
            ),
            MasterClassVideosEntity(
                title: "O2O - Session 3",
                url: "https://www.youtube.com/watch?v=XnCssBURNHY&list=PL8ctfChTZiKo-4FBZHmoEwJznX6F_WiqT&index=44&t=929s"
            ),
            MasterClassVideosEntity(
                title: "O2O - Session 3 Part 2",
                url: "https://www.youtube.com/watch?v=zpHXHx6vNq8&list=PL8ctfChTZiKo-4FBZHmoEwJznX6F_WiqT&index=2&t=26s"
            ),
            MasterClassVideosEntity(
                title: "O2O - Session 7",
                url: "https://www.youtube.com/watch?v=Hc8swRcimC4&list=PL8ctfChTZiKo-4FBZHmoEwJznX6F_WiqT&index=21"
            )
          ]
      ),
      MasterClassEntity(
          title: "Talent DNA",
          poster: "https://drive.google.com/file/d/1wrcy4NyC07vuqRg3LLM58KJ6SgEhAYmn/view?usp=sharing",
          introduction: "DNA DISC “我们最大的资产就是我们的人” 我们如何把合适的人放在合适的位置上？我们如何释放他们的潜力？我们如何为团队找到合适的人选？ 团队领导者不断地一次又一次地问这些问题，以评估他们的员工队伍。不用再烦恼了，因为我们向您展示了一个人才突破公式，它将确保您以高生产率释放团队的真正潜力。准备好探索如何建立沟通桥梁，以更有效地作为团队合作。 业内的每个人都应该探索这个系列，因为您最终会很好地掌握自己的真正才能，并朝着更“满足、充实和快乐”的方向努力！ 加入我们，让您或您的团队成员重新获得资本，因为我们带来了人力资本发展的振兴前景，并踏上了发现自己真正潜力的旅程。",
          type: 1,
          videos: [
            MasterClassVideosEntity(
                title: "Intro to DISC",
                url: "https://www.youtube.com/watch?v=h_B2ZylH61Y&list=PL8ctfChTZiKozqRKnJzrVlKkdY1EAhB0u&index=1"
            ),
            MasterClassVideosEntity(
                title: "D Dominance",
                url: "https://www.youtube.com/watch?v=TJ7JBiq45oo&list=PL8ctfChTZiKozqRKnJzrVlKkdY1EAhB0u&index=2"
            ),
            MasterClassVideosEntity(
                title: "I Influence",
                url: "https://www.youtube.com/watch?v=uce_wzEKBQs&list=PL8ctfChTZiKozqRKnJzrVlKkdY1EAhB0u&index=3"
            ),
            MasterClassVideosEntity(
                title: "S Steadiness",
                url: "https://www.youtube.com/watch?v=zi32zmMveOQ&list=PL8ctfChTZiKozqRKnJzrVlKkdY1EAhB0u&index=4"
            ),
            MasterClassVideosEntity(
                title: "C Compliance",
                url: "https://www.youtube.com/watch?v=stCgvMO9BEQ&list=PL8ctfChTZiKozqRKnJzrVlKkdY1EAhB0u&index=5"
            )
          ]
      ),
    ],
    "Paid Education":[
      MasterClassEntity(
          title: "富债为王",
          poster: "https://drive.google.com/file/d/1Aw5942JkD4x1eBfqgxUj5V9Gh8xHRc99/view?usp=sharing",
          type: 2,
      ),
      MasterClassEntity(
        title: "财富为王",
        poster: "https://drive.google.com/file/d/1Aw5942JkD4x1eBfqgxUj5V9Gh8xHRc99/view?usp=sharing",
        type: 2,
      ),
      MasterClassEntity(
        title: "人才为王",
        poster: "https://drive.google.com/file/d/1Aw5942JkD4x1eBfqgxUj5V9Gh8xHRc99/view?usp=sharing",
        type: 2,
      )
    ]
  };

  static Map<String,List<MasterClassEntity>> paid = {
    "富债为王":[
      MasterClassEntity(
          title: "SCICD",
          poster: "https://drive.google.com/file/d/1Aw5942JkD4x1eBfqgxUj5V9Gh8xHRc99/view?usp=sharing",
          introduction: "3天线上课程- SCICD破解收入之秘 升级版【富债为王 5.0】3天线上课程【破解收入之谜】来了！ 该怎么做、做什么，才能符合银行的“胃口”，轻松拿到贷款？ 原来贷款成功过与否，竟然是看这些这么简单，又最 常被忽略的小事。 只送给3天富债为王课程的学生。",
          videos: [],
          type: 1
      ),
      MasterClassEntity(
          title: "Property Deal",
          poster: "https://drive.google.com/file/d/1MNNZSQYtgm6L4bJi10EIQV01eoeU6c3n/view?usp=sharing",
          introduction: "跟着Adrian Wee老师的脚步，一起去找“对的产业”！延续Jalan-Jalan Cari Property 的精神，Adrian Wee老师与团队在寻找房地产的时候，你也有机会随行，现场看房地产之余，还能近距离跟老师学习、还能青烟看着老师如何化腐朽为神奇。",
          type: 1,
          videos: []
      ),
      MasterClassEntity(
          title: "房地产冠军方程式",
          poster: "https://drive.google.com/file/d/1gzofAQ4XW9u_taJLnqI7Bi1YOIRZAkil/view?usp=sharing",
          introduction: "3天线上-房地产冠军方程式 什么是房地产冠军方程式? 买入可以立刻套现50K ++房地产的方式！ 第一天：Ready 准备给3中不同阶段的人，如何策略性以零头期钱， 在3年内轻松赚取至少20万的策略 第二天： Set 哪一种的房地产才适合你？ 每个人都在不同的领域和地点，老师给你一套计算方程式， 让你自己也能轻松评估出最适合你的房地产。 第三天： Go 学习了策略，就是落地的时候了！ 正式购买的时候，Banker 的考量时什么？ 购买前、购买时、购买后要注意什么？很多购屋者 都忽略的细节。。。",
          type: 1,
          videos: []
      ),
      MasterClassEntity(
          title: "3 Hours DWMD 5.0",
          poster: "https://drive.google.com/file/d/10HYAl6dyMmxrbqbZwXMRtu6gSmIVh8f2/view?usp=sharing",
          introduction: "富债为王5.0 - 3小时速成班 课程是关于什么? -如何杠杆别人的时间和金钱，让一个倒闭过4次的人 都有办法再站起来，再房地产找到机会 -如何用一张IC就可以无资本购买房地产 -每个月RM800就可以让你拥有1百万 -面对房地产不再感到压力 -银行的贷款秘密 -不再让父母担心，让他们安享晚年",
          type: 1,
          videos: [
            MasterClassVideosEntity(
                title: "视频",
                url: "https://player.vimeo.com/external/664642565.sd.mp4?s=1183104d8d40aa4b06f7517277903cafc0be3e04&profile_id=165"
            )
          ]
      ),
      MasterClassEntity(
          title: "3 Days DWMD 5.0",
          poster: "https://drive.google.com/file/d/1Rv1yvvmz2pehdkx2HNqIPfOygHPHqvhT/view?usp=sharing",
          introduction: "3天富债为王5.0 【富债为王】课程的内容是教导学生们一切关于债务的课题，让“可怕”的债务，变成“可爱”的债务。 通过这个课程，学生们都清楚知道何为“负债”和“富债”。 “负债”-让人们每天活在恐惧中的债务， 比如说车贷、信用卡、个人贷款、生意贷款等等 “富债”- 日复一日，会为我们带来被动收入的债务，比如说房贷。。。 黄天成老师举列，我们申请车贷； 一辆10万令吉的轿车，贷款的利息是3%,每个月供期是大概1500， 重点是车价是在我们领取车的那一天就立刻降价大概30%。 而房贷就不一样， 一间50万的房地产，贷款利息是4%， 每个月的供日期是2000, 而在通货膨胀的情况下，只要是在对的地方，屋价会在10年后翻倍增涨，这也大大提升屋主的净资产。",
          type: 1,
          videos: [
            MasterClassVideosEntity(
                title: "3 Days DWMD 5.0",
                url: "https://youtu.be/IlDaXOxZQtc"
            )
          ]
      ),
    ],
    "财富为王":[
      MasterClassEntity(
          title: "O2O 盈利大会",
          poster: "https://drive.google.com/file/d/1oWLQ-Twa-lPWEDAgKF9eh-PiBS9XLahs/view?usp=sharing",
          introduction: "一套online生意模式，让你简简单单把产品和服务转到线上、开拓客户群、提升销售额。 一步一步的指导，从设计产品、线上营销策略、销售模式和系统。",
          type: 1,
          videos: [
            MasterClassVideosEntity(
                title: "盈利大会",
                url: "https://player.vimeo.com/external/664654985.sd.mp4?s=453f0e7f7a1901629efea01e7177dcc9eaa755ab&profile_id=165"
            )
          ]
      ),
      MasterClassEntity(
          title: "MMC Platinum Education",
          poster: "https://drive.google.com/file/d/1AyJgzUXK46OGEw075mjy12YICd-ILB0u/view?usp=sharing",
          introduction: "4  Days 3 Nights - Performance Creator Intensive (PCI) 4天三夜-企业商业莫斯 生意的27个基础，倍增生意额的首要条件，这里是专门为每个中小型企业家所设的资料库。 3 Days Workshop - 10X Performance 3天课程 - 10X绩效增长 10倍增收入，倍增减低不必要的花费。这里没有空口说白话，只有最落地和已经被超过100家企业证实的有效方案。 2 Days Workshop - Performance KPI 2天课程 - 关键绩效指标 最难搞的‘人’，这边给你答案！有效倍增工作效率，把人才通通留在身边，减低离职效率，还能省下不必要的费用。",
          type: 1,
          videos: [
            MasterClassVideosEntity(
                title: "盈利大会",
                url: "https://player.vimeo.com/external/664654985.sd.mp4?s=453f0e7f7a1901629efea01e7177dcc9eaa755ab&profile_id=165"
            )
          ]
      ),
      MasterClassEntity(
          title: "7R",
          poster: "https://drive.google.com/file/d/1oBomeJNrLNxIcidSts29B0dopFheRYYU/view?usp=sharing",
          introduction: "主动收入 在3天线上营的第一天，老师和团队就会跟你研讨，怎么样才能巩固你的主动收入，即使你到世界哪个角落都能靠自己赚取薪金 ！ 主动收入讲的像是工作的薪水，只要认真工作，老板每个月发薪水给钱就是主动收入 。 被动收入 在3天线上营的第二天，老师和团队就会跟你分享，被动收入的风险管理，把风险减到最低，同时把利润推到最好 ！ 被动收入是一种只要付出一点努力进行维护，就能定期获得的收入 。 在你完成設置被動收入之後，可能會有一些工作來維持經營 。 组合收入 在线上营的第三天，老师和团队在大家都敲定好自己的主动和被动收入后，就会进入到组合收入，而这一类型的收入的知识非常少见，所以潜能也特别的高 ！ 组合收入又称重复产生的收入 。 利用网络的设定下，不间断提升主动和被动收入，24/7 。",
          type: 1,
          videos: [
            MasterClassVideosEntity(
                title: "7R",
                url: "https://player.vimeo.com/external/664650416.sd.mp4?s=3e9325a7bbee4128f13ffdbab6bf225ab6b42996&profile_id=165"
            )
          ]
      )
    ],
    "人才为王":[
      MasterClassEntity(
          title: "DNA DISC",
          poster: "https://drive.google.com/file/d/1BTEEO7KeWT4dGH4Pn2bS2TiuKoE2jQfg/view?usp=sharing",
          introduction: "3小时打造人与人之间的沟通桥梁，了解人性 一种米养百种人，那我们可以怎么样才能最有效地跟身边的人沟通？ -更有效的沟通 -提升团队留职力 -准确聘请对的人在对的岗位 -提升生产力 -提升销售训练和有效性 -提升管理素质",
          type: 1,
          videos: [
            MasterClassVideosEntity(
                title: "7R",
                url: "https://player.vimeo.com/external/664650416.sd.mp4?s=3e9325a7bbee4128f13ffdbab6bf225ab6b42996&profile_id=165"
            )
          ]
      )
    ]
  };
}