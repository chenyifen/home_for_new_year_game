import 'package:flutter/material.dart';
import 'package:home_for_new_year_game/models/car.dart';
import 'package:home_for_new_year_game/widgets/car_view.dart';


class CarPager extends StatefulWidget {
  final List<Car?> cars;
  final double carWidth;

  const CarPager({
    required this.cars,
    required this.carWidth,
    Key? key,
  }) : super(key: key);

  @override
  _CarPagerState createState() => _CarPagerState();
}

class _CarPagerState extends State<CarPager> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.6,
      initialPage: 0,
    );
  }

  @override
  void didUpdateWidget(covariant CarPager oldWidget) {
    super.didUpdateWidget(oldWidget);
    _handlePageTransition(oldWidget.cars);
  }

  void _handlePageTransition(List<Car?> oldCars) {
    if (widget.cars.length > oldCars.length) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 2000),
        curve: Curves.easeInOut,
      );
    } else if (widget.cars.length < oldCars.length) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 2000),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.cars.length,
      onPageChanged: (index) => setState(() => _currentPage = index),
      itemBuilder: (context, index) {
        return _buildCarItem(widget.cars[index], index);
      },
    );
  }

  Widget _buildCarItem(Car? car, int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        final value = _calculatePageValue(index);
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: car != null
          ? CarView(
              car: car,
              width: 300.0,//TODO chenyifen
            )
          : const SizedBox.shrink(),
    );
  }

  double _calculatePageValue(int index) {
    if (_pageController.position.haveDimensions) {
      final value = _pageController.page! - index;
      return (1 - value.abs() * 0.3).clamp(0.0, 1.0);
    }
    return 1.0;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}