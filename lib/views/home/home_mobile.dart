// ignore_for_file: prefer_const_constructors, sort_child_properties_last

part of home_view;

class _HomeMobile extends StatefulWidget {
  final HomeViewModel viewModel;

  const _HomeMobile(this.viewModel);

  @override
  State<_HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<_HomeMobile> {
  @override
  void initState() {
    context.read<RickandmortyBloc>().add(OnAppStartEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RickandmortyBloc, RickandmortyState>(
      listener: (context, state) {
        if (state.dataStatus == Constants.dataLoadingFailureDue) {
          app<NavigatorService>().buildAndPush(NewsignupView());
        }
        if (state.dataStatus == Constants.dataReceivedAndMapped) {
          app<NavigatorService>().buildAndPushReplacement(
            HomeViewWidgets(
                items: context.read<RickAndMortyRepository>().cardView),
          );
        }
      },
      builder: (context, state) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class HomeViewWidgets extends StatelessWidget {
  const HomeViewWidgets({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<SwipeItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Rick and Morty'),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(1, 3),
                          color: Colors.grey,
                          blurRadius: 3),
                    ]),
                child: SwipeCards(
                    matchEngine: MatchEngine(swipeItems: items),
                    onStackFinished: () {
                      app<NavigatorService>().buildAndPush(SomethingView());
                    },
                    itemBuilder: (context, index) {
                      return SwipeItemDesign(
                          imageUrl: items[index].content,
                          name: items[index].content,
                          species: items[index].content);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
