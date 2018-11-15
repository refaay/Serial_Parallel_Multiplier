// file: PPM_tb.v
// author: @refaay
// Testbench for PPM

`timescale 1ns/1ns

module PPM_tb;

	//Inputs
	reg [0: 0] clk;
	reg [0: 0] resetn;
	reg [31: 0] MP;
	reg [31: 0] MC;
	reg [0: 0] start;


	//Outputs
	wire [63: 0] P;
	wire [0: 0] done;

    
    //For Testbench
    wire [63:0] prodtb;
    wire err;
    reg [6:0] counter; // progress counter
    
    assign prodtb = MP * MC;
    assign err =  (prodtb != P) & done & (!start) ;

	//Instantiation of Unit Under Test
	PPM uut (
		.clk(clk),
		.resetn(resetn),
		.MP(MP),
		.MC(MC),
		.start(start),
		.P(P),
		.done(done)
	);

    always #2 clk = !clk;

    initial begin
	//Inputs initialization
		clk = 0;
		resetn = 0;
		MP = (($random) % 32'd1000);
		MC = (($random) % 32'd1000);
		start = 0;
		counter = 7'd0;
		
		#4;
		resetn = 1'b1;
		
		#4;
		start = 1;
		
		#4;
		start = 0;
		counter = 7'd0;
	end
    /*
    initial begin
        $display( "\t\ttime,\tMC,\tMP,\tP, \tProdtb, \tError" );
        forever begin
            wait(done === 1'd1 && start === 1'd0) 
                $display( "%d,\t%d,\t%d,\t%d,\t%d,\t%b", $time,MC,MP,P, prodtb, err);
        end
    end
    always @(posedge clk) begin
        wait(done === 1'd1 && start === 1'd0) 
                $display( "%d,\t%d,\t%d,\t%d,\t%d,\t%b", $time,MC,MP,P, prodtb, err);
    end
    */
	always @(posedge clk) begin
        if(counter > 65) begin
    		MP <= (($random) % 32'd1000);
    		MC <= (($random) % 32'd1000);
    		start <= 1;
    
    		#4;
    		start <= 0;
    		counter <= 7'd0;
        end
        else
            counter <= counter + 7'd1;
    end

endmodule