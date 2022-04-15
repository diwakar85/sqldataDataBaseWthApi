import 'package:apiandsql/screens/fatchData.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
void main(){
  runApp(
  const GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  )
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FatchData();
  }
}
