import 'package:complimentsjar/pages/about_page.dart';
import 'package:complimentsjar/pages/bugs/bug_edit_page.dart';
import 'package:complimentsjar/pages/bugs/debugged_code_page.dart';
import 'package:complimentsjar/pages/dashboard/admin_dashboard.dart';
import 'package:complimentsjar/pages/dashboard/debugger_dashboard.dart';
import 'package:complimentsjar/pages/dashboard/reporter_dashboard.dart';
import 'package:complimentsjar/pages/debugger/bugs/bug_submission_page.dart';
import 'package:complimentsjar/pages/debugger/bugs/debugger_bug_details_page.dart';
import 'package:complimentsjar/pages/debugger/projects/debugger_project_details.dart';
import 'package:complimentsjar/pages/debugger/projects/debugger_project_page.dart';
import 'package:complimentsjar/pages/home_page.dart';
import 'package:complimentsjar/pages/login_page.dart';
import 'package:complimentsjar/pages/bugs/bug_details_page.dart';
import 'package:complimentsjar/pages/bugs/register_bug_page.dart';
import 'package:complimentsjar/pages/logout_page.dart';
import 'package:complimentsjar/pages/projects/create_project_page.dart';
import 'package:complimentsjar/pages/projects/edit_project_page.dart';
import 'package:complimentsjar/pages/projects/project_details_page.dart';
import 'package:complimentsjar/pages/projects/project_page.dart';
import 'package:complimentsjar/pages/signup_page.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => HomePage(),
  '/about': (context) => AboutPage(),
  '/login': (context) => LoginPage(),
  '/signup': (context) => SignupPage(),
  '/reporter-dashboard': (context) => ReporterDashboard(),
  '/admin-dashboard': (context) => AdminDashboard(),
  '/debugger-dashboard': (context) => DebuggerDashboard(),
  '/create-project': (context) => CreateProjectPage(),
  '/project-details': (context) => ProjectDetailsPage(),
  '/bug-details': (context) => BugDetailsPage(),
  '/register-bug': (context) => RegisterBugPage(),
  '/edit-project': (context) => EditProjectPage(),
  '/logout': (context) => LogoutPage(),
  '/edit-bug': (context) => BugEditPage(),
  '/debugger-projects': (context) => DebuggerProjectPage(),
  '/reporter-projects' : (context) => ProjectPage(),
  '/debugger-project-details' : (context) => DebuggerProjectDetails(),
  '/debugger-bug-details' : (context) => DebuggerBugDetailsPage(),
  '/bug-submission-page' : (context) =>  BugSubmissionPage(),
  '/check-debugged-code' : ( context) => DebuggedCodePage(),
  // Add more routes as needed
};
