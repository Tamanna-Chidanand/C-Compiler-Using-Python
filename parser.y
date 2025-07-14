%{
    #include "abstract_syntax_tree.h"
    #include "quad_generation.h"
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    // Function declarations
    extern expression_node* init_exp_node(char* val, expression_node* left, expression_node* right);
    extern void display_exp_tree(expression_node* exp_node);
    extern char* new_temp();
    extern char* new_label();
    extern void quad_code_gen(char* arg1, char* op, char* arg2, char* result);
    extern void print_quads();

    void yyerror(const char* s);
    int yylex();
    extern int yylineno;
    extern FILE* yyin;
%}

%union {
    char* text;
    struct expression_node* exp_node;
}

%token <text> T_ID T_NUM
%token IF ELSE DO WHILE EQ NE GE LE

%type <exp_node> program stmt_list stmt expr cond_stmt assign_stmt do_while_stmt
%type <exp_node> E T F condition

%start program

%%
program : stmt_list { 
            printf("\nAbstract Syntax Tree:\n");
            display_exp_tree($1); 
            print_quads();
            printf("\nValid program\n"); 
            YYACCEPT; 
        }
        ;

stmt_list : stmt_list stmt { $$ = init_exp_node("stmt_list", $1, $2); }
          | stmt           { $$ = $1; }
          ;

stmt : assign_stmt ';'     { $$ = $1; }
     | cond_stmt           { $$ = $1; }
     | do_while_stmt       { $$ = $1; }
     ;

assign_stmt : T_ID '=' expr { 
                $$ = init_exp_node("=", init_exp_node(strdup($1), NULL, NULL), $3); 
                quad_code_gen($3->value, "=", $1, $1);
            }
            ;

expr : E { $$ = $1; }
     ;

E : E '+' T { 
        $$ = init_exp_node("+", $1, $3); 
        char* temp = new_temp();
        quad_code_gen($1->value, "+", $3->value, temp);
        $$->value = temp;
    }
    | E '-' T { 
        $$ = init_exp_node("-", $1, $3); 
        char* temp = new_temp();
        quad_code_gen($1->value, "-", $3->value, temp);
        $$->value = temp;
    }
    | T { $$ = $1; }
    ;

T : T '*' F { 
        $$ = init_exp_node("*", $1, $3); 
        char* temp = new_temp();
        quad_code_gen($1->value, "*", $3->value, temp);
        $$->value = temp;
    }
    | T '/' F { 
        $$ = init_exp_node("/", $1, $3); 
        char* temp = new_temp();
        quad_code_gen($1->value, "/", $3->value, temp);
        $$->value = temp;
    }
    | F { $$ = $1; }
    ;

F : '(' expr ')' { $$ = $2; }
    | T_ID { $$ = init_exp_node(strdup($1), NULL, NULL); }
    | T_NUM { $$ = init_exp_node(strdup($1), NULL, NULL); }
    ;

cond_stmt : IF '(' condition ')' '{' stmt_list '}' ELSE '{' stmt_list '}' {
                $$ = init_exp_node("if-else", $3, init_exp_node("then-else", $6, $10));
                char* label1 = new_label();
                char* label2 = new_label();
                
                quad_code_gen($3->left->value, $3->value, $3->right->value, label1);
                quad_code_gen("0", "goto", "0", label2);
                
                printf("%s:\n", label1);
                printf("%s:\n", label2);
            }
            | IF '(' condition ')' '{' stmt_list '}' {
                $$ = init_exp_node("if", $3, $6);
                char* label = new_label();
                
                quad_code_gen($3->left->value, $3->value, $3->right->value, label);
                printf("%s:\n", label);
            }
            ;

do_while_stmt : DO '{' stmt_list '}' WHILE '(' condition ')' ';' {
                    $$ = init_exp_node("do-while", $3, $7);
                    char* label1 = new_label();
                    char* label2 = new_label();
                    
                    printf("%s:\n", label1);
                    quad_code_gen($7->left->value, $7->value, $7->right->value, label1);
                    quad_code_gen("0", "goto", "0", label2);
                    
                    printf("%s:\n", label2);
                }
                ;

condition : expr EQ expr { $$ = init_exp_node("==", $1, $3); }
          | expr NE expr { $$ = init_exp_node("!=", $1, $3); }
          | expr '>' expr { $$ = init_exp_node(">", $1, $3); }
          | expr '<' expr { $$ = init_exp_node("<", $1, $3); }
          | expr GE expr { $$ = init_exp_node(">=", $1, $3); }
          | expr LE expr { $$ = init_exp_node("<=", $1, $3); }
          ;

%%

void yyerror(const char* s) {
    printf("Error: %s at line %d\n", s, yylineno);
}

int main(int argc, char** argv) {
    if (argc < 2) {
        printf("Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    yyin = fopen(argv[1], "r");
    if (!yyin) {
        printf("Could not open input file %s\n", argv[1]);
        return 1;
    }

    yyparse();
    fclose(yyin);
    return 0;
}