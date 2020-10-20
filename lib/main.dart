import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import './screens/restaurants_screen.dart';

//Colores de la app no mover de acá.
const _primaryColor = Color(0xFFFF5722);
const _darkPrimaryColor = Color(0xFFE64A19);
const _lightPrimaryColor = Color(0xFFFFCCBC);
const _accentColor = Color(0xFF8BC34A);
const _dividerColor = Color(0xFFBDBDBD);

//Colores de texto. Habrá que copiarlos en cada .dart para usarlos
// TODO: intentar añadirlos al ThemeData. De momento ver como usarlos
const _primaryText = Color(0xFF212121);
const _secondaryText = Color(0xFF757575);
const _textsIcons = Color(0xFFFFFFFF);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(FoodSight());
}

class FoodSight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodSight',
      theme: ThemeData(
        errorColor: Colors.red,
        primaryColor: _primaryColor,
        primaryColorLight: _lightPrimaryColor,
        primaryColorDark: _darkPrimaryColor,
        accentColor: _accentColor,
        dividerColor: _dividerColor,
        
      ),
      home: MyHomePage(),
      routes: {
        RestaurantsScreen.screenRoute: (context) => RestaurantsScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

void selectRestaurant (BuildContext ctx){
  Navigator.of(ctx).pushNamed(RestaurantsScreen.screenRoute);
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FoodSight'),
      ),
      body: Column(
        children: [
          InkWell(
          onTap: () => selectRestaurant(context),
          child: Container(
              margin: EdgeInsets.all(10),
              height: 50,
              width: 200,
              color: Colors.amber,
              child: Center(child: Text ("Catalogo de Restaurante")),
            ),
        ),
        ],
      )
        

    );
  }
}
