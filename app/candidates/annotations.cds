using OnboardingService as service from '../../srv/service';
using from '../../db/schema';


annotate service.Candidates with {
    ID             @UI.Hidden;
    candidateID    @title: '{i18n>CandidateID}';
    name           @title: '{i18n>Name}';
    country        @title: '{i18n>Country}';
    description    @title: '{i18n>Description}';
    role           @(
        title                          : '{i18n>Role}',
        Common.ValueListWithFixedValues: true,
        Common.Text                    : role.name,
        Common.Text.@UI.TextArrangement: #TextOnly,
    );
    status         @(
        title                          : '{i18n>Status}',
        Common.ValueListWithFixedValues: true,
        Common.Text                    : status.name,
        Common.Text.@UI.TextArrangement: #TextOnly,
    );
    resumeFile     @(
        title                    : '{i18n>Resume}',
        Core.AcceptableMediaTypes: [
            'application/pdf',
            'application/msword',
            'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
        ]
    );
    resumeFileName @title: '{i18n>ResumeFileName}';
    resumeFileType @title: '{i18n>ResumeFileType}';

};

annotate service.Candidates with @(
    UI.CreateHidden                : {$edmJson: {$Path: '/OnboardingService.EntityContainer/UIConfiguration/createHidden'}},
    UI.UpdateHidden                : {$edmJson: {$Path: '/OnboardingService.EntityContainer/UIConfiguration/updateHidden'}},
    UI.DeleteHidden                : {$edmJson: {$Path: '/OnboardingService.EntityContainer/UIConfiguration/deleteHidden'}},
    Capabilities.FilterRestrictions: {NonFilterableProperties: [resumeFile]},
    Capabilities.SortRestrictions  : {NonSortableProperties: [resumeFile]},
    Capabilities.GroupRestrictions : {NonGroupableProperties: [resumeFile]},
    UI.SelectionFields             : [
        candidateID,
        name,
        country_code,
        role_code,
        status_code,
    ],
    UI.LineItem                    : [
        {
            $Type             : 'UI.DataField',
            Value             : candidateID,
            @HTML5.CssDefaults: {
                $Type: 'HTML5.CssDefaultsType',
                width: '10rem',
            },
        },
        {
            $Type: 'UI.DataField',
            Value: name,
        },
        {
            $Type             : 'UI.DataField',
            Value             : country_code,
            @HTML5.CssDefaults: {
                $Type: 'HTML5.CssDefaultsType',
                width: '10rem',
            },
        },
        {
            $Type             : 'UI.DataField',
            Value             : role_code,
            @HTML5.CssDefaults: {
                $Type: 'HTML5.CssDefaultsType',
                width: '10rem',
            },
        },
        {
            $Type             : 'UI.DataField',
            Value             : status_code,
            @HTML5.CssDefaults: {
                $Type: 'HTML5.CssDefaultsType',
                width: '10rem',
            },
            Criticality       : status.criticality,
        },
        {
            $Type             : 'UI.DataField',
            Value             : resumeFile,
            @HTML5.CssDefaults: {
                $Type: 'HTML5.CssDefaultsType',
                width: '20rem',
            },
        },
    ],
    UI.Facets                      : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>GeneralInfo}',
            ID    : 'i18nGeneralInfo',
            Target: '@UI.FieldGroup#i18nGeneralInfo',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>SystemInfo}',
            ID    : 'i18nSystemInfo',
            Target: '@UI.FieldGroup#i18nSystemInfo',
        },
    ],
    UI.FieldGroup #i18nGeneralInfo : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: name,
            },
            {
                $Type: 'UI.DataField',
                Value: country_code,
            },
            {
                $Type: 'UI.DataField',
                Value: role_code,
            },
            {
                $Type: 'UI.DataField',
                Value: resumeFile,
                Label: '{i18n>Resume}',
            },
            {
                $Type      : 'UI.DataField',
                Value      : status_code,
                Criticality: status.criticality,
            },
        ],
    },
    UI.HeaderInfo                  : {
        Title         : {
            $Type: 'UI.DataField',
            Value: name,
        },
        TypeName      : '{i18n>Candidate}',
        TypeNamePlural: '{i18n>Candidates}',
        Description   : {
            $Type: 'UI.DataField',
            Value: candidateID,
        },
    },
    UI.FieldGroup #i18nSystemInfo  : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: createdBy,
            },
            {
                $Type: 'UI.DataField',
                Value: createdAt,
            },
            {
                $Type: 'UI.DataField',
                Value: modifiedBy,
            },
            {
                $Type: 'UI.DataField',
                Value: modifiedAt,
            },
        ],
    },
);

annotate service.Roles with {
    code @(
        Common.Text                    : name,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

annotate service.CandidateStatuses with {
    code @(
        Common.Text                    : name,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

annotate service.Candidates with {
    country @(
        Common.Text                    : country.name,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};
