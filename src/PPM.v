/*******************************************************************
*
* Module: PPM.v
* Project: Serial_Parallel_Multiplier
* Author: Ahmed Refaay - refaay@aucegypt.edu
* Description: Full Parallel_Parallel_Multiplier circuit with Serial_parallel Multiplier inside
*
* Change history: 02/16/18 – Created module
*                 02/22/18 – Finished module
*
**********************************************************************/

`include "src/global_numerics.v"

module PPM(clk, resetn, MP, MC, start, P, done);
    parameter N = 32;
    
    input wire [0:0] clk; // global clk
    input wire [0:0] resetn; // global reset
    
    input wire [N-1:0] MP; // multiplier parallel input
    input wire [N-1:0] MC; // multiplicand parallel input
    input wire [0:0] start; // indicates that MP and MC are stable to start the multiplication
    output reg [2*N-1:0] P; // product parallel output
    output reg [0:0] done; // indicates that the product (P) is ready
    
    wire [0:0] resetk; // spm reset
    wire [0:0] yin; // y input to spm
    wire [0:0] spmout; // serial product output
    reg [2*N-1:0] Product; // product shift register
    reg [6:0] counter; // progress counter
    
    assign resetk = (start)? 1'b0 : resetn;
    assign yin = (counter[5])?  MP[N-1]: MP[counter[4:0]];
    
    SPM spm1 (.clk(clk), .rst(resetk), .x(MC), .y(yin), .prod(spmout));
    
    always @ (posedge clk or negedge resetn) begin
        if(!resetn) begin
            done <= 1'b0;
            Product <= {2*N{1'b0}};
            P <= {2*N{1'b0}};
            counter <= 7'd0;
        end
        else begin
            if(start) begin
                done <= 1'b0;
                counter <= 7'd0;
                Product <= {2*N{1'b0}};
                P <= P;
            end
            else begin
                if(counter > 2*N) begin
                    done <= 1'b1;
                    counter <= counter;
                    P <= Product;
                    Product <= Product;
                end
                else begin
                    done <= 1'b0;
                    counter <= counter + 6'd1;
                    P <= P;
                    Product <= {spmout, Product[2*N-1:1]};
                end
            end
        end
    end
    
endmodule