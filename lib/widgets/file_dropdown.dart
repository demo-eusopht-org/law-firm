// import 'dart:io';
//
// import 'package:flutter/material.dart';
//
// class FileDropdown extends StatefulWidget {
//   const FileDropdown({super.key});
//
//   @override
//   State<FileDropdown> createState() => _FileDropdownState();
// }
//
// class _FileDropdownState extends State<FileDropdown> {
//   List<String> fileNames = []; // List of file names
//   String? selectedFile; // Currently selected file
//
//   @override
//   void initState() {
//     super.initState();
//     loadFiles(); // Load files when the app starts
//   }
//
//   // Load files from a directory
//   void loadFiles() async {
//     Directory directory =
//         Directory('/storage/emulated/0/Download/Alpha-Generation/images');
//     List<FileSystemEntity> files = directory.listSync();
//     files.forEach((file) {
//       if (file is File) {
//         fileNames.add(file.path.split('/').last);
//       }
//     });
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("File Dropdown Example"),
//       ),
//       body: Center(
//         child: DropdownButton<String>(
//           value: selectedFile,
//           hint: Text('Select a file'),
//           onChanged: (String newValue) {
//             setState(() {
//               selectedFile = newValue;
//             });
//             // Perform actions based on the selected file
//             print("Selected file: $selectedFile");
//           },
//           items: fileNames.map((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }
