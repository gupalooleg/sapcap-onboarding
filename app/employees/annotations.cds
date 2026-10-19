using EmployeesService as service from '../../srv/employees-service';
using from '../../db/schema';

annotate service.Employees with {
    
  ID @UI.Hidden;
  employeeID @title: '{i18n>EmployeeId}';
  name @title: '{i18n>Name}';
  country @title: '{i18n>Country}';
  role @title: '{i18n>Role}';
  beginDate @title: '{i18n>BeginDate}';
  endDate @title: '{i18n>EndDate}';
  performanceRate @title: '{i18n>PerformanceRate}';
};

annotate service.Employees with @(
    UI.CreateHidden                : {$edmJson: {$Path: '/EmployeesService.EntityContainer/UIConfiguration/createHidden'}},
    UI.UpdateHidden                : {$edmJson: {$Path: '/EmployeesService.EntityContainer/UIConfiguration/updateHidden'}},
    UI.DeleteHidden                : {$edmJson: {$Path: '/EmployeesService.EntityContainer/UIConfiguration/deleteHidden'}},
        
    UI.SelectionFields : [
        employeeID,
        name,
        country_code,
        role_code,
        beginDate,
        endDate,
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : employeeID,
        },
        {
            $Type : 'UI.DataField',
            Value : name,
        },
        {
            $Type : 'UI.DataField',
            Value : role_code,
        },
        {
            $Type : 'UI.DataField',
            Value : country_code,
        },
        {
            $Type : 'UI.DataField',
            Value : beginDate,
        },
        {
            $Type : 'UI.DataField',
            Value : endDate,
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target : '@UI.Chart#performanceRate',
            Label : '{i18n>PerformanceRate}',
        },
    ],
    UI.HeaderInfo : {
        TypeName : '{i18n>Employee}',
        TypeNamePlural : '{i18n>Employees}',
        Title : {
            $Type : 'UI.DataField',
            Value : name,
        },
        Description : {
            $Type : 'UI.DataField',
            Value : employeeID,
        },
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>GeneralInfo}',
            ID : 'i18nGeneralInfo',
            Target : '@UI.FieldGroup#i18nGeneralInfo',
        },
        // {
        //     $Type : 'UI.ReferenceFacet',
        //     Label : '{i18n>Attachments}',
        //     ID : 'attachments',
        //     Target : 'attachments/@UI.LineItem',
        // },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>SystemInfo}',
            ID : 'i18nSystemInfo',
            Target : '@UI.FieldGroup#i18nSystemInfo',
        },
    ],
    UI.FieldGroup #i18nGeneralInfo : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : name,
            },
            {
                $Type : 'UI.DataField',
                Value : country_code,
            },
            {
                $Type : 'UI.DataField',
                Value : role_code,
            },
            {
                $Type : 'UI.DataField',
                Value : beginDate,
            },
            {
                $Type : 'UI.DataField',
                Value : endDate,
            },
            {
                $Type : 'UI.DataField',
                Value : performanceRate,
            },
        ],
    },
    UI.DataPoint #performanceRate : {
        Value : performanceRate,
        TargetValue : 100,
        CriticalityCalculation : {
            ImprovementDirection : #Maximize,
            DeviationRangeLowValue : 50,
            ToleranceRangeLowValue : 80,
        },
    },
    UI.Chart #performanceRate : {
        ChartType : #Donut,
        Measures : [
            performanceRate,
        ],
        MeasureAttributes : [
            {
                DataPoint : '@UI.DataPoint#performanceRate',
                Role : #Axis1,
                Measure : performanceRate,
            },
        ],
    },
    UI.Identification : [
        {
            $Type : 'UI.DataField',
            Value : employeeID,
        },
        {
            $Type : 'UI.DataField',
            Value : name,
        },
    ],
    UI.FieldGroup #i18nSystemInfo : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : createdBy,
            },
            {
                $Type : 'UI.DataField',
                Value : createdAt,
            },
            {
                $Type : 'UI.DataField',
                Value : modifiedBy,
            },
            {
                $Type : 'UI.DataField',
                Value : modifiedAt,
            },
        ],
    }
);

annotate service.Employees with {
    role @(
        Common.Text : role.name,
        Common.Text.@UI.TextArrangement : #TextOnly,
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.Employees with {
    country @(
        Common.Text : country.name,
        Common.Text.@UI.TextArrangement : #TextOnly,
    )
};

annotate service.Roles with {
    code @(
        Common.Text : name,
        Common.Text.@UI.TextArrangement : #TextOnly,
)};

