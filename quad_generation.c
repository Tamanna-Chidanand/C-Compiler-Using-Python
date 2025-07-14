#include "quad_generation.h"

Quad quads[100];
int quad_count = 0;
int temp_no = 1;
int label_no = 1;

void quad_code_gen(char* arg1, char* op, char* arg2, char* result) {
    quads[quad_count].quad_no = quad_count + 1;
    quads[quad_count].arg1 = strdup(arg1);
    quads[quad_count].op = strdup(op);
    quads[quad_count].arg2 = strdup(arg2);
    quads[quad_count].result = strdup(result);
    quad_count++;
}

char* new_temp() {
    char* temp = malloc(10);
    sprintf(temp, "t%d", temp_no++);
    return temp;
}

char* new_label() {
    char* label = malloc(10);
    sprintf(label, "L%d", label_no++);
    return label;
}

void print_quads() {
    printf("\nIntermediate Code Generation:\n");
    printf("| Quad No | Operand 1 | Operator | Operand 2 | Result |\n");
    printf("|---------|-----------|----------|-----------|--------|\n");
    
    for (int i = 0; i < quad_count; i++) {
        printf("| %-7d | %-9s | %-8s | %-9s | %-6s |\n",
               quads[i].quad_no,
               quads[i].arg1,
               quads[i].op,
               quads[i].arg2,
               quads[i].result);
    }
}