import 'dart:math';

import 'package:definitely_not_amazon/screens/home/repository/model/item_details.dart';
import 'package:definitely_not_amazon/widgets/custom_appbar.dart';
import 'package:definitely_not_amazon/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:responsive_builder/responsive_builder.dart';

class EditItemDetailsScreen extends StatefulWidget {
  EditItemDetailsScreen({Key? key, required this.itemDetails})
      : super(key: key);
  ItemDetails itemDetails;

  @override
  State<EditItemDetailsScreen> createState() => _EditItemDetailsScreenState();
}

class _EditItemDetailsScreenState extends State<EditItemDetailsScreen> {
  int quantity = 1;
  TextEditingController mrpController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    descriptionController.text = widget.itemDetails.description!;
    nameController.text = widget.itemDetails.name!;
    priceController.text = widget.itemDetails.price.toString();
    mrpController.text = widget.itemDetails.mrp.toString();
    quantity = widget.itemDetails.quantity!;

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ItemDetails itemDetails = widget.itemDetails;
    var fontSize = MediaQuery
        .of(context)
        .size
        .width * 0.015;
    var mobFontSize = MediaQuery
        .of(context)
        .size
        .height * 0.03;
    var deviceType = getDeviceType(MediaQuery
        .of(context)
        .size);
    return CustomScaffold(
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: deviceType == DeviceScreenType.mobile
              ? Column(
            children: [
              ImageSlider(imageUrls: itemDetails.images!),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        controller: nameController,
                        style: TextStyle(
                            fontSize: mobFontSize * 1.5,
                            fontWeight: FontWeight.bold),
                        text: 'Name',
                      ),
                      Text(
                        itemDetails.store_name?.toString() ?? "NA",
                        style: TextStyle(
                          fontSize: mobFontSize / 1.5,
                          color: Colors.grey,
                        ),
                      ),
                      CustomTextField(
                        controller: priceController,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9]')),
                        ],
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: mobFontSize * 1.5,
                            fontWeight: FontWeight.bold),
                        text: 'Selling Price',
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: mobFontSize / 2,
                                right: mobFontSize / 2),
                            child: Text(itemDetails.rating.toString(),
                                style: TextStyle(
                                    fontSize: mobFontSize / 1.2)),
                          ),
                          RatingBarIndicator(
                            rating: itemDetails.rating ?? 0.0,
                            itemBuilder: (context, index) =>
                                Icon(
                                  Icons.star,
                                  size: mobFontSize / 2,
                                  color: Colors.amber,
                                ),
                            itemCount: 5,
                            itemSize: mobFontSize / 2,
                            unratedColor: Colors.amber.withAlpha(50),
                            direction: Axis.horizontal,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: fontSize,
                      ),
                      CustomTextField(
                        maxLines: 4,
                        controller: descriptionController,
                        text: 'Description',
                      ),

                      // UserDetailsViewModel.userDetailsModel == null
                      //     ? Container()
                      //     :

                      SizedBox(
                        height: mobFontSize,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text("Quantity Available ",
                                  style:
                                  TextStyle(fontSize: mobFontSize / 1.2)),
                              Row(
                                children: [
                                  Container(
                                    height: mobFontSize * 1.5,
                                    width: mobFontSize * 1.5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            10)),
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          quantity++;
                                        });
                                      },
                                      child: Text(
                                        "+",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: mobFontSize / 1.5),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: mobFontSize / 2,
                                  ),
                                  Text(quantity.toString(),
                                      style:
                                      TextStyle(fontSize: mobFontSize / 1.2)),
                                  SizedBox(
                                    width: mobFontSize / 2,
                                  ),
                                  Container(
                                    height: mobFontSize * 1.5,
                                    width: mobFontSize * 1.5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            10)),
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          if (quantity > 0) {
                                            quantity--;
                                          }
                                        });
                                      },
                                      child: Text(
                                        "-",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: mobFontSize / 1.5),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(width: fontSize*15),
                          SizedBox(width: fontSize*10, child: CustomTextField(
                              controller: mrpController, text: 'MRP'))
                        ],
                      ),
                      SizedBox(
                        height: mobFontSize,
                      ),
                      Center(
                        child: Container(
                          height: mobFontSize * 2,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.5,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: mobFontSize),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ReviewsWidget(reviews: itemDetails.reviews ?? [])
            ],
          )
              : Column(
            children: [
              Container(
                height: min(MediaQuery
                    .of(context)
                    .size
                    .height * 0.5,
                    MediaQuery
                        .of(context)
                        .size
                        .width * 0.3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: PhotoViewer(
                          imageUrls: itemDetails.images,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  controller: nameController,
                                  style: TextStyle(
                                      fontSize: fontSize * 1.5,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  itemDetails.store_name?.toString() ??
                                      "NA",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: fontSize / 1.5,
                                  ),
                                ),
                                TextField(
                                  controller: priceController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: fontSize * 1.5,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: fontSize / 2,
                                          right: fontSize / 2),
                                      child: Text(
                                          itemDetails.rating.toString(),
                                          style: TextStyle(
                                              fontSize: fontSize)),
                                    ),
                                    RatingBarIndicator(
                                      rating: itemDetails.rating ?? 0.0,
                                      itemBuilder: (context, index) =>
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: fontSize * 2,
                                      unratedColor:
                                      Colors.amber.withAlpha(50),
                                      direction: Axis.horizontal,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: fontSize,
                                ),
                                TextField(
                                  controller: descriptionController,
                                  maxLines: 10,
                                  style: TextStyle(
                                    fontSize: fontSize,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            child: LayoutBuilder(builder:
                                (BuildContext context,
                                BoxConstraints constraints) {
                              // Calculate the font size based on the screen width
                              double height = constraints.maxHeight;
                              double width = constraints.maxWidth;
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.1),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    CustomTextField(
                                        controller: mrpController,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .allow(RegExp(r'[0-9]')),
                                        ],
                                        text: "MRP"),

                                    SizedBox(
                                      height: height * 0.05,
                                    ),

                                    SizedBox(
                                      height: fontSize / 2,
                                    ),
                                    Text("Change available quantity",
                                        style: TextStyle(
                                            fontSize: fontSize / 1.5)),
                                    // quantity button add and subtract, minimum 0
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: height * 0.10,
                                          width: width * 0.10,
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10)),
                                          child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                if (quantity > 0) {
                                                  quantity--;
                                                }
                                              });
                                            },
                                            child: Text(
                                              "-",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: fontSize / 1),
                                            ),
                                          ),
                                        ),
                                        //a quantity textfield here
                                        Container(
                                          width: width * 0.10,
                                          height: height * 0.10,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10)),
                                          child: Center(
                                            child: Text(
                                              quantity.toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),

                                        Container(
                                          height: height * 0.10,
                                          width: width * 0.10,
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10)),
                                          child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                quantity++;
                                              });
                                            },
                                            child: Text(
                                              "+",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: fontSize / 1),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(
                                      height: fontSize / 2,
                                    ),
                                    Container(
                                      height: height * 0.10,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius:
                                          BorderRadius.circular(10)),
                                      child: TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          "Save",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: fontSize / 1.55),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ))
                  ],
                ),
              ),
              ReviewsWidget(reviews: itemDetails.reviews ?? [])
            ],
          )),
    );
  }
}

class PhotoViewer extends StatefulWidget {
  const PhotoViewer({Key? key, required this.imageUrls}) : super(key: key);
  final List<String>? imageUrls;

  @override
  State<PhotoViewer> createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  int selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Calculate the font size based on the screen width
          return Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: constraints.maxWidth * 0.2,
                  height: constraints.maxHeight,
                  child: Align(
                    alignment: Alignment.center,
                    child: ListView.builder(
                      itemCount: widget.imageUrls!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: selectedImageIndex == index
                                        ? Colors.black
                                        : Colors.transparent)),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedImageIndex = index;
                                });
                              },
                              child: Image.network(
                                "${widget.imageUrls![index]}",
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      "${widget.imageUrls![selectedImageIndex]}",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class ImageSlider extends StatefulWidget {
  final List<String> imageUrls;

  ImageSlider({required this.imageUrls});

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildPageView(),
        Positioned(
          bottom: 8,
          left: MediaQuery
              .of(context)
              .size
              .width * 0.5 -
              (widget.imageUrls.length * 12),
          // Adjust the multiplier (12) to control the spacing between the circles
          child: _buildCircleIndicator(),
        ),
        _buildLeftArrowButton(),
        _buildRightArrowButton(),
      ],
    );
  }

  Widget _buildPageView() {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.5,
      child: PageView.builder(
        itemCount: widget.imageUrls.length,
        controller: _pageController,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            "${widget.imageUrls[index]}",
            fit: BoxFit.contain,
            width: double.infinity,
            height: double.infinity,
          );
        },
        onPageChanged: (int index) {
          _currentPageNotifier.value = index;
        },
      ),
    );
  }

  Widget _buildLeftArrowButton() {
    return Positioned(
      left: 0,
      top: MediaQuery
          .of(context)
          .size
          .height * 0.5 * 0.5 - 15,
      child: IconButton(
        onPressed: () {
          _pageController.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
    );
  }

  Widget _buildRightArrowButton() {
    return Positioned(
      right: 0,
      top: MediaQuery
          .of(context)
          .size
          .height * 0.5 * 0.5 - 15,
      child: IconButton(
        onPressed: () {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
        icon: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  Widget _buildCircleIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CirclePageIndicator(
        itemCount: widget.imageUrls.length,
        currentPageNotifier: _currentPageNotifier,
      ),
    );
  }
}

class ReviewsWidget extends StatelessWidget {
  const ReviewsWidget({Key? key, required this.reviews}) : super(key: key);
  final List<ReviewDetails> reviews;

  @override
  Widget build(BuildContext context) {
    double fontSize = min(MediaQuery
        .of(context)
        .size
        .width * 1 / 30,
        MediaQuery
            .of(context)
            .size
            .height * 1 / 60);
    return Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text("Reviews",
                    style: TextStyle(
                        fontSize: MediaQuery
                            .of(context)
                            .size
                            .width * 1 / 35,
                        fontWeight: FontWeight.bold)),
              ),
              reviews.isEmpty
                  ? const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text("No reviews"),
                  ))
                  : Column(
                  children: List.generate(
                      reviews.length ?? 0,
                          (index) =>
                          Container(
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
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            height:
                            MediaQuery
                                .of(context)
                                .size
                                .height * 1 / 5,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            child: GestureDetector(
                                              onTap: () =>
                                                  Navigator.pop(context),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      (reviews[index]
                                                          .imageUrls ==
                                                          null ||
                                                          reviews[index]
                                                              .imageUrls!
                                                              .isEmpty)
                                                          ? "https://thumbs.dreamstime.com/z/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg"
                                                          : "Urls.kBaseUrl${reviews[index]
                                                          .imageUrls![0]}",
                                                    ),
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Image.network(
                                      (reviews[index].imageUrls == null ||
                                          reviews[index]
                                              .imageUrls!
                                              .isEmpty)
                                          ? "https://thumbs.dreamstime.com/z/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg"
                                          : "https://ujjwalaggarwal.pythonanywhere.com${reviews[index]
                                          .imageUrls![0]}",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          reviews[index].title ?? "NA",
                                          style: TextStyle(
                                              fontSize: fontSize,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: fontSize / 2,
                                                  right: fontSize / 2),
                                              child: Text(
                                                  reviews[index]
                                                      .rating
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: fontSize)),
                                            ),
                                            RatingBarIndicator(
                                              rating:
                                              reviews[index].rating ??
                                                  0.0,
                                              itemBuilder:
                                                  (context, index) =>
                                              const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              itemCount: 5,
                                              itemSize: fontSize * 2,
                                              unratedColor: Colors.amber
                                                  .withAlpha(50),
                                              direction: Axis.horizontal,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          reviews[index].reviewer_name ??
                                              "NA",
                                          style: TextStyle(
                                              fontSize: fontSize,
                                              fontStyle: FontStyle.italic),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: fontSize),
                                        Flexible(
                                          child: Text(
                                            reviews[index].description ??
                                                "NA",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )))
            ],
          ),
        ));
  }
}

class ShowMoreText extends StatefulWidget {
  final String text;
  final int maxLines;

  ShowMoreText({required this.text, required this.maxLines});

  @override
  _ShowMoreTextState createState() => _ShowMoreTextState();
}

class _ShowMoreTextState extends State<ShowMoreText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final TextPainter textPainter = TextPainter(
          text: TextSpan(
            text: widget.text,
            style: DefaultTextStyle
                .of(context)
                .style,
          ),
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr,
        )
          ..layout(maxWidth: constraints.maxWidth);

        final bool isTextOverflowing = textPainter.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.text,
              maxLines: _isExpanded ? null : widget.maxLines,
              overflow: TextOverflow.clip,
            ),
            if (isTextOverflowing)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Text(
                  _isExpanded ? "Show Less" : "Show More",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
          ],
        );
      },
    );
  }
}
