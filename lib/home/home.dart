import 'package:flutter/material.dart';
import 'package:first_course/Services/productServices.dart';
import 'package:first_course/pages/video/videoplayer.dart';
import 'package:badges/badges.dart' as badges;

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
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> products = [];
  int cartCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  void _fetchProducts() async {
    try {
      var res = await ApiService.getProduct();
      print('------>' + res.toString());
      setState(() {
        products = res['data']['items'];
      });
    } catch (e) {
      print('Error fetching products: $e');
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            child: badges.Badge(
              badgeStyle: badges.BadgeStyle(badgeColor: Colors.white),
              position: badges.BadgePosition.topEnd(top: 0, end: 0),
              badgeContent: Text(
                '$cartCount',
                style: TextStyle(color: Colors.red),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.add_shopping_cart,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  // Navigate to cart page or show cart details
                },
              ),
            ),
          )
        ],
        title: Text(
          'All Products',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
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
                      MaterialPageRoute(builder: (context) => VideoPlayer()),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
                            child:  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      'https://filesduab.tojsiab.com/square/450/${product['images'][0]}', scale: 1.0,
                                      
                                    ),
                                  ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            product['description'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Views: ${product['view']}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    cartCount++;
                                    // Implement logic to add product to cart
                                  });
                                },
                                child: Text('Add to cart'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
