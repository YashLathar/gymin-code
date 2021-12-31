import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_in/controllers/cart_controller.dart';
import 'package:gym_in/pages/product_detail_page.dart';
import 'package:gym_in/widgets/product_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GymProductsPage extends HookWidget {
  GymProductsPage({Key? key}) : super(key: key);
  final Stream<QuerySnapshot> _productStream =
      FirebaseFirestore.instance.collection('product').snapshots();

  @override
  Widget build(BuildContext context) {
    final cartControllerProvider = useProvider(cartProvider);
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
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              color: Theme.of(context).scaffoldBackgroundColor,
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
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                border: Border.all(
                                  width: 2.0,
                                  color: Theme.of(context).backgroundColor,
                                ),
                              ),
                              child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, "/productCartPage");
                                  },
                                  icon: Icon(
                                    Icons.shopping_cart,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .color,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                child: Center(
                                  child: Text(cartControllerProvider
                                      .products.length
                                      .toString()),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: CupertinoSearchTextField(
                      backgroundColor: Colors.grey[300],
                      padding: EdgeInsets.all(16),
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text(
                  //         'Popular',
                  //         style: kSubHeadingStyle.copyWith(
                  //             color:
                  //                 Theme.of(context).textTheme.bodyText2!.color),
                  //       ),
                  //       // Text(
                  //       //   'View all',
                  //       //   style: kSmallContentStyle.copyWith(
                  //       //       color: Colors.redAccent),
                  //       // )
                  //     ],
                  //   ),
                  // ),
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
                                  inStock: data['inStock'],
                                ),
                              ),
                            );
                          },
                          child: ProductCard(
                            productId: document.id,
                            title: data['title'],
                            description: data['description'],
                            image: data['image'],
                            price: data['price'],
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
