import 'package:flutter/material.dart';
import 'package:nytimes/functions/fetch_data.dart';
import 'package:nytimes/models/article.dart';

class MyArticles extends StatefulWidget {
  const MyArticles({super.key, required this.title});
  final String title;

  @override
  State<MyArticles> createState() => _MyArticlesState();
}

class _MyArticlesState extends State<MyArticles> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: Scaffold(
            appBar: AppBar(
              title:  Text(widget.title, style: const TextStyle(fontSize: 25)),
              backgroundColor: Colors.brown[50],
              foregroundColor: Colors.brown[800],
              toolbarHeight: 80,
              actions: [
                Padding(
                    padding: const EdgeInsets.all(15),
                    child: CircleAvatar(
                      backgroundColor: Colors.brown.shade800,
                      child: const Text('A'),
                    ))
              ],
            ),
            drawer: Drawer(
                backgroundColor: Colors.brown[50],
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.brown[800],
                      ),
                      child: Text(
                        'Drawer Header',
                        style: TextStyle(color: Colors.brown[50]),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.home,
                      ),
                      title: const Text('Page 1'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.train,
                      ),
                      title: const Text('Page 2'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )),
            body: Container(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: FutureBuilder<List<Article>>(
                  future: fetchArticles(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('An error has occurred!'),
                      );
                    } else if (snapshot.hasData) {
                      return ArticlesList(articles: snapshot.data!);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            )));
  }
}

class ArticlesList extends StatelessWidget {
  const ArticlesList({super.key, required this.articles});

  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        String imageUrl;
        if (articles[index].multiMedia.isNotEmpty) {
          imageUrl = articles[index].multiMedia.first['url'];
        } else {
          imageUrl = "";
        }

        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ListTile(
            leading: SizedBox(
                height: 400,
                width: 100,
                child: Image.network(imageUrl, fit: BoxFit.cover)),
            title:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "# ${articles[index].section}",
                style: TextStyle(fontSize: 15, color: Colors.grey[500]),
              ),
              Text(
                articles[index].title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              )
            ]),
            subtitle: Text(articles[index].byLine),
            isThreeLine: true,
          ),
          Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                articles[index].description,
                style: const TextStyle(fontSize: 14),
              ))
        ]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(color: Colors.brown[50], height: 40, thickness: 7);
      },
    );
  }
}
