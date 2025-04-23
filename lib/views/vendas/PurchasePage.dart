import 'dart:async';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage({Key? key}) : super(key: key);
  @override
  _PurchasePageState createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  final InAppPurchase _iap = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _sub;
  List<ProductDetails> _products = [];
  bool _available = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initStore();
  }

  Future<void> _initStore() async {
    _available = await _iap.isAvailable();
    if (!_available) {
      setState(() => _error = 'Loja indisponível');
      return;
    }
    const ids = <String>{'remove_ads'};
    final resp = await _iap.queryProductDetails(ids);
    if (resp.error != null) {
      setState(() => _error = resp.error!.message);
      return;
    }
    if (resp.productDetails.isEmpty) {
      setState(() => _error = 'Produto não encontrado');
      return;
    }
    _products = resp.productDetails;
    _sub = _iap.purchaseStream.listen(_onPurchaseUpdated, onDone: () => _sub.cancel());
    setState(() {});
  }

  Future<void> _onPurchaseUpdated(List<PurchaseDetails> purchases) async {
    for (var p in purchases) {
      if (p.productID == 'remove_ads' && p.status == PurchaseStatus.purchased) {
        // marca como comprado
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isPurchased', true);
        // completa a compra
        if (p.pendingCompletePurchase) {
          await _iap.completePurchase(p);
        }
        // vai para a HomePage
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const HomePage())
        );
      } else if (p.status == PurchaseStatus.error) {
        // trate erro
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro na compra: ${p.error?.message ?? ''}'))
        );
      }
    }
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Remover Anúncios')),
        body: Center(child: Text(_error!)),
      );
    }
    if (!_available || _products.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final prod = _products.first;
    return Scaffold(
      appBar: AppBar(title: const Text('Remover Anúncios')),
      body: Center(
        child: ElevatedButton(
          child: Text('Remover Anúncios – ${prod.price}'),
          onPressed: () {
            final param = PurchaseParam(productDetails: prod);
            _iap.buyNonConsumable(purchaseParam: param);
          },
        ),
      ),
    );
  }
}
