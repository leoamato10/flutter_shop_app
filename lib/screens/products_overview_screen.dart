import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:flutter_complete_guide/screens/cart_screen.dart';
import 'package:flutter_complete_guide/widgets/badge.dart';

import 'package:flutter_complete_guide/widgets/products_grid.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Products",
          ),
          actions: [
            Consumer<Cart>(
                builder: (_, cart, ch) =>
                    Badge(child: ch, value: cart.itemCount.toString()),
                child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                )),
            PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favorites) {
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                  }
                });
              },
              icon: Icon(
                Icons.more_vert,
              ),
              itemBuilder: (_) {
                return [
                  PopupMenuItem(
                    child: Text("Only Favorites"),
                    value: FilterOptions.Favorites,
                  ),
                  PopupMenuItem(
                    child: Text("All products"),
                    value: FilterOptions.All,
                  )
                ];
              },
            ),
          ],
        ),
        body: ProductsGrid(_showOnlyFavorites));
  }
}
