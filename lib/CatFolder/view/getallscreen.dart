import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practicaltest/CatFolder/model/gifmodel.dart';
import 'package:practicaltest/CatFolder/repository/gifrepository.dart';
import 'package:practicaltest/search/searchInputScreen.dart';

class ViewAllScreen extends StatefulWidget {
  const ViewAllScreen({Key? key}) : super(key: key);

  @override
  State<ViewAllScreen> createState() => _GifViewScreenState();
}

class _GifViewScreenState extends State<ViewAllScreen> {
  late Future<List<CatGiftsResponseModel>> catalbum;

  int _page = 0;

  final int _limit = 20;

  bool _hasNextPage = true;

  bool _isFirstLoadRunning = false;

  bool _isLoadMoreRunning = false;

  // The controller for the ListView
  late ScrollController _controller;

  late String mimeType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    if (mimeType == 'jpg') {
      catalbum = fetchGifs(_page, 'jpg');
    } else {
      catalbum = fetchGifs(_page, 'gif');
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  // This function will be triggered whenver the user scroll
  // to near the bottom of the list view
  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
      });
      _page += 1;
      if (mimeType == 'jpg') {
        catalbum = fetchGifs(_page, 'jpg');
      } else {
        catalbum = fetchGifs(_page, 'gif');
      }
      // fetchGifs(_page, 'gif');

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  container(AsyncSnapshot<List<CatGiftsResponseModel>> gifList, index) {
    // return Container();

    return _isFirstLoadRunning
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : gifList.data!.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: Card(
                      child: Image.network(
                        gifList.data![index].url!,
                        height: 250.0,
                        width: 250.0,
                      ),
                    ),
                  ),
                  if (_isLoadMoreRunning == true)
                    const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 40),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),

                  // When nothing else to load
                  if (_hasNextPage == false)
                    Container(
                      padding: const EdgeInsets.only(top: 30, bottom: 40),
                      color: Colors.amber,
                      child: const Center(
                        child: Text('You have fetched all of the content'),
                      ),
                    ),
                ],
              )
            : const Text('No Data');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: SizedBox(
          child: Center(
            child: FutureBuilder<List<CatGiftsResponseModel>>(
              future: fetchGifs(_page, 'gif'),
              builder: (BuildContext context, gifList) {
                if (gifList.hasData) {
                  // print((gifList.data![0]));
                  return ListView.builder(
                      controller: _controller,
                      padding: const EdgeInsets.all(8),
                      itemCount: gifList.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        // if (gifList.data![index].categories) {
                        return container(gifList, index);
                      });
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ));
  }
}
