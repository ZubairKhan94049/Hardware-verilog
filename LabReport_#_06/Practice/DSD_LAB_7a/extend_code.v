`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:17:03 05/26/2022 
// Design Name: 
// Module Name:    lab_07 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////


module counter(
	input clk, rst, 
	output [7:0] counter
    );
	
	reg [7:0] counter

	clk_divider Div_Clock(clk, clk1, rst) 
	
	always @ (posedge clk1)
		if(rst)
			counter = 0;
		else
			counter = counter + 1;
			if(counter == 10)
				counter = 0;
endmodule


module clk_divider(clk, clk1, rst);
	integer cnt;
	input clk, rst;
	output reg clk1;
	always @(posedge clk)
		begin
			if(rst)
				begin
					cnt = 0;
					clk1 = 0;
				end
			else
				begin
					cnt = cnt + 1;
					if(counter == 1000000)
						begin
							clk1 = ~clk1;
							cnt = 0;
						end
				end
		end
endmodule


module seven_seg(
	input en,
	input [3:0] in,
	output dp,
	output [6:0] out
)

	assign dp = en;

	assign out = (in == 0) ? 7'd0:
				 (in == 1) ? 7'd1:
				 (in == 2) ? 7'd2:
				 (in == 3) ? 7'd3:
				 (in == 4) ? 7'd4:
				 (in == 5) ? 7'd5:
				 (in == 6) ? 7'd6:
				 (in == 7) ? 7'd7:
				 (in == 8) ? 7'd8:
				 (in == 9) ? 7'd9: 7'd0
endmodule
