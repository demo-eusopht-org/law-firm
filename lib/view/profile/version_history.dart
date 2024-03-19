import 'package:case_management/view/profile/add_version.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewVersionHistory extends StatefulWidget {
  const ViewVersionHistory({super.key});

  @override
  State<ViewVersionHistory> createState() => _ViewVersionHistoryState();
}

class _ViewVersionHistoryState extends State<ViewVersionHistory> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: Container(
        width: size.width * 0.4,
        child: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
          backgroundColor: Colors.green,
          onPressed: () async {
            await Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => AddVersion(),
              ),
            );
          },
          child: textWidget(
            text: 'Add Version',
            color: Colors.white,
            fSize: 16.0,
            fWeight: FontWeight.w700,
          ),
        ),
      ),
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Version History',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            VersionCard(
              versionName: '1.0.0',
              releaseNotes:
                  'Initial release Bug fixes and performance improvements.',
              releaseDate: '2024-03-18',
              status: 'Active',
            ),
            VersionCard(
              versionName: '1.1.0',
              releaseNotes: 'Bug fixes and performance improvements.',
              releaseDate: '2024-04-02',
              status: 'InActive',
            ),
            // Add more VersionCards as needed
          ],
        ),
      ),
    );
  }
}

class VersionCard extends StatelessWidget {
  final String versionName;
  final String releaseNotes;
  final String releaseDate;
  final String status;

  const VersionCard({
    required this.versionName,
    required this.releaseNotes,
    required this.releaseDate,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textWidget(
              text: 'Version: $versionName',
              fWeight: FontWeight.w500,
              fSize: 16.0,
            ),
            SizedBox(height: 8.0),
            textWidget(
              text: 'Release Notes: $releaseNotes',
              fWeight: FontWeight.w500,
              fSize: 16.0,
            ),
            SizedBox(height: 8.0),
            textWidget(
              text: 'Release At: $releaseDate',
              fWeight: FontWeight.w500,
              fSize: 16.0,
            ),
            SizedBox(height: 8.0),
            textWidget(
              text: 'Status: $status',
              fWeight: FontWeight.w500,
              fSize: 16.0,
            ),
            SizedBox(height: 8.0),
            if (status == 'Active')
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {},
                  child: textWidget(
                    text: 'Download',
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
