import 'dart:math';

import 'package:definitely_not_amazon/screens/home/repository/model/item_details.dart';
import 'package:definitely_not_amazon/utils/urls.dart';
import 'package:definitely_not_amazon/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ItemDetailsView extends StatefulWidget {
  ItemDetailsView({Key? key, required this.itemDetails}) : super(key: key);
  ItemDetails itemDetails;

  @override
  State<ItemDetailsView> createState() => _ItemDetailsViewState();
}

class _ItemDetailsViewState extends State<ItemDetailsView> {
  @override
  Widget build(BuildContext context) {
    var fontSize = MediaQuery.of(context).size.width * 0.02;
    var deviceType = getDeviceType(MediaQuery.of(context).size);
    return CustomScaffold(
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: deviceType == DeviceScreenType.mobile
              ? Column(
                  children: [
                    ImageSlider(imageUrls: widget.itemDetails.images!),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.itemDetails.name!,
                              style: TextStyle(
                                  fontSize: fontSize * 1.5,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.itemDetails.seller_name?.toString() ??
                                  "NA",
                              style: TextStyle(
                                fontSize: fontSize,
                              ),
                            ),
                            Text(
                              "₹${widget.itemDetails.price!.toString()}",
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: fontSize * 1.5,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: fontSize / 2, right: fontSize / 2),
                                  child: Text(
                                      widget.itemDetails.rating.toString(),
                                      style: TextStyle(fontSize: fontSize)),
                                ),
                                RatingBarIndicator(
                                  rating: widget.itemDetails.rating ?? 0.0,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: fontSize * 2,
                                  unratedColor: Colors.amber.withAlpha(50),
                                  direction: Axis.horizontal,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: fontSize,
                            ),
                            Text(
                              widget.itemDetails.description!,
                              maxLines: 10,
                              style: TextStyle(
                                fontSize: fontSize,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ReviewsWidget(reviews: widget.itemDetails.reviews ?? [])
                  ],
                )
              : Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: PhotoViewer(
                            imageUrls: widget.itemDetails.images,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.itemDetails.name!,
                                  style: TextStyle(
                                      fontSize: fontSize * 1.5,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  widget.itemDetails.seller_name?.toString() ??
                                      "NA",
                                  style: TextStyle(
                                    fontSize: fontSize,
                                  ),
                                ),
                                Text(
                                  "₹${widget.itemDetails.price!.toString()}",
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
                                          widget.itemDetails.rating.toString(),
                                          style: TextStyle(fontSize: fontSize)),
                                    ),
                                    RatingBarIndicator(
                                      rating: widget.itemDetails.rating ?? 0.0,
                                      itemBuilder: (context, index) =>
                                          const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: fontSize * 2,
                                      unratedColor: Colors.amber.withAlpha(50),
                                      direction: Axis.horizontal,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: fontSize,
                                ),
                                Text(
                                  widget.itemDetails.description!,
                                  maxLines: 10,
                                  style: TextStyle(
                                    fontSize: fontSize,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    ReviewsWidget(reviews: widget.itemDetails.reviews ?? [])
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
                            "${Urls.kBaseUrl}${widget.imageUrls![index]}",
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
                  "${Urls.kBaseUrl}${widget.imageUrls![selectedImageIndex]}",
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
          left: MediaQuery.of(context).size.width * 0.5 -
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
      height: MediaQuery.of(context).size.height * 0.5,
      child: PageView.builder(
        itemCount: widget.imageUrls.length,
        controller: _pageController,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            "${Urls.kBaseUrl}${widget.imageUrls[index]}",
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
      top: MediaQuery.of(context).size.height * 0.5 * 0.5 - 15,
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
      top: MediaQuery.of(context).size.height * 0.5 * 0.5 - 15,
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
    double fontSize = min(MediaQuery.of(context).size.width * 1 / 30,
        MediaQuery.of(context).size.height * 1 / 60);
    return Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text("Ratings",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 1 / 30,
                        fontWeight: FontWeight.bold)),
              ),
              reviews.isEmpty
                  ? Text("No reviews")
                  : Column(
                      children: List.generate(
                          reviews.length ?? 0,
                          (index) => Container(
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
                                    MediaQuery.of(context).size.height * 1 / 5,
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
                                                          (reviews[index].imageUrls ==
                                                                      null ||
                                                                  reviews[index]
                                                                      .imageUrls!
                                                                      .isEmpty)
                                                              ? "https://thumbs.dreamstime.com/z/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg"
                                                              : "Urls.kBaseUrl${reviews[index].imageUrls![0]}",
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
                                              : "https://ujjwalaggarwal.pythonanywhere.com${reviews[index].imageUrls![0]}",
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
