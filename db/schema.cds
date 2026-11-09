using {
    cuid,
    managed,
    sap.common.CodeList,
    Country
} from '@sap/cds/common';
using from '@sap/cds-common-content';

using {Attachments} from '@cap-js/attachments';

namespace ah.onboarding;

// @assert.unique.employee: [employee]
entity Candidates : cuid, managed {
    @readonly
    @odata.Type                      : 'Edm.String'
    candidateID    : Integer;

    @mandatory
    name           : String;

    @mandatory
    @assert.target
    country        : Country;

    @mandatory
    @assert.target
    role           : Association to Roles;

    @mandatory
    @assert.target
    status         : Association to CandidateStatuses default #New;

    description    : String;

    @Core.MediaType                  : resumeFileType
    @Core.ContentDisposition.Filename: resumeFileName
    resumeFile     : LargeBinary;

    @Core.IsMediaType
    resumeFileType : String;
    resumeFileName : String;
    
    employee: Association to Employees;
}

entity CandidateStatuses : CodeList {
    key code        : String enum {
            Accepted = 'ACCEPTED';
            New = 'NEW';
            Rejected = 'REJECTED';
        };
        criticality : Integer;
}

entity Roles : CodeList {
    key code : String enum {
            Analyst = 'ANALYST';
            Developer = 'DEVELOPER';
            Tester = 'TESTER';
        }
}

entity Employees : cuid, managed {
    @readonly
    @odata.Type  : 'Edm.String'
    employeeID      : Integer;

    @mandatory
    name            : String;

    @mandatory
    country         : Country;

    @mandatory
    @assert.target
    role            : Association to Roles;

    @mandatory
    beginDate       : Date;

    @mandatory
    @assert      : (case
                        when endDate < beginDate
                             then 'END_DATE_INVALID'
                    end)
    endDate         : Date;

    @mandatory
    @assert.range: [
        0,
        100
    ]
    // @assert.range.message: 'ASSERT_RANGE_CUST'
    performanceRate : Integer default 100;

    attachments     : Composition of many Attachments;

    candidate: Association to one Candidates on candidate.employee = $self;
}
