import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../model/companies/all_company_response.dart';
import '../../../widgets/appbar_widget.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/loader.dart';
import '../../../widgets/text_widget.dart';
import '../bloc/admin_bloc.dart';
import '../bloc/admin_events.dart';
import '../bloc/admin_states.dart';
import 'create_company_page.dart';

class CompaniesPage extends StatefulWidget {
  const CompaniesPage({super.key});

  @override
  State<CompaniesPage> createState() => _CompaniesPageState();
}

class _CompaniesPageState extends State<CompaniesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => BlocProvider.of<AdminBloc>(context).add(
        GetCompaniesAdminEvent(),
      ),
    );
  }

  void _onEditTapped(Company company) async {
    await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => CreateCompanyPage(
          company: company,
        ),
      ),
    );
    BlocProvider.of<AdminBloc>(context).add(
      GetCompaniesAdminEvent(),
    );
  }

  void _onDeleteTap(Company company) {
    BlocProvider.of<AdminBloc>(context).add(
      DeleteCompanyEvent(companyId: company.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        title: 'Companies',
        showBackArrow: true,
      ),
      floatingActionButton: RoundedElevatedButton(
        text: 'Create Company',
        onPressed: () async {
          await Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const CreateCompanyPage(),
            ),
          );

          BlocProvider.of<AdminBloc>(context).add(
            GetCompaniesAdminEvent(),
          );
        },
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<AdminBloc, AdminState>(
      bloc: BlocProvider.of<AdminBloc>(context),
      builder: (context, state) {
        if (state is LoadingAdminState) {
          return const Loader();
        } else if (state is ErrorAdminState) {
          return Center(
            child: textWidget(text: state.message),
          );
        } else if (state is ReadCompaniesAdminState) {
          return _buildCompanies(state.companies);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildCompanies(List<Company> companies) {
    if (companies.isEmpty) {
      return Center(
        child: textWidget(text: 'No companies created yet!'),
      );
    }
    return ListView.builder(
        itemCount: companies.length,
        itemBuilder: (context, index) {
          final company = companies[index];
          return _buildCompanyCard(company);
        });
  }

  Widget _buildCompanyCard(Company company) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 8.0,
        child: Slidable(
          actionPane: const SlidableStrechActionPane(),
          actionExtentRatio: 0.25,
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Edit',
              color: Colors.green,
              icon: Icons.edit,
              onTap: () => _onEditTapped(company),
            ),
            IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () => _onDeleteTap(company),
            ),
          ],
          child: ListTile(
            title: textWidget(text: company.companyName),
            subtitle: textWidget(
              text:
                  company.companyAdmin?.displayName ?? 'No admin assigned yet!',
            ),
          ),
        ),
      ),
    );
  }
}
