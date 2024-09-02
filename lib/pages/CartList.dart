import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Api/Models/ProductModel.dart';
import '../cubit/kartpage/kart_cubit.dart';

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  late KartCubit kartCubit;
  late List<ProductModel> cartItems = [];

  @override
  void initState() {
    kartCubit = KartCubit();
    kartCubit.displayCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider<KartCubit>(
          create: (context) => kartCubit,
          child: BlocListener<KartCubit, KartState>(
            listener: (context, state) {
              if (state is KartLoading) {
              } else if (state is KartSuccessWithLenth) {
                cartItems = state.cartItems;
              } else if (state is KartSuccess) {
                cartItems = state.cartItems;
              } else if (state is KartFail) {}
            },
            child: BlocBuilder<KartCubit, KartState>(
              builder: (context, state) {
                if (state is KartLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is KartSuccessWithLenth) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 22,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 22,
                          ),
                          Image.asset(
                            "assets/images/image.png",
                            height: 30,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "E-Shop",
                            style: TextStyle(fontSize: 22),
                          ),
                          Expanded(
                              child: SizedBox(
                            height: 2,
                          )),
                          Icon(Icons.shopping_cart_outlined),
                          SizedBox(
                            width: 1,
                          ),
                          Container(
                            height: 16,
                            width: 16,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(16)),
                            child: BlocBuilder<KartCubit, KartState>(
                              builder: (context, state) {
                                final cartCount =
                                    context.watch<KartCubit>().cartCount;
                                return Text(
                                  cartCount.toString(),
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.white),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: 22,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Divider(
                        height: .5,
                        color: Colors.black12,
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 22, bottom: 22),
                        child: Text(
                          "Cart",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Flexible(
                          child: ListView.builder(
                              itemCount: cartItems.length,
                              itemBuilder: (context, intex) {
                                return Container(
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.only(
                                      left: 22, right: 22, bottom: 12),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: .5, color: Colors.black26),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.network(
                                        cartItems[intex].image!,
                                        height: 80,
                                        width: 80,
                                      ),
                                      SizedBox(
                                          width:
                                              16), // Add some space between the image and the text
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 40,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      cartItems[intex].title!,
                                                      maxLines: 1,
                                                      textAlign: TextAlign.left,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Spacer(), // Push the delete icon to the right
                                                  GestureDetector(
                                                    onTap: () {
                                                      kartCubit.removeFromCart(
                                                          cartItems[intex]);
                                                    },
                                                    child: Icon(Icons.delete),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 120,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black38),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                          height: 40,
                                                          width: 30,
                                                          child: Center(
                                                              child:
                                                                  Text("-"))),
                                                      Divider(
                                                        height: 40,
                                                        color: Colors.black38,
                                                        thickness: 1,
                                                      ),
                                                      SizedBox(
                                                          height: 40,
                                                          width: 30,
                                                          child: Center(
                                                              child:
                                                                  Text("00"))),
                                                      Divider(
                                                        height: 40,
                                                        color: Colors.black38,
                                                        thickness: 1,
                                                      ),
                                                      SizedBox(
                                                          height: 40,
                                                          width: 30,
                                                          child: Center(
                                                              child:
                                                                  Text("+"))),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                    "\$${cartItems[intex].price}")
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              })),
                      Container(
                        height: 80,
                        padding: EdgeInsets.only(right: 22, bottom: 8),
                        alignment: Alignment.centerRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(color: Colors.black26),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "\$400",
                              style: TextStyle(
                                  color: Colors.black26, fontSize: 34),
                            )
                          ],
                        ),
                      ),
                      Expanded(child: SizedBox())
                    ],
                  );
                } else if (state is KartSuccess) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 22,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 22,
                          ),
                          Image.asset(
                            "assets/images/image.png",
                            height: 30,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "E-Shop",
                            style: TextStyle(fontSize: 22),
                          ),
                          Expanded(
                              child: SizedBox(
                            height: 2,
                          )),
                          Icon(Icons.shopping_cart_outlined),
                          SizedBox(
                            width: 1,
                          ),
                          Container(
                            height: 16,
                            width: 16,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(16)),
                            child: BlocBuilder<KartCubit, KartState>(
                              builder: (context, state) {
                                final cartCount =
                                    context.watch<KartCubit>().cartCount;
                                return Text(
                                  cartCount.toString(),
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.white),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: 22,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Divider(
                        height: .5,
                        color: Colors.black12,
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 22, bottom: 22),
                        child: Text(
                          "Cart",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Flexible(
                          child: ListView.builder(
                              itemCount: cartItems.length,
                              itemBuilder: (context, intex) {
                                return Container(
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.only(
                                      left: 22, right: 22, bottom: 12),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: .5, color: Colors.black26),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.network(
                                        cartItems[intex].image!,
                                        height: 80,
                                        width: 80,
                                      ),
                                      SizedBox(
                                          width:
                                              16), // Add some space between the image and the text
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 40,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      cartItems[intex].title!,
                                                      maxLines: 1,
                                                      textAlign: TextAlign.left,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Spacer(), // Push the delete icon to the right
                                                  GestureDetector(
                                                    onTap: () {
                                                      kartCubit.removeFromCart(
                                                          cartItems[intex]);
                                                    },
                                                    child: Icon(Icons.delete),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 120,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black38),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                          height: 40,
                                                          width: 30,
                                                          child: Center(
                                                              child:
                                                                  Text("-"))),
                                                      Divider(
                                                        height: 40,
                                                        color: Colors.black38,
                                                        thickness: 1,
                                                      ),
                                                      SizedBox(
                                                          height: 40,
                                                          width: 30,
                                                          child: Center(
                                                              child:
                                                                  Text("00"))),
                                                      Divider(
                                                        height: 40,
                                                        color: Colors.black38,
                                                        thickness: 1,
                                                      ),
                                                      SizedBox(
                                                          height: 40,
                                                          width: 30,
                                                          child: Center(
                                                              child:
                                                                  Text("+"))),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                    "\$${cartItems[intex].price}")
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              })),
                      Container(
                        height: 80,
                        padding: EdgeInsets.only(right: 22, bottom: 8),
                        alignment: Alignment.centerRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(color: Colors.black26),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "\$400",
                              style: TextStyle(
                                  color: Colors.black26, fontSize: 34),
                            )
                          ],
                        ),
                      ),
                      Expanded(child: SizedBox())
                    ],
                  );
                } else if (state is KartFail) {
                  return Text("kert is emty",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Colors.black));
                } else {
                  return Text("something went wrong",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Colors.black));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
