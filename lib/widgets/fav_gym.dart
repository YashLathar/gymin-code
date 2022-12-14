import 'package:flutter/material.dart';
import 'package:gym_in/controllers/favourites_controller.dart';
import 'package:gym_in/services/favourites_service.dart';
import 'package:gym_in/widgets/toast_msg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FavGym extends HookConsumerWidget {
  const FavGym({
    Key? key,
    required this.imageUrl,
    required this.gymName,
    required this.gymId,
    required this.address,
  }) : super(key: key);

  final String imageUrl;
  final String gymName;
  final String gymId;
  final String address;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favController = ref.watch(favouritesControllerProvider);
    final favService = ref.watch(favServiceProvider);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      height: 160,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).scaffoldBackgroundColor),
      child: Row(
        children: [
          Container(
            width: 130,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                imageUrl,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  gymName,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  address.length > 35
                      ? address.substring(0, 35) + "..."
                      : address + " ...",
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2.0,
                            color: Colors.redAccent,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            await favService.deleteGymFromFav(gymId);
                            favController.removeGym(gymId);
                            aShowToast(msg: "Removed from Favourites");
                          },
                          child: Text(
                            "Remove",
                            style: TextStyle(
                                color: Theme.of(context).backgroundColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
