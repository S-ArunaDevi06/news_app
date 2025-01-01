import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  
List<dynamic> news=[];
int selected=0;

void onTapping(int index)
{
  setState(() {
    selected=index;
  });
}

Future<void> fetchNews(String category) async
{
  if (category==' '){
  print('FETCH NEWS WORKED!');
  String apiKey = YOUR_API_KEY;
  String url = "http://newsapi.org/v2/top-headlines?country=in&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=${apiKey}";
  final uri=Uri.parse(url);
  var response = await http.get(uri);

  var jsonData = jsonDecode(response.body);


  if(jsonData['status'] == "ok"){
  news=jsonData['articles'];
  }
  }
  else if (category=='business')
    {
      print('FETCH NEWS WORKED!');
      String apiKey = "YOUR_API_KEY";
      String url = "http://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=${apiKey}";
      final uri=Uri.parse(url);
      var response = await http.get(uri);

      var jsonData = jsonDecode(response.body);


      if(jsonData['status'] == "ok"){
        news=jsonData['articles'];
      }
    }
  else if (category=='sports')
  {
    print('FETCH NEWS WORKED!');
    String apiKey = "YOUR_API_KEY";
    String url = "http://newsapi.org/v2/top-headlines?country=in&category=sports&apiKey=${apiKey}";
    final uri=Uri.parse(url);
    var response = await http.get(uri);

    var jsonData = jsonDecode(response.body);


    if(jsonData['status'] == "ok"){
      news=jsonData['articles'];
    }
  }

  else if (category=='health')
  {
    print('FETCH NEWS WORKED!');
    String apiKey = "YOUR_API_KEY";
    String url = "http://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=${apiKey}";
    final uri=Uri.parse(url);
    var response = await http.get(uri);

    var jsonData = jsonDecode(response.body);


    if(jsonData['status'] == "ok"){
      news=jsonData['articles'];
    }
  }

  //print(news);
}


  @override
  Widget build(BuildContext context) {

    //print(news);
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed:(){setState(() {
        fetchNews(' ');
      });},child: Icon(Icons.refresh),),
      backgroundColor: Colors.white,
      appBar:AppBar(title: Text('NEWS',style: TextStyle(color: Colors.brown[900]),),backgroundColor: Colors.amber,centerTitle: true,),
      body:ListView.builder(
        itemCount: news.length,
        itemBuilder: (context,index)
          {
            //print('entered');
            final title_=news[index]['title'];
            final description=news[index]['description'];
            String imageurl='';
            if (news[index]['urlToImage']==null)
              {
                imageurl='https://artsmidnorthcoast.com/wp-content/uploads/2014/05/no-image-available-icon-6.png';
              }
            else
              {
                imageurl=news[index]['urlToImage'];
              }

            print(title_);
            return ListTile(
              //onTap:() {},
              leading: ClipRRect(
                child:CircleAvatar(child: Image.network(imageurl),radius: 50,),
              ),
              title: Text(title_,style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Text(description),
            );
          }
      ),
        bottomNavigationBar: NavigationBar(destinations: const[
    NavigationDestination(icon: Icon(Icons.home), label: "HOME",selectedIcon: Icon(Icons.home),),
          NavigationDestination(icon: Icon(Icons.business), label: 'Business'),
          NavigationDestination(icon: Icon(Icons.sports), label: 'Sports'),
          NavigationDestination(icon: Icon(Icons.health_and_safety), label: 'health'),
      ],
          onDestinationSelected: (int index)
          {
            setState(() {
              selected=index;
              if (index==1)
              {
                 setState(() {
                   fetchNews('business');
                 });
              }
              else if (index==0)
                {
                  setState(() {
                    fetchNews(' ');
                  });
                }
              else if (index==2)
                {
                  setState(() {
                    fetchNews('sports');
                  });
                }
              else if (index==3)
                {
                  setState(() {
                    fetchNews('health');
                  });
                }
            });
          },
          indicatorColor: Colors.grey,
          selectedIndex: selected,
        ),

    );
  }
}
