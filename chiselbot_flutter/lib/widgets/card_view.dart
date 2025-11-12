import 'dart:math';

import 'package:flutter/material.dart';

import '../models/cards.dart';

class CardView extends StatefulWidget {
  final List<CardData> items;
  final Function(int index)? onCardTap;

  const CardView({
    super.key,
    required this.items,
    this.onCardTap,
  });

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  PageController? pageController;
  var viewPortFraction = .5;
  double? pageOffset = 0;
  Size? size;

  @override
  void initState() {
    super.initState();
    pageController =
        PageController(initialPage: 0, viewportFraction: viewPortFraction)
          ..addListener(
            () {
              setState(() {
                pageOffset = pageController!.page;
              });
            },
          );
  }

  @override
  void dispose() {
    pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return PageView.builder(
      controller: pageController,
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final cardData = widget.items[index];
        double distance = (pageOffset! - index).abs();
        final bool isSelected = distance < .5;
        double scale = max(0.7, 1 - distance * 0.2);

        return GestureDetector(
          onTap: () {
            // 콜백 함수가 있으면 호출
            if (widget.onCardTap != null) {
              widget.onCardTap!(index);
            }
          },
          child: Padding(
            padding: EdgeInsets.only(
              right: size!.width * .02,
              left: size!.width * .0,
              top: 40 - scale * 20,
            ),
            child: Transform.scale(
              scale: scale,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(60)),
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest
                            : Theme.of(context).colorScheme.surfaceContainerLow,
                      ),
                    ),
                    Column(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * .015,
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(width: 50, child: cardData.icon),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * .015,
                          ),
                        ),
                        Text(
                          cardData.title,
                          style: const TextStyle(
                            fontSize: 16,
                            // color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * .015,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
