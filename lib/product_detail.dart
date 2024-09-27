import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/model/product.dart';
import 'package:frontend/widgets/custom_back.dart';
import 'package:frontend/widgets/header_text.dart';

class ProductDetail extends StatefulWidget {
  final Map<String, Product> args;

  const ProductDetail(this.args, {super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  Product? productDetail;
  int itemCount = 1;
  bool currentLocation = false;
  double? lat, lng;
  final formKey = GlobalKey<FormState>();

  void _incrementProduct() {
    setState(() {
      itemCount++;
    });
  }

  // final formatter = NumberFormat('#,##0.00');

  void _decrementProduct() {
    setState(() {
      if (itemCount > 1) itemCount--;
    });
  }

  int currentSlide = 0;

  @override
  void initState() {
    super.initState();
    productDetail = widget.args['product'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                height: MediaQuery.of(context).size.height * .6,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  productDetail?.image ?? "",
                  fit: BoxFit.cover,
                )),
            const Positioned(top: 20, left: 20, child: CustomBack()),
            Positioned(
              top: 20,
              right: 20,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: const Icon(Icons.shopping_cart),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: Column(
                  children: [
                    Image.asset("assets/images/indicator.png"),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeaderText(
                                labelText: productDetail?.name ?? "",
                              ),
                              Row(
                                children: [
                                  Image.asset("assets/images/star-big.png"),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  HeaderText(
                                    labelText:
                                        productDetail?.averageRate.toString() ??
                                            "",
                                    textFontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    textColor: primaryColor.withOpacity(.5),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const HeaderText(
                              labelText: "Price",
                              textColor: Colors.grey,
                              textFontSize: 13,
                            ),
                            HeaderText(
                              labelText: "\$${productDetail?.costPrice}",
                              textColor: primaryColor,
                              textFontSize: 13,
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    const Divider(),
                    HeaderText(
                      align: TextAlign.start,
                      labelText: productDetail?.description ?? "",
                      textFontSize: 12,
                      textColor: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 43,
                                width: 43,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.remove,
                                  ),
                                  onPressed: _decrementProduct,
                                  color: primaryColor,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 50,
                                child: Text(
                                  '$itemCount',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                              Container(
                                height: 43,
                                width: 43,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: _incrementProduct,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // Set the border radius here
                              ),
                            ),
                            onPressed: () {},
                            label: const Text(
                              "Add To Cart",
                              style: TextStyle(color: Colors.white),
                            ),
                            icon: Image.asset(
                              "assets/images/shopping-cart.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
