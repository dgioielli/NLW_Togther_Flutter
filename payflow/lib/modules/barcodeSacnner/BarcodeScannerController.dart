import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:payflow/modules/barcodeSacnner/BarcodeScannerStatus.dart';

class BarcodeScannerController {
  final statusNotifier =
      ValueNotifier<BarcodeScannerStatus>(BarcodeScannerStatus());
  BarcodeScannerStatus get status => statusNotifier.value;
  set status(BarcodeScannerStatus status) => statusNotifier.value = status;
  final barcodeScanner = GoogleMlKit.vision.barcodeScanner();

  void getAvailableCameras() async {
    try {
      print("getAvailableCameras - 1");
      final response = await availableCameras();
      final camera = response.firstWhere(
          (element) => element.lensDirection == CameraLensDirection.back);
      print("getAvailableCameras - 1");
      final cameraController = CameraController(
        camera,
        ResolutionPreset.max,
        enableAudio: false,
      );
      await cameraController.initialize();
      print("getAvailableCameras - 1");
      status = BarcodeScannerStatus.available(cameraController);
      scanWithCamera();
    } catch (e) {
      print(e);
      status = BarcodeScannerStatus.error(e.toString());
    }
  }

  void scanWithImagePicker() async {
    print("scanWithImagePicker - 1");
    await status.cameraController!.stopImageStream();
    print("scanWithImagePicker - 1");
    final response = await ImagePicker().getImage(source: ImageSource.gallery);
    print("scanWithImagePicker - 1");
    final inputImage = InputImage.fromFilePath(response!.path);
    print("scanWithImagePicker - 1");
    scannerBarcode(inputImage);
  }

  void scanWithCamera() {
    print("scanWithCamera - 1");
    Future.delayed(Duration(seconds: 20)).then((value) {
      if (status.cameraController != null) {
        if (status.cameraController!.value.isStreamingImages)
          status.cameraController!.stopImageStream();
      }
      print("scanWithCamera - 2");
      status = BarcodeScannerStatus.error("Timeout de leitura de boleto");
    });
    print("scanWithCamera - 3");
    listenCamera();
  }

  void listenCamera() {
    if (status.cameraController != null) {
      if (status.cameraController!.value.isStreamingImages == false) {
        status.cameraController!.startImageStream((image) async {
          try {
            print("listenCamera - 1");
            final WriteBuffer allBytes = WriteBuffer();
            for (Plane plane in image.planes) {
              print("listenCamera - 1");
              allBytes.putUint8List(plane.bytes);
            }
            print("listenCamera - 1");
            final bytes = allBytes.done().buffer.asUint8List();
            final Size imageSize =
                Size(image.width.toDouble(), image.height.toDouble());
            print("listenCamera - 1");
            final InputImageRotation imageRotation =
                InputImageRotation.Rotation_0deg;
            final InputImageFormat imageFormat =
                InputImageFormatMethods.fromRawValue(image.format.raw) ??
                    InputImageFormat.NV21;
            print("listenCamera - 1");
            final planeData = image.planes.map((Plane plane) {
              return InputImagePlaneMetadata(
                  bytesPerRow: plane.bytesPerRow,
                  height: plane.height,
                  width: plane.width);
            }).toList();
            print("listenCamera - 1");
            final inputImageData = InputImageData(
                size: imageSize,
                imageRotation: imageRotation,
                inputImageFormat: imageFormat,
                planeData: planeData);
            final inputImageCamera = InputImage.fromBytes(
                bytes: bytes, inputImageData: inputImageData);
            print("listenCamera - 1");
            await Future.delayed(Duration(seconds: 3));
            print("listenCamera - 1");
            await scannerBarcode(inputImageCamera);
          } catch (e) {
            print(e);
          }
        });
      }
    }
  }

  Future<void> scannerBarcode(InputImage inputImage) async {
    try {
      print("scannerBarcode - 1");
      if (status.cameraController != null) {
        if (status.cameraController!.value.isStreamingImages) {
          status.cameraController!.stopImageStream();
        }
      }
      print("scannerBarcode - 2");
      final barcodes = await barcodeScanner.processImage(inputImage);
      var barcode;
      print("scannerBarcode - 3");
      for (Barcode item in barcodes) {
        barcode = item.value.displayValue;
      }
      print("scannerBarcode - 4");
      if (barcode != null && !status.hasBarcode) {
        status = BarcodeScannerStatus.barcode(barcode);
        if (status.cameraController != null) status.cameraController!.dispose();
      } else {
        getAvailableCameras();
      }
      print("scannerBarcode - 5");
      return;
    } catch (e) {
      print(e);
    }
  }

  void dispose() {
    print("dispose - 1");
    statusNotifier.dispose();
    print("dispose - 1");
    barcodeScanner.close();
    if (status.showCamera) {
      print("dispose - 1");
      status.cameraController!.dispose();
    }
  }
}
