import 'package:definitely_not_amazon/provider/viewmodel/user_details_viewmodel.dart';
import 'package:definitely_not_amazon/screens/home/repository/model/mini_item_details.dart';
import 'package:definitely_not_amazon/screens/home/viewmodel/home_view_model.dart';
import 'package:definitely_not_amazon/screens/search/view/search_screen.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  CustomAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/home', ModalRoute.withName('/'));
              },
              child: Image.asset(
                'assets/images/logo.png', // Replace with your logo URL
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      cursorColor: Colors.black,
                      controller: _searchController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: GestureDetector(
                            onTap: () async {
                              if (_searchController.text.isNotEmpty) {
                                try {
                                  List<MiniItemDetails> items =
                                      await HomeScreenViewModel.getSearchItems(
                                          _searchController.text);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SearchScreen(
                                              items: items,
                                              searchText:
                                                  _searchController.text)));
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString())));
                                }
                              }
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(7),
                                    topRight: Radius.circular(7)),
                                color: Colors.orange,
                              ),
                              child: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Search',
                        contentPadding: EdgeInsets.all(10.0),
                        hintStyle: const TextStyle(color: Colors.black38),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                    context,
                    UserDetailsViewModel.userDetailsModel == null ||
                            UserDetailsViewModel.userDetailsModel!.access ==
                                null ||
                            UserDetailsViewModel
                                .userDetailsModel!.access!.isEmpty
                        ? '/login'
                        : '/profile');
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    UserDetailsViewModel.userDetailsModel == null
                        ? 'Sign In'
                        : 'Hello,\n${UserDetailsViewModel.userDetailsModel!.first_name ?? 'NA'}',
                    style: const TextStyle(color: Colors.white, fontSize: 10)),
              ),
            ),
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart, color: Colors.white),
                  onPressed: () {
                    // Add your onPressed logic
                  },
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.orange,
                    child: Text(
                      UserDetailsViewModel.userDetailsModel?.cart_count
                              .toString() ??
                          '0',
                      // Replace with the number of items in the cart
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomScaffold extends StatelessWidget {
  final String? title;
  final Widget body;

  CustomScaffold({Key? key, this.title, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: body,
    );
  }
}
