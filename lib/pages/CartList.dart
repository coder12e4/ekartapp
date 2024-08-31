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
                } else if (state is KartSuccess) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 22,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 22,
                          ),
                          Image.asset(
                            "assets/images/image.png",
                            height: 30,
                          ),
                          SizedBox(
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
                      Expanded(
                          child: ListView.builder(
                              itemCount: cartItems.length,
                              itemBuilder: (context, intex) {
                                return Row(
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
                                            MainAxisAlignment.spaceAround,
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
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }))
                    ],
                  );
                } else if (state is KartFail) {
                  return Text("Add to cart",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Colors.black));
                } else {
                  return Text("Add to cart",
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
