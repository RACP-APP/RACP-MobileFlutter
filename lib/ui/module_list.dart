import 'package:flutter/material.dart';

import 'package:expandable/expandable.dart';
import "package:percent_indicator/circular_percent_indicator.dart";

class ModulesList extends StatelessWidget {
  ModulesList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(height: 58),
      body: ExpandableTheme(
        data:
            const ExpandableThemeData(iconColor: Colors.blue, useInkWell: true),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[Card1(), Card2()],
        ),
      ),
    );
  }
}

class Card1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    buildCollapsed1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "My Classes",
                    style: Theme.of(context).textTheme.body1,
                  ),
                ],
              ),
            ),
          ]);
    }

    buildCollapsed2() {
      return HoriView();
      //buildImg(Colors.lightGreenAccent, 150);
    }

    buildCollapsed3() {
      return Container();
    }

    buildExpanded1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "My Classes",
                    style: Theme.of(context).textTheme.body1,
                  ),
                  Text(
                    "Get back straight to where you left!",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
          ]);
    }

    buildExpanded2() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new CircularPercentIndicator(
                radius: 120.0,
                lineWidth: 13.0,
                animation: true,
                animationDuration: 1200,
                percent: 0.3,
                center: new Text(
                  "30.0%",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                footer: new Text(
                  "Over All Prpgress",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.lightBlue,
              ),
            ],
          ),
        ],
      );
    }

    buildExpanded3() {
      return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            VerticalView(true),
            //VeView(),
          ],
        ),
      );
    }

    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: ScrollOnExpand(
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expandable(
                  collapsed: buildCollapsed1(),
                  expanded: buildExpanded1(),
                ),
                Expandable(
                  collapsed: buildCollapsed2(),
                  expanded: buildExpanded2(),
                ),
                Expandable(
                  collapsed: buildCollapsed3(),
                  expanded: buildExpanded3(),
                ),
                Divider(
                  height: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Builder(
                      builder: (context) {
                        var controller = ExpandableController.of(context);
                        return FlatButton(
                          child: Text(
                            controller.expanded ? "COLLAPSE" : "EXPAND",
                            style: Theme.of(context)
                                .textTheme
                                .button
                                .copyWith(color: Colors.deepPurple),
                          ),
                          onPressed: () {
                            controller.toggle();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Card2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    buildCollapsed1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "All available Classes",
                    style: Theme.of(context).textTheme.body1,
                  ),
                ],
              ),
            ),
          ]);
    }

    buildCollapsed2() {
      return HoriView();
      //buildImg(Colors.lightGreenAccent, 150);
    }

    buildCollapsed3() {
      return Container();
    }

    buildExpanded1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "All available Classes",
                    style: Theme.of(context).textTheme.body1,
                  ),
                  Text(
                    "Pick one!",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
          ]);
    }

    buildExpanded3() {
      return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            VerticalView(false),
          ],
        ),
      );
    }

    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: ScrollOnExpand(
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expandable(
                  collapsed: buildCollapsed1(),
                  expanded: buildExpanded1(),
                ),
                Expandable(
                  collapsed: buildCollapsed2(),
                  expanded: null,
                ),
                Expandable(
                  collapsed: buildCollapsed3(),
                  expanded: buildExpanded3(),
                ),
                Divider(
                  height: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Builder(
                      builder: (context) {
                        var controller = ExpandableController.of(context);
                        return FlatButton(
                          child: Text(
                            controller.expanded ? "COLLAPSE" : "EXPAND",
                            style: Theme.of(context)
                                .textTheme
                                .button
                                .copyWith(color: Colors.deepPurple),
                          ),
                          onPressed: () {
                            controller.toggle();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String sss = "إليك بعض الأمور الواجب وضعها بعين الإعتبار:";

List foo() {
  List<Map> data = List();
  data.add(
    {
      "icon":
          "https://images.unsplash.com/photo-1524704654690-b56c05c78a00?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80",
      "name": "Parental stuff",
      "topics": [
        {
          "name": "my child is sick",
          "articles": [
            {
              "name": "is he feeling cold?",
              "content": [
                {
                  "type": "video",
                  "source":
                      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
                },
                {
                  "type": "text",
                  "source":
                      "التحديات التي تواجه الأسرة: \r\n\r\n    • الأسرة الآمنة وادوارها: \r\nالطفل يشبه النبتة، إذا قمت بزرعها ببيئة مناسبة، وقمت بتوفير الحاجات اللازمة لنموها: الضوء، درجة الحرارة، الماء اللازم لنموها بلا زيادة ولا نقصان، وحمايتها من بعض الأمور التي من الممكن أن تكون خطر عليها أو تهدد نموها بطريقة جيدة، وغيرها من الأمور.. \r\nفلو قسنا ذلك على الطفل فإن التربة المناسبة له هي الأسرة، ويحتاج لكي ينمو ويكبر إلى توفير الطعام والشراب والأمن والحماية والنظافة وتقديم الرعاية المستمرة والحنان والإهتمام وغيرها العديد من الواجبات التي تقومون بها كأهل. \r\n\r\nتأتي أهمية الأسرة للطفل من خلال أدوارها حيث أنها: \r\n- تمدهم بالبيئة الأمنة التي توفر احتياجاتهم وحقوقهم في جو من الحنان، كي يتمتعوا بشخصية متوازنة قادرة على الانتاج والعطاء.\r\n- تعد الأطفال للمشاركة في حياة المجتمع والتعرف على قيمه وعاداته،  فهي تلعب دورا حيويا في تشريب الطفل ثقافة المجتمع وقيمه ولغته، مما يهيء الطفل للحياة الاجتماعية ولسلوك بطريقة متوافقة مع سلوك الجماعة.\r\n- الأسرة مسؤولة عن توفير الاستقرار والحماية والرعاية للأطفال منذ ولادتهم، فهي الاقدر بين مؤسسات المجتمع على القيام بذلك ولا تستطيع اي مؤسسة ان تسد مسدها .\r\n- لا تلبي الاحتياجات الاولية للفرد من طعام وملبس ومشرب فحسب، وانما تتعدى ذلك لتلبية حاجاته الانسانية الاخرى كالحاجة للحب والانتماء.\r\n- من خلال الكيفية التي يتعامل فيها الوالدان مع بعضهما ومع أبنائهما، يكتسب الطفل مفهومه للعلاقات الاسرية، ونظرته للرجل والمرأة، وكيفية التواصل وحل المشكلات اليومية ففي مرحلة الطفولة المبكرة تتكون لدى الطفل نظرته للعالم الخارجي، ويكتسب اتجاهاته نحو محيطه ونحو نفسه، وذلك يعتمد على التفاعل داخل الاسرة وشكله ونمط رعايته، واشباع الحاجات الاساسية له \" \r\n    • التحديات التي تواجه الأسرة: \r\nذكرنا أهمية دور وتأثير الأسرة على الطفل إلا أن هناك العديد من التحديات التي تعيق عمل الأسرة الآمنة في المنزل، \r\nفيما يلي سنتحدث عن بعض هذه التحديات: \r\n( الأسرة الممتدة، الإنفصال، غياب أحد الأبوين (عمل، مرض، وفاة، هجرة، فقدان)، اللجوء) \r\n ومن أبرز هذه التحديات ما يلي: \r\n    • العيش مع الاسرة الممتدة:\r\n هناك العديد من الأسر الشابة التي تضطر للعيش مع الأسرة الكبيرة لاسباب مختلفة منها الظروف الإقتصادية أو الإجتماعية، مع أن السكن المنفصل يعطي فرصة أكبر من الخصوصية بين الزوجين، وقدرة أكبر على ضبط سلوك الأطفال وتربيتهم،  لكن قي بعض الحالات يكون السكن مع الأسرة الممتدة أمراً واقعياً ومفروضاً على الزوجين لذا، ربما يكون العبء الأكبر على الزوجة الشابة التي دخلت على أسرة وثقافة جديدة فاعلاقة عن قرب ستحدث بعض الخلافات، وحل هذه الخلافات يتطلب التعاون من كل الأطراف. وعلينا دائماً أن نتذكر الجوانب الإيجابية ونبحث عنها ونحاول تنميتها. \r\nففي الأسرة الممتدة ليس سهلاً أن تتنازل الجدة عن عرشها في المنزل فهي التي كانت تدير المنزل وتقرر وتدير المصروفات لفترة طويلة من الزمن، وعلى الزوجات الشابات أن تفهم هذه الطبيعة لكبيرات السن. \r\nوأحياناً ترى الجدة أنها أكثر إلماماً بكيفية تربية الأطفال بينما ترى الأم أن الجدة ليست مؤهلى لتربية الأطفال في هذا الزمن الحديث، مما يوجد خلافات بين الجدة والأم، ويدخلهما أحياناً في حالة تنافس على حب الطفل، وهو ما يجب اجتنابه بحيث تدرك الأم أن الجدة تدلل الطفل وهذا من حقها وتنبهها بطريقة رقيقة حتى لا تحرجها، في حال كانت الجدة تسمح للطفل بأمور غير مسموحة لدى الأم. \r\nبعض النصائح لإقامة علاقة جيدة مع أسرة الزوج: \r\n    1- الإستعانة بحكمة الأجداد وتجاربهم، مما ينعكس على بناء علاقة إيجابية وجيدة. \r\n    2- الحرص على بناء علاقة خاصة قائمة على الإحترام والتقدير للجد والجدة، لأن أي علاقة متوترة ستؤثر على العلاقة مع الزوج وينعكس ذلك على الأطفال. \r\n    3- تجنب الرد القاسي او الصراخ على الأب والأم، وخاصة بوجود الأطفال لانهم يراقبون جيداً ويتمثلون ما يشاهدونه. \r\n    4- ضرورة الإتفاق على قواعد وقوانين أساسية يلتزم الجميع بها وذلك تجنباً لوقوع الخلافات. \r\n    5- ضرورة الإشادة بالدور الإيجابي الذي يلعبه الجدان في حياة الطفل، وتقدير مساعدتهما. \r\n    6- إذا شعرت الزوجة بكثرة لوم وانتقاد والدة الزوج لها، فينصح بمناقشة الأمور بصراحة متناهية مع هدوء ولطف، خاصة إذا كان الأمر يتعلق بتربية الطفل. \r\n    7- يجب على الزالدين أن يبنوا علاقة ثقة وتواصل مع أطفالهم، بحيث يشعر الطفل بأنهم مرجعه. \r\n    8- ومطلوب من الزوج أيضاً أن يظهر لأهله ( الجدة، الجد، ...) وبوضوح ثقته بزوجته، وأنه هو وهي يتحملان مسؤولية مشتركة قانونياً وشرعياً وإجتماعياً لرعاية أطفالهم. \r\n\r\n    • الانفصال:\r\nوجود اي مشاكل في الاسرة كفيل بأن يشعر الأطفال بالخوف والتهديد وفي بعض الأحيان عدم فهم ما يجري  وعادة ما يغفل الآباء هذا الشيء أثناء الإنفصال والمشاكل التي من الممكن أن تصاحبه، من مشاكل إجتماعية وأسرية في نفس الأسرة وهو بالتأكيد يؤثر على الأبناء بشكل ملحوظ.\r\n                      اليكم عدداً من النصائح للمقدمين على الطلاق: \r\n    1-  إعلام الأطفال مسبقاً بإمكانية حدوث الطلاق، ويراعى في هذه المرحلة أن يتحدث جميع أفراد الأسرة معاً بما في ذلك ( الأم والأب والأطفال) وأن يتسم الحديث بالصدق ويجيب على تساؤلات الأطفال بإهتمام.\r\n    2- التأكيد للطفل بأنه ليس السبب من خلال الحديث معه حتى قبل أن يسأل، وعدم المجادلة أو الصراخ أمام الطفل.\r\n    3- تأكيد الوالدين للطفل بأنهما يحبانه من خلال إستمرار التواصل.\r\n    4- تشجيع الأطفال على الحديث عن مشاعرهم والتنفيس عنها، وتوجيه الأطفال للتنفيس عن هذه المشاعر من خلال: البكاء، الرسم، النشاط الرياضي أو الفني، الحديث مع شخص آخر غير الاب و الام. \r\n    5- الحرص على إبقاء علاقة الطفل بالاب والام قوية، قيستطيع زيارتهم، التحدث معهم عبر الهاتف..\r\n    6- الحرص على توضيح خطة الحياة الديدة للطفل: مع من سيبقى؟ إلى أين سيذهب ،، \r\n    7- إذا تطلبت الحاجة إلى مساعدة، مراجعة الأخصائيين. \r\n\r\n   \r\n    • غياب أحد الأبوين (عمل، مرض، وفاة، هجرة، فقدان): \r\n\r\nالصعب في هذا الموضوع هو إضطرار أحد الوالدين لتربية الأبناء لوحده والقيام بالعديد من الأدوار المخصصة ليقوم بها الإثنان معاً في التربية، \r\nعملية التربية هي شراكة، وعندما لا تتوفر هذا الشراكة يشعر أحد الوالدين بأنه يحتاج ليكون الأب والأم بنفس الوقت. فبالإضافة الى القيام بأعمال المنزل، توفير سبل العيش، تربية الأطفال، يشعر المسؤول عن التربية أن عليه أن يقوم بدور مضاعف: اللعب مع الأطفال، التحدث مع الابن، الاهتمام بالابنة، الطبخ، والتنظيف، القلق بشأن المصاريف وتوفيرها وغيرها من الواجبات والمسؤوليات..\r\nجزء مهم من التعامل مع هذا الضغط، هو السماح للآخرين بمساعدتك، إذا كان لديك أخ أو أخت أو اي شخص آخر، تثق بأسلوبهم ويحترمون تجربتك وما عانيته، إطلب منهم اللعب مع الأطفال، التحدث للإبن، مساعدتك في تقديم الرعاية للأطفال، وان لم تجد حاول دائماً أن تذكر نفسك بأن ما تقوم به رائع وكافيز \r\n\r\nكأب أو أم لابد أن يكون لديك علاقات جيدة مع الآخرين، كأن تواكب على حضور نشاطات مجتمعية وجلسات، أصدقاء يساعدونك في التخفيف عليك، يعطونك القوة ويشجعونك على الإستمرار، إنه لشيء رائع أن تعلم أنه لا يجب أن تعرف كل شيء ولكن من المهم أن تعرف من تسأل. ولهذا من المهم أن يكون لديك نظام دعم إجتماعي.\r\n\r\nنظام الدعم الإجتماعي: هو أن يشعر الفرد بوجود أشخاص داعمين له ومحيطين به ويقدمون له المساعدة وأن يعتبر نفسه فرداً من مجموعة الدعم الإجتماعي لآخرين أيضاً. \r\n\r\nإليك بعض النصائح لإنشاء نظام دعم إجتماعي: \r\n\r\n    • تفقد البرامج التي تقدم الرعاية الوالدية في منطقتك، من الممكن أن تلتقي بأشخاص آخرين يمرون بنفس التجربة ومن الممكن أن يعطوك حلولاً لبعض المشاكل، وايضاً تجعلك تدرك أنك لست لوحدك، وهذا ما يحدث كل الفرق في بعض الأحيان. \r\n    • أبق عينيك وأذنيك مفتوحتين، لا تخف من طلب المساعدة من الممكن أن يكون جارك أو صديقك، زميلك في العمل: لديهم تجارب، بعض المواعظ، أبناء في عمر أبنائك، خبرة في تصليح عطل ما في المنزل وغيرها من الأمور التي من الممكن أن تعينك. \r\n    • أبقِ على علاقات جيدة مع الأهل قدر المستطاع، الجد والجدة والأعمام والأخوال والعمات، حتى لو لم يعد الشخص الذي يربطك بهم موجود، من الممكن أن تكون لديهم نصائح جيدة، واهميتهم في حياة الطفل فيساعدونه على التقبل والشفاء عندما يعمون أنهم مايزالون ينتمون لعائلاتهم الممتدة، واذا كان من الصعب ابقاء العلاقات جيدة مع العائلة، أوجد للأطفال عائلة مشابهة من الأصدقاء و الجيران. \r\n    • خصص وقتاً للصداقة، الأصدقاء ليسوا فقط مستمعين رائعين ولكن من الممكن أن يكونوا مصدراً للحكمة وحل المشكلات. لا تخف من التحدث عما تشعر به وتواجهه أمام الأشخاص الذين يهتمون حقاً.\r\n\r\n\r\n    • اللجوء:  \r\nمن الصعب الحفاظ على علاقة جيدة وقوية في ظروف مختلفة وقاسية تتعرض لها الأسرة مثل اللجوء: \r\nيواجه اللاجئين بعض الصعوبات والمشكلات بسبب الاختلافات السياسية والإجتماعية وايضاً الظروف المعيشية الصعبة أو ما خلفته تجربة اللجوء من فقدان بعض الافراد او تأثير على الحالة النفسية او اصابات مختلفة. \r\n\r\n\r\n\r\n\r\nإذا كان لا يزال تأثير صدمة قوية كاللجوء مثلاً على أطفالك ولا زلت تواجه صعوبة بالتعامل مع هذه التحديات، \r\nفيما يلي بعض الخطوات لتي قد تساعدك على تخطي مثل هكذا أزمات: \r\n\r\n    • كن واعياً بردود الأفعال تجاه الصدمة: \r\nبعض الأطفال يلعق إصبعه، أو التبول اللاارادي وغيره من العلامات بامكانك الضغط على الرابط المرفق \r\nلتعرف أكثر عن الموضوع. من المهم أن تتذكر أن ردود الأفعال هذه طبيعية تجاه الصدمة ولذلك عليك أن تتصرف بهدوء وأن تقدم الإهتمام والرعاية اللازمة. \r\n\r\n    • كن مستعداً للتعامل مع المخاوف والهموم: \r\nمن الممكن أن تطور بعض مخاوف الطفولة بعد الأزمة بشكل أكبر، يخاف الأطفال من الظلام، أو الوحدة. مشاكل في النوم، اوجاع متكررة بالمعدة والرأس وغيرها من الأمور التي لابد أن عايشتموها مع أطفالكم، يمكنك أن تساعد أطفالك أن يهدؤوا من روعهم من خلال: قراءة بعض القصص واللعب معهم، طهي الطعام الذي يحبونه، وعليكم أن تساعدوهم على أن يستعيدوا ثقتهم بأنفسهم من خلال الكلمات والإحتضان. \r\n\r\n    • إخلق جواً من الأمان: \r\nسيشعر الأطفال بالحزن والإرباك، من المهم أن تكون حامياً ومعطاءاً لهم، من خلال توفير الراحة الجسدية، الأغطية والطعام المفضل، نشاطات لطمأنتهم وتهدئتهم، ليستطيعوا إستعادة الحس بالأمان. أمض وقت أكثر معهم كعائلة. \r\n \r\n\r\n\r\n\r\n\r\n    • إحرص على ألا يشاهدوا الأخبار:\r\nلا تعتمد على الأخبار لإعطاء طفلك ما يبحث عنه، الأصوات والصور في التقارير الأخبارية من الممكن أن تزيد من صدمة الطفل، من المهم توضيح الإرتباك وإعطاء إجابات صادقة، ولكن لا تتعمق بالإجابة وألحق هذا الحديث بإعادة التأكيد على انه الآن بأمان. \r\n\r\n    • خصص وقتاً للإستماع: \r\nإحرص على حصول الأطفال على فرصة للتعبير عن مشاعرهم وقلقهم. إسأل بعض الأسئلة المفتوحة( ماذا سمعت من أخبار؟ كيف تشعر؟ هل لديك أي أسئلة؟ ) إسمح لهم بتحديد حاجاتهم، إستمع لهم بشكل فعال بدون التقليل من مشاعرهم، وأكد عليهم من خلال جمل مثل: أنت بأمان. \r\n\r\n\r\n    • شجع أطفال على الكتابة والرسم للتعبير عن تجربتهم: \r\nبعض الأطفال لا يحبون التحدث عن تجربتهم، أعطهم طرقاً أخرى للتعبير عن أنفسهم، الرسم والكتابة من الممكن أن تساعد الأطفال على التعامل مع ما مروا به. \r\n\r\n\r\n    • اللعب: \r\nاللعب هو طريقة كل الأطفال في التواصل وتحليل الأمور، يعد اللعب أسلوب صحي لتشتيت إنتباه الطفل عن الظروف الصعبة والتحرر من الضغوط والتوتر. \r\n \r\n    • كن قدوة لهم من خلال التكيف بأسلوب صحي: \r\nينظر إليك أطفالك بالعادة ليطمئنوا، وأيضاً لتعلم كيفية التعامل مع المشاعر المعقدة، خصص وقتاً لتحلل ما تمر به، لكي تكون قادراً على مساعدة أطفالك، لا يجب عليك أن تخفي مشاعرك عن أطفالك ولكن من المهم التأكيد على أنك تشعر بالحزن بالوقت الحالي ولكنك تعرف العديد من الأمور التي ستساعدك على التحسن. \r\n\r\n    • تابع سلوك طفلك مع الوقت: \r\nإهتم بالتغير الذي من الممكن أن يحصل في النوم، الأكل، اللعب، الدراسة والتواصل مع الآخري: إذا لم يحصل اي تحسن على سلوك الطفل، حاول أن تحصل على مساعدة متخصصة. \r\n\r\n\r\nإليك بعض الأمور الواجب وضعها بعين الإعتبار: \r\n\r\nيعرف الأطفال عن هذه التحديات على إختلافها بشكل مباشر أو غير مباشر ومحاولة إخفاء المشكلة عن الأطفال تعيق التواصل الأسري الناجح وأيضاً من الممكن أن تزرع لدى الطفل مخاوف اكبر من حجمها أو غير صحيحة مما يؤثر على صحته النفسية ونموه، من المهم بالحالات السابقة: \r\n\r\n1- توضيح المشكلة لدى الطفل باختصار وبما يناسب عمره \r\n2- الاتفاق مع الطفل طريقة للتعامل مع هذه المشكلة \r\n3- تقديم الدعم  العاطفي للطفل \r\n4- وجود روتين يومي في البيت ( لدى الطفل والعائلة  ) "
                },
                {
                  "type": "image",
                  "source":
                      "https://www.wallpaperup.com/uploads/wallpapers/2017/06/20/1092637/456c9025ad66bcfb2b2ead805281426d-700.jpg"
                }
              ]
            }
          ]
        }
      ]
    },
  );
  data.add({
    "name": "You",
    "icon":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSEzcd0SCyC8nqruJxNvPQNx6KlXDR3s9IntFNZs904i9OwJGvS",
    "content": [
      {
        "type": "video",
        "content":
            "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
      }
    ]
  });
  data.add({
    "name": "We",
    "icon":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQZWxG4gOgEs_csSqdaj_OugrYSTjEpmyS6U8OFf6W92Lui5QUp",
    "content": [
      {
        "type": "video",
        "content":
            "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
      }
    ]
  });
  data.add({
    "name": "who",
    "icon":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTqP-VlRrnX3FItUslani17KKDcQWYFPAzUCroSM25HrdVVR5Sv",
    "content": [
      {
        "type": "video",
        "content":
            "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
      }
    ]
  });
  return data;
}

var _cards = foo();

class HoriView extends StatelessWidget {
  HoriView();

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      height: 150.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _cards.length,
        itemExtent: 100.0,
        itemBuilder: (context, index) {
          var item = _cards[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                '/MV',
                arguments: {"items": item["topics"], "icon": item["icon"]},
              ),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      item["icon"],
                    ),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black26,
                      BlendMode.darken,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //add progress info
                    /* Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://iisy.fi/wp-content/uploads/2018/08/user-profile-male-logo.jpg',
                        ),
                        radius: 14.0,
                      ),
                    ),
                  ),
                  */
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        item["name"],
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// to do bookmrks

class VerticalView extends StatelessWidget {
  VerticalView(this.use);
  final bool use;
  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      height: 500.0,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _cards.length,
        //itemExtent: 100.0,
        itemBuilder: (context, index) {
          var item = _cards[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                '/MV',
                arguments: {"items": item["topics"], "icon": item["icon"]},
              ),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: double.maxFinite,
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(item["icon"]),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Center(
                        child: Text(item["name"]),
                      ),
                    ),
                    Container(
                        child: this.use
                            ? Center(
                                child: Text("progress 50%"),
                              )
                            : null),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const MyCustomAppBar({
    Key key,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.horizontal(),
              color: Colors.green[100],
            ),
            width: double.infinity,
            height: 58,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: null,
                  child: Icon(Icons.notifications, color: Colors.yellow),
                  shape: new CircleBorder(),
                  constraints:
                      new BoxConstraints(minHeight: 50.0, minWidth: 50.0),
                ),
                Text("AppName"),
                Icon(
                  Icons.flare,
                  color: Colors.green,
                  size: 50,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
