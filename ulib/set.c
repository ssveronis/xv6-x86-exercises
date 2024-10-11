#include "types.h"
#include "set.h"
#include "user.h"

Set* createRoot(){
    Set *set = malloc(sizeof(Set));
    set->size = 0;
    set->root = NULL;
    return set;
}

void createNode(int i, Set *set){
    SetNode *temp = malloc(sizeof(SetNode));
    temp->i = i;
    temp->next = NULL;

    SetNode *curr = set->root;
    if(curr != NULL) {
        while (curr->next != NULL){
            if (curr->i == i){
                free(temp);
                return;
            }
            curr = curr->next;
        }
    }
    if (curr->i != i) attachNode(set, curr, temp);
    else free(temp);
}

void attachNode(Set *set, SetNode *curr, SetNode *temp){
    if(set->size == 0) set->root = temp;
    else curr->next = temp;
    set->size += 1;
}

void deleteSet(Set *set){
    if (set == NULL) return;
    SetNode *temp;
    SetNode *curr = set->root;
    while (curr != NULL){
        temp = curr->next;
        free(curr);
        curr = temp;
    }
    free(set);
}

SetNode* getNodeAtPosition(Set *set, int i){
    if (set == NULL || set->root == NULL) return NULL;

    SetNode *curr = set->root;
    int n;

    for(n = 0; n<i && curr->next != NULL; n++) curr = curr->next;
    return curr;
}