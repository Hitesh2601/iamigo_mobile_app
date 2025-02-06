import 'package:push_notification/utility/constants/global_variables.dart';
import 'dart:math';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:shared_preferences/shared_preferences.dart';

class AESEncryption {
  static String encryptPassword(String plainText, String randomNumber) {
    final key = enc.Key.fromUtf8(GlobalVariables.encInput);

    final iv = enc.IV.fromUtf8(randomNumber);

    final encryptor = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));

    var encrypted = encryptor.encrypt(plainText, iv: iv);

    return encrypted.base64;
  }

  static String generateRandomNumber() {
    String strrandom = '';
    var charArr = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
    Random objran = Random();
    int noofcharacters = 16;
    int min = 1;
    int max = charArr.length;
    for (int i = 0; i < noofcharacters; i++) {
      int pos = objran.nextInt((max + 1) - min);
      strrandom = strrandom + charArr.elementAt(pos).toString();
    }
    return strrandom;
  }

  void callSharePreference(SharedPreferences mypref, String uuid) async {
    mypref = await SharedPreferences.getInstance();
    mypref.setString('UUID', uuid);
  }

  Future<SharedPreferences> getInstanceOfSharePreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  String getSharePreference() {
    String result = '';
    //final prefs = mypref;
    //prefs.then((value) => {result = value.getString('UUID').toString()});
    return result;
  }
}
 
 
 
// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:crypto/crypto.dart';
 
// String encryptAES(String plaintext, String password) {
//   final key = _generateKey(password);
//   final iv = _generateIV();
//   final cipher = encryptAES(plaintext, password);
//   final encrypted = cipher.encrypt(utf8.encode(plaintext));
//   final encodedIV = base64Url.encode(iv);
//   final encodedBytes = base64Url.encode(encrypted.bytes);
//   return "$encodedIV:$encodedBytes";
// }
 
// String decryptAES(String ciphertext, String password) {
//   final key = _generateKey(password);
//   final parts = ciphertext.split(":");
//   final iv = base64Url.decode(parts[0]);
//   final cipher = new AES(key, iv);
//   final decoded = base64Url.decode(parts[1]);
//   final decrypted = cipher.decrypt(new Encrypted(decoded));
//   return utf8.decode(decrypted);
// }
 
// Uint8List _generateKey(String password) {
//   final codec = new Utf8Codec();
//   final key = codec.encode(password);
//   final sha256 = new SHA256();
//   return sha256.process(key);
// }
 
// Uint8List _generateIV() {
//   final random = new Random.secure();
//   final iv = new Uint8List(16);
//   for (var i = 0; i < iv.length; i++) {
//     iv[i] = random.nextInt(256);
//   }
//   return iv;
// }
 
 