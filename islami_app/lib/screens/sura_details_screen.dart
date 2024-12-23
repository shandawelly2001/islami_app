import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_app/screens/quran_details_screen.dart';
import 'package:islami_app/tabs/radio_tab/sura_name.dart';
import 'package:islami_app/widgets.dart';

class SuraDetailsScreen extends StatefulWidget {
  static String routeName = 'suraNames-screen';

  @override
  State<SuraDetailsScreen> createState() => _SuraDetailsScreenState();
}

class _SuraDetailsScreenState extends State<SuraDetailsScreen> {
  List<String> verses = [];

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as SuraArgs;
    verses.isEmpty ? readQuranFile(args.index) : null;
    return verses.isEmpty
        ? Center(child: CircularProgressIndicator())
        : Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                Images.ImagePath_2,
              ),
              fit: BoxFit.fill,
            )),
            child: Scaffold(
              body: Card(
                margin: EdgeInsets.all(26),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                color: Color.fromARGB(255, 247, 247, 247),
                child: ListView.separated(
                  separatorBuilder: (context, index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 32),
                    color: Color(0xFFB7935F),
                    width: double.infinity,
                    height: 2,
                  ),
                  itemBuilder: (context, index) =>
                      QuranDetails(quranText: verses[index]),
                  itemCount: verses.length,
                ),
              ),
              appBar: AppBar(
                title: Text(args.title),
              ),
            ));
  }

  void readQuranFile(int index) async {
    String fileContent =
        await rootBundle.loadString('assets/files/${index + 1}.txt');

    List<String> surLines = fileContent.split('\n');
    verses = surLines;
    for (int i = 0; i < surLines.length; i++) {
      print(verses[i]);
    }
    setState(() {});
  }
}

