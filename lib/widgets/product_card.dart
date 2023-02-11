import 'package:flutter/material.dart';
import 'package:flutter_products_app/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _cardDecoration(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroundImage(
              url: product.picture ?? '',
            ),
            _ProductDetails(
              title: product.name,
              subTitle: product.id ?? 'N/D',
            ),
            Positioned(
                top: 0,
                right: 0,
                child: _ProductPrice(
                  price: product.price,
                )),
            if (!product.available)
              Positioned(top: 0, left: 0, child: _NotAvailable())
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 10, offset: Offset(0, 7))
          ]);
}

class _NotAvailable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'No disponible',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.yellow[800],
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25), topLeft: Radius.circular(25))),
    );
  }
}

class _ProductPrice extends StatelessWidget {
  final double price;

  const _ProductPrice({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '\$$price',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25), bottomLeft: Radius.circular(25))),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  final String title;
  final String subTitle;

  const _ProductDetails(
      {super.key, required this.title, required this.subTitle});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 50),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              subTitle,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
      color: Colors.indigo,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25), topRight: Radius.circular(25)));
}

class _BackgroundImage extends StatelessWidget {
  final String url;

  const _BackgroundImage({super.key, required this.url});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
          width: double.infinity,
          height: 400,
          child: url.isNotEmpty
              ? FadeInImage(
                  placeholder: AssetImage('assets/jar-loading.gif'),
                  image: NetworkImage(url),
                  fit: BoxFit.fitWidth)
              : Image(
                  image: AssetImage('assets/no-image.png'),
                  fit: BoxFit.cover,
                )),
    );
  }
}
