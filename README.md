# qr_scanner

A new Flutter application.
![](images/22.png)

### Screenshots of App
<img src="images/33.png" width="300" height="500">
<img src="images/44.png" width="300" height="500">


### Features

* [x] Scan 2D barcodes
* [x] Scan QR codes
* [x] Control the flash while scanning
* [x] Permission handling
* [ ] Support multiple barcode libraries

### Android 
 add a permission and a activity to AndroidManifest.xml
  
  `<uses-permission android:name="android.permission.CAMERA" />`
  
  `<activity android:name="com.apptreesoftware.barcodescan.BarcodeScannerActivity"/>`
  
### Ios
  add a key and a string to Info.plist 
 
 `<key>NSCameraUsageDescription</key>`
 
  `<string>Camera permission is required for barcode scanning.</string>`
  
### Commits
* [ ] added a history tab
* [ ] added a image picker tab
  
  
## Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.io/).
