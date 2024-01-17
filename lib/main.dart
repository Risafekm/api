import 'package:api/provider/test_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderOperation(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Provider Api'),
      ),
    );
  }
}

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
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Text(posts[index].mTestId.toString()),
                  tileColor: Colors.grey.withOpacity(0.2),
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
                  trailing: IconButton(
                      onPressed: () {
                        value.SendActivity({"userid": posts[index].userId});
                      },
                      icon: Icon(Icons.send)),
                ),
              );
            },
          );
        }));
  }
}
