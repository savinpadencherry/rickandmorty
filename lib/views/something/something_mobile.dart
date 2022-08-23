part of something_view;

class _SomethingMobile extends StatefulWidget {
  final SomethingViewModel viewModel;

  _SomethingMobile(this.viewModel);

  @override
  State<_SomethingMobile> createState() => _SomethingMobileState();
}

class _SomethingMobileState extends State<_SomethingMobile> {
  int currentIndex = 0;
  List<SwipeItem> likeList = [];
  List<SwipeItem> unlikeList = [];
  @override
  Widget build(BuildContext context) {
    likeList = context.read<RickAndMortyRepository>().likeItems;
    unlikeList = context.read<RickAndMortyRepository>().unlikeItems;
    final screens = [
      likescreen(likeList),
      Unlikescreen(unlikeList),
    ];
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,

        onTap: (index) => setState(() {
          currentIndex = index;
        }),
        //   selectedItemColor: const Color.fromRGBO(0, 125, 254, 1),
        //   unselectedItemColor: const Color.fromRGBO(203, 228, 254, 1),

        selectedItemColor: const Color.fromRGBO(0, 125, 254, 1),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        iconSize: 30,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
              ),
              label: 'Liked'),
          BottomNavigationBarItem(
              icon: Icon(Icons.thumb_down_sharp), label: 'Disliked'),
        ],
      ),
    );
  }

  Center likescreen(List<SwipeItem> likeList) {
    return Center(
      child: Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  offset: Offset(1, 3), color: Colors.grey, blurRadius: 3),
            ]),
        child: SwipeCards(
            matchEngine: MatchEngine(swipeItems: likeList),
            onStackFinished: () {},
            itemBuilder: (context, index) {
              return SwipeItemDesign(
                  imageUrl: likeList[index].content,
                  name: likeList[index].content,
                  species: likeList[index].content);
            }),
      ),
    );
  }

  Center Unlikescreen(List<SwipeItem> unLikeList) {
    return Center(
      child: Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  offset: Offset(1, 3), color: Colors.grey, blurRadius: 3),
            ]),
        child: SwipeCards(
            matchEngine: MatchEngine(swipeItems: unlikeList),
            onStackFinished: () {},
            itemBuilder: (context, index) {
              return SwipeItemDesign(
                imageUrl: unlikeList[index].content,
                name: unlikeList[index].content,
                species: unlikeList[index].content,
              );
            }),
      ),
    );
  }
}
