import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photoaday/services/services.dart';
import 'package:photoaday/widgets/pages/project/Project.dart';
import 'package:rxdart/rxdart.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Project>> getProjects() async {
    var ref = _db.collection('projects');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var projects = data.map((d) => Project.fromJson(d));

    return projects.toList();
  }

  Future<UniversalDay> getUniversalDay(String date) async {
    var ref = _db.collection('universaldays').doc(date);
    var snapshot = await ref.get();

    return UniversalDay.fromJson(snapshot.data() ?? {});
  }

  Stream<Project> streamProject() {
    return AuthService().userStream.switchMap(
      (user) {
        if (user != null) {
          var ref = _db.collection('reports').doc(user.uid);
          return ref.snapshots().map((doc) => Project.fromJson(doc.data()!));
        } else {
          return Stream.fromIterable([Project()]);
        }
      },
    );
  }

  Future<void> createUserProject(
      String name, String description, ProjectTypes type) {
    var user = AuthService().user!;
    var ref = _db.collection('projects').doc(user.uid);

    var data = {
      'id': DateTime.now().toString(),
      'name': name,
      'description': description,
      'type': type,
    };

    return ref.set(data);
  }

  Future<void> updateUserProjectName(String name) {
    var user = AuthService().user!;
    var ref = _db.collection('projects').doc(user.uid);

    var data = {
      'name': name,
    };

    return ref.set(data, SetOptions(merge: true));
  }
}
