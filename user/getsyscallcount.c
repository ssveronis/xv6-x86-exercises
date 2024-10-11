#include "types.h"
#include "stat.h"
#include "user.h"


int main(int argc, char *argv[]){
    if (argc != 2){
        printf(1, "getsyscallcount: Unexpected input");
        exit();
    }
    getcount(atoi(argv[1]));
    exit();
}