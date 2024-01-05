fragment NameDescription:
    name=ID description=STRING;

/**
 * Description fragment typically found within blocks of AdvoCATE-DSL nodes
 */
fragment Description:
    'description' description=STRING;

/**
 * Common designator for functions and components
 * 
 * safety indicates relevance to safety, system is a non-relevant component for safety
*/
fragment SafetyRelevance:
    safetyRelevance=('system' | 'safety');

/**
 * EvidenceTypeEnumLiteral is mainly a feature of evidencedef.langium, but is x-referenced by toollog.langium
 */
EvidenceTypeEnumLiteral:
    name=ID many?='many';

/**
 * Pattern commonly used in header of AdvoCATE DSLs
 */
fragment VersionName:
    version=FLOAT name=ID;

hidden terminal WS: /\s+/;
terminal ID: /[_a-zA-Z][\w_]*/;
terminal QualifiedName: ID (. ID)+;
terminal FLOAT: INT . INT;
terminal INT returns number: /[0-9]+/;
terminal STRING: /"(\\.|[^"\\])*"|'(\\.|[^'\\])*'/;

hidden terminal ML_COMMENT: /\/\*[\s\S]*?\*\//;
hidden terminal SL_COMMENT: /\/\/[^\n\r]*/;
