import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/restaurant.dart';

class Restaurants with ChangeNotifier {
  List<Restaurant> _items = [
    Restaurant(
      id: 'r1',
      name: 'Hipster Restaurant',
      email: 'hipsrestaurant@gmail.com',
      address: 'En el ranchito',
      description: 'La ensalada cuenta chistes muy graciosos',
      location: 'Por alla',
      password: '1234a',
      phone: '22577777',
      priceCategory: PriceCategory.Pricey,
      rating: 3.0,
      photoUrl:
          'https://images-ext-1.discordapp.net/external/j66WmQSfDUAR1cAbnkrWrUL0hhX9UjUY4NCWbYrYuhg/%3Fixlib%3Drb-1.2.1%26ixid%3DeyJhcHBfaWQiOjEyMDd9%26auto%3Dformat%26fit%3Dcrop%26w%3D500%26q%3D60/https/images.unsplash.com/photo-1533777857889-4be7c70b33f7',
      fbUrl: 'https://www.facebook.com/PizzaHut.SV',
      instaUrl: 'https://www.youtube.com/watch?v=fC7oUOUEEi4',
    ),
    Restaurant(
      id: 'r2',
      name: 'Chorys',
      email: 'choripanes@gmail.com',
      address: 'Por todos lados',
      description: 'Ricos y Baratos',
      location: 'Por alla',
      password: '1234a',
      phone: '22577777',
      priceCategory: PriceCategory.Affordable,
      rating: 5.0,
      photoUrl:
          'https://images-ext-1.discordapp.net/external/Szy_YZPb6vFgJ5Wcqv3QXqeZqW16XVd2LeaMZml7j8g/https/elsalvadorgram.com/wp-content/uploads/2020/06/Chory-A-domicilio.jpg?width=747&height=560',
      fbUrl: 'https://www.facebook.com/PizzaHut.SV',
      instaUrl: 'https://www.youtube.com/watch?v=fC7oUOUEEi4',
    ),
  ];

  List<Restaurant> get items {
    return [..._items];
  }

  List<Restaurant> getList(PriceCategory selectedCategory) {
    return selectedCategory == PriceCategory.All
        ? [..._items]
        : _items
            .where((element) => element.priceCategory == selectedCategory)
            .toList();
  }

  Restaurant findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void addRestaurant(Restaurant restaurant) {
    const url = 'https://foodsight-api.herokuapp.com/api/restaurant/create';
    const url2 = 'http://localhost:3000/api/restaurant/create';

    http
        .post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'name': restaurant.name,
        'email': restaurant.email,
        'password': restaurant.password,
        'description': restaurant.description,
        'phone': restaurant.phone,
        'rating': 5,
        'photo': restaurant.photoUrl,
        'facebook': restaurant.fbUrl,
        'instagram': restaurant.instaUrl
      }),
    )
        .then((response) {
      print(json.decode(response.body));
      print(
        json.encode({
          'name': restaurant.name,
          'email': restaurant.email,
          'password': restaurant.password,
          'description': restaurant.description,
          'phone': restaurant.phone,
          'rating': 5,
          'photo': restaurant.photoUrl,
          'facebook': restaurant.fbUrl,
          'instagram': restaurant.instaUrl
        }),
      );
      final newRestaurant = Restaurant(
        id: DateTime.now().toString(),
        address: restaurant.address,
        description: restaurant.description,
        email: restaurant.email,
        fbUrl: restaurant.fbUrl,
        rating: restaurant.rating,
        instaUrl: restaurant.instaUrl,
        location: restaurant.location,
        name: restaurant.name,
        password: restaurant.password,
        phone: restaurant.phone,
        photoUrl: restaurant.photoUrl,
        priceCategory: restaurant.priceCategory,
      );
      _items.add(newRestaurant);
      notifyListeners();
    });
  }

  void updateRestaurant(String id, Restaurant newRestaurant) {
    final prodIndex = _items.indexWhere((res) => res.id == id);

    if (prodIndex >= 0) {
      _items[prodIndex] = newRestaurant;
      notifyListeners();
    } else {
      print('errors.... searching products');
    }
  }
}
