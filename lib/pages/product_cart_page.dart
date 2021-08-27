import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/dumy-data/products_info.dart';
import 'package:gym_in/widgets/cart_product.dart';
import 'package:gym_in/widgets/order_summary.dart';

class ProductCartPage extends StatelessWidget {
  const ProductCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      color: Color(0xffF2F2F2),
      child: SafeArea(
        child: Container(
          width: size.width,
          height: size.width,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        FontAwesomeIcons.bell,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    CartProduct(
                      productName: productsData[0].name,
                      price: productsData[0].price,
                      imageUrl: productsData[0].image,
                    ),
                    CartProduct(
                      productName: productsData[1].name,
                      price: productsData[1].price,
                      imageUrl: productsData[1].image,
                    ),
                  ],
                ),
              ),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                padding: EdgeInsets.symmetric(horizontal: 15),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Offers",
                      style: kSmallHeadingTextStyle,
                    ),
                    Text(
                      "add a code",
                      style: kSmallContentStyle.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                padding: EdgeInsets.symmetric(horizontal: 15),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Address",
                      style: kSmallHeadingTextStyle,
                    ),
                    Row(
                      children: [
                        Text(
                          "C-129, Ashyina...",
                          style:
                              kSmallContentStyle.copyWith(color: Colors.grey),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              OrderSummary(
                subtotal: "9398",
                shipping: "60",
                total: "9458",
              ),
              Expanded(
                child: Center(
                  child: Container(
                    height: 55,
                    width: size.width / 1.3,
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(20)),
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text(
                        "Go Checkout",
                        style: kSmallContentStyle.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
