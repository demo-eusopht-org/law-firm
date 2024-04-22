import 'package:case_management/services/file_service.dart';
import 'package:case_management/services/locator.dart';
import 'package:case_management/view/admin/bloc/admin_bloc.dart';
import 'package:case_management/view/admin/bloc/admin_events.dart';
import 'package:case_management/view/admin/bloc/admin_states.dart';
import 'package:case_management/view/admin/templates/upload_template_page.dart';
import 'package:case_management/widgets/button_widget.dart';
import 'package:case_management/widgets/loader.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:case_management/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../model/templates/all_templates_response.dart';
import '../../../utils/constants.dart';
import '../../../widgets/appbar_widget.dart';

class TemplatesPage extends StatefulWidget {
  const TemplatesPage({super.key});

  @override
  State<TemplatesPage> createState() => _TemplatesPageState();
}

class _TemplatesPageState extends State<TemplatesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => BlocProvider.of<AdminBloc>(context).add(
        GetTemplatesAdminEvent(),
      ),
    );
  }

  void _listener(BuildContext context, AdminState state) {
    if (state is SuccessTemplateAdminState) {
      BlocProvider.of<AdminBloc>(context).add(
        GetTemplatesAdminEvent(),
      );
    }
  }

  Future<void> _onDownloadTapped(Template template) async {
    try {
      final url = Constants.getTemplateUrl(template.fileName);
      final filePath = await locator<FileService>().download(
        url: url,
        filename: template.fileName,
      );
      if (filePath == null) {
        throw Exception('File could not be downloaded!');
      }
      CustomToast.show('File downloaded to $filePath');
    } catch (e) {
      CustomToast.show(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<AdminBloc>(context),
      listener: _listener,
      child: Scaffold(
        appBar: AppBarWidget(
          context: context,
          showBackArrow: true,
          title: 'Templates',
        ),
        floatingActionButton: RoundedElevatedButton(
          onPressed: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const UploadTemplatePage(),
            ),
          ),
          text: 'Upload template',
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<AdminBloc, AdminState>(
      bloc: BlocProvider.of<AdminBloc>(context),
      builder: (context, state) {
        if (state is LoadingAdminState) {
          return const Loader();
        } else if (state is GotTemplatesAdminState) {
          return _buildTemplates(state.templates);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildTemplates(List<Template> templates) {
    if (templates.isEmpty) {
      return const Center(
        child: Text('No templates found!'),
      );
    }
    return ListView.builder(
      itemCount: templates.length,
      itemBuilder: (context, index) {
        final template = templates[index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: Slidable(
            actionPane: const SlidableStrechActionPane(),
            actionExtentRatio: 0.25,
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Edit',
                color: Colors.green,
                icon: Icons.edit,
                onTap: () {},
              ),
              IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () {},
              ),
            ],
            child: ListTile(
              leading: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.green,
                child: textWidget(
                  text: '${index + 1}',
                  color: Colors.white,
                ),
              ),
              title: textWidget(text: template.title),
              subtitle: textWidget(text: template.fileName),
              trailing: InkWell(
                onTap: () => _onDownloadTapped(template),
                child: const Icon(
                  Icons.download,
                  color: Colors.green,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
