#include <iostream>
#include <fstream>
#include <sstream>
#include <map>
#include "Helper.h"
#include "Parser.y"
#include "Quads.h"
#include "Function.h"
#include "Symbol.h"

extern "C" FILE *yyin;
extern "C" int yylex();
map<string,Function*> funcTable;

using namespace std;

Quad quadBuf;
//TODO: add all the globals needed, probably: current scope offset, current scope register counter

int main(int argc, char* argv[]) {
    if (argc != 2) {
        cerr << "Operational error: invalid number of arguments" << endl;
        exit(OPERATIONAL_ERROR);
    }

    string fileName = argv[1];
    size_t dotIndex = fileName.size() - 4;
    if (fileName.substr(dotIndex) != ".cmm") {
        cerr << "Operational error: file type not supported" <<endl;
        exit(OPERATIONAL_ERROR);
    }

    //all was good, preparing file for output

    string outputName = fileName.substr(0,dotIndex) + ".rsk"; //changing the output file to be a RISKY file
    //Creating a new file and redirecting the standard output to it for the parsing process
    ofstream out(outputName);
    streambuf *coutBuf = cout.rdbuf(); //saving the buffer's state for later
    cout.rdbuf(out.rdbuf()); //redirecting...

    yyin = fopen(argv[1], "r");
    yyparse();

    quadBuf.printQuadsBufferAndHeaders(funcTable); //printing all the buffer out
    cout.rdbuf(coutBuf); //return of the king
    fclose(yyin);

    return 0;
}
