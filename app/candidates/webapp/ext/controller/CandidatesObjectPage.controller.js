sap.ui.define(
  ["sap/ui/core/mvc/ControllerExtension", "ah/onboarding/candidates/ext/utils/NavigationHelper"],
  function (ControllerExtension, NavigationHelper) {
    "use strict";

    return ControllerExtension.extend(
      "ah.onboarding.candidates.ext.controller.CandidatesObjectPage",
      {
        // this section allows to extend lifecycle hooks or hooks provided by Fiori elements
        override: {
          /**
           * Called when a controller is instantiated and its View controls (if available) are already created.
           * Can be used to modify the View before it is displayed, to bind event handlers and do other one-time initialization.
           * @memberOf ah.onboarding.candidates.ext.controller.CandidatesObjectPage
           */
          onInit: function () {
            // you can access the Fiori elements extensionAPI via this.base.getExtensionAPI
            // var oModel = this.base.getExtensionAPI().getModel();
          },

          intentBasedNavigation: {
            adaptNavigationContext: function (oSelectionVariant, oNavigationInfo) {
              NavigationHelper.adaptNavigationContext(oSelectionVariant, oNavigationInfo);
            },
          },
        },
      },
    );
  },
);
