import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

//##########################
//main app
//##########################
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Gain Gauge',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 42, 158, 82)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

//##########################
//App state handling
//##########################

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  void delete(pair){
    if (favorites.contains(pair)) {
      favorites.remove(pair);
      notifyListeners();
    }

  }


}

//##########################
//home page 
//##########################

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//##########################
//home page state
//##########################

// the _ makes the class private
class _MyHomePageState extends State<MyHomePage> {

  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavoritesPage();
        break;
      case 2:
        page = EditPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }


    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
        
              // child 1
              SafeArea(
                child: NavigationRail(

                  // True if available width is above 600
                  extended: constraints.maxWidth >= 600,
                  destinations: [
        
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
        
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text('Favorites'),
                    ),
        
                    NavigationRailDestination(
                      icon: Icon(Icons.edit),
                      label: Text('Edit'),
                    ),

                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
        
                    // makes changes and ensures listeners notice
                    setState(() {
                      selectedIndex = value;
                    });
        
                  },
                ),
              ),
        
              //child 2
              // Expanded widgets are "greedy" and take up a lot of space
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  
                  // THIS IS WHERE THE PAGE IS SELECTED ##################
                  child: page,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}


///###################
/// generator page def
///###################

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// ##################
/// My page
/// ##################

class EditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    //var favorites = <WordPair>[];
    var favorites = appState.favorites;

    return Center(
      child: ListView(
        children: [

          for (var fav in favorites)
            ListTile(
              leading: ElevatedButton.icon(
                onPressed: () {
                  appState.delete(fav);
                },
                label: Icon(Icons.remove_circle_outline),
              ),

              title: Text('$fav')
              
              ),
            SizedBox(height: 10),
          
        ],
      ),
    );
  }
}

///#################
/// Favorites page
///#################

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have '
              '${appState.favorites.length} favorites:'),
        ),
        for (var pair in appState.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.asLowerCase),
          ),
      ],
    );
  }
}

// ...

//######################################
// wordpair custom card
//######################################

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.colorScheme.primary,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20.0),


        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}