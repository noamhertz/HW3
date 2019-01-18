//
// Created by Asafr on 11-Jan-19.
//

#ifndef HW333_QUADS_H
#define HW333_QUADS_H

#include <vector>
#include <string>
#include <list>
#include <map>
#include "Function.h"

using namespace std;

class Quad {
private:
    vector<string> quadruples;

public:
    Quad();

    ~Quad();
    void backpatch(vector<int> TFNlist, int lineNo); //backpatch function
    void emit(const string& cmd); //emit function
    void printQuadsBufferAndHeaders(map<string, Function*>& functions);
    int nextQuad();
};

#endif //HW333_QUADS_H
