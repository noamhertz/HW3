//
// Created by Asafr on 11-Jan-19.
//

#include <iostream>
#include "Quads.h"

using namespace std;

Quad::Quad() = default;

Quad::~Quad() = default;

                //////////backpatch Function//////////
//////////adding the line needed in the goto for the true/false/next lists//////////
void Quad::backpatch(vector<int> TFNlist, int lineNo) {
    for (int i : TFNlist)
        quadruples[i -1] += to_string(lineNo); //the -1 is because the quadruples start counting from 0
}
                //////////emit Function//////////
//////////pushing the command given to the quadruples vector//////////
void Quad::emit(const string &cmd) {
    quadruples.push_back(cmd);
}

                //////////printing Function//////////
void Quad::printQuadsBufferAndHeaders(map<string, Function*>& functions) {
    //printing all the headers first
    cout << "<header>" << endl;
    // print all unimplemented function calls and their lineNo
    cout << "<unimplemented> ";
    map<string, Function*>::iterator it;
    list<int>::iterator usageIt;
    for(it = functions.begin(); it != functions.end(); it++)
    {
        Function* function = it->second;
        if (function->getFuncStatus() == UNIMPLEMENTED)
        {
            cout << " " << function->getName(); //returns the name of the function
            for(usageIt = function->getCallLines().begin(); usageIt != function->getCallLines().end(); usageIt++)
                cout << "," << to_string(*usageIt); //while we're not at the end of the functions list, put a coma
        }
    }
    cout << endl;
    // print all implemented function calls and their lineNo
    cout << "<implemented> ";
    for(it = functions.begin(); it != functions.end(); it++)
    {
        Function* func = it->second;
        if (func->getFuncStatus() == IMPLEMENTED)
        {
            cout << " " << func->getName();
            cout << "," << to_string(func->getStartLine());
        }
    }
    cout << endl;
    cout << "</header>" << endl;
    for (const auto &quadruple : quadruples)
        cout << quadruple << endl;
}

                //////////nextQuad Function//////////
//////////going to the next quadruple in the quadruples vector and returning it's number//////////
int Quad::nextQuad() {
    return (quadruples.size() + 1);
}