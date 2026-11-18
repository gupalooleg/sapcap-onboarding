sap.ui.define(["sap/m/MessageToast"], function (MessageToast) {
  "use strict";

  async function _updateEmployeeModifiedInfo(oContext) {
    await oContext.requestSideEffects([
      { $PropertyPath: "modifiedBy" },
      { $PropertyPath: "modifiedAt" },
    ]);
  }

  return {
    /**
     * Generated event handler.
     *
     * @param oEvent the event object provided by the event provider.
     */
    onCommentsFeedInputPost: async function (oEvent) {
      const sValue = oEvent.getParameter("value");
      const oListBinding = this.byId("idCommenstList").getBinding("items");
      const oContext = oListBinding.create({ text: sValue.trim() });
      await this.editFlow.updateDocument(oListBinding, oContext.created());
      await _updateEmployeeModifiedInfo(oListBinding.getContext());
    },

    onDeleteFeedListItemAction: async function (oEvent) {
      const oContext = oEvent.getParameter("item").getBindingContext();
      const oListBinding = this.byId("idCommenstList").getBinding("items");
      await this.editFlow.updateDocument(oListBinding, oContext.delete());
      await _updateEmployeeModifiedInfo(oListBinding.getContext());
    },
  };
});
