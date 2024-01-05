import 'base'


// ============= EvidenceDef & ToolLog commonality =============


// ------------- EvidenceDef -------------
// The following are defined in EvidenceDef, but x-referenced in ToolLog

/**
 * EvidenceTypeEnumLiteral is mainly a feature of evidencedef.langium, but is x-referenced by toollog.langium
 */
EvidenceTypeEnumLiteral:
    name=ID many?='many';

DependencyTypeEnum: // Need validator to ensure only one DependencyTypeEnum definition
    'enum' 'DependencyType' '{'
        literals+=DependencyTypeEnumLiteral (',' literals+=DependencyTypeEnumLiteral)*
    '}';

DependencyTypeEnumLiteral:
    name=ID;

Dependency: // Need validation for only one dependency of each type in DependencyTypeEnum
    {infer GeneratedByDependency} dependencyType='createdFrom' usingTool=[ToolDef] 'from' fromArtifact=[ArtifactDef] |
    dependencyType=[DependencyTypeEnumLiteral:QualifiedName] 
        dependentArtifacts+=[ArtifactDef:QualifiedName] (',' dependentArtifacts+=[ArtifactDef:QualifiedName]);

ArtifactDef:
    'artifact' name=ID ArtifactBlock; // Block is not optional in AdvoCATE, and yet no properties appear to be required...

/**
 * **Properties defining an Evidence Artifact**
 * 
 * To allow the ability to parse these definitions in any order, the allowable multiplicity by
 * the parser is [0.*]. Choosing to enforce optionality and singularity of items at the validation
 * stage
 */
fragment ArtifactBlock:
    '{'
        (
            // There seems to be a 'condition' keyword, though I can't figure out the syntax for it. It's not present in the manuals
            Description |
            'purpose' purpose=STRING |
            'type' artifactType=[EvidenceTypeEnumLiteral] |
            'version' version=FLOAT |
            'provenance' provenance=STRING |
            'status' status=('obtained_and_to_be_verified' | 'obtained_and_verified' | 'pending') |
            'location' location=STRING |
            dependencies+=Dependency 
        )*
    '}';


// ------------- ToolLog -------------
// The following are defined in ToolLog, but x-referenced in EvidenceDef

ToolDef:
    'tool' name=ID ToolBlock;

fragment ToolBlock:
    '{'
        (
            Description |
            'inputs'  '[' inputs+=ToolIO  (',' inputs+=ToolIO)*  ']' |
            'outputs' '[' outputs+=ToolIO (',' outputs+=ToolIO)* ']' |
            'toolset' referencedToolSet=[ToolSetDef:QualifiedName]
        )*
    '}';

ToolIO:
    name=ID ':' evidType=[EvidenceTypeEnumLiteral:QualifiedName];

ToolSetDef:
    'toolset' name=ID ToolSetBlock;

fragment ToolSetBlock:
    '{'
        Description?
    '}';