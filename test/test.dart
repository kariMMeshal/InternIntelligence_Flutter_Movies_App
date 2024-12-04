import 'dart:io';

void checkFileExistence() {
  final file = File('.env');
  if (file.existsSync()) {
    print('File exists');
  } else {
    print('File does not exist');
  }
}

void main() async {
  checkFileExistence();
}