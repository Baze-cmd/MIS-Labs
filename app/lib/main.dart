import 'package:flutter/material.dart';
import 'dart:math';

void main()
{
    runApp(MyApp());
}

class MyApp extends StatelessWidget
{
    const MyApp({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context)
    {
        return MaterialApp(home: HomePage());
    }
}

class HomePage extends StatelessWidget
{
    final String index = "216089";

    @override
    Widget build(BuildContext context)
    {
        return Scaffold(appBar: AppBar(title: Text(index)), body: Products());
    }
}

class Product
{
    final String name;
    final String description;
    final int price;
    final String imgURL;

    Product({required this.name,
        required this.description,
        required this.price,
        required this.imgURL});
}

class Products extends StatelessWidget
{
    final List<Product> products = [];
    final random = Random();

    Products({super.key})
    {
        String desc = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate";
        products.add(Product(
                name: 'T-shirt',
                description: desc,
                price: 100 + random.nextInt(100),
                imgURL: 'data:image/jpeg;base64,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'));
        products.add(Product(
                name: 'Hoodie',
                description: desc,
                price: 100 + random.nextInt(100),
                imgURL: 'data:image/jpeg;base64,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'));
        products.add(Product(
                name: 'Cap',
                description: desc,
                price: 100 + random.nextInt(100),
                imgURL: 'data:image/jpeg;base64,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'));
        products.add(Product(
                name: 'Jeens',
                description: desc,
                price: 100 + random.nextInt(100),
                imgURL: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_xxWN-gja2nr-nEM820PCmGS3u1uHygz1FA&s'));
        products.add(Product(
                name: 'Jacket',
                description: desc,
                price: 100 + random.nextInt(100),
                imgURL: 'data:image/jpeg;base64,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'));
        products.add(Product(
                name: 'Boots',
                description: desc,
                price: 100 + random.nextInt(100),
                imgURL: 'data:image/jpeg;base64,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'));
    }

    @override
    Widget build(BuildContext context)
    {
        return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75),
            itemCount: this.products.length,
            itemBuilder: (context, index)
            {
                return GestureDetector(
                    onTap: ()
                    {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(product: this.products[index])));
                    },
                    child: Card(
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                Image.network(
                                    products[index].imgURL,
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover
                                ),
                                SizedBox(height: 10),
                                Text(
                                    products[index].name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontWeight: FontWeight.bold)
                                ),
                                SizedBox(height: 20),
                                Text(products[index].description,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 15)
                                ),
                                SizedBox(height: 5),
                                Text(
                                    '\$${products[index].price.toStringAsFixed(2)}',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)
                                )
                            ]))
                );
            }
        );
    }
}

class ProductDetails extends StatelessWidget
{
    final Product product;

    const ProductDetails({Key? key, required this.product})
        : super(key: key);

    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            appBar: AppBar(),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Center(
                            child: Image.network(
                                product.imgURL,
                                width: 300,
                                height: 300,
                                fit: BoxFit.cover
                            )
                        ),
                        SizedBox(height: 20),
                        Text(
                            product.name,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
                        ),
                        SizedBox(height: 10),
                        Text(
                            product.description,
                            style: TextStyle(fontSize: 16)
                        ),
                        SizedBox(height: 10),
                        Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 18,
                                color: Colors.green,
                                fontWeight: FontWeight.bold)
                        )
                    ]
                )
            )
        );
    }
}
