/*******************************************************************
*
* Module: TCMP.v
* Project: Serial_Parallel_Multiplier
* Author: Ahmed Refaay - refaay@aucegypt.edu
* Description: Two’s Complement circuit
*
* Change history: 02/16/18 – Finished module
*                 02/22/18 – Reviewed module
*
**********************************************************************/

`include "src/global_numerics.v"

module TCMP(clk, rst, a, s);
    input wire [0:0] clk; // global clk
    input wire [0:0] rst; // global reset
    
    input wire [0:0] a; // serial input
    output wire [0:0] s; // serial output
    
    wire [0:0] z; // fd flip flop output
    wire [0:0] dsin; // s flip flop input
    wire [0:0] dfdin; // fd flip flop input
    
    assign dsin = a ^ z;
    assign dfdin = a | z;
    
    d_flip_flop ds (.clk(clk), .rst(rst), .d(dsin), .q(s)); // sum flip flop
    d_flip_flop dfd (.clk(clk), .rst(rst), .d(dfdin), .q(z)); // save carry flip flop

endmodule