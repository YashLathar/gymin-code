import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/dumy-data/products_info.dart';
import 'package:gym_in/widgets/quantity_counter.dart';
import 'package:like_button/like_button.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key, required this.dataIndex})
      : super(key: key);

  final dynamic dataIndex;

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late Razorpay _razorpay;
  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      color: Color(0xffF2F2F2),
      child: Container(
        margin: EdgeInsets.only(top: 50),
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Detail",
                        style: kSubHeadingStyle,
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: LikeButton(
                        size: 25,
                        bubblesSize: 500,
                        animationDuration: Duration(milliseconds: 1500),
                        circleColor: CircleColor(
                            start: Color(0xff00ddff), end: Color(0xff0099cc)),
                        bubblesColor: BubblesColor(
                          dotPrimaryColor: Color(0xff33b5e5),
                          dotSecondaryColor: Color(0xff0099cc),
                        ),
                        likeBuilder: (bool isLiked) {
                          return Icon(
                            Icons.favorite,
                            color: isLiked ? Colors.redAccent : Colors.black,
                            size: 25,
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Hero(
                tag: widget.dataIndex,
                child: Image.network(
                  productsData[widget.dataIndex].image,
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: size.width,
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          productsData[widget.dataIndex].name,
                          style: kSubHeadingStyle,
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "₹" +
                                  productsData[widget.dataIndex]
                                      .price
                                      .substring(0, 4),
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 40,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                            QuantityCounter(),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          productsData[widget.dataIndex].description,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 15),
                            child: Center(
                              child: Container(
                                width: size.width / 3,
                                decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(15)),
                                child: MaterialButton(
                                  onPressed: () {
                                    // openCheckout(
                                    //   name: productsData[widget.dataIndex].name,
                                    //   price: productsData[widget.dataIndex].price,
                                    //   description: productsData[widget.dataIndex]
                                    //       .description,
                                    //   image: productsData[widget.dataIndex].image,
                                    // );
                                  },
                                  child: Text(
                                    "Add to Cart",
                                    style: kSmallContentStyle.copyWith(
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 85,),
                          Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        child: Center(
                          child: Container(
                            width: size.width / 3,
                            decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(15)),
                            child: MaterialButton(
                              onPressed: () {
                                openCheckout(
                                  name: productsData[widget.dataIndex].name,
                                  price: productsData[widget.dataIndex].price,
                                  description: productsData[widget.dataIndex]
                                      .description,
                                  image: productsData[widget.dataIndex].image,
                                );
                              },
                              child: Text(
                                "Buy Now",
                                style: kSmallContentStyle.copyWith(
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(
      {String? name, String? description, String? price, String? image}) async {
    var options = {
      'key': 'rzp_test_8NBNETBLt7d5Bg',
      'amount': price,
      'name': name,
      'description': description,
      'image': image,
      'prefill': {'contact': '9876543210', 'email': 'test@pay.com'},
    };
    _razorpay.open(options);
  }
}
