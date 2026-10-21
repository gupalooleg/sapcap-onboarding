sap.ui.define([
], function() {
    'use strict';

    return {
        /**
         * Generated event handler.
         *
         * @param oContext the context of the page on which the event was fired. `undefined` for list report page.
         * @param aSelectedContexts the selected contexts of the table rows.
         */
        navigateToCandidates: function(oContext, aSelectedContexts) {
            this.intentBasedNavigation.navigateOutbound("candidates");
        }
    };
});
