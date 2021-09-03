        //  Container(
        //         padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        //         child: TabBar(
        //           indicatorColor: Colors.cyan,
        //           controller: _tabController,
        //           tabs: [
        //             Tab(
        //               child: Text(
        //                 'Posts',
        //                 style: kSmallHeadingTextStyle,
        //               ),
        //             ),
        //             Tab(
        //               child: Text(
        //                 'Gyms visited',
        //                 style: kSmallHeadingTextStyle,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       Expanded(
        //         child: TabBarView(
        //           controller: _tabController,
        //           children: [
        //             UserPostWidget(images: [
        //               "https://images.pexels.com/photos/2294361/pexels-photo-2294361.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
        //               "https://images.pexels.com/photos/3490348/pexels-photo-3490348.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
        //               "https://images.pexels.com/photos/1865131/pexels-photo-1865131.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
        //               "https://images.pexels.com/photos/2294361/pexels-photo-2294361.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
        //             ]),
        //             ListView.builder(
        //                 scrollDirection: Axis.vertical,
        //                 itemCount: gymsData.length,
        //                 itemBuilder: (context, index) {
        //                   return GymCard(
        //                     gymName: gymsData[index].gymName,
        //                     gymPhotoUrl: gymsData[index].gymPhotoUrl[0],
        //                     index: index,
        //                     ratings: gymsData[index].ratings,
        //                     isCurrentlyOpen: gymsData[index].isOpen,
        //                     address: gymsData[index].address,
        //                   );
        //                 }),
        //           ],
        //         ),
        //       )
        //     ],     
        //   ),
        // ),