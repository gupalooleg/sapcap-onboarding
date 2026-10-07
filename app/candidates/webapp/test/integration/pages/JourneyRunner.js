sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ah/onboarding/candidates/test/integration/pages/CandidatesList.gen",
	"ah/onboarding/candidates/test/integration/pages/CandidatesObjectPage.gen"
], function (JourneyRunner, CandidatesListGenerated, CandidatesObjectPageGenerated) {
    'use strict';

    const runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ah/onboarding/candidates') + '/test/flp.html#app-preview',
        pages: {
			onTheCandidatesListGenerated: CandidatesListGenerated,
			onTheCandidatesObjectPageGenerated: CandidatesObjectPageGenerated
        },
        async: true
    });

    return runner;
});

