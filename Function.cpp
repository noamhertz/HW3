//
// Created by Asafr on 11-Jan-19.
//

#include "Function.h"
#include <iostream>
#include <string>

Function::Function(Type retType, int startLine, pSymbolTable fSymbolTable) : retType(retType),
    startLine(startLine), fSymbolTable(fSymbolTable){}

Function::~Function() = default;

Type Function::getRetType() const {
    return retType;
}

void Function::setRetType(Type retType) {
    this->retType = retType;
}

int Function::getStartLine() const {
    return startLine;
}

void Function::setStartLine(int startLine) {
    this->startLine = startLine;
}

const pSymbolTable Function::getFSymbolTable() const {
    return fSymbolTable;
}
void Function::setFSymbolTable(pSymbolTable fSymbolTable) {
    this->fSymbolTable = fSymbolTable;
}

vector<Type> Function::getParametersTypes() {
    return parametersTypes;
}

void Function::setParametersTypes(vector<Type> parametersTypes) {
    this->parametersTypes = parametersTypes;
}

vector<string> Function::getParametersNames() {
    return parametersNames;
}

void Function::setParametersNames(vector<string> parametersNames) {
    this->parametersNames = parametersNames;
}

list<int> Function::getCallLines() {
    return callLines;
}

void Function::addCallLine(int line) {
    callLines.push_back(line);
}

FuncStatus Function::getFuncStatus() {
    return funcStatus;
}

string Function::getName() {
    return funcName;
}
