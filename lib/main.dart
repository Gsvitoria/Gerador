import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'projeto_5',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 73, 3, 235)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  final List<String> lista = [
    "Vamos, Flamengo! Acima de tudo rubro-negro!",
    "O Corinthians é o time do povo, é o time do coração!",
    "Santos, glorioso alvinegro praiano, orgulho do Brasil!",
    "São Paulo, clube da fé, tricolor do Morumbi!",
    "Palmeiras, meu Palmeiras, meu coração é verde e branco!",
    "Galo forte e vingador, orgulho de Minas Gerais!",
    "Cruzeiro, guerreiro dos gramados, estrelado campeão!",
    "Internacional, colorado, clube do povo, orgulho do Rio Grande do Sul!",
    "Grêmio, imortal tricolor, com raça e coração!",
    "Vasco da Gama, gigante da Colina, da virada e da vitória!",
    "Botafogo, estrela solitária, glorioso do Rio!",
    "Fluminense, pó de arroz, tricolor das Laranjeiras!",
    "Bahia, esquadrão de aço, orgulho do Nordeste!",
    "Vitória, leão da Barra, rubro-negro baiano!",
    "Atlético Paranaense, furacão do Brasil, rubro-negro do Paraná!",
    "Coritiba, coxa-branca, campeão do Paraná!",
    "Sport Recife, leão da Ilha, orgulho de Pernambuco!",
    "Santa Cruz, tricolor do Arruda, cobra coral!",
    "Fortaleza, tricolor de aço, leão do Pici!",
    "Ceará, vozão, alvinegro da Porangabuçu!",
    "Goiás, verdão, esmeraldino de coração!",
    "Atlético Goianiense, dragão rubro-negro de Goiás!",
    "Avaí, leão da Ilha, orgulho de Santa Catarina!",
    "Figueirense, furacão do Estreito, alvinegro catarinense!",
    "Chapecoense, verdão do Oeste, orgulho de Chapecó!",
    "Náutico, timbu, alvirrubro de Pernambuco!",
    "América Mineiro, coelho, tradição e glória em Minas Gerais!",
    "Ponte Preta, macaca, força de Campinas!",
    "Guarani, bugre, campeão de 78!",
    "Remo, leão azul, tradição do Pará!",
    "Paysandu, papão da Curuzu, bicolor do Pará!",
    "Juventude, verdão da Serra, orgulho de Caxias do Sul!",
    "Criciúma, tigre catarinense, orgulho do sul!",
    "Paraná Clube, tricolor da Vila, força da capital paranaense!",
    "Brasil de Pelotas, xavante, tradição do interior gaúcho!"
  ];

  String currentFrase = '';

  var favorites = <String>[]; // Alterado para uma lista de Strings

  void toggleFavorite(String frase) {
    if (favorites.contains(frase)) {
      favorites.remove(frase);
    } else {
      favorites.add(frase);
    }
    notifyListeners();
  }

  void getRandomFrase() {
    final random = Random();
    currentFrase = lista[random.nextInt(lista.length)];
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
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
      default:
        throw UnimplementedError('nenhum widget para $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          title: Text('O Canto da Torcida'),
        ),
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,  // ← Here.
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite),
                    label: Text('Favoritos'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}
class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    IconData icon;
    if (appState.favorites.contains(appState.currentFrase)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(randomPhrase: appState.currentFrase),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite(appState.currentFrase);
                },
                icon: Icon(icon),
                label: Text('Gostei'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getRandomFrase();
                },
                child: Text('Próximo'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class BigCard extends StatelessWidget {
  final String randomPhrase;

  const BigCard({Key? key, required this.randomPhrase}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontSize: 15,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding( 
        padding: const EdgeInsets.all(20),
        child: Text(randomPhrase, style: style),
      ),
    );
  }
}
class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('Ainda não há favoritos.'),
      );
    }

    return ListView.builder(
      itemCount: appState.favorites.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.favorite),
          title: Text(
            appState.favorites[index], // Acessa o elemento da lista diretamente
            style: TextStyle(
              // Estilo opcional para o texto
            ),
          ),
        );
      },
    );
  }
}