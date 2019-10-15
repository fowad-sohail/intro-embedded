
#include <msp430.h>


// Author: Fowad Sohail
// Class: Introduction to Embedded Systems
// Section: 3
// Date: 8 October 2019
// Microcontroller: MSP430F5529

// Program Description: This program is designed to turn on LED1 (P1.0) when S2 (P1.1) is pressed. This is done by using an
//                      infinitely looping while loop to constantly check if S2 is pressed. If it is pressed, LED1 will light up.
//                      If it is not pressed, LED1 will be turned off.
int main(void)
{
    int j;
    WDTCTL = WDTPW | WDTHOLD;   // stop watchdog timer

    P1SEL = 0;
    P2SEL = 0;
    P1DIR |= 0x50; //Set port 1.6 as output (LED)
    P2DIR &= ~BIT1; //Set port 2.1 as input (Button)

    P2REN |= BIT1; //enable pull up resistor
    P2OUT |= BIT1;
    P1OUT &= ~(BIT0);

    while(1)
    {
        j = P2IN & BIT1;
        if(j != 2)
        {
            volatile unsigned int i;
                for(i = 0; i<=6000; i++)
                {
                    if((i % 2000) == 0)
                    {
                        P1OUT ^= 0x50;      // Toggle P1.6 and P1.4 using exclusive-OR
                    }
                }
        }
        else
        {
        }
    }
}
