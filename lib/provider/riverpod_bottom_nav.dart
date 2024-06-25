import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realtime_chat/provider/bottom_nav_provider.dart';

final bottomNavRiverpod = ChangeNotifierProvider((ref) => BottomNavProvider());
