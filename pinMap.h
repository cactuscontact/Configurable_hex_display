#ifndef PINMAP_H
#define PINMAP_H

#define NUM_PINS_P8 46
#define NUM_PINS_P9 46

typedef struct{
    int header_num;
    int pin_num;
} GPIO_Pin;


extern GPIO_Pin GPIO_pinList[];

int getGPIO(int header_num, int pin_num);


#endif
