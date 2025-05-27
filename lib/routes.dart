import 'package:complimentsjar/pages/about_page.dart';
import 'package:complimentsjar/pages/dashboard_page.dart';
import 'package:complimentsjar/pages/home_page.dart';
import 'package:complimentsjar/pages/login_page.dart';
import 'package:complimentsjar/pages/projects/create_project_page.dart';
import 'package:complimentsjar/pages/projects/project_page.dart';
import 'package:complimentsjar/pages/signup_page.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) =>  HomePage(),
  '/about': (context) => AboutPage(),
  '/login': (context) => LoginPage(),
  '/signup': (context) => SignupPage(),
  '/dashboard':(context)=>DashboardPage(),
  '/projects':(context)=>ProjectPage(),
  '/create-project':(context)=>CreateProjectPage(),
  // Add more routes as needed
};