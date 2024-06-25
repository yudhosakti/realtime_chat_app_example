import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realtime_chat/provider/auth_login_provider.dart';

final authLoginRiverpod = ChangeNotifierProvider((ref) => AuthLoginProvider());
