import 'package:flutter/material.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:like_button/like_button.dart';
// import 'package:gym_in/dumy-data/posts_info.dart';
// import 'package:gym_in/models/post.dart';
// import 'package:gym_in/widgets/post_widget.dart';

class FeedsPage extends StatefulWidget {
  // final String postId;
  // final String ownerId;
  // final String username;
  // final String location;
  // final String description;
  // final String mediaUrl;
  // final dynamic likes;

  // post ({
  // this.postId,
  // this.ownerId,
  // this.username,
  // this.location,
  // this.description,
  // this.mediaUrl,
  // this.likes,
  // });

  // factory Post.fromDocument(DocumentSnapshot doc) {
  //   return Post(
  //     postId: doc['postId'],
  //     ownerId: doc['ownerId'],
  //     username: doc['username'],
  //     location: doc['location'],
  //     description: doc['description'],
  //     mediaUrl: doc['mediaUrl'],
  //     likes: doc['likes'],
  //   );
  // }

  // int getLikeCount(likes) {
  //   // if no likes return 0
  //   if (likes == null) {
  //     return 0;
  //   }
  //   int  count = 0;
  //   // if key is set to true, add likes
  //   likes.values.forEach((val) {
  //     if (val == true) {
  //       count += 1;
  //     }
  //   });
  //   return count;
  // }

  @override
  _FeedsPageState createState() => _FeedsPageState(
      // postId: this.postId,
      // ownerId: this.ownerId,
      // username: this.username,
      // location: this.location,
      // description: this.description,
      // mediaUrl: this.mediaUrl,
      // likes: this.likes,
      // likeCount: getLikeCount(this.likes),
      );
}

class _FeedsPageState extends State<FeedsPage> {
  // final String postId;
  // final String ownerId;
  // final String username;
  // final String location;
  // final String description;
  // final String mediaUrl;
  // int likeCount;
  // Map likes;

  // _PostState({
  // this.postId,
  // this.ownerId,
  // this.username,
  // this.location,
  // this.description,
  // this.mediaUrl,
  // this.likes,
  // this.likeCount,
  // });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            'Feeds',
            style: kSmallHeadingTextStyle.copyWith(
              color: Theme.of(context).textTheme.bodyText2!.color,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => UploadPage()));
              },
              icon: Icon(
                Icons.add_a_photo,
                color: Theme.of(context).textTheme.bodyText2!.color,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).textTheme.bodyText2!.color,
              ),
            ),
          ],
          // Row(
          //   children: [

          //     SizedBox(
          //       width: 205.0,
          //     ),
          //
          //   ],
          // ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PostHeader(),
              PostImage(),
              PostFooter(),
            ],
          ),
        )
        // Container(
        //   child: ListView.builder(
        //     itemBuilder: (context, index) {
        //       return PostWidget(
        //         image: postData[index].image,
        //         userName: postData[index].userName,
        //         userImage: postData[index].userImage,
        //       );
        //     },
        //     itemCount: postData.length,
        //   ),
        // ),
        );
  }
}

class PostHeader extends HookConsumerWidget {
  const PostHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authControllerState = ref.watch(authControllerProvider);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          authControllerState!.photoURL ??
              "https://fanfest.com/wp-content/uploads/2021/02/Loki.jpg",
        ),
      ),
      title: GestureDetector(
        onTap: () => print("showing profile"),
        child: Text(
          authControllerState.displayName ?? 'username',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyText2!.color),
        ),
      ),
      subtitle: Text(
        "ChimiChangas",
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText2!.color,
        ),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.more_vert,
          color: Theme.of(context).textTheme.bodyText2!.color,
        ),
      ),
    );
  }
}

class PostImage extends HookConsumerWidget {
  const PostImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authControllerState = ref.watch(authControllerProvider);
    return GestureDetector(
      onDoubleTap: () {},
      child: Stack(
        alignment: Alignment.center,
        children: [
          //profile pic as post image for example
          Image.network(authControllerState!
                  .photoURL ?? // 'mediaUrl' instead for the post image
              "https://fanfest.com/wp-content/uploads/2021/02/Loki.jpg")
        ],
      ),
    );
  }
}

class PostFooter extends HookConsumerWidget {
  const PostFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authControllerState = ref.watch(authControllerProvider);
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 40.0, left: 20.0)),
          LikeButton(
            size: 25,
            bubblesSize: 500,
            animationDuration: Duration(milliseconds: 1500),
            circleColor:
                CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
            bubblesColor: BubblesColor(
              dotPrimaryColor: Color(0xff33b5e5),
              dotSecondaryColor: Color(0xff0099cc),
            ),
            likeBuilder: (bool isLiked) {
              return Icon(
                Icons.favorite_border,
                color: isLiked
                    ? Colors.redAccent
                    : Theme.of(context).textTheme.bodyText2!.color,
                size: 25,
              );
            },
          ),
          Padding(padding: EdgeInsets.only(right: 20.0)),
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.chat,
              size: 25.0,
              color: Theme.of(context).textTheme.bodyText2!.color,
            ),
          ),
        ],
      ),
      Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20.0),
            child: Text(
              "14 likes", //"$likeCount likes" instead
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText2!.color,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20.0),
            child: Text(
              authControllerState!.displayName ?? 'Username',
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText2!.color,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
              child: Text(
            "Maximum Effort!!",
            style: TextStyle(fontWeight: FontWeight.w500),
          ))
        ],
      ),
      SizedBox(
        height: 20,
      ),
      Container(
        height: 100,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Text(
          "Coming Soon...",
          style: kSmallContentStyle.copyWith(color: Colors.redAccent),
        ),
      ),
    ]);
  }
}
