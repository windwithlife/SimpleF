import './route_helper.dart';

import '../pages/common/page.dart';
import '../pages/task/task_add.dart';
import '../pages/task/task_list.dart';
import '../pages/task/task_project_list.dart';
import '../pages/task/task_project_add.dart';
import '../pages/reading/reading_home.dart';

class RouteConfigs extends RouterConfigList {
  @override
  addRoutes(RouterConfigList routeMap) {
    
    routeMap.addRouteConfigItem('/page', (params) => Page());
    routeMap.addRouteConfigItem('/task/addTask', (params) => AddTaskScreen().create());
    routeMap.addRouteConfigItem('/task/taskList', (Map<String, List<String>> params) =>TasksPage(params).create());
    routeMap.addRouteConfigItem('/task/taskProjectList', (Map<String, List<String>> params) =>TaskProjectList().create());
    routeMap.addRouteConfigItem('/task/addTaskProject', (Map<String, List<String>> params) =>TaskProjectAddPage().create());
    routeMap.addRouteConfigItem('/reading/readingHome', (Map<String, List<String>> params) =>ReadingHomePage().create());
      
  }
}


