#!/bin/bash

# Clean previous builds
rm -f lex.yy.c y.tab.c y.tab.h compiler *.output

# Generate parser and lexer
yacc -d parser.y
lex lex.l

# Compile
gcc -o compiler y.tab.c lex.yy.c abstract_syntax_tree.c quad_generation.c

# Run
if [ -f "./compiler" ]; then
    ./compiler test_input_1.c
else
    echo "Compilation failed - check errors above"
fi