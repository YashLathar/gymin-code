import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/dumy-data/products_info.dart';
import 'package:gym_in/widgets/product_card.dart';

class GymProductsPage extends StatelessWidget {
  const GymProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          Navigator.pushNamed(context, "/productCartPage");
        },
        child: Center(
          child: Icon(
            Icons.shopping_cart,
          ),
        ),
      ),
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
                                fontSize: 35, fontWeight: FontWeight.w900)),
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
                    Text(
                      'View all',
                      style:
                          kSmallContentStyle.copyWith(color: Colors.redAccent),
                    )
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.only(bottom: 50),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 350,
                      crossAxisSpacing: 15),
                  itemBuilder: (BuildContext context, index) {
                    return ProductCard(
                      index: index,
                      name: productsData[index].name,
                      image: productsData[index].image,
                      price: productsData[index].price,
                    );
                  },
                  itemCount: productsData.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void checkItemInCart(String price, BuildContext context) {
  // gyminFlutter.sharedPreferences.getStringList(gyminFlutter.userCartList).contains(price)
  // ? Fluttertoast.showToast(msg: "Item is already in cart.")
  // : addItemToCart(price, context);
}

addItemToCart(String price, BuildContext context) {
  // List tempCartList = gyminFlutter.sharedPreferences.getStringList(gyminFlutter.userCartList);
  // tempCartList.add(price);

  // gyminFlutter.firestore.collection(gyminflutter.collectionUser)
  // .document(gyminFlutter.sharedpreferences.getString(gyminFlutter.UserUID))
  // .updateData({
  //   gyminFlutter.UserCartList: tempCartList,
  // }).then((v) {
  //   Fluttertoast.showToast(msg: "Item Added to cart Successfully.");
  //   gyminFlutter.sharedPreferences.setStringList(gyminFlutter.userCartList, tempCartList);
  //   Provider.of<CartItemCounter>(context, listen: false).displayResult();
  // });
}