/*******************************************************************
*
* Module: CSA.v
* Project: Serial_Parallel_Multiplier
* Author: Ahmed Refaay - refaay@aucegypt.edu
* Description: Carry-Save Adder circuit
*
* Change history: 02/16/18 – Finished module
*                 02/22/18 – Reviewed module
*
**********************************************************************/

`include "src/global_numerics.v"

module CSA(clk, rst, x, y, s);
    input wire [0:0] clk; // global clk
    input wire [0:0] rst; // global reset
    
    input wire [0:0] x; // first operand serial input
    input wire [0:0] y; // second operand serial input
    output wire [0:0] s; // summation serial output
    
    wire [0:0] sc; // save carry flip flop output
    wire [0:0] car1; // half adder carry-out output
    wire [0:0] car2; // between and & xor gates
    wire [0:0] hsum1; // sum output of half adder
    wire [0:0] dsumin; // sum flip flop input
    wire [0:0] dscin; // save carry flip flop input
    
    assign car2 = x & hsum1;
    assign dsumin = x ^ hsum1;
    assign dscin = car1 ^ car2;
    
    d_flip_flop dsum (.clk(clk), .rst(rst), .d(dsumin), .q(s)); // sum flip flop
    d_flip_flop dsc (.clk(clk), .rst(rst), .d(dscin), .q(sc)); // save carry flip flop
    half_adder hd1 (.a(y), .b(sc), .s(hsum1), .carry(car1)); 
    
endmodule