#ifndef QUAD_GENERATION_H
#define QUAD_GENERATION_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int quad_no;
    char* op;
    char* arg1;
    char* arg2;
    char* result;
} Quad;

extern Quad quads[100];
extern int quad_count;
extern int temp_no;
extern int label_no;

void quad_code_gen(char* arg1, char* op, char* arg2, char* result);
char* new_temp();
char* new_label();
void print_quads();

#endif