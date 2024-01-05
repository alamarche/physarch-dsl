grammar PhysArch

import 'base'

entry PhysarchModel:
    VersionStatement (components+=ComponentDef)*;

VersionStatement:
    'physical' 'decomposition' VersionName;

// Need validation check for lack of associated failure modes
ComponentDef:
    'component' NameDescription SafetyRelevance ComponentBlock?;

fragment ComponentBlock:
    '{'
        (ComponentDef | FailureModesDef)* // Will need to add validator to ensure only one FailureModesDef per block
    '}';

// Need validation check for lack of hazard associated with component's failure mode
FailureModesDef:
    'failure' 'modes' '[' failureModes+=FailureMode (',' failureModes+=FailureMode)* ']';

FailureMode:
    NameDescription;




