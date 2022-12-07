import 'package:flutter/material.dart';
import 'package:flutter_demo/backend/home_controller.dart';
import 'package:flutter_demo/model/post_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future? getFutureData;
  List<PostsModel> postsModel = [];

  Future<void> getData()async{
    postsModel = await HomeController().getPostsData();
  }

  @override
  void initState() {
    super.initState();
    getFutureData = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home"),centerTitle: true,),
      body: getBody(),
    );
  }

  Widget getBody() {
    return FutureBuilder(
      future: getFutureData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
      if(snapshot.connectionState == ConnectionState.done){
        return getPostsListView();
      } else {
        return  Center(
          child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),
        );
      }
    });
  }

  Widget getPostsListView(){
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: postsModel.length,
        itemBuilder: (BuildContext context, int index){
          PostsModel pm = postsModel[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ExpansionTile(
                  expandedAlignment: Alignment.centerLeft,
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${index+1}"),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(pm.title,style: const TextStyle(fontWeight: FontWeight.bold),),
                            const SizedBox(height: 5,),
                            Text(pm.body,maxLines: 1,overflow: TextOverflow.ellipsis)
                          ],
                        ),
                      ),
                    ],
                  ),
                  // subtitle: "•",
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            text:"",
                            style: const TextStyle(fontSize: 20, color: Colors.black,),
                            children: [
                              TextSpan(
                                text: pm.body,
                                style: const TextStyle(fontSize: 14, color: Colors.black87),
                              )
                            ]
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
    );
  }
}
