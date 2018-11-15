/*******************************************************************
*
* Module: half_adder.v
* Project: Serial_Parallel_Multiplier
* Author: Ahmed Refaay - refaay@aucegypt.edu
* Description: basic half adder circuit
*
* Change history: 02/15/18 – Finished module
*
**********************************************************************/

`include "src/global_numerics.v"

module half_adder(a, b, s, carry); 
    input a;
    input b; 
    output s;
    output carry;
    
    assign s = a^b; 
    assign carry = a&b; 
endmodule
