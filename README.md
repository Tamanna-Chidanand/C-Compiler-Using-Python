# Mini C Compiler with AST and Intermediate Code Generation

This project implements a basic **C language compiler** capable of:
- Lexical and syntax analysis
- Generating an **Abstract Syntax Tree (AST)**
- Producing **Intermediate Code Representation (ICR)**
- Reporting whether the input code has valid syntax

It is built using traditional compiler construction tools like **Lex (Flex)** and **Yacc (Bison)**.

---

## Features

- Lexical analysis using Flex (tokenization)
- Syntax analysis using Bison (grammar validation)
- Abstract Syntax Tree generation and printing
- Intermediate code generation (3AC or Quadruples)
- Syntax error handling and reporting
- AST visualization support using Graphviz

---

## Tools & Technologies

- **Flex (Lex)** – for lexical analysis
- **Bison (Yacc)** – for parser generation
- **C Language** – for core compiler logic
- **Graphviz** – for visualizing the AST

---


## How to Build and Run

### 1. Install dependencies

Ensure you have `flex`, `bison`, and `gcc` installed. On Linux:

```bash
sudo apt install flex bison gcc graphviz
```

### 2. Compile the compiler

```bash
make
```

### 3. Run on a C source file

```bash
./compiler test_inputs/sample1.c
```

### 4. Visualize AST (optional)

If AST is dumped to a `.dot` file:

```bash
dot -Tpng output/ast.dot -o output/ast.png
```

---



---

## 📌 License

This project is open-source and available under the MIT License.

