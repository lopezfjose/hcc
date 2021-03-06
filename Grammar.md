
# C Language Grammar

This is the grammar listed in the C Programming Language book (2nd Edition) by Brian Kernighan and Dennis Ritchie. I've also made some customizations, such as adding native `bool` type recognition.

> Note: an asterisk on an item indicates it is optional.

```
translation-unit:
    external-declaration
    translation-unit external-declaration

external-declaration:
    function-definition
    declaration

function-definition:
    declaration-specifiers* declarator declaration-list* compound-statement

declaration:
    declaration-specifiers init-declarator-list*

declaration-list:
    declaration
    declaration-list declaration

declaration-specifiers:
    storage-class-specifier declaration-specifiers*
    type-specifier declaration-specifiers*
    type-qualifier declaration-specifiers*

storage-class-specifier: one of
    auto register static extern typedef

type-specifier: one of
    void char short int long float double bool signed unsigned struct-or-union-specifier enum-specifier typedef-name

type-qualifier: one of
    const volatile

struct-or-union-specifier:
    struct-or-union identifier* { struct-declaration-list }
    struct-or-union identifier

struct-or-union: one of
    struct union

struct-declaration-list:
    struct-declaration
    struct-declaration-list struct-declaration

init-declarator-list:
    init-declarator
    init-declarator-list , init-declarator

init-declarator:
    declarator
    declarator = initializer

struct-declaration:
    specifier-qualifier-list struct-declarator-list ;

specifier-qualifier-list:
    struct-declarator
    struct-declarator-list , struct-declarator

struct-declarator:
    declarator
    declarator* : constant-expression

enum-specifier:
    enum identifier* { enumerator-list }
    enum identifier

enumerator-list:
    enumerator
    enumerator-list , enumerator

enumerator:
    identifier
    identifier = constant-expression

declarator:
    pointer* direct-declarator

direct-declarator:
    identifier
    ( declarator )
    direct-declarator [ constant-expression* ]
    direct-declarator ( parameter-type-list )
    direct-declarator ( identifier-list* )

pointer:
    * type-qualifier-list*
    * type-qualifier-list* pointer

type-qualifier-list:
    type-qualifier
    type-qualifier-list type-qualifier

parameter-type-list:
    parameter-list
    parameter-list , ...

parameter-list:
    parameter-declaration
    parameter-list , parameter-declaration

parameter-declaration:
    declaration-specifiers declarator
    declaration-specifiers abstract-declarator*

identifier-list:
    identifier
    identifier-list , identifier

initializer:
    assignment-expression
    { initializer-list }
    { initializer-list , }

initializer-list:
    initializer
    initializer-list , initializer

type-name:
    specifier-qualifier-list abstract-declarator*

abstract-declarator:
    pointer
    pointer* direct-abstract-declarator

direct-abstract-declarator:
    ( abstract-declarator )
    direct-abstract-declarator* [ constant-expression* ]
    direct-abstract-declarator* ( parameter-type-list* )

typedef-name:
    identifier

statement:
    labeled-statement
    expression-statement
    compound-statement
    selection-statement
    iteration-statement
    jump-statement

labeled-statement:
    identifier : statement
    case constant-expression : statement
    default: : statement

expression-statement:
    expression* ;

compound-statement:
    { declaration-list* statement-list* }

statement-list:
    statement
    statement-list statement

selection-statement:
    if ( expression ) statement
    if ( expression ) statement else statement
    switch ( expression ) statement

iteration-statement:
    while ( expression ) statement
    do statement while ( expression ) ;
    for ( expression* ; expression* ; expression* ) statement

jump-statement:
    goto identifier ;
    continue ;
    break ;
    return expression* ;

expression:
    assignment-expression
    expression, assignment-expression

assignment-expression:
    conditional-expression
    unary-expression assignment-operator assignment-expression

assignment-operator: one of
    = *= /= %= += -= <<= >>= &= ^= |=

conditional-expression:
    logical-OR-expression
    logical-OR-expression ? expression : conditional-expression

constant-expression:
    conditional-expression

logical-OR-expression:
    logical-AND-expression
    logical-OR-expression || logical-AND-expression

logical-AND-expression:
    inclusive-OR-expression
    logical-AND-expression && inclusive-OR-expression

inclusive-OR-expression:
    exclusive-OR-expression
    inclusive-OR-expression | exclusive-OR-expression

exclusive-OR-expression:
    AND-expression
    exclusive-OR-expression ^ AND-expression

AND-expression:
    equality-expression
    AND-expression & equality-expression

equality-expression:
    relational-expression
    equality-expression == relational-expression
    equality-expression != relational-expression

relational-expression:
    shift-expression
    relational-expression < shift-expression
    relational-expression > shift-expression
    relational-expression <= shift-expression
    relational-expression >= shift-expression

shift-expression:
    additive-expression
    shift-expression << additive-expression
    shift-expression >> additive-expression

additive-expression:
    multiplicative-expression
    additive-expression + multiplicative-expression
    additive-expression - multiplicative-expression

multiplicative-expression:
    cast-expression
    multiplicative-expression * cast-expression
    multiplicative-expression / cast-expression
    multiplicative-expression % cast-expression

cast-expression:
    unary-expression
    ( type-name ) cast-expression

unary-expression:
    postfix-expression
    ++ unary-expression
    -- unary-expression
    unary-operator cast-expression
    sizeof unary-expression
    sizeof ( type-name )

unary-operator: one of
    & * + - ~ !

postfix-expression:
    primary-expression
    postfix-expression [ expression ]
    postfix-expression ( argument-expression-list* )
    postfix-expression . identifier
    postfix-expression -> identifier
    postfix-expression ++
    postfix-expression --

primary-expression:
    identifier
    constant
    string
    ( expression )

argument-expression-list:
    assignment-expression
    argument-expression-list, assignment-expression

constant:
    integer-constant
    character-constant
    floating-constant
    enumeration-constant

```
