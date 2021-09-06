import 'package:flutter/material.dart';
import 'package:gym_in/pages/products_page.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.name,
    required this.price,
    required this.image,
    required this.index,
  }) : super(key: key);

  final int index;
  final String image;
  final String name;
  final String price;

  get removefromcart => null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          "/productDetailPage",
          arguments: index,
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          child: Column(
            children: [
              Container(
                child: Hero(
                  tag: index,
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ),
              Container(
                height: 120,
                padding: EdgeInsets.symmetric(horizontal: 15),
                width: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffF2F2F2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "₹" + price.substring(0, 4),
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.redAccent),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: removefromcart == null ?
                            IconButton(onPressed: () {
                              checkItemInCart(price, context);
                            }, 
                            icon: Icon(
                              Icons.add_shopping_cart)
                            )
                            : IconButton(
                              onPressed: () {}, 
                              icon: Icon(Icons.remove_shopping_cart)
                            )
                            // child: Center(
                            //   child: Icon(
                            //     FontAwesomeIcons.plus,
                            //     size: 15,
                            //     color: Colors.white,
                            //   ),
                            // ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
