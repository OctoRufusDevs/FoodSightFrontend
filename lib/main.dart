import 'package:FoodSight/screens/auth_screen.dart';

import './providers/products.dart';
import './screens/product_form_screen.dart';
import './screens/restaurant_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import './screens/restaurants_screen.dart';
import './screens/restaurant_detail.dart';
import './screens/restaurant_info.dart';
import './providers/restaurants.dart';
import 'providers/auth.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Restaurants(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          //create: (ctx) => Products(null, []),
          update: (ctx, auth, previousProducts) => Products(
            auth.logId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, authData, _) => MaterialApp(
          title: 'FoodSight',
          theme: ThemeData(
            errorColor: Colors.red,
            primaryColor: _primaryColor,
            primaryColorLight: _lightPrimaryColor,
            primaryColorDark: _darkPrimaryColor,
            accentColor: _accentColor,
            dividerColor: _dividerColor,
            fontFamily: 'RobotoCondensed',
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold,
                    color: _textsIcons,
                  ),
                  headline5: TextStyle(
                    fontSize: 24,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold,
                    color: _primaryText,
                  ),
                ),
          ),
          routes: {
            '/': (context) => RestaurantsScreen(),
            RestaurantDetail.routeName: (context) => RestaurantDetail(),
            RestaurantInformation.routeName: (context) =>
                RestaurantInformation(),
            RestaurantFormScreen.routeName: (context) => RestaurantFormScreen(),
            ProductFormScreen.routeName: (context) => ProductFormScreen(),
            AuthScreen.routeName: (context) => AuthScreen(),
          },
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
