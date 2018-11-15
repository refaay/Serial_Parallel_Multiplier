/*******************************************************************
*
* Module: d_flip_flop.v
* Project: Serial_Parallel_Multiplier
* Author: Ahmed Refaay - refaay@aucegypt.edu
* Description: basic D flip flop sequential circuit
*
* Change history: 02/16/18 – Finished module
*
**********************************************************************/

`include "src/global_numerics.v"

module d_flip_flop(clk, rst, d, q);
    input wire [0:0] clk; // global clk
    input wire [0:0] rst; // global reset
    
    input wire [0:0] d; // D input
    output reg [0:0] q; // Q output

    always @(posedge clk or negedge rst) begin
        if (~rst) begin // asynchronous active low reset
            q <= 1'b0;
        end
        else begin
            q <= d;
        end
    end
endmodule