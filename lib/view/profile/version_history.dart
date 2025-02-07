import 'package:case_management/model/version/app_version_model.dart';
import 'package:case_management/utils/date_time_utils.dart';
import 'package:case_management/view/profile/profile_bloc/profile_bloc.dart';
import 'package:case_management/view/profile/profile_bloc/profile_events.dart';
import 'package:case_management/view/profile/profile_bloc/profile_states.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/file_service.dart';
import '../../services/locator.dart';
import '../../utils/constants.dart';
import '../../widgets/toast.dart';
import 'add_version.dart';

class ViewVersionHistory extends StatefulWidget {
  const ViewVersionHistory({super.key});

  @override
  State<ViewVersionHistory> createState() => _ViewVersionHistoryState();
}

class _ViewVersionHistoryState extends State<ViewVersionHistory> {
  bool _downloading = false;
  // GetRoleModel? roleModel;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileBloc>(context).add(GetAllVersionsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
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
                builder: (context) => const AddVersion(),
              ),
            );
            BlocProvider.of<ProfileBloc>(context).add(
              GetAllVersionsEvent(),
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
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      bloc: BlocProvider.of<ProfileBloc>(context),
      builder: (context, state) {
        if (state is LoadingProfileState) {
          return const Center(
            child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation(
                Colors.green,
              ),
            ),
          );
        } else if (state is VersionSuccessProfileState) {
          return _buildLawyersList(state);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildLawyersList(VersionSuccessProfileState state) {
    final clientData = state.data.where((data) => data.status == true).toList();
    final otherClientData =
        state.data.where((data) => data.status != true).toList();

    return ListView(
      children: [
        ...clientData.map((data) {
          return _buildLawyerCard(data);
        }).toList(),
        ...otherClientData.map((data) {
          return _buildLawyerCard(data);
        }).toList(),
      ],
    );
  }

  Widget _buildLawyerCard(Versions versions) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        elevation: 5,
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  textWidget(
                    text: 'Version No:',
                    fSize: 14.0,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  textWidget(
                    text: versions.versionNumber ?? '',
                    fSize: 14.0,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  textWidget(
                    text: 'Released Notes:',
                    fSize: 14.0,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  textWidget(
                    text: versions.releaseNotes ?? '',
                    fSize: 14.0,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  textWidget(
                    text: 'Released At:',
                    fSize: 14.0,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  textWidget(
                    text: versions.uploadedBy.createdAt.getFormattedDateTime(),
                    fSize: 14.0,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  textWidget(
                    text: 'Status:',
                    fSize: 14.0,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  textWidget(
                    text: versions.status == true ? 'Active' : 'InActive',
                    fSize: 14.0,
                  ),
                ],
              ),
              if (versions.status == true)
                Center(
                  child: _downloading
                      ? const CircularProgressIndicator(
                          color: Colors.green,
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () async {
                            setState(() {
                              _downloading = true;
                            });
                            final url = Constants.getAppVersionUrl(
                                versions.versionNumber ?? '',
                                versions.fileName ?? '');
                            print(url);
                            final savedPath =
                                await locator<FileService>().download(
                              url: url,
                              filename: versions.fileName ?? '',
                            );

                            if (savedPath == null) {
                              CustomToast.show(
                                'Could not download file!',
                              );
                            } else {
                              CustomToast.show(
                                'File downloaded to: $savedPath',
                              );
                              setState(() {
                                _downloading = false;
                              });
                            }
                          },
                          child: textWidget(
                            text: 'Download',
                            color: Colors.white,
                          ),
                        ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
