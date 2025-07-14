#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "abstract_syntax_tree.h"
#include "quad_generation.h"

expression_node* init_exp_node(char* val, expression_node* left, expression_node* right) {
    expression_node* node = (expression_node*)malloc(sizeof(expression_node));
    if (!node) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }
    node->value = strdup(val);
    node->left = left;
    node->right = right;
    return node;
}

const char* get_operator_for_temp(const char* temp) {
    for (int i = 0; i < quad_count; i++) {
        if (strcmp(quads[i].result, temp) == 0) {
            return quads[i].op;
        }
    }
    return NULL;
}

void display_exp_tree_helper(expression_node* node) {
    if (!node) return;
    
    if (node->value[0] == 't') {
        const char* op = get_operator_for_temp(node->value);
        if (op) {
            printf("%s ", op);
            display_exp_tree_helper(node->left);
            display_exp_tree_helper(node->right);
        }
        return;
    }
    
    printf("%s ", node->value);
}

void display_exp_tree(expression_node* root) {
    if (!root) return;
    
    printf("\nAbstract Syntax Tree:\n");
    
    if (strcmp(root->value, "=") == 0) {
        printf("%s = ", root->left->value);
        display_exp_tree_helper(root->right);
    } else {
        display_exp_tree_helper(root);
    }
    printf("\n");
}