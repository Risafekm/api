import 'package:api/provider/user_provider.dart';
import 'package:api/ui/edit_page.dart';
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
      Provider.of<UserProvider>(context, listen: false).getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Consumer<UserProvider>(builder: (context, value, child) {
        if (value.isLoding) {
          return const CircularProgressIndicator();
        }
        final posts = value.posts;
        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            var user = posts[index];
            return Card(
                child: ListTile(
              onTap: () async {
                controller.editmodIdController.text = user.modNum.toString();
                controller.edituserIdController.text = user.userId.toString();
                controller.editmtestPointsController.text =
                    user.mTestPoints.toString();
                controller.editstatusController.text = user.status.toString();

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditPage(user: user)));
              },
              leading: Text(posts[index].mTestId.toString()),
              tileColor: Colors.blue.withOpacity(0.2),
              title: Text(
                posts[index].userId.toString(),
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Column(
                children: [
                  Text(posts[index].modNum.toString()),
                  Text(posts[index].mTestPoints.toString()),
                  // Text(posts[index].status.toString()),
                ],
              ),
              trailing: GestureDetector(
                  onTap: () async {
                    controller.deleteData(user.mTestId.toString());
                    print('clicked');
                  },
                  child: const Icon(Icons.delete, color: Colors.red)),
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
