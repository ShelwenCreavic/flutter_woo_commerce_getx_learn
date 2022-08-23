import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';
import 'widgets/widgets.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return Column(
      children: [
        const HelloWidget(),
        ElevatedButton(
          onPressed: () {
            controller.handleTap(12);
          },
          child: const Text('change'),
        ),
        ElevatedButton(
          onPressed: () {
            Get.toNamed("/spalsh");
          },
          child: const Text('跳转 splash'),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("login")),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}