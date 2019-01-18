//
// Created by Asafr on 11-Jan-19.
//

#ifndef HW333_FUNCTION_H
#define HW333_FUNCTION_H

#include "Helper.h"
#include "Symbol.h"
#include <vector>
#include <memory>
#include <map>
#include <list>

typedef enum FuncStatus{UNIMPLEMENTED, IMPLEMENTED} FuncStatus;

class Function {
private:
    IntOrFloat retType; //what is the type of what's returning from the function
    int startLine; //in case the function is called but not yet implemented -> this is where it actually starts
    FuncStatus funcStatus;
    string funcName;
    pSymbolTable fSymbolTable; //the function's symbol table
    vector<IntOrFloat> parametersTypes; //pretty self explanatory
    vector<string> parametersNames; //pretty self explanatory
    list<int> callLines; //stores the places where the function is being called
public:
    Function(IntOrFloat retType, int startLine, pSymbolTable fSymbolTable);
    ~Function();

    IntOrFloat getRetType() const;
    void setRetType(IntOrFloat retType);
    int getStartLine() const;
    void setStartLine(int startLine);
    const pSymbolTable getFSymbolTable() const;
    void setFSymbolTable(pSymbolTable fSymbolTable);
    vector<IntOrFloat> getParametersTypes();
    void setParametersTypes(vector<IntOrFloat> parametersTypes);
    vector<string> getParametersNames();
    void setParametersNames(vector<string> parametersNames);
    list<int> getCallLines() ;
    void addCallLine(int line);
    FuncStatus getFuncStatus();
    string getName();
};

#endif //HW333_FUNCTION_H
