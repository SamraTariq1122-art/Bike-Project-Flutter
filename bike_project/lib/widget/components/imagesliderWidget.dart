import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../../data/imageSliderData.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  CarouselController carouselController = CarouselController();
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: CarouselSlider(
              carouselController: carouselController,
              items: imageList
                  .map((image) => ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          image,
                          fit: BoxFit.fill,
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2,
                viewportFraction: 1,
                autoPlayAnimationDuration: Duration(seconds: 1),
                scrollPhysics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentindex = index;
                  });
                },
              ),
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 10,
            child: DotsIndicator(
              dotsCount: imageList.length,
              position: currentindex,
              decorator: DotsDecorator(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.white,
                activeColor: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
