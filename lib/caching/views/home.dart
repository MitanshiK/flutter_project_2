import 'package:flutter/material.dart';
import 'package:flutter_project_2/caching/controllers/fetch_api.dart';
import 'package:flutter_project_2/caching/controllers/local_database.dart';
import 'package:flutter_project_2/caching/models/news_modal.dart';
import 'package:flutter_project_2/caching/views/open_news.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 ScrollController _scrollController = ScrollController();
 List <NewsModal> latestNews=[];
 bool loading =true;
 bool isMoreNewsLoading=false;
 List<Map<String,dynamic>> savedTime=[];
 int currentPage=0;

//getting data from api or local database
   firstPageNews() async {
    int count = await LocalDatabase.getNewsCount() ?? 0;
    debugPrint("No of news saved ${count}");
    int savedTimeLength = savedTime.length;
    DateTime firstPageSavedTime = savedTimeLength >= 1
        ? DateTime.parse(savedTime[0]["lastSavedTime"] ?? "2000-01-01")
        : DateTime(2000);

    debugPrint("$firstPageSavedTime");

    DateTime currentTime = DateTime.now();

    Duration difference = currentTime.difference(firstPageSavedTime);
    if (difference.inMinutes > 5 || count == 0) {
      debugPrint("fetching the api");
      var isApifetching = await FetchApiNews.getLatestNews(currentPage);
      if (isApifetching) {
        getNews();
      }
    } else {
      debugPrint("data from local database");
      getNews();
    }
  }

//  for next page 
nextPageNews()async{
    int count = await LocalDatabase.getNewsCount() ?? 0;
    debugPrint("No of news saved ${count}");
    int savedTimeLength = savedTime.length;
    DateTime nextPageSavedTime = currentPage >savedTimeLength -1
        ? DateTime(2000)
        : DateTime.parse(savedTime[currentPage]["lastSavedTime"] ?? "2000-01-01");


    debugPrint("$nextPageSavedTime");

    DateTime currentTime = DateTime.now();

    Duration difference = currentTime.difference(nextPageSavedTime);
    if (difference.inMinutes > 5) {
      debugPrint("fetching the api $currentPage");
      var isApifetching = await FetchApiNews.getLatestNews(currentPage);
      if (isApifetching) {
        getMoreNews();
      }
    } else {
      debugPrint("data from local database  $currentPage");
      getMoreNews();
    }
 }

  // get all the times with page where saved to database
  getLastSavedTime() async {
    var time = await LocalDatabase.getSaveTime();
  debugPrint(time.toString());
    setState(() {
      savedTime = time;
    });
  }

// getting data from local database
getNews() async{
  var news= await LocalDatabase.getNews();
  setState(() {
    latestNews=news.map((e) => NewsModal.fromJson(e)).toList();
    loading=false;
  });
}

// to load more news
getMoreNews() async{
  setState(() {
  isMoreNewsLoading=true;
  });

var news= await LocalDatabase.getMoreNews(latestNews.length);
setState(() {
  latestNews.addAll(news.map((e) => NewsModal.fromJson(e)).toList());
  isMoreNewsLoading=false;
}); 
}

//to load more news on scroll
scrollListner(){
  if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
    currentPage++;
    nextPageNews();
  }
}

@override
  void initState() {
    getLastSavedTime();
   firstPageNews();
   _scrollController.addListener(scrollListner);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: isMoreNewsLoading 
      ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: CircularProgressIndicator(),
          ),
        ],
      ) : null,
      appBar: AppBar(title: Text("News"),centerTitle: true,),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
            FloatingActionButton(
                heroTag: "btn1",
            onPressed: ()async{
            LocalDatabase.deleteAllNews();
            LocalDatabase.deleteSavedTime;
            setState(() {
              latestNews=[];
            });
            },
            child: Icon(Icons.delete),),
            SizedBox(width: 20,),
            FloatingActionButton(
                heroTag: "btn2",
              onPressed: (){
              getLastSavedTime();
              firstPageNews();
              currentPage = 0; 

              setState(() {
                loading=true;
              });
              },
              child: Icon(Icons.refresh),
              )
          ],
      ),
      body: loading
       ? Center(child:  CircularProgressIndicator())
       : latestNews.isEmpty ? Center(child: Text("No News"),)
       : ListView.builder(
        controller: _scrollController,
           itemCount: latestNews.length,
           itemBuilder: (BuildContext context, int index) { 
            return ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> OpenNews(newsUrl: latestNews[index].url)));
              },
              leading: Text("${index+1}"),
              title: Text(latestNews[index].title),
              subtitle: Text("by ~ ${latestNews[index].author}"),
              trailing: IconButton(onPressed: (){
                _launchUrl(latestNews[index].url);
              }, icon: Icon(Icons.link)),
            );
            },)
    );
  }

  Future<void> _launchUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}
}