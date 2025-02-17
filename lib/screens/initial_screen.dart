import 'package:flutter/material.dart';
import 'package:home_for_new_year_game/widgets/board_view.dart';
import 'package:home_for_new_year_game/widgets/car_view.dart';
import 'package:home_for_new_year_game/widgets/current_car_view.dart';
import 'package:home_for_new_year_game/widgets/next_car_view.dart';
import 'package:provider/provider.dart';
import 'package:home_for_new_year_game/controllers/main_controller.dart';

class InitialScreen extends StatelessWidget {
  // 颜色转换为中文的映射
  final Map<String, String> colorToChineseName = {
    'red': '红色',
    'blue': '蓝色',
    'green': '绿色',
    'yellow': '黄色',
  };

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final carWidth = screenWidth > 600 ? 300.0 : screenWidth / 2;

    return Scaffold(
      appBar: AppBar(
        title: Text('回家过年'),
        centerTitle: true,
        backgroundColor: Color(0xFF3421AC),
      ),
      backgroundColor: Color(0xFF3421AC),
      body: Consumer<MainController>(
        builder: (context, controller, child) {
          if (!controller.isInitialized || controller.gameState == null) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }

          return Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 车辆信息显示
                          Container(
                            padding: EdgeInsets.all(16),
                            margin: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  '当前车辆: ${colorToChineseName[controller.gameState?.carQueueState.currentCar?.color ?? '']} (剩余座位: ${controller.gameState?.carQueueState.currentCar?.seatCount ?? 0})',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF3421AC),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '下一辆车: ${colorToChineseName[controller.gameState?.carQueueState.nextCar?.color ?? '']}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF3421AC),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: carWidth / 6,
                                child: NextCarView(),
                              ),
                              Container(
                                width: carWidth/3,
                              ),
                              Container(
                                width: carWidth,
                                child: CurrentCarView(),
                              ),
                              Container(
                                width: carWidth/2,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () => controller.resetGame(),
                              child: Text('重置游戏'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF35257E),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          BoardView(),
                        ],
                      ),
                    ),
                  );
                },
              ),
              // 游戏结束显示层
              if (controller.isGameOver)
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 30,
                      ),
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
                          Text(
                            '候车区满',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3421AC),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '游戏结束',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () => controller.resetGame(),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              child: Text(
                                '重新开始',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
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
                ),
            ],
          );
        },
      ),
    );
  }
}