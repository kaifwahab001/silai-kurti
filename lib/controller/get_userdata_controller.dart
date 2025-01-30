import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class GetUserDatController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<QueryDocumentSnapshot<Object?>>> getData(String uId) async {
    try {
      final QuerySnapshot userData =
          await firestore
              .collection('users')
              .where('uId', isEqualTo: uId)
              .get();
      print(userData.docs);
      return userData.docs;
    } catch (e) {
      print('Error fetching user data: $e');
      print('helllo');
      return [];
    }
  }
}
