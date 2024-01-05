grammar EvidenceDef

import 'base'

entry EvidenceModel:
    VersionStatement (evidenceEnum=EvidenceTypeEnum | dependencyTypeEnum=DependencyTypeEnum | artifactDefs+=ArtifactDef);

VersionStatement:
    'evidence' 'log' VersionName;

EvidenceTypeEnum: // Need validator to ensure only one EvidenceTypeEnum definition
    'enum' 'EvidenceType' '{'
        evidenceTypes+=EvidenceTypeEnumLiteral (',' evidenceTypes+=EvidenceTypeEnumLiteral)*
    '}';



DependencyTypeEnum: // Need validator to ensure only one DependencyTypeEnum definition
    'enum' 'DependencyType' '{'
        literals+=DependencyTypeEnumLiteral (',' literals+=DependencyTypeEnumLiteral)*
    '}';

DependencyTypeEnumLiteral:
    name=ID;

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
            Description | // 
            'purpose' purpose=STRING |
            'type' artifactType=[EvidenceTypeEnumLiteral] |
            'version' version=FLOAT |
            'provenance' provenance=STRING |
            'status' status=('obtained_and_to_be_verified' | 'obtained_and_verified' | 'pending') |
            'location' location=STRING // |
            // relation+=[DependencyTypeEnumLiteral] // TODO - add the configurable dependency keywords here
        )*
    '}';