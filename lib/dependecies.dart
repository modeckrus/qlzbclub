import 'package:get_it/get_it.dart';

import 'impl/fire_user_repo_impl.dart';
import 'service/db_service.dart';
import 'service/dgraph_service.dart';
import 'service/user_service.dart';

class Dependencies {
  static Future<void> init() async {
    final fbuserRepo = FirebaseUserRepo();
    GetIt.I.registerSingleton<UserService>(fbuserRepo);
    await fbuserRepo.init();
    if (fbuserRepo.isSignIn) {
      if (!isDb) {
        await initDb();
      }
    }
  }

  static bool isDb = false;
  static Future<int> initDb() async {
    final Dgraph dgraph = Dgraph();
    GetIt.I.registerSingleton<Db>(dgraph);
    try {
      await dgraph.init();
      isDb = true;
      return 1;
    } catch (e) {
      print(e);
      return 0;
    }
  }
}
