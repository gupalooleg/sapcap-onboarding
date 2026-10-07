using {ah.onboarding as srv} from '../db/schema';

@requires: [
    'CandidateAdministrator',
    'CandidateViewer'
]
service OnboardingService {
    @odata.draft.enabled
    @restrict: [
        {
            grant: ['READ'],
            to   : 'CandidateViewer'
        },
        {
            grant: ['*'],
            to   : 'CandidateAdministrator'
        }
    ]
    entity Candidates as projection on srv.Candidates;

    @odata.singleton
    @readonly
    @cds.persistence.skip
    entity UIConfiguration {
        createHidden : Boolean;
        updateHidden : Boolean;
        deleteHidden : Boolean;
    }
}
