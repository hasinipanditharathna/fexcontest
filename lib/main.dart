import 'package:flutter/material.dart';
import 'package:practicaltest/CatFolder/model/gifmodel.dart';
import 'package:practicaltest/CatFolder/repository/gifrepository.dart';
import 'package:practicaltest/CatFolder/view/gifviewscreen.dart';
import 'package:practicaltest/CatFolder/view/imageViewScreen.dart';
import 'package:practicaltest/main_screen.dart';
import 'package:practicaltest/search/searchInputScreen.dart';
import 'package:practicaltest/splashscreen/scplash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fexcon',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Future<List<CatGiftsResponseModel>> catalbum;

  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CAT View',
        ),
        centerTitle: false,
        actions: [
          Row(
            children: [
              ElevatedButton(
                style: raisedButtonStyle,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GifViewScreen(
                              mimeType: 'gif',
                            )),
                  );
                },
                child: const Text('GIF'),
              ),
              const SizedBox(
                width: 5,
              ),
              ElevatedButton(
                style: raisedButtonStyle,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ImageViewScreen(
                              mimeType: 'jpg',
                            )),
                  );
                },
                child: const Text('Images'),
              )
            ],
          )
        ],
      ),
      body: SizedBox(
        child: Center(
          child: FutureBuilder<List<CatGiftsResponseModel>>(
            future: fetchAll(_page),
            builder: (BuildContext context, allList) {
              if (allList.hasData) {
                return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: allList.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return container(allList, index);
                    });
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  container(AsyncSnapshot<List<CatGiftsResponseModel>> gifList, index) {
    // return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        gifList.data!.isNotEmpty
            ? SizedBox(
                width: 250,
                height: 250,
                child: Card(
                  child: Image.network(
                    gifList.data![index].url!,
                    height: 250.0,
                    width: 250.0,
                  ),
                ),
              )
            : const Text('No Data'),
      ],
    );
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: Colors.grey[300],
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );
}
