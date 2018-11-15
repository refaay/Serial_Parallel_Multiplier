/*******************************************************************
*
* Module: SPM.v
* Project: Serial_Parallel_Multiplier
* Author: Ahmed Refaay - refaay@aucegypt.edu
* Description: Serial_Parallel_Multiplier circuit
*
* Change history: 02/16/18 – Finished module
*                 02/22/18 – Reviewed module
*
**********************************************************************/

`include "src/global_numerics.v"

module SPM(clk, rst, x, y, prod);
    parameter N = 32;
    
    input wire [0:0] clk; // global clk
    input wire [0:0] rst; // global reset
    
    input wire [N-1:0] x; // multiplicand parallel input
    input wire [0:0] y; // multiplier serial input
    output wire [0:0] prod; // product serial output
    
    wire [N-1:0] xy; // outputs of and gates
    wire [N-1:0] pp; // wires interconnecting all csa's
    
    assign prod = pp[0];
    TCMP tcmp1 (.clk(clk), .rst(rst), .a(xy[N-1]), .s(pp[N-1]));
    
    genvar i;
    generate
        for (i=0; i<N; i=i+1) begin: spmbit
            assign xy[i] = x[i] & y; 
            if(i != N-1)
                CSA csabit (.clk(clk), .rst(rst), .x(xy[i]), .y(pp[i+1]), .s(pp[i]));
        end
    endgenerate

endmodule