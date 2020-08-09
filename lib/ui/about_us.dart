import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../customIcons/irj_logo_icons_icons.dart';

class AboutUs extends StatelessWidget {
  AboutUs({Key key}) : super(key: key);

  static final myDarkGrey = Color(0xff605E5E);
  final myDarkBlue = Color(0xff085576);
  final mylightBlue = Color(0xff8AD0EE);
  final myDarkBlueOverlay = Color(0x55085576);
  static const introHtml = ''' 
  <div style="color:white;direction:rtl;text-align:right;font-size:14px;text-decoration:none;">
  <h3>من نحن .. </h3>
  <p>
  جمعية الإغاثة الإسلامية عبر العالم هي منظمة دولية إنسانية غير حكومية وغير ربحية, مسجلة لدى وزارة التنمية والشؤون الاجتماعية تحت رقم (2012011100031) .وقد بدأت عملها في الأردن عام 1997 ضمن برامج رعاية الطفولة وكفالات الأيتام حيث تولت رعاية المئات من الأيتام والأطفال الذين يعيشون ضمن ظروف معيشية صعبة. وانطلاقا من واجب المنظمة لاحتواء الأزمة السورية في أواخر 2011 وما نتج عنها من آثار على المجتمع الأردني فقد استجابت المنظمة لتقديم المساعدات الإنسانية في مختلف المجالات :الصحة, التعليم, الدعم النفسي والحماية, تمكين المرأة والأسرة, الغذاء, المشاريع الموسمية (رمضان, الأضاحي),مشاريع تنموية.
  </p>
<p>
<h4>كُن على تواصلٍ معنا :</h4>
أبراج مكة , بناء رقم 174
<br/>
الطابق الخامس , مكتب رقم 509
<br/>
شارع مكة - عمان الاردن 
 <br/>
هانف +9626552884
<br/>
فاكس +96265543661
<br/>
jordan.info@irj.org.jo
<br/>
<br/>
<b>الخط الساخن +962787194131</b>
</p>
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
        child: ListView(
          //  use ListView instead of Column
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
                    padding: EdgeInsets.only(
                        top: 15.0, left: 10.0, right: 10.0, bottom: 15.0),
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
