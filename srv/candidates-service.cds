using {ah.onboarding as srv} from '../db/schema';

@requires: [
    'CandidateAdministrator',
    'CandidateViewer'
]
service CandidatesService {
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
    entity Candidates as projection on srv.Candidates actions {
        action addAsEmployee() returns Candidates;
    };

    @readonly
    entity Employees as projection on srv.Employees;

    @odata.singleton
    @readonly
    @cds.persistence.skip
    entity UIConfiguration {
        createHidden : Boolean;
        updateHidden : Boolean;
        deleteHidden : Boolean;
    }
}
