import 'package:api/provider/test_provider.dart';
import 'package:api/ui/insert_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProviderOperation>(context, listen: false).getAllPosts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Consumer<ProviderOperation>(builder: (context, value, child) {
        if (value.isLoding) {
          return const CircularProgressIndicator();
        }
        final posts = value.posts;
        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return Card(
                child: ListTile(
              leading: Text(posts[index].mTestId.toString()),
              tileColor: Colors.blue.withOpacity(0.2),
              title: Text(
                posts[index].userId.toString(),
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Column(
                children: [
                  Text(posts[index].modNum.toString()),
                  // Text(posts[index].mtest_points.toString()),
                  Text(posts[index].status.toString()),
                ],
              ),
            ));
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const InsertPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
