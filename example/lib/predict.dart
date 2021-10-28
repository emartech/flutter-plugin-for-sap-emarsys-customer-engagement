import 'dart:math';

import 'package:emarsys_sdk/emarsys_sdk.dart';
import 'package:emarsys_sdk/model/predict/predict_cart_item.dart';
import 'package:emarsys_sdk_example/main.dart';
import 'package:emarsys_sdk_example/title_text.dart';
import 'package:flutter/material.dart';

class PredictView extends StatefulWidget {
  const PredictView({Key? key}) : super(key: key);

  @override
  _PredictState createState() => _PredictState();
}

class _PredictState extends State<PredictView> {
  late TextEditingController _searchTermController;
  late TextEditingController _categoryPathController;
  late TextEditingController _itemIdController;
  late TextEditingController _orderIdController;
  late TextEditingController _tagEventNameController;
  late TextEditingController _tagAttributesController;
  late List<CartItem> _cartItems;
  late List<Product> _productsToShow;
  @override
  void initState() {
    super.initState();
    _searchTermController = TextEditingController();
    _categoryPathController = TextEditingController();
    _itemIdController = TextEditingController();
    _orderIdController = TextEditingController();
    _tagEventNameController = TextEditingController();
    _tagAttributesController = TextEditingController();
    _cartItems = [];
    _productsToShow = [];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0), child: buildTrackItemView()),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildTrackSearchTerm()),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildTrackCategoryPath()),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildCartAndPurchase()),
          Padding(padding: const EdgeInsets.all(8.0), child: buildTrackTag()),
          Padding(
              padding: const EdgeInsets.all(8.0), child: buildRecommendation())
        ],
      ),
    );
  }

  Widget buildTrackSearchTerm() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText("Search term"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchTermController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "searchTerm"),
            ),
          ),
          Row(
            children: [
              Spacer(),
              TextButton(
                  onPressed: () {
                    Emarsys.predict.trackSearchTerm(_searchTermController.text);
                    setState(() {
                      _searchTermController.clear();
                    });
                  },
                  child: Text("Track")),
            ],
          )
        ],
      ),
    );
  }

  Widget buildTrackCategoryPath() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText("Category view"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _categoryPathController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "categoryPath"),
            ),
          ),
          Row(
            children: [
              Spacer(),
              TextButton(
                  onPressed: () {
                    Emarsys.predict
                        .trackCategoryView(_categoryPathController.text);
                    setState(() {
                      _categoryPathController.clear();
                    });
                  },
                  child: Text("Track")),
            ],
          )
        ],
      ),
    );
  }

  Widget buildTrackItemView() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText("Item view"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _itemIdController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "itemId"),
            ),
          ),
          Row(
            children: [
              Spacer(),
              TextButton(
                  onPressed: () {
                    Emarsys.predict.trackItemView(_itemIdController.text);
                    setState(() {
                      _itemIdController.clear();
                    });
                  },
                  child: Text("Track")),
            ],
          )
        ],
      ),
    );
  }

  Widget buildTrackTag() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText("Tag"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _tagEventNameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "eventName"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _tagAttributesController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Attributes"),
            ),
          ),
          Row(
            children: [
              Spacer(),
              TextButton(
                  onPressed: () {
                    Emarsys.predict.trackTag(_tagEventNameController.text,
                        convertTextToMap(_tagAttributesController.text) ?? {});
                    setState(() {
                      _tagEventNameController.clear();
                      _tagAttributesController.clear();
                    });
                  },
                  child: Text("Track")),
            ],
          )
        ],
      ),
    );
  }

  Widget buildCartAndPurchase() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText("Cart and purchase"),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _orderIdController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "orderId"),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Emarsys.predict
                        .trackPurchase(_orderIdController.text, _cartItems);
                    setState(() {
                      _orderIdController.clear();
                      _cartItems.clear();
                    });
                  },
                  child: Text("Track purchase"))
            ],
          ),
          Text(_cartItems.map((e) => e.toString()).join("\n")),
          Row(
            children: [
              Spacer(),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    mini: true,
                    onPressed: () {
                      setState(() {
                        generateCartItem();
                      });
                    },
                    child: Icon(Icons.add),
                  )),
              Spacer(),
              TextButton(
                  onPressed: () {
                    Emarsys.predict.trackCart(_cartItems);
                  },
                  child: Text("Track Cart items"))
            ],
          )
        ],
      ),
    );
  }

  Widget buildRecommendation() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText("Recommendation"),
          Row(
            children: [
              TextButton(
                  onPressed: () async {
                    List<Product> products = await Emarsys.predict
                        .recommendProducts(
                            logic: RecommendationLogic.search(
                                searchTerm: "shirt"));
                    setState(() {
                      _productsToShow = products;
                    });
                    await Emarsys.predict
                        .trackRecommendationClick(products[0]);
                  },
                  child: Text("Recommend search"))
            ],
          ),
          Row(
            children: [
              TextButton(
                  onPressed: () async {
                    List<Product> products = await Emarsys.predict
                        .recommendProducts(
                            logic: RecommendationLogic.cart(
                                cartItems: _cartItems));
                    setState(() {
                      _productsToShow = products;
                    });
                  },
                  child: Text("Recommend cart"))
            ],
          ),
          Row(
            children: [
              TextButton(
                  onPressed: () async {
                    List<Product> products = await Emarsys.predict
                        .recommendProducts(
                            logic: RecommendationLogic.related(itemId: "2407"));
                    setState(() {
                      _productsToShow = products;
                    });
                    await Emarsys.predict.trackRecommendationClick(products[0]);
                  },
                  child: Text("Recommend related"))
            ],
          ),
          Row(
            children: [
              TextButton(
                  onPressed: () async {
                    List<Product> products = await Emarsys.predict
                        .recommendProducts(
                            logic: RecommendationLogic.category(
                                categoryPath: "shirt->"));
                    setState(() {
                      _productsToShow = products;
                    });
                  },
                  child: Text("Recommend category"))
            ],
          ),
          Row(
            children: [
              TextButton(
                  onPressed: () async {
                    List<Product> products = await Emarsys.predict
                        .recommendProducts(
                            logic:
                                RecommendationLogic.alsoBought(itemId: "2407"));
                    setState(() {
                      _productsToShow = products;
                    });
                  },
                  child: Text("Recommend also bought"))
            ],
          ),
          Row(
            children: [
              TextButton(
                  onPressed: () async {
                    List<Product> products = await Emarsys.predict
                        .recommendProducts(
                            logic: RecommendationLogic.popular(
                                categoryPath: "shirt"));
                    setState(() {
                      _productsToShow = products;
                    });
                  },
                  child: Text("Recommend popular"))
            ],
          ),
          Row(
            children: [
              TextButton(
                  onPressed: () async {
                    List<Product> products = await Emarsys.predict
                        .recommendProducts(
                            logic: RecommendationLogic.personal(
                                variants: ["var1"]));
                    setState(() {
                      _productsToShow = products;
                    });
                  },
                  child: Text("Recommend personal"))
            ],
          ),
          Row(
            children: [
              TextButton(
                  onPressed: () async {
                    List<Product> products = await Emarsys.predict
                        .recommendProducts(
                            logic:
                                RecommendationLogic.home(variants: ["var2"]));
                    setState(() {
                      _productsToShow = products;
                    });
                  },
                  child: Text("Recommend home"))
            ],
          ),
          Text(_productsToShow.map((e) => e.toString()).join("\n")),
        ],
      ),
    );
  }

  void generateCartItem() {
    _cartItems.add(PredictCartItem(
        itemId: Random().toString(),
        price: Random().nextDouble(),
        quantity: Random().nextDouble()));
  }
}
