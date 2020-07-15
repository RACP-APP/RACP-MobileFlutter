import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../ui/app_notification.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../customIcons/irj_logo_icons_icons.dart';
class Welcome extends StatelessWidget {
  Welcome({Key key}) : super(key: key);

  static final myDarkGrey = Color(0xff605E5E);
  final myDarkBlue = Color(0xff085576);
  final mylightBlue = Color(0xff8AD0EE);
  final myDarkBlueOverlay = Color(0x55085576);
  static const introHtml = ''' 
  <div style="color:white;direction:rtl;text-align:right;font-size:14px;text-decoration:none;">
  <h3>السلام عليكم ،،،</h3>
  <p>
  <ul type="circle" >
    <li>عزيزتي المربيةٌ، عزيزي المربّي، كنتَ أمًّا أو أبًا، معلّمةً أو معلمًا، أختًا أوأخًا كبيرًا، ميسّرةً أوميسّرًا لأنشطةِ الأطفالِ؛ فإنّ هذا التطبيقَ يُفيدُك في رعايةِ نفسِكَ ورعايةِ طفلِكَ.  </li>
    <li>
      <p>جعلَ الله في نفوسِنا مناعةً نفسيّةً تعيدُ لنا التّوازنَ  بعدَ التّعرّضِ للخسائرِ أو الضغوطاتِ الحياتيّةِ اليوميّةِ، إلّا أنّنا قد نجدُ مناعتنا قد ضَعُفَت؛ لذا يجبُ على المرءِ هنا أن يسألَ ويسترشدَ، ويبحثَ ويَجِدَّ.<p>
      <p>
        <p> في هذا التطبيقِ ستجدون ما يُعينُكم ويُذكّرُكم بطرقٍ للتّعاملِ مع مشاكلِ الحياةِ اليوميّةِ:</p>
        <ul type="square">
          <li>التربيةُ الإيجابيّةُ والتعاملُ مع الأطفال. </li>
          <li>تمكينُ النفسِ والتعاملُ مع انفعالاتِها .</li>
          <li>حمايةُ الطفلِ من: (التنمّرِ، الزواج المبكّرِ، عمالةِ الأطفالِ، والتحرّشِ والإساءةِ الجنسيّةِ).</li>
          <li>استمراريّةُ التعليمِ، والأطفالُ ذوو الإعاقةِ.</li>
          <li>صحّةُ الطفلِ وتأثيرُ ذلك على حياتِه اليوميّةِ وتعلّمِه .</li>
          <li>الخدماتُ المتعلقةُ بالطفلِ والمرأةِ في الأردنِ، وكيفيّةُ الوصولِ إليها. </li>
        </ul>
      </p>
      </p>
    </li>
    <li><b>في هذا المحتوى لن تجدَ حلولًا سحريّةً،  بل ستجدُ مفاتيحَ قد تفتحُ لكَ أبوابَ المعافاةِ. إنّ إرادتَك وسعيكَ في إصلاحِ نفسِك؛ هو الذي سيضعُ تلكَ المفاتيحَ في الأبوابِ، وسيُحرّكُ المفتاحَ؛ لتصلَ إلى الحلِّ. </b></li>
  </ul>
  <p>
  </div>
  ''';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: new BoxDecoration(
          color: myDarkBlue,
        ),
        child: ListView(     //  use ListView instead of Column
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                color: Colors.white,
              ),
              width: double.infinity,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(bottom: 3.0),
                      child: RawMaterialButton(
                        onPressed: () => Navigator.of(context).pushNamed('/'),
                        child: new Icon(FeatherIcons.home, color: myDarkGrey),
                        shape: new CircleBorder(),
                        constraints:
                            new BoxConstraints(minHeight: 7.0, minWidth: 7.0),
                      )),
                  // new NotificationWidget(myDarkGrey),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            IrjLogoIcons.irglogo,
                            color: myDarkGrey,
                            size: 30,
                          )))
                ],
              ),
            ),
            Expanded(
                child: Padding(
                    padding:
                        EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0,bottom: 15.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: HtmlWidget(
                        introHtml,
                        webView: true,
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
