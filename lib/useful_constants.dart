import 'dart:io';

import 'package:flutter/foundation.dart';

const msStorePackageName = 'Microsoft.DesktopAppInstaller_8wekyb3d8bbwe';

bool get kIsDesktop =>
    (Platform.isWindows || Platform.isLinux || Platform.isMacOS) && !kIsWeb;

bool get isSnap =>
    !kIsWeb && Platform.isLinux && Platform.environment.containsKey('SNAP');

bool get isFlatpak =>
    !kIsWeb &&
    Platform.isLinux &&
    Platform.environment.containsKey('FLATPAK_ID');

bool get isMsix =>
    !kIsWeb &&
    Platform.isWindows &&
    Platform.resolvedExecutable.contains('WindowsApps') &&
    Platform.resolvedExecutable.contains(msStorePackageName);
