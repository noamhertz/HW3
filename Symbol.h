//
// Created by Asafr on 11-Jan-19.
//

#ifndef HW333_SYMBOLS_H
#define HW333_SYMBOLS_H

#include <string>
#include <map>
#include <memory>
#include "Helper.h"

using namespace std;

class Symbol {
private:
    string name;
    Type type;
    int size;
    int offset;

public:
    Symbol (int size); //regular constructor
    ~Symbol();
    Type getType() const;
    void setType(Type type);
    int getSize() const;
    void setSize(int size);
    int getOffset() const;
    void setOffset(int offset);
};

typedef string symbolName;
typedef shared_ptr<Symbol> pSymbol;
typedef map<symbolName, pSymbol> symbolTable;
typedef shared_ptr<map<symbolName, pSymbol>> pSymbolTable;

extern symbolName scopeSymbolTable; //used for storing the scope symbols for a block/function

//TODO: do we need functions for copying/merging symbolTables?

#endif //HW333_SYMBOLS_H
