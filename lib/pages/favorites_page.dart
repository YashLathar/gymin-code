import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/controllers/favourites_controller.dart';
import 'package:gym_in/widgets/fav_gym.dart';
import 'package:gym_in/widgets/fav_product.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FavoritesPage extends HookWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favProducts = useProvider(favouritesControllerProvider).favProducts;
    final favGyms = useProvider(favouritesControllerProvider).favGyms;
    final tabController = useTabController(initialLength: 2);
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(
                        width: 2.0, color: Theme.of(context).backgroundColor),
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Theme.of(context).textTheme.bodyText2!.color,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Your Favourites",
                      style: kSubHeadingStyle.copyWith(
                          color: Theme.of(context).textTheme.bodyText2!.color),
                    ),
                  ),
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(
                      width: 2.0,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.plus,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: size.width,
            height: 75,
            child: TabBar(
              controller: tabController,
              indicatorColor: Colors.redAccent,
              tabs: [
                Tab(
                  child: Text(
                    "Products",
                    style: TextStyle(fontSize: 22,
                    color: Theme.of(context).textTheme.bodyText2!.color
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Gyms",
                    style: TextStyle(fontSize: 22,
                    color: Theme.of(context).textTheme.bodyText2!.color
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                ListView(
                  children: favProducts
                      .map((product) => FavProduct(
                            productId: product.productId,
                            imageUrl: product.image,
                            quantity: product.quantity,
                            price: product.price.toString(),
                            productName: product.title,
                          ))
                      .toList(),
                ),
                ListView(
                  children: favGyms
                      .map((gym) => FavGym(
                            gymId: gym.gymId,
                            imageUrl: gym.gymPhoto,
                            address: gym.gymaddress,
                            gymName: gym.gymName,
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
