import 'package:path_provider/path_provider.dart';
import 'dart:io';



class TextStorage {
      Future<String> get _localPath async {
      final directory = await getApplicationDocumentsDirectory();
      return directory.path;
      }

      Future<File> get _localFile async {
      final path = await _localPath;
      return File('$path/demo.txt');
      }

      Future<String> readFile() async {
           try {

           final file = await _localFile;

          String content = await file.readAsString();
           return content;
          } catch (e) {
            return '';
           }
       }

       Future<File> writeFile(String text) async {
              final file = await _localFile;
              return file.writeAsString('$text\r\n', mode: FileMode.append);
       }

      Future<File> cleanFile() async {
                final file = await _localFile;
                return file.writeAsString('');
      }
}