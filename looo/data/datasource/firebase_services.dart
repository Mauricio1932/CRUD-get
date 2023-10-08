import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getHomeworks() async {
  List homeworks = [];

  CollectionReference collectionReferenceHomeworks = db.collection('tarea');
  QuerySnapshot queryHomeworks = await collectionReferenceHomeworks.get();

  for (var element in queryHomeworks.docs) {
    final Map<String, dynamic> data = element.data() as Map<String, dynamic>;
    final homework = {
      'name': data['name'],
      'description': data['description'],
      'date': data['date'],
      'uid': element.id,
    };
    homeworks.add(homework);
  }

  return homeworks;
}

Future<void> addHomework(String name, String description, String date) async {
  await db
      .collection('tarea')
      .add({'name': name, 'description': description, 'date': date});
}

Future<List> getIdHomeworks() async {
  List id = [];

  CollectionReference collectionReferenceHomeworks = db.collection('tarea');
  QuerySnapshot queryHomeworks = await collectionReferenceHomeworks.get();

  queryHomeworks.docs.forEach((element) {
    String idStr = element.id;
    id.add(idStr);
  });

  return id;
}

Future<void> deleteHomework(String uid) async {
  DocumentReference docRef = await db.collection('tarea').doc(uid);
  docRef.delete();
}

//Actualizar
Future<void> updateHomework(
    String uid, String newname, String newdescription, String newdate) async {
  await db
      .collection('tarea')
      .doc(uid)
      .set({'name': newname, 'description': newdescription, 'date': newdate});
}
