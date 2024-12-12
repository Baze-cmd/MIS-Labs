import 'package:flutter/material.dart';
import '../widgets/ProductsWidget.dart';

class Home extends StatelessWidget
{
    final String index = "216089";

    @override
    Widget build(BuildContext context)
    {
        return Scaffold(appBar: AppBar(title: Text(index)), body: ProductsWidget());
    }
}
