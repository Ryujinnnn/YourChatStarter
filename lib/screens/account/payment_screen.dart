import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:your_chat_starter/main.dart';

import '../../constants.dart';

class PaymentScreen extends StatefulWidget {
  final String planName;
  final int amount;
  final String nameService;

  const PaymentScreen(
      {Key? key,
      required this.planName,
      required this.amount,
      required this.nameService})
      : super(key: key);
  @override
  _PaymentScreenState createState() =>
      _PaymentScreenState(this.planName, this.amount, this.nameService);
}

class _PaymentScreenState extends State<PaymentScreen> {
  final String planName;
  final int amount;
  final String nameService;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  _PaymentScreenState(this.planName, this.amount, this.nameService);
  @override
  Widget build(BuildContext context) {
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
        decoration: BoxDecoration(color: Color(0xFF1D1D35)),
        child: SingleChildScrollView(
            child: Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    Text(
                      "Thông tin thanh toán",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kContentColorLightTheme),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildEnableFocusTextField(
                        "Họ tên", "Nhập họ tên", nameController),
                    buildEnableFocusTextField(
                        "Địa chỉ", "Nhập địa chỉ", addressController),
                    buildNumberTextField("Số điện thoại", "Nhập số điện thoại",
                        phoneNumberController),
                    buildEnableFocusTextField(
                        "Email", "Nhập email", emailController),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: kPrimaryColor),
                    color: Colors.white),
                child: Container(
                  margin: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Thanh toán",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: kContentColorLightTheme),
                          ),
                          Expanded(child: SizedBox()),
                          Text(
                            "1",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: kContentColorLightTheme),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            nameService,
                            style: TextStyle(
                                fontSize: 16, color: kContentColorLightTheme),
                          ),
                          Expanded(child: SizedBox()),
                          Text(
                            amount.toString() + " đ",
                            style: TextStyle(
                                fontSize: 16, color: kContentColorLightTheme),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        height: 1.5,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Tổng",
                            style: TextStyle(
                                fontSize: 16, color: kContentColorLightTheme),
                          ),
                          Expanded(child: SizedBox()),
                          Text(
                            amount.toString() + " đ",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: kContentColorLightTheme),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: kPrimaryColor),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                          child: Text(
                        "Thanh toán",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget buildEnableFocusTextField(
      String label, String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: kContentColorLightTheme),
      decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 0.0),
          ),
          labelText: label,
          labelStyle:
              TextStyle(fontSize: 16, color: Colors.grey.withOpacity(0.3)),
          floatingLabelStyle: TextStyle(fontSize: 16, color: kPrimaryColor),
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.grey.withOpacity(0.3),
          )),
    );
  }

  Widget buildNumberTextField(
      String label, String hint, TextEditingController controller) {
    return TextField(
      keyboardType: TextInputType.number,
      controller: controller,
      style: const TextStyle(color: kContentColorLightTheme),
      decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 0.0),
          ),
          labelText: label,
          labelStyle:
              TextStyle(fontSize: 16, color: Colors.grey.withOpacity(0.3)),
          floatingLabelStyle: TextStyle(fontSize: 16, color: kPrimaryColor),
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.grey.withOpacity(0.3),
          )),
    );
  }
}
