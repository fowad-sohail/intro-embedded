
#include <msp430.h>


/**
 * main.c
 * MSP430f5529
 */
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
            /**P1OUT |= 0x01; // ON LED

            int i = 50000000; // Delay
            do (i--);
            while (i != 0);

            P1OUT &= ~0x1; // OFF LED**/

            volatile unsigned int i;
                for(i = 0; i<=6000; i++)
                {
                    if((i % 2000) == 0)
                    {
                        P1OUT ^= 0x50;      // Toggle P1.6 using exclusive-OR
                    }
                }
        }
        else
        {
//            P1OUT &= ~(BIT0);
        }
    }
}
