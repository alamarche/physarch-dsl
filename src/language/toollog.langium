grammar ToolLog

import 'base'

entry ToolLogModel:
    VersionStatement (tools+=ToolDef | toolUses+=ToolUseDef | toolSets+=ToolSetDef)*;

VersionStatement:
    'tools' 'integration' VersionName;

ToolDef:
    'tool' name=ID ToolBlock;

fragment ToolBlock:
    '{'
        (
            Description |
            'inputs'  '[' inputs+=ToolIO  (',' inputs+=ToolIO)*  ']' |
            'outputs' '[' outputs+=ToolIO (',' outputs+=ToolIO)* ']' |
            'toolset' referencedToolSet=[ToolSetDef]
        )*
    '}';

ToolIO:
    name=ID ':' evidType=[EvidenceTypeEnumLiteral:QualifiedName];

ToolSetDef:
    'toolset' name=ID ToolSetBlock;

ToolSetBlock:
    '{'
        Description?
    '}';