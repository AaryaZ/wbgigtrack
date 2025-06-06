import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gigtrack/home.dart';
import 'package:gigtrack/settings.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Navigationcontroller());

    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller._selectedIndex.value,
          onDestinationSelected:
              (index) => {
                controller._selectedIndex.value = index,
                // Get.to(controller.screens[index]),
              },
          backgroundColor: Colors.grey[350],
          indicatorColor: Colors.white,
          indicatorShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.grid_view_rounded,
                color: Colors.black,
                size: 30,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings, color: Colors.black, size: 30),
              label: 'Settings',
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller._selectedIndex.value]),
    );
  }
}

class Navigationcontroller extends GetxController {
  final Rx<int> _selectedIndex = 0.obs;

  final screens = [Home(), Settings()];
}
