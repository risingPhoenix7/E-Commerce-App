import 'package:definitely_not_amazon/screens/home/repository/model/category.dart';
import 'package:definitely_not_amazon/screens/home/repository/model/mini_item_details.dart';
import 'package:definitely_not_amazon/screens/home/viewmodel/home_view_model.dart';
import 'package:definitely_not_amazon/screens/search/view/search_screen.dart';
import 'package:definitely_not_amazon/widgets/custom_appbar.dart';
import 'package:definitely_not_amazon/widgets/error_dialogue.dart';
import 'package:definitely_not_amazon/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Category> categories = [];
  bool isLoading = true;
  bool isError = false;

  getCategories() async {
    isError = false;
    try {
      categories = await HomeScreenViewModel.getCategories();
      categories.insert(
          0,
          Category(
              name: "Top 20",
              image:
                  "https://png.pngtree.com/png-vector/20220525/ourmid/pngtree-top-20-label-neon-best-png-image_4737812.png"));
      isError = false;
    } catch (e) {
      isError = true;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceType = getDeviceType(MediaQuery.of(context).size);

    return CustomScaffold(
      title: 'Home',
      body: isLoading
          ? Loader()
          : isError
              ? SizedBox(height: 100, width: 100, child: ErrorDialogue())
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoryBox(
                          category: categories[index], isTopCard: index == 0);
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          deviceType == DeviceScreenType.mobile ? 2 : 4,
                    ),
                  ),
                ),
    );
  }
}

class CategoryBox extends StatefulWidget {
  CategoryBox({Key? key, required this.category, required this.isTopCard})
      : super(key: key);
  Category category;
  bool isTopCard;

  @override
  State<CategoryBox> createState() => _CategoryBoxState();
}

class _CategoryBoxState extends State<CategoryBox> {
  Future<List<MiniItemDetails>> getItemDetails(bool isTopCard) async {
    List<MiniItemDetails> items = [];
    try {
      if (isTopCard) {
        items = await HomeScreenViewModel.getTrendingItems(20);
      } else {
        items =
            await HomeScreenViewModel.getCategoryItems(widget.category.name!);
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        print("Being pushed");
        List<MiniItemDetails> items = await getItemDetails(widget.isTopCard);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SearchScreen(
                    items: items, searchText: widget.category.name)));
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              // Calculate the font size based on the screen width
              double fontSize = constraints.maxWidth * 0.07;
              return Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(fontSize / 2),
                  child: Text(
                    widget.category.name ?? "IDK",
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }),
            Expanded(
              child: Image.network(
                widget.category.image ??
                    "https://www.google.com/url?sa=i&url=https%3A%2F%2Fprofessionals.tarkett.com%2Fen_EU%2Fcollection-C000117-id-square%2Fchambray-light-grey&psig=AOvVaw0j26eA23QeLz2hoJS4E079&ust=1681218861351000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCLj-lbqyn_4CFQAAAAAdAAAAABAI",
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
