import '../consts/app_texts.dart';

enum FormComponent {
  dashboardInit,
  dashboardTextBox,
  dashboardCandidateList,
  dashboardMap,
  dashboardDestinationList,
}

String getFormTitle(FormComponent component) {
  switch (component) {
    case FormComponent.dashboardInit:
      return "init";
    case FormComponent.dashboardTextBox:
      return DESTINATION;
    case FormComponent.dashboardCandidateList:
      return CANDIDATE_LIST;
    case FormComponent.dashboardMap:
      return SELECTED;
    case FormComponent.dashboardDestinationList:
      return DESTINATION_LIST;
    default:
      assert(false, "undefined component: $component");
      return "";
  }
}
