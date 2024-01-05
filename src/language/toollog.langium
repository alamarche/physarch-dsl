grammar ToolLog

import 'evidencedef-and-toollog-shared'

entry ToolLogModel:
    ToolLogVersionStatement (tools+=ToolDef | toolUses+=ToolUseDef | toolSets+=ToolSetDef)*;

ToolLogVersionStatement:
    'tools' 'integration' VersionName;

ToolUseDef:
    'tool' 'use' name=ID ToolUseBlock;

fragment ToolUseBlock:
    '{'
        (
            'tool' tool=[ToolDef:QualifiedName] |
            'inputs' '[' inputs+=[ArtifactDef]  (',' inputs+=[ArtifactDef])* ']'|
            'outputs' '[' outputs+=[ArtifactDef]  (',' outputs+=[ArtifactDef])* ']'
        )
    '}';
