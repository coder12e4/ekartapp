import 'package:ekartapp/Api/Models/ProductModel.dart';
import 'package:ekartapp/cubit/kartpage/kart_cubit.dart';
import 'package:ekartapp/pages/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'CartList.dart';

class ProductView extends StatefulWidget {
  ProductModel? productModel;
  ProductView({Key? key, this.productModel}) : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  ProductModel? productModel;
  late KartCubit kartCubit;

  @override
  void initState() {
    productModel = widget.productModel;
    kartCubit = KartCubit();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Column(
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CartList()));
                    },
                    child: Container(
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
                            style: TextStyle(fontSize: 8, color: Colors.white),
                          );
                        },
                      ),
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
                height: 16,
              ),
              Image.network(
                productModel!.image ?? 'https://via.placeholder.com/150',
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error);
                },
                width: MediaQuery.of(context).size.width - 40,
                height: MediaQuery.of(context).size.width - 40,
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                margin: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      productModel!.title!,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      productModel!.description!,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Text("\$${productModel!.price!}",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.red)),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    GestureDetector(
                      onTap: () {
                        kartCubit.addToCart(productModel!);
                      },
                      child: Container(
                        height: 60,
                        width: 220,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: HexColor("FBB03B"),
                            borderRadius: BorderRadius.circular(60)),
                        child: BlocProvider<KartCubit>(
                          create: (context) => kartCubit,
                          child: BlocListener<KartCubit, KartState>(
                            listener: (context, state) {
                              if (state is KartLoading) {
                              } else if (state is KartSuccess) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Added to Cart!'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              } else if (state is KartFail) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(state.error),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                            child: BlocBuilder<KartCubit, KartState>(
                              builder: (context, state) {
                                if (state is KartLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is KartSuccess) {
                                  return Text("Add to cart",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.black));
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
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
