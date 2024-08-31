import 'package:ekartapp/Api/Repositories/HomeRepository.dart';
import 'package:ekartapp/cubit/home_cubit.dart';
import 'package:ekartapp/cubit/kartpage/kart_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Api/Models/ProductModel.dart';
import 'ProductView.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeCubit homeCubit;
  List<String> categories = [];
  List<ProductModel> productList = [];
  int selectedIndex = 0;
  late KartCubit kartCubit;

  @override
  void initState() {
    homeCubit = HomeCubit(HomeRepository());
    homeCubit.getCategories(selectedIndex);
    kartCubit = KartCubit();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider<HomeCubit>(
          create: (context) => homeCubit,
          child: BlocListener<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is HomeLoding) {
              } else if (state is HomeSucess) {
                categories = state.categoris;
                productList = state.productList;
                selectedIndex = state.intex;
                print(categories.length);
              } else if (state is HomeFail) {}
            },
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoding) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                } else if (state is HomeSucess) {
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
                              )),
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
                      Container(
                        margin: EdgeInsets.only(top: 22, left: 22),
                        height: 30,
                        child: ListView.builder(
                          itemCount: categories.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                selectedIndex = index;
                                homeCubit.getCategories(selectedIndex);
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                margin: EdgeInsets.only(
                                    right: 16, top: 4, bottom: 4),
                                child: Text(
                                  categories[index],
                                  style: TextStyle(
                                    color: selectedIndex == index
                                        ? Colors.black
                                        : Colors.black54,
                                    fontWeight: selectedIndex == index
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(22.0),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // 2 elements per row
                              childAspectRatio: 3 /
                                  2, // Adjust this ratio to change the size of the items
                              crossAxisSpacing: 10.0,
                              mainAxisExtent:
                                  MediaQuery.of(context).size.height / 3,
                              // Space between items horizontally
                              mainAxisSpacing:
                                  10.0, // Space between items vertically
                            ),
                            itemCount: productList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductView(
                                                productModel:
                                                    productList[index],
                                              )));
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Image.network(
                                          productList[index].image ??
                                              'https://via.placeholder.com/150',
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Icon(Icons.error);
                                          },
                                          height: 100,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        productList[index].title!,
                                        maxLines: 1,
                                        textAlign: TextAlign.start,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "\$${productList[index].price!}",
                                        maxLines: 1,
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  );
                } else if (state is HomeFail) {
                  return Center(
                    child: Text(state.error),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
