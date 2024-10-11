#include "random.h"

void lcg_init(LCG *lcg, int seed){
    lcg->state = seed % lcg->m;
}

int lcg_random(LCG *lcg){
    lcg->state = (lcg->a * lcg->state + lcg->c) % lcg->m;
    return lcg->state;
};