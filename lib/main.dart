import 'package:complimentsjar/pages/home_page.dart';
import 'package:flutter/material.dart';
main(){
  runApp(App());
}
class App extends StatelessWidget{
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Compliment Jar",
      theme: ThemeData(scaffoldBackgroundColor: Colors.grey.shade100),
      home: HomePage(),
    ) ;
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> 78b52a0a59815ff3ac582bbf224dbd500ff838c3
