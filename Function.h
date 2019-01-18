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

class Function {
private:
    Type retType; //what is the type of what's returning from the function
    int startLine; //in case the function is called but not yet implemented -> this is where it actually starts
    FuncStatus funcStatus;
    string funcName;
    pSymbolTable fSymbolTable; //the function's symbol table
    vector<Type> parametersTypes; //pretty self explanatory
    vector<string> parametersNames; //pretty self explanatory
    list<int> callLines; //stores the places where the function is being called
public:
    Function(Type retType, int startLine, pSymbolTable fSymbolTable);
    ~Function();

    Type getRetType() const;
    void setRetType(Type retType);
    int getStartLine() const;
    void setStartLine(int startLine);
    const pSymbolTable getFSymbolTable() const;
    void setFSymbolTable(pSymbolTable fSymbolTable);
    vector<Type> getParametersTypes();
    void setParametersTypes(vector<Type> parametersTypes);
    vector<string> getParametersNames();
    void setParametersNames(vector<string> parametersNames);
    list<int> getCallLines() ;
    void addCallLine(int line);
    FuncStatus getFuncStatus();
    string getName();
};

#endif //HW333_FUNCTION_H
