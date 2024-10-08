#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

#define ASCII_a 97
#define ASCII_z 122
#define ASCII_A 65
#define ASCII_Z 90
#define ASCII_0 48
#define ASCII_9 57
#define ASCII__ 95
#define ASCII_DOT 46

int validateFileName(char* s);
char* getFileName(char *argv[]);
char* manageFileNameInput(char* argv[]);
int getFlagInt(char *flag);
void cFlagHandler(char* filename, char *argv[], int i);
//int test();

int main(int argc, char *argv[]){
    int i, c;
    char* filename;

    if (argc <= 1) {
        printf(1, "touch: file name not defined\n");
        exit();
    }
    filename = manageFileNameInput(argv);
    mknod(filename, 0, 0);
    if (argc == 2) exit();
    switch (getFlagInt(argv[2])) {
        case 1:
            printf(1, "touch: -c flag\n");
            cFlagHandler(filename, argv, 3);
            break;
        case -1:
            printf(1, "touch: Unexpected input\n");
        default:
            exit();
            break;
    }
//    for(i = 2; i < argc; i++){
//        for(c = 0; c < strlen(argv[i]); c++){
//            printf(1, "%c\n", argv[i][c]);
//        }
//    }
//  mknod("file", 0, 0);
    exit();
}

int getFlagInt(char *flag){
    if (strcmp(flag, "-c") == 0) {
        return 1;
    } else {
        return -1;
    }
}

char* manageFileNameInput(char* argv[]){
    char* filename = getFileName(argv);
    if(validateFileName(filename) == 0){
        printf(1, "touch: file name invalid\n");
        exit();
    }
    return filename;
}

char* getFileName(char *argv[]){
    char* filename = malloc(strlen(argv[1])+1);
    strcpy(filename, argv[1]);
    return filename;
}

int validateFileName(char* s){
    int i, match = 1;
    //printf(1, "%s\n", s);
    for(i=0; s[i] != '\0'; i++){
        int d = (unsigned char) s[i];
        int charmatch = ((d >= ASCII_a && d <= ASCII_z) ||
                         (d >= ASCII_A && d <= ASCII_Z) ||
                         (d >= ASCII_0 && d <= ASCII_9) ||
                          d == ASCII__ || d == ASCII_DOT);
        match = match & charmatch;
        //printf(1, "%d => %d\n", d, charmatch);
    }
    //printf(1, "!%d\n", match);
    return match;
}

void cFlagHandler(char* filename, char *argv[], int i){
    printf(1, "%s\n", argv[i]);
    printf(1, "%d\n", strlen(argv[i]));
    printf(1, "%c\n", argv[i][strlen(argv[i])-1]);
    
    int firstChar = (unsigned char) argv[i][0];
    if (firstChar == """) {
        printf(1, "text input");
    }
}
