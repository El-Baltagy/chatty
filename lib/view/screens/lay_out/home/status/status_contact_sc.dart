import 'package:chatty/shared/utils/app_methods.dart';
import 'package:chatty/view/screens/lay_out/home/status/status_sc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../controller/status_prov.dart';
import '../../../../../models/status_model.dart';
import '../../../../../shared/utils/app_colors.dart';
import '../../../../../shared/widgets/loader.dart';


class StatusContactsScreen extends StatelessWidget {
  const StatusContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Status>>(
      future: Provider.of<StatusProv>(context,listen: false).getStatus(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            var statusData = snapshot.data![index];
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    GoPage().push(context, path: StatusSC(status: statusData,));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      title: Text(
                        statusData.username,
                      ),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          statusData.profilePic,
                        ),
                        radius: 30,
                      ),
                    ),
                  ),
                ),
                const Divider(color: AppColors.dividerColor, indent: 85),
              ],
            );
          },
        );
      },
    );
  }


}
