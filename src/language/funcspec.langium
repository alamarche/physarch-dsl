grammar FuncSpec

import 'base'
import 'physarch-and-funcspec-shared'

entry FuncspecModel:
    VersionStatement (functions+=FunctionDef | deviations+=DeviationDef)*;

VersionStatement:
    'function' 'decomposition' VersionName;


// Function Definitions

// Need validation check for lack of associated deviations
FunctionDef:
    'function' NameDescription SafetyRelevance FunctionBlock?;

fragment FunctionBlock:
    '{'
        (DeviationReferences | subFunctions+=FunctionDef)* // Apply validation checks to ensure only one DeviationReferences
    '}';

fragment DeviationReferences:
    'deviations' '[' referencedDeviations+=[DeviationDef] (',' referencedDeviations+=[DeviationDef])* ']';


// Deviation Definitions

// Need validation check for lack of hazard associated with component's failure mode
DeviationDef:
    'deviation' NameDescription DeviationBlock?;

fragment DeviationBlock:
    '{'
        subDeviations+=DeviationDef*
    '}';