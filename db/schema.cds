using {
    cuid,
    managed,
    sap.common.CodeList,
    Country
} from '@sap/cds/common';
using from '@sap/cds-common-content';

namespace ah.onboarding;

entity Candidates : cuid, managed {
    @readonly
    @odata.Type                      : 'Edm.String'
    candidateID    : Integer;

    @mandatory
    name           : String;

    @mandatory
    country        : Country;

    @mandatory
    role           : Association to Roles;

    @mandatory
    status         : Association to CandidateStatuses default #New;

    description    : String;

    @Core.MediaType                  : resumeFileType
    @Core.ContentDisposition.Filename: resumeFileName
    resumeFile     : LargeBinary;

    @Core.IsMediaType
    resumeFileType : String;
    resumeFileName : String;
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
