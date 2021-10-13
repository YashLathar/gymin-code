import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/dumy-data/products_info.dart';
import 'package:gym_in/dumy-data/review_info.dart';
import 'package:gym_in/pages/favorites_page.dart';
import 'package:gym_in/pages/products_page.dart';
import 'package:gym_in/widgets/review_card.dart';
import 'package:gym_in/widgets/toast_msg.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:reviews_slider/reviews_slider.dart';

class ProductDetailPage extends StatefulWidget {
  final dynamic dataIndex;
  const ProductDetailPage({required this.dataIndex});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late Razorpay _razorpay;

  get dataIndex => 0;
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
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Container(
                width: size.width,
                height: 1310,
                child: Column(
                  children: [
                    Container(
                      color: Colors.redAccent,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.redAccent,
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
                          Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.redAccent,
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.search,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.redAccent,
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FavoritesPage()));
                                    },
                                    icon: Icon(
                                      Icons.favorite,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.redAccent,
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, "/productCartPage");
                                    },
                                    icon: Icon(Icons.shopping_cart),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Hero(
                            tag: widget.dataIndex,
                            child: Image.network(
                              productsData[widget.dataIndex].image,
                            ),
                          ),
                          Divider(
                            thickness: 2.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              productsData[widget.dataIndex].name,
                              style: kSmallContentStyle.copyWith(
                                fontSize: 22,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
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
                                //QuantityCounter(),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 5,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 5,
                                    right: 5,
                                    top: 2,
                                    bottom: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      15,
                                    ),
                                    color: Colors.redAccent,
                                  ),
                                  child: Text("4.1⭐️"),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  child: Text(
                                    "317 ratings",
                                    style: kSmallContentStyle.copyWith(
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 15,
                              right: 15,
                              bottom: 20,
                            ),
                            child: Text(
                              productsData[widget.dataIndex].description,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 3.0,
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25),
                            ),
                          ),
                          context: context,
                          builder: (context) {
                            return OffersandCoupons();
                          },
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                        ),
                        height: 38,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "All offers and Coupons",
                              style: kSmallContentStyle.copyWith(
                                color: Colors.redAccent,
                                fontSize: 16,
                              ),
                            ),
                            Icon(
                              Icons.expand_more,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 3.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 15,
                        bottom: 15,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Deliver to",
                                style: kSmallContentStyle.copyWith(
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                "Ram Ganga Vihar - Moradabad",
                                style: kSmallContentStyle.copyWith(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.car_rental,
                                  ),
                                  Text(
                                    "Free",
                                    style: kSmallContentStyle.copyWith(
                                      fontSize: 13,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Change Address",
                                  style: kSmallContentStyle.copyWith(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.find_replace,
                                  ),
                                  Text(
                                    "Deliver in 3 Days,",
                                    style: kSmallContentStyle.copyWith(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.expand_more,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 7,
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.dollarSign,
                                    size: 17,
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    "Cash On Delivery Available",
                                    style: kSmallContentStyle.copyWith(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.expand_more,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 2.5,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 17,
                          right: 17,
                        ),
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.chat,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Chat to Ask About this Product",
                                  style: kSmallContentStyle.copyWith(fontSize: 16,),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.expand_more,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 3.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Ratings and Reviews",
                                style: kSmallContentStyle,
                              ),
                              TextButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(25),
                                        ),
                                      ),
                                      context: context,
                                      builder: (context) {
                                        return ReviewsPSheet();
                                      });
                                },
                                child: Text(
                                  "Rate Product",
                                  style: kSmallContentStyle.copyWith(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ReviewCard(
                            userPhotoUrl:
                                reviewsData[dataIndex].userPhotoUrl[0],
                            userName: reviewsData[dataIndex].userName,
                            index: 0,
                            button: reviewsData[dataIndex].editButton,
                            height: 30,
                            width: 30,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                        child: Container(
                          width: size.width / 3,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              checkItemInCart(
                                  productsData[widget.dataIndex].price,
                                  context);
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
                    SizedBox(
                      width: 85,
                    ),
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
                                description:
                                    productsData[widget.dataIndex].description,
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

class OffersandCoupons extends StatelessWidget {
  const OffersandCoupons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 30,
      ),
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.drag_handle),
          Text(
            "Offers will be Added Soon",
            style: kSmallContentStyle,
          ),
        ],
      ),
    );
  }
}

class ReviewsPSheet extends StatefulWidget {
  const ReviewsPSheet({Key? key}) : super(key: key);

  @override
  _ReviewsPSheetState createState() => _ReviewsPSheetState();
}

class _ReviewsPSheetState extends State<ReviewsPSheet> {
  bool buttonPressed = false;
  bool buttonnotpressed = false;

  int selectedValue1 = 0;
  int selectedValue2 = 0;
  int selectedValue3 = 0;

  void onChange1(int value) {
    setState(() {
      selectedValue1 = value;
    });
  }

  void onChange2(int value) {
    setState(() {
      selectedValue2 = value;
    });
  }

  void onChange3(int value) {
    setState(() {
      selectedValue3 = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(6),
            child: Icon(Icons.drag_handle),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      "Your Private Feedback",
                      style: kSmallContentStyle.copyWith(
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'How would you rate this Product?',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 20),
                  ReviewSlider(
                    optionStyle: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    onChange: onChange1,
                    initialValue: 4,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      selectedValue1.toString(),
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                  // SizedBox(height: 20),
                  // Text(
                  //   'Your Experience of our Services?',
                  //   style: TextStyle(color: Colors.black, fontSize: 18),
                  // ),
                  // SizedBox(height: 20),
                  // ReviewSlider(
                  //   optionStyle: TextStyle(
                  //     color: Colors.black,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  //   onChange: onChange3,
                  //   initialValue: 3,
                  // ),
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: Text(
                  //     selectedValue3.toString(),
                  //     style: TextStyle(color: Colors.redAccent),
                  //   ),
                  // ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 5.0,
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            buttonnotpressed = true;
                          });
                          await Future.delayed(Duration(seconds: 2));
                          Navigator.pop(context);
                          aShowToast(
                            msg: "Thanks For Your FeedBack",
                          );
                          setState(() {
                            buttonnotpressed = false;
                            buttonPressed = true;
                          });
                        },
                        child: Text(
                          buttonnotpressed ? "Submitting" : "Send Review",
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
