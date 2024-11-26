import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

import '../useful_constants.dart';

class TestTray with TrayListener {
  Future<void> init() async {
    // root Systray entry
    // const systrayIconPath = 'assets/img/icon.png';
    var systrayIconPath = 'assets/img/icon.png';

    try {
      // Create the context menu. We are not using hide and quit on MacOS
      // because the windowManager does not perform as expected on MacOS
      Menu menu = Menu(items: [
        MenuItem(key: "focus", label: "Focus"),
        MenuItem(key: "hide", label: "Hide"),
        MenuItem(key: "quit", label: "Quit")
      ]);
      if (Platform.isMacOS) {
        menu = Menu(items: [
          MenuItem(key: "focus", label: "Focus"),
          MenuItem(key: "quit", label: "Quit")
        ]);
      } else if (isSnap) {
        systrayIconPath = p.joinAll([
          p.dirname(Platform.resolvedExecutable),
          'data/flutter_assets/assets/img',
          'icon.png'
        ]);
      }

      print("Systray initialized, icon: $systrayIconPath");
      await trayManager.setIcon(systrayIconPath);
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
