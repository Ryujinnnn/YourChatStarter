import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_chat_starter/constants.dart';
import 'package:your_chat_starter/theme.dart';

import '../../main.dart';
import '../../services/api_service.dart';
import '../chatbot_screen.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  _ThemeScreenState createState() => _ThemeScreenState();
}

enum ThemeGroup { green, sunshine, cherry, ocean }

class _ThemeScreenState extends State<ThemeScreen> {
  ThemeGroup? _themeGroup;
  bool circular = true;
  final double appBarHeight = AppBar().preferredSize.height;
  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  void fetchData() async {
    setState(() {
      circular = false;
      _themeGroup = savedTheme;
    });
  }

  onUnsavedTheme() {
    switch (savedTheme) {
      case ThemeGroup.green:
        kPrimaryColor = const Color(0xFF00BF6D);
        kSecondaryColor = const Color.fromARGB(223, 0, 114, 0);
        break;
      case ThemeGroup.cherry:
        kPrimaryColor = const Color(0xFFC6246D);
        kSecondaryColor = const Color(0xFF89123A);
        break;
      case ThemeGroup.sunshine:
        kPrimaryColor = Colors.amber;
        kSecondaryColor = const Color(0xFFFE9901);
        break;
      case ThemeGroup.ocean:
        kPrimaryColor = const Color.fromARGB(255, 45, 175, 250);
        kSecondaryColor = const Color.fromARGB(255, 1, 102, 254);
        break;
      default:
        {
          kPrimaryColor = const Color(0xFF00BF6D);
          kSecondaryColor = const Color.fromARGB(223, 0, 114, 0);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => {
                    _themeGroup = savedTheme,
                    onUnsavedTheme(),
                    Navigator.of(context).pop()
                  }),
          brightness: Brightness.dark,
          backgroundColor: kBackgroundColor,
          automaticallyImplyLeading: false,
          title: const Text("Giao diện"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[kPrimaryColor, kSecondaryColor],
              ),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  //await applyChanges();
                  saveLocalData();
                  setState(() {
                    savedTheme = _themeGroup;
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const ChatBotScreen()),
                        (Route<dynamic> route) => false);
                  });
                },
                icon: const Icon(Icons.check))
          ],
        ),
        body: Column(children: <Widget>[
          ListTile(
            title: Row(
              children: [
                Container(
                    height: 20, width: 20, color: const Color(0xFF00BF6D)),
                const SizedBox(
                  width: 10,
                ),
                const Text('Mặc định'),
              ],
            ),
            leading: Radio<ThemeGroup>(
              value: ThemeGroup.green,
              groupValue: _themeGroup,
              onChanged: (ThemeGroup? value) {
                setState(() {
                  _themeGroup = value;
                  kPrimaryColor = const Color(0xFF00BF6D);
                  kSecondaryColor = const Color.fromARGB(223, 0, 114, 0);
                });
              },
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Container(
                    height: 20, width: 20, color: const Color(0xFFC6246D)),
                const SizedBox(
                  width: 10,
                ),
                const Text('Anh đào'),
              ],
            ),
            leading: Radio<ThemeGroup>(
              value: ThemeGroup.cherry,
              groupValue: _themeGroup,
              onChanged: (ThemeGroup? value) {
                setState(() {
                  _themeGroup = value;
                  kPrimaryColor = const Color(0xFFC6246D);
                  kSecondaryColor = const Color(0xFF89123A);
                });
              },
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Container(height: 20, width: 20, color: Colors.amber),
                const SizedBox(
                  width: 10,
                ),
                const Text('Nắng vàng'),
              ],
            ),
            leading: Radio<ThemeGroup>(
              value: ThemeGroup.sunshine,
              groupValue: _themeGroup,
              onChanged: (ThemeGroup? value) {
                setState(() {
                  _themeGroup = value;
                  kPrimaryColor = Colors.amber;
                  kSecondaryColor = const Color(0xFFFE9901);
                });
              },
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Container(
                    height: 20,
                    width: 20,
                    color: const Color.fromARGB(255, 45, 175, 250)),
                const SizedBox(
                  width: 10,
                ),
                const Text('Đại dương'),
              ],
            ),
            leading: Radio<ThemeGroup>(
              value: ThemeGroup.ocean,
              groupValue: _themeGroup,
              onChanged: (ThemeGroup? value) {
                setState(() {
                  _themeGroup = value;
                  kPrimaryColor = const Color.fromARGB(255, 45, 175, 250);
                  kSecondaryColor = const Color.fromARGB(255, 1, 102, 254);
                });
              },
            ),
          ),
        ]));
  }

  void saveLocalData() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeValue', _themeGroup.toString());
  }
}
