using {ah.onboarding as srv} from '../db/schema';

@requires: [
    'EmployeeAdministrator',
    'EmployeeViewer'    
]
service EmployeesService {
    @odata.draft.enabled
    @restrict: [
        {
            grant: ['READ'],
            to   : 'EmployeeViewer'
        },
        {
            grant: ['*'],
            to   : 'EmployeeAdministrator'
        }
    ]
    entity Employees as projection on srv.Employees;

    @readonly
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