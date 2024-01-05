fragment NameDescription:
    name=ID description=STRING;

fragment Name:
    name=QualifiedName;

/**
 * Description fragment typically found within blocks of AdvoCATE-DSL nodes
 */
fragment Description:
    'description' description=STRING;

/**
 * Pattern commonly used in header of AdvoCATE DSLs
 */
fragment VersionName:
    version=FLOAT name=ID;

hidden terminal WS: /\s+/;
terminal ID: /[_a-zA-Z][\w_]*/;
terminal QualifiedName: ID (. ID)*;
terminal INT returns number: /[0-9]+/;
terminal FLOAT: INT . INT;
terminal STRING: /"(\\.|[^"\\])*"|'(\\.|[^'\\])*'/;

hidden terminal ML_COMMENT: /\/\*[\s\S]*?\*\//;
hidden terminal SL_COMMENT: /\/\/[^\n\r]*/;
