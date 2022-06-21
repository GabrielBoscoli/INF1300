import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final DatabaseReference ref = FirebaseDatabase.instance.ref();
  late final DatabaseReference usersReference = ref.child(_usersChild);
  late String? userId;
  static const String _usersChild = 'users';
  static const String _somaString = 'soma';
  static const String _countString = 'count';

  Future<int> getMediaMeta() async {
    DataSnapshot snapshot = await ref.child(_somaString).get();
    if (snapshot.exists) {
      int soma = int.parse(snapshot.value.toString());
      snapshot = await ref.child(_countString).get();
      if (snapshot.exists) {
        int count = int.parse(snapshot.value.toString());
        return soma~/count;
      }
    }
    return -1;
  }

  Future<void> updateMeta(String userId, int novaMeta, int metaAntiga) async {
    DataSnapshot snapshot = await ref.child(_somaString).get();
    int soma = 0;
    if (snapshot.exists) {
      soma = int.parse(snapshot.value.toString());
    }
    ref.child(_somaString).set(soma - metaAntiga + novaMeta);
    usersReference.child(userId).set(novaMeta);
  }

  Future<String?> createUserId() async {
    DataSnapshot snapshot = await ref.child(_countString).get();
    if (snapshot.exists) {
      final int count = int.parse(snapshot.value.toString());
      ref.child(_countString).set(count + 1);
    }
    return usersReference.push().key;
  }
}