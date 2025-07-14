#ifndef ABSTRACT_SYNTAX_TREE_H
#define ABSTRACT_SYNTAX_TREE_H

typedef struct expression_node {
    char* value;
    struct expression_node* left;
    struct expression_node* right;
} expression_node;

expression_node* init_exp_node(char* val, expression_node* left, expression_node* right);
void display_exp_tree(expression_node* exp_node);

#endif