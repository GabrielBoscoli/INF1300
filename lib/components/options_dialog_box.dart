import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class OptionsDialogBox extends StatelessWidget {
  static const String firstOption = "Tirar foto";
  static const String secondOption = "Selecionar da galeria";
  final Function? callback;
  final ImagePicker _imagePicker = ImagePicker();

  OptionsDialogBox({Key? key, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextButton(
                onPressed: () async {
                  final image = await openCamera();
                  Navigator.pop(context, image);
                },
                child: new Text(firstOption)),
            Padding(padding: EdgeInsets.all(8.0)),
            TextButton(
                onPressed: () async {
                  final image = await openGallery();
                  Navigator.pop(context, image);
                },
                child: new Text(secondOption)),
          ],
        ),
      ),
    );
  }

  Future<XFile?> openCamera() {
    return _imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1920,
      maxHeight: 1920,

    );
  }

  Future<XFile?> openGallery() {
    return _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1920,
    );
  }
}
