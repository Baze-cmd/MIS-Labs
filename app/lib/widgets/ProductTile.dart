import 'package:flutter/material.dart';
import '../models/Product.dart';

class ProductTile extends StatelessWidget
{
    final Product product;

    const ProductTile({Key? key, required this.product}) : super(key: key);

    @override
    Widget build(BuildContext context)
    {
        return Card(
            elevation: 5,
            margin: EdgeInsets.all(10),
            child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Image.network(this.product.imgURL,
                        width: 200, height: 200, fit: BoxFit.cover),
                    SizedBox(height: 10),
                    Text(this.product.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    Text(this.product.description,
                        textAlign: TextAlign.left, style: TextStyle(fontSize: 15)),
                    SizedBox(height: 5),
                    Text('\$${this.product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold))
                ]));
    }
}
