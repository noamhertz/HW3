//
// Created by Asafr on 11-Jan-19.
//

#include <string>
#include <iostream>
#include "Symbol.h"
#include "Helper.h"

using namespace std;

Symbol::Symbol(int size) : type(INT), size(size), offset(scopeOffset){
    scopeOffset += size; //updating the size of the scope to where it points next
}

Symbol::~Symbol() = default;

Type Symbol::getType() const {
    return type;
}

void Symbol::setType(Type type) {
    this->type = type;
}

int Symbol::getSize() const {
    return size;
}

void Symbol::setSize(int size) {
    this->size = size;
}

int Symbol::getOffset() const {
    return offset;
}

void Symbol::setOffset(int offset) {
    this->offset = offset;
}

//TODO: if needed add copy/merge symboltable, check in the H file as well.
