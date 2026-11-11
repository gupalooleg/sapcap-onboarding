sap.ui.define([], function () {
  "use strict";

  return {
    adaptNavigationContext: function (oSelectionVariant, oNavigationInfo) {
      if (oNavigationInfo.semanticObject === "employees") {
        this._adaptEmployeesNavigation(oSelectionVariant);
      }
    },

    _adaptEmployeesNavigation: function (oSelectionVariant) {
      const aEmployeeIdSO = oSelectionVariant.getSelectOption("employee_ID");
      const aIsActiveEntitySO = oSelectionVariant.getSelectOption("IsActiveEntity");

      oSelectionVariant.getSelectOptionsPropertyNames().forEach((sPropertyName) => {
        oSelectionVariant.removeSelectOption(sPropertyName);
      });

      if (aEmployeeIdSO?.[0]) {
        const { Sign, Option, Low } = aEmployeeIdSO[0];
        oSelectionVariant.addSelectOption("employee_ID", Sign, Option, Low);
      }

      if (aIsActiveEntitySO?.[0]) {
        const { Sign, Option } = aIsActiveEntitySO[0];
        oSelectionVariant.addSelectOption("IsActiveEntity", Sign, Option, "true");
      }
    },
  };
});
