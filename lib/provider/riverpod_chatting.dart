import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realtime_chat/provider/chatting_provider.dart';

final chattingRiverpod = ChangeNotifierProvider((ref) => ChattingProvider());
