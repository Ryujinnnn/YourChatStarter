import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:your_chat_starter/main.dart';

import '../../constants.dart';
import '../../models/profile_respond.dart';
import '../../services/api_service.dart';
import '../chatbot_screen.dart';

class PaymentScreen extends StatefulWidget {
  final String planName;
  final int amount;
  final String nameService;
  final String paymentQR;

  const PaymentScreen(
      {Key? key,
      required this.planName,
      required this.amount,
      required this.nameService,
      required this.paymentQR})
      : super(key: key);
  @override
  _PaymentScreenState createState() => _PaymentScreenState(
      this.planName, this.amount, this.nameService, this.paymentQR);
}

class _PaymentScreenState extends State<PaymentScreen> {
  final String planName;
  final int amount;
  final String nameService;
  final String paymentQR;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  _PaymentScreenState(
      this.planName, this.amount, this.nameService, this.paymentQR);

  late ProfileRespondModel profile;
  String username = "";
  bool circular = true;
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    if (isLogin = true) {
      var response = await APIService.getProfile();
      setState(() {
        profile = response;
        if (profile.user != null) {
          username = response.user.username;
        }
        circular = false;
      });
    }
  }

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
              colors: <Color>[kPrimaryColor, kPrimaryColor],
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Thanh toán"),
      ),
      body: Container(
        child: SingleChildScrollView(
            child: Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: kPrimaryColor),
                    color: Colors.white),
                child: Container(
                  margin: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Thanh toán chuyển khoản ngân hàng",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kContentColorLightTheme),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Chuyển khoản trực tiếp tới số tài khoản dưới đây:",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: kContentColorLightTheme),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Nguyễn Ngọc Đăng \n 5331 0000 921 488",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Ngân hàng TMCP & PT Việt Nam (BIDV)",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: kContentColorLightTheme),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        height: 1.5,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Số tiền chuyển khoản:",
                        style: TextStyle(
                            fontSize: 16, color: kContentColorLightTheme),
                      ),
                      Text(
                        amount.toString() + " đ",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: kContentColorLightTheme),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Nội dung chuyển khoản:",
                        style: TextStyle(
                            fontSize: 16, color: kContentColorLightTheme),
                      ),
                      Text(
                        "$username - YourChatStarter",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: kContentColorLightTheme),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: kPrimaryColor),
                ),
                child: Column(
                  children: [
                    Text("Thanh toán qua ví điện tử MoMo",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kContentColorLightTheme)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Vui lòng quét mã QR dưới đây với lời nhắn:",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: kContentColorLightTheme),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "$username - YourChatStarter",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: kContentColorLightTheme),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      child: Image.asset(
                        paymentQR,
                        height: MediaQuery.of(context).size.width * 0.5,
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
