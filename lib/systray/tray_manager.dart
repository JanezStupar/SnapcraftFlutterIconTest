import 'dart:io';

import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

class TestTray with TrayListener {
  Future<void> init() async {
    // root Systray entry
    const systrayIconPath = 'assets/img/icon.png';
    await trayManager.setIcon(systrayIconPath);
    print("Systray initialized, icon: $systrayIconPath");

    try {
      // Create the context menu. We are not using hide and quit on MacOS
      // because the windowManager does not perform as expected on MacOS
      Menu menu;
      if (Platform.isMacOS) {
        menu = Menu(items: [
          MenuItem(key: "focus", label: "Focus"),
          MenuItem(key: "quit", label: "Quit")
        ]);
      } else {
        menu = Menu(items: [
          MenuItem(key: "focus", label: "Focus"),
          MenuItem(key: "hide", label: "Hide"),
          MenuItem(key: "quit", label: "Quit")
        ]);
      }

      await trayManager.setContextMenu(menu);
    } catch (e) {
      print("Systray initialization failed: $e");
    }
  }

  @override
  void onTrayIconMouseDown() {
    trayManager.popUpContextMenu();
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) {
    if (menuItem.key == 'quit') {
      windowManager.close();
    }
    if (menuItem.key == 'focus') {
      windowManager.show();
      windowManager.focus();
    }
    if (menuItem.key == 'hide') {
      windowManager.hide();
    }
  }
}
