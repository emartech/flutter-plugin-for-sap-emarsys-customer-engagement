import 'dart:math';
import 'package:emarsys_sdk/emarsys_sdk.dart';
import 'package:emarsys_sdk/model/predict/predict_cart_item.dart';
import 'package:emarsys_sdk_example/main.dart';
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
    _initControllers();
    _cartItems = [];
    _productsToShow = [];
  }

  void _initControllers() {
    _searchTermController = TextEditingController();
    _categoryPathController = TextEditingController();
    _itemIdController = TextEditingController();
    _orderIdController = TextEditingController();
    _tagEventNameController = TextEditingController();
    _tagAttributesController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCard("Item view", _itemIdController, _trackItemView),
          _buildCard("Search term", _searchTermController, _trackSearchTerm),
          _buildCard(
              "Category view", _categoryPathController, _trackCategoryView),
          _buildCartAndPurchase(),
          _buildTrackTag(),
          _buildRecommendationSection(),
        ],
      ),
    );
  }

  Widget _buildCard(
      String title, TextEditingController controller, VoidCallback onTrack) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(title),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: title.toLowerCase().replaceAll(" ", ""),
              ),
            ),
          ),
          _buildTrackButton(onTrack),
        ],
      ),
    );
  }

  Widget _buildTrackButton(VoidCallback onPressed) {
    return Row(
      children: [
        const Spacer(),
        TextButton(
          onPressed: onPressed,
          child: const Text("Track"),
        ),
      ],
    );
  }

  void _trackItemView() {
    Emarsys.predict.trackItemView(_itemIdController.text);
    _clearController(_itemIdController);
  }

  void _trackSearchTerm() {
    Emarsys.predict.trackSearchTerm(_searchTermController.text);
    _clearController(_searchTermController);
  }

  void _trackCategoryView() {
    Emarsys.predict.trackCategoryView(_categoryPathController.text);
    _clearController(_categoryPathController);
  }

  void _clearController(TextEditingController controller) {
    setState(() {
      controller.clear();
    });
  }

  Widget _buildTrackTag() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle("Tag"),
          _buildTextField(_tagEventNameController, "Event Name"),
          _buildTextField(_tagAttributesController, "Attributes"),
          _buildTrackButton(_trackTag),
        ],
      ),
    );
  }

  void _trackTag() {
    Emarsys.predict.trackTag(
      _tagEventNameController.text,
      convertTextToMap(_tagAttributesController.text) ?? {},
    );
    _clearController(_tagEventNameController);
    _clearController(_tagAttributesController);
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
        ),
      ),
    );
  }

  Widget _buildCartAndPurchase() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle("Cart and Purchase"),
          _buildOrderTextField(),
          _buildCartButtons(),
          _buildCartItemsDisplay(),
        ],
      ),
    );
  }

  Widget _buildOrderTextField() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _orderIdController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Order ID",
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: _trackPurchase,
          child: const Text("Track Purchase"),
        ),
      ],
    );
  }

  void _trackPurchase() {
    Emarsys.predict.trackPurchase(_orderIdController.text, _cartItems);
    setState(() {
      _orderIdController.clear();
      _cartItems.clear();
    });
  }

  Widget _buildCartButtons() {
    return Row(
      children: [
        const Spacer(),
        FloatingActionButton(
          mini: true,
          onPressed: _generateCartItem,
          child: const Icon(Icons.add),
        ),
        const Spacer(),
        TextButton(
          onPressed: _trackCartItems,
          child: const Text("Track Cart Items"),
        ),
      ],
    );
  }

  void _trackCartItems() {
    Emarsys.predict.trackCart(_cartItems);
  }

  void _generateCartItem() {
    setState(() {
      _cartItems.add(PredictCartItem(
        itemId: Random().nextInt(10000).toString(),
        price: Random().nextDouble(),
        quantity: Random().nextDouble(),
      ));
    });
  }

  Widget _buildCartItemsDisplay() {
    return Text(_cartItems.map((item) => item.toString()).join("\n"));
  }

  Widget _buildRecommendationSection() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle("Recommendation"),
          _buildRecommendationButton("Recommend search", _recommendSearch),
          _buildRecommendationButton("Recommend cart", _recommendCart),
          _buildRecommendationButton("Recommend related", _recommendRelated),
          _buildRecommendationButton("Recommend category", _recommendCategory),
          _buildRecommendationButton(
              "Recommend also bought", _recommendAlsoBought),
          _buildRecommendationButton("Recommend popular", _recommendPopular),
          _buildRecommendationButton("Recommend personal", _recommendPersonal),
          _buildRecommendationButton("Recommend home", _recommendHome),
          _buildProductsToShow(),
        ],
      ),
    );
  }

  Widget _buildRecommendationButton(String text, VoidCallback onPressed) {
    return TextButton(onPressed: onPressed, child: Text(text));
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  Widget _buildProductsToShow() {
    return Text(
        _productsToShow.map((product) => product.toString()).join("\n"));
  }

  void _recommendSearch() async {
    List<Product> products = await Emarsys.predict.recommendProducts(
      logic: RecommendationLogic.search(searchTerm: "shirt"),
    );
    _updateProducts(products);
    await Emarsys.predict.trackRecommendationClick(products.first);
  }

  void _recommendCart() async {
    List<Product> products = await Emarsys.predict.recommendProducts(
      logic: RecommendationLogic.cart(cartItems: _cartItems),
    );
    _updateProducts(products);
  }

  void _recommendRelated() async {
    List<Product> products = await Emarsys.predict.recommendProducts(
      logic: RecommendationLogic.related(itemId: "2407"),
    );
    _updateProducts(products);
    await Emarsys.predict.trackRecommendationClick(products.first);
  }

  void _recommendCategory() async {
    List<Product> products = await Emarsys.predict.recommendProducts(
      logic: RecommendationLogic.category(categoryPath: "shirt->"),
    );
    _updateProducts(products);
  }

  void _recommendAlsoBought() async {
    List<Product> products = await Emarsys.predict.recommendProducts(
      logic: RecommendationLogic.alsoBought(itemId: "2407"),
    );
    _updateProducts(products);
  }

  void _recommendPopular() async {
    List<Product> products = await Emarsys.predict.recommendProducts(
      logic: RecommendationLogic.popular(categoryPath: "shirt"),
    );
    _updateProducts(products);
  }

  void _recommendPersonal() async {
    List<Product> products = await Emarsys.predict.recommendProducts(
      logic: RecommendationLogic.personal(variants: ["var1"]),
    );
    _updateProducts(products);
  }

  void _recommendHome() async {
    List<Product> products = await Emarsys.predict.recommendProducts(
      logic: RecommendationLogic.home(variants: ["var2"]),
    );
    _updateProducts(products);
  }

  void _updateProducts(List<Product> products) {
    setState(() {
      _productsToShow = products;
    });
  }
}
