import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/pages/product_detail_page.dart';
import 'package:gym_in/widgets/product_card.dart';

class GymProductsPage extends StatefulWidget {
  const GymProductsPage({Key? key}) : super(key: key);

  @override
  State<GymProductsPage> createState() => _GymProductsPageState();
}

class _GymProductsPageState extends State<GymProductsPage> {
  final Stream<QuerySnapshot> _productStream =
      FirebaseFirestore.instance.collection('product').snapshots();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
      stream: _productStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Container(
              height: 50,
              width: 50,
              child: Center(
                child: Text("Something Went Wrong"),
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Container(
              height: 50,
              width: 50,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: size.height,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Discover our best Products",
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/productCartPage");
                          },
                          icon: Icon(
                            Icons.shopping_cart,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: CupertinoSearchTextField(
                      padding: EdgeInsets.all(16),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Popular',
                          style: kSubHeadingStyle,
                        ),
                        // Text(
                        //   'View all',
                        //   style: kSmallContentStyle.copyWith(
                        //       color: Colors.redAccent),
                        // )
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 350,
                          crossAxisSpacing: 15),
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailPage(
                                  productID: document.id,
                                  title: data['title'],
                                  image: data['image'],
                                  price: data['price'],
                                  description: data['description'],
                                  rating: data['rating'],
                                ),
                              ),
                            );
                          },
                          child: ProductCard(
                            productId: document.id,
                            title: data['title'],
                            image: data['image'],
                            price: data['price'].toString(),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
