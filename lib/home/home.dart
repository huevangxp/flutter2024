import 'package:first_course/Services/productServices.dart';
import 'package:first_course/pages/video/videoplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> items = List<String>.generate(40, (i) => "Item $i");

  String postTitle = 'No title yet';
  var products = [];

  @override
  void initState() {
    // TODO: implement initState
    _fetchPost();
    super.initState();
  }

  void _fetchPost() async {
    try {
    var data = await ProductAPI.getProduct();

    // print('----------------------->' + );
    setState(() {
      products = data['products'];
    });
    } catch (e) {
      setState(() {
        postTitle = 'Failed to load post';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: <Widget>[
           
         
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                var product = products[index];
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => VideoPlayer())));
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: const Border(
                          left: BorderSide(
                            color: Colors.green,
                            width: 3,
                          ),
                          right: BorderSide(
                            color: Colors.green,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Image.network(
                                product['images'][0],
                                width: 100,
                                height: 100,
                              ),
                            ),
                             Flexible(
                              flex: 2,
                              child: Text(
                                product['title'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                             Flexible(
                              flex: 1,
                              child: Text(product['price']),
                            ),
                          ],
                        ),
                      ),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
