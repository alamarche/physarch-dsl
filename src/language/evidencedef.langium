grammar EvidenceDef

import 'evidencedef-and-toollog-shared'

entry EvidenceModel:
    VersionStatement (evidenceEnum=EvidenceTypeEnum | dependencyTypeEnum=DependencyTypeEnum | artifactDefs+=ArtifactDef);

VersionStatement:
    'evidence' 'log' VersionName;

EvidenceTypeEnum: // Need validator to ensure only one EvidenceTypeEnum definition
    'enum' 'EvidenceType' '{'
        evidenceTypes+=EvidenceTypeEnumLiteral (',' evidenceTypes+=EvidenceTypeEnumLiteral)*
    '}';





