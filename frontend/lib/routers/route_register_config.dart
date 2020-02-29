import './route_helper.dart';
import '../pages/details_page.dart';
import '../pages/secondPage.dart';
import '../pages/common/page.dart';
import '../pages/task/add_task.dart';
class RouteConfigs extends RouterConfigList {
  @override
  addRoutes(RouterConfigList routeMap) {
    routeMap.addRouteConfigItem('/detail', (params) => DetailsPage(params));
    routeMap.addRouteConfigItem('/secondPage', (params) => SecondPage());
    routeMap.addRouteConfigItem('/page', (params) => Page());
    routeMap.addRouteConfigItem('/addTask', (params) => AddTaskScreen().create());
    
  }
}


