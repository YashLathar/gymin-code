import 'package:flutter/material.dart';
import 'package:gym_in/constants.dart';

class ProductCartPage extends StatelessWidget {
  ProductCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      color: Color(0xffF2F2F2),
      child: SafeArea(
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.width,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "My Cart",
                              style: kSubHeadingStyle,
                            ),
                          ),
                        ),
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.add_shopping_cart_outlined,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 240,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/img/empty-cart.gif",
                          height: 175.0,
                          width: 150.0,
                        ),
                        Text(
                          "Your Cart is Empty",
                          style: kSmallContentStyle,
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                       height: 70,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          "Try Adding some Products",
                          style: kSmallContentStyle,
                        ),
                      )
                      // Image.network(
                      //   "https://c.tenor.com/tkbRMbqhR2UAAAAM/app-online-store.gif",
                      //   height: 200,
                      //   width: 180,
                      // color: Colors.white,
                      // ),
                      ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding:
                    EdgeInsets.only(bottom: 15, left: 15, right: 15, top: 15),
                color: Colors.white,
                width: size.width,
                child: Container(
                  height: 65,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Start Shopping",
                      style: kSubHeadingStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
