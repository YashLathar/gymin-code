import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/controllers/favourites_controller.dart';
import 'package:gym_in/models/gym.dart';
import 'package:gym_in/services/favourites_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:like_button/like_button.dart';

class GymCard extends HookConsumerWidget {
  GymCard({
    required this.gymId,
    required this.gymphotos,
    required this.gymPhoto,
    required this.gymName,
    required this.gymratings,
    required this.gymopen,
    required this.gymaddress,
    required this.trainername,
    required this.trainerphoto,
    required this.trainerrating,
    required this.traineravailable,
  });

  final bool gymopen, traineravailable;
  final List gymphotos;
  final String gymId,
      gymName,
      gymPhoto,
      gymratings,
      gymaddress,
      trainername,
      trainerphoto,
      trainerrating;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favGymsController = ref.watch(favouritesControllerProvider);
    final favService = ref.watch(favServiceProvider);
    Future<bool> onLikeButtonTapped(bool isLiked) async {
      final thisGym =
          favGymsController.favGyms.where((gym) => gym.gymId == gymId);

      if (thisGym.isEmpty) {
        final gym = Gym(
          gymName: gymName,
          gymPhoto: gymPhoto,
          gymphotos: gymphotos,
          gymratings: gymratings,
          gymopen: gymopen,
          gymaddress: gymaddress,
          trainername: trainername,
          trainerphoto: trainerphoto,
          trainerrating: trainerrating,
          traineravailable: traineravailable,
          gymId: gymId,
        );

        await favService.addGymToFav(gym);

        favGymsController.addGymToFav(gym);

        Fluttertoast.showToast(msg: "Added to Favourites");
        return isLiked = true;
      } else {
        Fluttertoast.showToast(msg: "Already in Favourites");
        return isLiked;
      }
    }

    return Container(
      width: 270,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 250,
                    height: 190,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Image.network(
                      gymPhoto,
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
                Positioned(
                  right: 15,
                  top: 15,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white.withOpacity(0.4),
                    ),
                    child: Center(
                      child: LikeButton(
                        onTap: onLikeButtonTapped,
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
                            color: isLiked ? Colors.redAccent : Colors.white,
                            size: 25,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  gymName,
                  style: kLoginPageSubHeadingTextStyle.copyWith(
                    color: Theme.of(context).textTheme.bodyText2!.color,
                    fontSize: 23,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        gymopen ? "Open" : "Closed",
                        style: TextStyle(
                            color: gymopen ? Colors.green : Colors.redAccent),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color:
                                  Theme.of(context).textTheme.bodyText2!.color,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .color,
                              ),
                              child: Center(
                                child: Text(
                                  gymratings.toString(),
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
