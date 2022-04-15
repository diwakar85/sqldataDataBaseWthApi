import 'package:apiandsql/modelClass/apiModel.dart';
import 'package:apiandsql/services/httpRequest.dart';
import 'package:flutter/material.dart';
import '../helper/dbHelper.dart';

class FatchData extends StatefulWidget {
  const FatchData({Key? key}) : super(key: key);

  @override
  State<FatchData> createState() => _FatchDataState();
}

class _FatchDataState extends State<FatchData> {
  HttpRequest httpRequest = HttpRequest();
  late Future<List<Post>> fetchdata;
  @override
  void initState() {
    super.initState();
    createDB();
    fetchPostData();
  }

  createDB() async {
    DBHelper.dbHelper.initDB();
    print("table create");
  }

  fetchPostData() {
    fetchdata = httpRequest.fetchAllData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("All Data"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  onChanged: (val) {
                    Future<List<Post>> response =
                        DBHelper.dbHelper.fetchSearchedData(val);
                    setState(() {
                      fetchdata = response;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "Search by id...",
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 12,
              child: FutureBuilder(
                  future: fetchdata,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("${snapshot.error}"),
                      );
                    } else if (snapshot.hasData) {
                      List<Post> data = snapshot.data as List<Post>;
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            Post p1 = data[index];
                            return Card(
                              margin: const EdgeInsets.all(10),
                              elevation: 5,
                              shadowColor: Colors.green,
                              child: ListTile(
                                leading: Text(
                                  p1.id.toString(),
                                  style: const TextStyle(fontSize: 22),
                                ),
                                title: Text(
                                  "${p1.title}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                                subtitle: Text(
                                  "${p1.body}",
                                  textDirection: TextDirection.ltr,
                                ),
                              ),
                            );
                          });
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            )
          ],
        ));
  }
}
