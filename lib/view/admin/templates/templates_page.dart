import 'package:case_management/view/admin/bloc/admin_bloc.dart';
import 'package:case_management/view/admin/bloc/admin_states.dart';
import 'package:case_management/view/admin/templates/upload_template_page.dart';
import 'package:case_management/widgets/button_widget.dart';
import 'package:case_management/widgets/loader.dart';
import 'package:case_management/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/appbar_widget.dart';

class TemplatesPage extends StatefulWidget {
  const TemplatesPage({super.key});

  @override
  State<TemplatesPage> createState() => _TemplatesPageState();
}

class _TemplatesPageState extends State<TemplatesPage> {
  void _listener(BuildContext context, AdminState state) {
    if (state is SuccessTemplateAdminState) {
      CustomToast.show("File uploaded!");
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
        }
        return const SizedBox.shrink();
      },
    );
  }
}
