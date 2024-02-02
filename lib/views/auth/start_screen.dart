import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:invoder_app/components/appbars/empty_app_bar.dart';
import 'package:invoder_app/components/ui/index.dart';
import 'package:invoder_app/utils/colors.dart';

List<Map<String, dynamic>> startCarouselData = [
  {
    'title': 'Add Up Multiple Branches',
    'description':
        'Streamline your business with the power to add multiple branches effortlessly.',
    'image': 'assets/images/world_map.svg',
  },
  {
    'title': 'Streamline Sales Effortlessly',
    'description':
        'With a user-friendly interface, you can process transactions, and accept payments with ease',
    'image': 'assets/images/add_to_cart.svg',
  },
  {
    'title': 'Gain Detailed Reporting',
    'description':
        'Unlock the power of data-driven decision-making with our comprehensive reporting features',
    'image': 'assets/images/reports.svg',
  },
];

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int _current = 0;
  CarouselController startCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: emptyAppBar(),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(20),
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CarouselSlider(
                            carouselController: startCarouselController,
                            options: CarouselOptions(
                              height: 350,
                              enableInfiniteScroll: false,
                              viewportFraction: 1,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              },
                            ),
                            items: startCarouselData.map((row) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          row['image'],
                                          width: 200,
                                          height: 200,
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          row['title'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          row['description'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color:
                                                    ThemeColors.lightDarkColor,
                                              ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                                startCarouselData.asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap: () => startCarouselController
                                    .animateToPage(entry.key),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 150),
                                  width: _current == entry.key ? 32 : 10,
                                  height: 10,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 3.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(50),
                                    color: (Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : primaryColor.shade900)
                                        .withOpacity(
                                            _current == entry.key ? 1 : 0.4),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'Skip',
                        onPressed: () {
                          Get.offAllNamed('/welcome');
                        },
                        variant: CustomButtonVariant.gray,
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: CustomButton(
                        text: 'Next',
                        onPressed: () {
                          if (_current == startCarouselData.length - 1) {
                            Get.offAllNamed('/welcome');
                          } else {
                            startCarouselController.nextPage();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
