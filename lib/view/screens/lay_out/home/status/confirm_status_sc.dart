import 'dart:io';
import 'package:chatty/controller/status_prov.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../shared/utils/app_colors.dart';

class ConfirmStatusScreen extends StatelessWidget {
  const ConfirmStatusScreen({
    Key? key,
    required this.file,
  });
  final File file;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 9 / 16,
          child: Image.file(file),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<StatusProv>(context,listen: false).addStatus(file, context);
          Navigator.pop(context);
        }, 
        backgroundColor: AppColors.tabColor,
        child: const Icon(
          Icons.done,
          color: Colors.white,
        ),
      ),
    );
  }

}
