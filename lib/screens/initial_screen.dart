import 'package:flutter/material.dart';
import 'package:home_for_new_year_game/models/car.dart';
import 'package:provider/provider.dart';
import 'package:home_for_new_year_game/controllers/main_controller.dart';
import 'package:home_for_new_year_game/models/car_queue_state.dart';
import 'package:home_for_new_year_game/widgets/board_view.dart';
import 'package:home_for_new_year_game/widgets/car_pager.dart';

class InitialScreen extends StatelessWidget {
  static const Map<String, String> colorToChineseName = {
    'red': '红色',
    'blue': '蓝色',
    'green': '绿色',
    'yellow': '黄色',
  };

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: const Color(0xFF3421AC),
      body: Consumer<MainController>(
        builder: (context, controller, _) {
          if (!controller.isInitialized) {
            return _buildLoadingIndicator();
          }
          return _buildGameInterface(controller, screenWidth);
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('回家过年'),
      centerTitle: true,
      backgroundColor: const Color(0xFF3421AC),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(color: Colors.white),
    );
  }

  Widget _buildGameInterface(MainController controller, double screenWidth) {
    final carWidth = screenWidth > 600 ? 300.0 : screenWidth / 2;
    final carState = controller.gameState!.carQueueState;

    return Stack(
      children: [
        _buildMainContent(controller, carWidth, carState),
        if (controller.isGameOver) _buildGameOverOverlay(controller),
      ],
    );
  }

  Widget _buildMainContent(
      MainController controller, double carWidth, CarQueueState carState) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCarInfoPanel(carState),
                _buildCarDisplay(carState, carWidth),
                _buildResetButton(controller),
                BoardView(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCarInfoPanel(CarQueueState carState) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildInfoText('当前车辆', carState.currentCar),
          SizedBox(height: 4),
          _buildInfoText('下一辆车', carState.nextCar),
        ],
      ),
    );
  }

  Widget _buildInfoText(String label, Car? car) {
    return Text(
      '$label: ${_getCarDescription(car)}',
      style: TextStyle(
        color: Color(0xFF3421AC),
        fontSize: 16,
        fontWeight: car != null ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  String _getCarDescription(Car? car) {
    return car != null
        ? '${colorToChineseName[car.color]} (剩余座位: ${car.seatCount})'
        : '无';
  }

  Widget _buildCarDisplay(CarQueueState carState, double carWidth) {
    return Container(
      width: carWidth * 2,
      height: carWidth / 2 + 20,
      child: CarPager(
        cars: _getVisibleCars(carState),
        carWidth: carWidth,
      ),
    );
  }

  List<Car?> _getVisibleCars(CarQueueState carState) {
    return [
      if (carState.currentCar != null) carState.currentCar,
      if (carState.nextCar != null) carState.nextCar,
    ];
  }

  Widget _buildResetButton(MainController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: controller.resetGame,
        child: Text('重置游戏'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF35257E),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildGameOverOverlay(MainController controller) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('候车区满', style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3421AC),
              )),
              SizedBox(height: 8),
              Text('游戏结束', style: TextStyle(
                fontSize: 24,
                color: Colors.black87,
              )),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: controller.resetGame,
                child: Text('重新开始'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3421AC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}