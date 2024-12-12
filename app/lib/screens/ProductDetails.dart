import 'package:flutter/material.dart';
import '../models/Product.dart';

class ProductDetails extends StatelessWidget
{
    final Product product;

    const ProductDetails({Key? key, required this.product}) : super(key: key);

    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            appBar: AppBar(),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Center(
                            child: Image.network(product.imgURL,
                                width: 300, height: 300, fit: BoxFit.cover)),
                        SizedBox(height: 20),
                        Text(product.name,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text(product.description, style: TextStyle(fontSize: 16)),
                        SizedBox(height: 10),
                        Text('\$${product.price.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.green,
                                fontWeight: FontWeight.bold))
                    ])));
    }
}
