//
// Created by Asafr on 11-Jan-19.
//

#ifndef HW333_HELPER_H
#define HW333_HELPER_H

#define LEXICAL_ERROR 1
#define SYNTAX_ERROR 2
#define SEMANTIC_ERROR 3
#define OPERATIONAL_ERROR 9

#include <iostream>
#include <string>
#include <vector>
#include <memory>
#include <map>
#include "Quads.h"
#include "Symbol.h"

using namespace std;

typedef enum {INT, FLOAT} IntOrFloat;

//global variables
extern Quad quadsBuffer;
extern int scopeRegisterCounter[2]; //counters for int/float registers
extern int scopeOffset; //the offset in the stack
extern IntOrFloat returnType; //the return type from a function, to be compared with the desired return type in the parser
extern vector<string> parameterInsertionOrder; //TODO: understand what is this!?!?!?!

//the new yystype for the parser to use
typedef struct {
    IntOrFloat type;
    string content;
    int regNum;
    int offset;

    //for Markers (M)
    int quad; //like in the recitation

    //for Boolean EXP (BEXP)
    vector<int> trueList;
    vector<int> falseList;

    //for statements (STMT)
    vector<int> nextList;

    //for functions (FUNC_ARGLIST) TODO: check what are these for, how to use them?
    vector<int> parameterRegisters;
    vector<IntOrFloat> parameterType;

} yystype;

#define YYSTYPE yystype //for the lexer, so he'll be redirected to the yystype structure when using YYSTYPE

//merge function
vector<int> merge(vector<int>& vectorA, vector<int>& vectorB) { //like in the recitation, to combine lists
    vector<int> mergedVector;
    mergedVector.reserve(vectorA.size() + vectorB.size());
    mergedVector.insert(mergedVector.end(), vectorA.begin(), vectorA.end());
    mergedVector.insert(mergedVector.end(), vectorB.begin(), vectorB.end());
    return mergedVector;
}

#endif //HW333_HELPER_H
