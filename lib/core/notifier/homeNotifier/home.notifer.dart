import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class HomeNotifer with ChangeNotifier {
  final ImagePicker picker = ImagePicker();
  File? userImage;
  File? get getUserImage => userImage;
  bool loading = false;
  bool? get getLoading => loading;
  String? finalText;
  final textDetector = GoogleMlKit.vision.textDetector();

  Future pickUserImage(
      {required BuildContext context, required ImageSource source}) async {
    final pickedUserImage = await picker.pickImage(source: source);
    userImage = File(pickedUserImage!.path);

    if (userImage != null) {
      finalText = '';
      userImage = await ImageCropper.cropImage(
          sourcePath: userImage!.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: const AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: const IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));
      loading = true;
      notifyListeners();
    } else {
      loading = false;
      notifyListeners();
    }
  }

  getImageFromText({required BuildContext context}) async {
    if (userImage != null) {
      final inputImage = InputImage.fromFile(userImage!);
      final RecognisedText recognisedText =
          await textDetector.processImage(inputImage);

      // ignore: unused_local_variable
      String text = recognisedText.text;

      for (TextBlock block in recognisedText.blocks) {
        for (TextLine line in block.lines) {
          for (TextElement element in line.elements) {
            finalText = finalText! + ' ' + element.text;
            notifyListeners();
          }
        }
      }
    } else {
      showInfo(context: context, text: 'Please Select A Image');
    }
  }

  copyTextToClipBoard({required BuildContext context}) async {
    if (finalText!.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: finalText!));
      showInfo(context: context, text: 'Text Copied Successfully');
    } else {
      showInfo(
          context: context, text: 'Image Has No Text That Can Be Extracted');
    }
  }

  showInfo({required BuildContext context, required String text}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
