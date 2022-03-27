import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_prefs/constants/app_const.dart';
import 'package:shared_prefs/data/datasource/local/shared_prefs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController strController = TextEditingController();
  TextEditingController intController = TextEditingController();
  TextEditingController listController = TextEditingController();
  String? strValue;
  int? intValue;
  bool boolValue = false;
  List<String> list = [];

  @override
  void initState() {
    super.initState();
    loadValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('Shared Preferences'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("String value: $strValue"),
            const SizedBox(height: 16),
            Text("Integer value: $intValue"),
            const SizedBox(height: 16),
            Text("Bool value: $boolValue"),
            const SizedBox(height: 16),
            ListView(
              shrinkWrap: true,
              children: list.map((e) => Text(e)).toList(),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CupertinoTextField(
                    placeholder: 'Masukkan String',
                    controller: strController,
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                  onPressed: () {
                    SharedPrefs.setString(strKey, strController.text);
                    loadValues();
                  },
                  child: const Text('Save'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                    onPressed: () {
                      SharedPrefs.remove(strKey);
                      loadValues();
                    },
                    child: const Text('Delete')),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CupertinoTextField(
                    placeholder: 'Masukkan angka',
                    controller: intController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                  onPressed: () {
                    SharedPrefs.setInt(intKey, int.parse(intController.text));
                    loadValues();
                  },
                  child: const Text('Save'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                    onPressed: () {
                      SharedPrefs.remove(intKey);
                      loadValues();
                    },
                    child: const Text('Delete')),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CupertinoTextField(
                    placeholder: 'Masukkan separated string',
                    controller: listController,
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                  onPressed: () {
                    final _text = listController.text.split(',');
                    final _list = _text.map((e) => e.trim()).toList();
                    SharedPrefs.setStringList(listKey, _list);
                    loadValues();
                  },
                  child: const Text('Save'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                    onPressed: () {
                      SharedPrefs.remove(listKey);
                      loadValues();
                    },
                    child: const Text('Delete')),
              ],
            ),
            CupertinoSwitch(
              value: boolValue,
              onChanged: (bool value) {
                SharedPrefs.setBool(boolKey, value);
                loadValues();
              },
            ),
          ],
        ),
      ),
    );
  }

  loadValues() async {
    strValue = await SharedPrefs.getString(strKey);
    intValue = await SharedPrefs.getInt(intKey);
    boolValue = await SharedPrefs.getBool(boolKey);
    list.clear();
    list.addAll(await SharedPrefs.getStringList(listKey));
    setState(() {});
  }
}
