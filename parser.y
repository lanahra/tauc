%{
#include <stdio.h>
int yylex();
void yyerror(char const *s);
%}

%token INT
%token FLOAT
%token BOOL
%token CHAR
%token STRING
%token IF
%token THEN
%token ELSE
%token WHILE
%token DO
%token INPUT
%token OUTPUT
%token RETURN
%token CONST
%token STATIC
%token FOREACH
%token FOR
%token SWITCH
%token CASE
%token BREAK
%token CONTINUE
%token CLASS
%token PRIVATE
%token PUBLIC
%token PROTECTED
%token LE_OP
%token GE_OP
%token EQ_OP
%token NE_OP
%token AND_OP
%token OR_OP
%token SL_OP
%token SR_OP
%token FORWARD_PIPE
%token BASH_PIPE
%token INT_LITERAL
%token FLOAT_LITERAL
%token FALSE
%token TRUE
%token CHAR_LITERAL
%token STRING_LITERAL
%token ID
%token ERROR

%start unit
%%

unit
    : element
    | unit element
    ;

element
    : element_definition
    | class_definition ';'
    ;

element_definition
    : ID global_var_declaration ';'
    | ID ID element_specifier
    | function_definition
    ;

global_var_declaration
    : global_var_type_specifier
    | array global_var_type_specifier
    | array global_var_class_specifier
    ;

global_var_type_specifier
    : type_specifier
    | STATIC type_specifier
    ;

global_var_class_specifier
    : ID
    | STATIC ID
    ;

array
    : '[' INT_LITERAL ']'
    ;

type_specifier
    : INT
    | FLOAT
    | BOOL
    | CHAR
    | STRING
    ;

element_specifier
    : ';'
    | parameters function_body
    ;

class_definition
    : CLASS ID '[' field_list ']'
    ;

field_list
    : field
    | field_list ':' field
    ;

field
    : type_specifier ID
    | access_modifier type_specifier ID
    ;

access_modifier
    : PRIVATE
    | PUBLIC
    | PROTECTED
    ;

function_definition
    : function_header function_body
    ;

function_header
    : type_specifier ID parameters
    | STATIC type_specifier ID parameters
    ;

parameters
    : '(' ')'
    | '(' parameter_list ')'
    ;

parameter_list
    : parameter
    | parameter_list ',' parameter
    ;

parameter
    : parameter_type_specifier ID
    | CONST parameter_type_specifier ID
    ;

parameter_type_specifier
    : ID
    | type_specifier
    ;

function_body
    : '{' '}'
    ;

%%

void yyerror(char const *s) {
   fprintf(stderr, "%s\n", s);
}
