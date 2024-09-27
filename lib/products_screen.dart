import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/model/product.dart';
import 'package:frontend/widgets/header_text.dart';
import 'package:frontend/widgets/rectangular_container.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uni_links/uni_links.dart';
import 'package:uuid/uuid.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  int activeCategoryIndex = 0;
  var uuid = const Uuid();
  List<Product> products = [];

  List<String> categories = [
    'All',
    'Phone',
    'Laptop',
    'Tablet',
    'TV',
    'Headset',
    'Console',
    'Camera',
    'Smartwatch',
    'Speaker',
    'Monitor',
    'Router',
    'Printer',
    'Drone',
    'Charger',
    'Projector',
    'Keyboard',
    'Mouse',
    'Scanner',
    'Battery',
    'Flashdrive',
  ];
  @override
  void initState() {
    super.initState();
    products = [
      Product(
        id: "11",
        isFeatured: true,
        name: "Gaming Mouse",
        averageRate: 4.8,
        costPrice: 100.0,
        image: "assets/images/mouse.jpg",
        description:
            "Razer DeathAdder Essential Gaming Mouse: 6400 DPI Optical Sensor - 5 Programmable Buttons - Mechanical Switches - Rubber Side Grips - Mercury White",
      ),
      Product(
        id: "22",
        isFeatured: false,
        name: "I phone 15 pro",
        averageRate: 4.5,
        costPrice: 1000.0,
        image: "assets/images/iphone.jpg",
        description:
            "Unlocked Tested for battery health and guaranteed to come with a battery that exceeds 90% of original capacity. Inspected and guaranteed to have minimal cosmetic damage, which is not noticeable when the device is held at arm’s length. Successfully passed a full diagnostic test which ensures like-new functionality and removal of any prior-user personal information. Includes a brand new, generic charging cable that is certified Mfi (Made for iPhone)",
      ),
      Product(
        id: "33",
        isFeatured: true,
        name: "Galaxy s22 ultra",
        averageRate: 4.8,
        costPrice: 500.0,
        image: "assets/images/samsung.jpg",
        description:
            "8K Video: Shoot videos with 8K resolution for epic quality Adaptive Color: Auto adjusts color and brightness for outdoor and indoor viewing Long Battery Life: 5000mAh battery provides all day power",
      ),
      Product(
        id: "44",
        isFeatured: true,
        name: "Headset",
        averageRate: 4.8,
        costPrice: 500.0,
        image: "assets/images/headset.jpg",
        description:
            "Lightweight steel and aluminum alloy construction offers maximum durability and a consistent fit Premium soft ear cups allow you to hear less background noise so you can focus comfortably",
      ),
      Product(
        id: "555",
        isFeatured: false,
        name: "Smart Watch",
        averageRate: 5.0,
        costPrice: 500.0,
        image: "assets/images/smart-watch.jpg",
        description:
            "Strong & Accurate GPS Tracking: From cycling through city streets to walking through wild woodland - wherever your travels take you, support for five satellite systems means the Amazfit GTR Mini watch will be able to pinpoint your position with the kind of precision only provided by Amazfit's patented circularly-polarized GPS antenna technology.",
      ),
    ];

    _sub = linkStream.listen((String? link) {
      if (link != null) {
        _handleDeepLink(link);
      }
    }, onError: (err) {
      // Handle errors
    });

    // Handle deep link if the app was opened by a deep link
    initUniLinks();
  }

  late StreamSubscription _sub;

  Future<void> initUniLinks() async {
    try {
      final initialLink = await getInitialLink();
      if (initialLink != null) {
        _handleDeepLink(initialLink);
      }
    } on Exception {
      // Handle exception
    }
  }

  void _handleDeepLink(String link) async {
    if (link != "") {
      List paths = link.split("/");

      String productId = paths[paths.length - 1];

      for (Product product in products) {
        if (product.id == productId.trim()) {
          Navigator.pushNamed(context, "product-detail",
              arguments: {"product": product});

          break;
        }
      }
    }
  }

  Container searchWidget(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        color: Colors.white,
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        // onTap: () => Navigator.pushNamed(
        //   context,
        //   "product-detail",
        //   arguments: {
        //     "product":
        //   }
        // ).then((_) {}),
        child: TextFormField(
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Color(0xffBDBDBD),
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
            // filled: true,
            prefixIcon: Image.asset("assets/images/search.png"),
            // fillColor:
            //     Theme.of(context).hintColor,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            hintText: "Search Products",
            enabled: false,
            hintStyle: const TextStyle(
                color: Color(0xffBDBDBD),
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }

  void shareProduct(ctx, id) async {
    await Share.share("https://deeplinkexample.onrender.com/$id");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // height: MediaQuery.of(context).size.height -
        //     MediaQuery.of(context).padding.top,
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 10,
                right: MediaQuery.of(context).size.width * .03,
                left: MediaQuery.of(context).size.width * .03,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: searchWidget(context),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
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
                    child: InkWell(
                      onTap: () {
                        // Navigator.pushNamed(
                        //     context, AppRoutes.ordersListScreen);
                      },
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: primaryColor,
                        child: Image.asset("assets/images/shopping-cart.png"),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * .03,
                  right: MediaQuery.of(context).size.width * .03),
              height: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderText(
                    align: TextAlign.start,
                    labelText: "Featured Products",
                    fontWeight: FontWeight.w600,
                    textColor: primaryColor,
                  ),
                  SizedBox(
                    height: 140,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) => InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            "product-detail",
                            arguments: {
                              "product": products[index],
                            },
                          );
                        },
                        child: RectangularContainer(
                          width: MediaQuery.of(context).size.width * .78,
                          child: Row(
                            children: [
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    products[index].image ?? "",
                                    fit: BoxFit.cover,
                                    height: 100,
                                    width: 100,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    HeaderText(
                                      align: TextAlign.start,
                                      labelText: products[index].name ?? "",
                                      textFontSize: 14,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          HeaderText(
                                            align: TextAlign.start,
                                            labelText:
                                                "\$${products[index].costPrice}",
                                            textFontSize: 14,
                                            textColor: primaryColor,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Image.asset("assets/images/star.png"),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          HeaderText(
                                            align: TextAlign.start,
                                            labelText: products[index]
                                                .averageRate
                                                .toString(),

                                            textFontSize: 14,

                                            textColor: Colors.grey,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              InkWell(
                                child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor:
                                        Colors.black.withOpacity(.8),
                                    child:
                                        Image.asset("assets/images/plus.png")),
                              )
                            ],
                          ),
                        ),
                      ),
                      itemCount: products.length,
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(
            //   height: 5,
            // ),
            Container(
              margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * .03,
                left: MediaQuery.of(context).size.width * .03,
              ),
              child: HeaderText(
                align: TextAlign.start,
                labelText: "Category",
                fontWeight: FontWeight.w600,
                textColor: primaryColor,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 50,
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * .03,
                right: MediaQuery.of(context).size.width * .03,
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 15),
                      decoration: BoxDecoration(
                        color: activeCategoryIndex == index
                            ? Colors.black
                            : const Color.fromARGB(255, 220, 219, 219),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: HeaderText(
                        textFontSize: 11,
                        labelText: categories[index],
                        textColor: activeCategoryIndex == index
                            ? Colors.white
                            : const Color.fromARGB(255, 138, 138, 138),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
                itemCount: products.length,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * .03,
                  left: MediaQuery.of(context).size.width * .03,
                ),
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 30,
                      childAspectRatio: 2 / 3,
                      mainAxisSpacing: 30,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        "product-detail",
                        arguments: {
                          "product": products[index],
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // shape: BoxShape.circle,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(
                                -1, 4), // Horizontal and Vertical offset
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              // color: Colors.red,
                              // height: 300,
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.asset(
                                          products[index].image ?? "",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 5,
                                    right: 15,
                                    child: InkWell(
                                      onTap: () {
                                        shareProduct(
                                            context, products[index].id);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                          color: Colors.grey.shade200,
                                          border: Border.all(
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Icon(
                                          Icons.share,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: HeaderText(
                                    align: TextAlign.start,
                                    labelText: products[index].name ?? "",
                                    textFontSize: 14,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Image.asset("assets/images/star.png"),
                                const SizedBox(
                                  width: 3,
                                ),
                                HeaderText(
                                  textColor: Colors.grey,
                                  textFontSize: 14,
                                  labelText:
                                      products[index].averageRate.toString(),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: HeaderText(
                                      align: TextAlign.start,
                                      labelText:
                                          "\$${products[index].costPrice}"
                                              .toString(),
                                      textFontSize: 12,
                                      textColor: primaryColor,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                        ),
                                      ),
                                      child: Image.asset(
                                          "assets/images/plus.png")),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  itemCount: products.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
