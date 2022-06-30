import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:your_chat_starter/main.dart';
import 'package:your_chat_starter/screens/account/payment_screen.dart';

import '../../constants.dart';

class UpgradeActivity extends StatefulWidget {
  @override
  _UpgradeActivityState createState() => _UpgradeActivityState();
}

class _UpgradeActivityState extends State<UpgradeActivity> {
  final _headerStyle = TextStyle(
      color: Color(0xffffffff), fontSize: 20, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[kPrimaryColor, kSecondaryColor],
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Nâng cấp dịch vụ"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20),
              child: Text(
                "Gói dịch vụ",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).iconTheme.color),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 15, right: 20),
              child: Text(
                "Nâng cấp dịch vụ để nâng cao trải nghiệm của bạn",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Accordion(
                maxOpenSections: 1,
                headerPadding:
                    EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                children: [
                  AccordionSection(
                    headerBackgroundColor: simpleServiceBackgroundColor,
                    headerPadding: EdgeInsets.all(15),
                    isOpen: true,
                    leftIcon: Icon(Icons.insights_rounded, color: Colors.white),
                    header: Text('Gói cơ bản',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    content: Column(
                      children: [
                        Text(
                          "Tra cứu thời tiết",
                          style: TextStyle(
                              fontSize: 14, color: kContentColorLightTheme),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Làm phép tính",
                          style: TextStyle(
                              fontSize: 14, color: kContentColorLightTheme),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Giao tiếp cơ bản",
                          style: TextStyle(
                              fontSize: 14, color: kContentColorLightTheme),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Sử dụng không giới hạn",
                          style: TextStyle(
                              fontSize: 14, color: kContentColorLightTheme),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text(
                            "Miễn phí trọn đời",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: kContentColorLightTheme),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                    contentHorizontalPadding: 20,
                    contentBorderWidth: 1,
                  ),
                  AccordionSection(
                    headerBackgroundColor: standardServiceBackgroundColor,
                    headerPadding: EdgeInsets.all(15),
                    isOpen: false,
                    leftIcon: Icon(Icons.insights_rounded, color: Colors.white),
                    header: Text('Gói tiêu chuẩn',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white)),
                    content: Column(
                      children: [
                        Text(
                          "Toàn bộ chức năng của gói cơ bản",
                          style: TextStyle(
                              fontSize: 14, color: kContentColorLightTheme),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Tra cứu tỉ giá ngoại tệ",
                          style: TextStyle(
                              fontSize: 14, color: kContentColorLightTheme),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Tra cứu chứng khoán",
                          style: TextStyle(
                              fontSize: 14, color: kContentColorLightTheme),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Trả phí hàng tháng",
                          style: TextStyle(
                              fontSize: 14, color: kContentColorLightTheme),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "10.000 đ/tháng",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: kContentColorLightTheme),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  _openPaymentScreen(
                                      "standard",
                                      10000,
                                      "Gói tiêu chuẩn",
                                      "assets/images/10k.jpg");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: standardServiceBackgroundColor),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(
                                      "Mua ngay",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                    contentHorizontalPadding: 20,
                    contentBorderWidth: 1,
                  ),
                  AccordionSection(
                    headerPadding: EdgeInsets.all(15),
                    headerBackgroundColor: premiumServiceBackgroundColor,
                    isOpen: false,
                    leftIcon: Icon(Icons.insights_rounded, color: Colors.white),
                    header: Text('Gói cao cấp',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    content: Column(
                      children: [
                        Text(
                          "Toàn bộ chức năng của gói tiêu chuẩn",
                          style: TextStyle(
                              fontSize: 14, color: kContentColorLightTheme),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Chức năng dịch thuật",
                          style: TextStyle(
                              fontSize: 14, color: kContentColorLightTheme),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Trả phí hàng tháng",
                          style: TextStyle(
                              fontSize: 14, color: kContentColorLightTheme),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "20.000 đ/tháng",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: kContentColorLightTheme),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  _openPaymentScreen("premium", 20000,
                                      "Gói cao cấp", "assets/images/20k.jpg");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: premiumServiceBackgroundColor),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(
                                      "Mua ngay",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                    contentHorizontalPadding: 20,
                    contentBorderWidth: 1,
                  ),
                  AccordionSection(
                    headerPadding: EdgeInsets.all(15),
                    headerBackgroundColor: lifeTimeServiceBackgroundColor,
                    isOpen: true,
                    leftIcon: Icon(Icons.insights_rounded, color: Colors.white),
                    header: Text('Gói trọn đời',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white)),
                    content: Column(
                      children: [
                        Text(
                          "Toàn bộ chức năng của gói cao cấp",
                          style: TextStyle(
                              fontSize: 14, color: kContentColorLightTheme),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Trả phí 1 lần",
                          style: TextStyle(
                              fontSize: 14, color: kContentColorLightTheme),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "200.000 đ",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: kContentColorLightTheme),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  _openPaymentScreen("lifetime", 200000,
                                      "Gói trọn đời", "assets/images/200k.jpg");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: lifeTimeServiceBackgroundColor),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(
                                      "Mua ngay",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                    contentHorizontalPadding: 20,
                    contentBorderWidth: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _openPaymentScreen(
      String planName, int amount, String serviceName, String paymentQR) {
    Navigator.of(context)
        .push(MaterialPageRoute<bool>(builder: (BuildContext context) {
      return PaymentScreen(
          planName: planName,
          amount: amount,
          nameService: serviceName,
          paymentQR: paymentQR);
    }));
  }
}
