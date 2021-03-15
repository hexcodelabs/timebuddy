import 'package:intl/intl.dart';
import 'package:timebuddy/modals/template_info.dart';

var now = new DateTime.now();

List<TemplateInfo> templates = [
  TemplateInfo("Template 1", now, description: "first template", id: 1),
  TemplateInfo("My new template", now,
      description: "this is my new template", id: 2),
  TemplateInfo("Friday TODOS", now,
      description: "this template i use for fridays", id: 3),
  TemplateInfo("Template 2", now,
      description: "this is my second template", id: 4),
  TemplateInfo("Template 3", now,
      description: "this is my new third template", id: 5),
];
