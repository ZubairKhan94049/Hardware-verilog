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
   	output [2:0]en, 
	output [6:0] counter7seg
	);
    reg [3:0] counter;
    assign en = 3'b011;

	seven_seg seg(counter, counter7seg);

	clk_divider Div_Clock(clk, clk1, rst);
	
	always @ (posedge clk1)
	begin
		if(rst)
			counter = 0;
		else
			begin
				counter = counter + 1'b1;
				if(counter == 10)
					counter = 0;
			end
	end
endmodule



module seven_seg(
	input [3:0] in,
	output [6:0] out
);
	assign out = (in == 0) ? 7'd0:
				 (in == 1) ? 7'b1111001:
				 (in == 2) ? 7'b0100100:
				 (in == 3) ? 7'b0110000:
				 (in == 4) ? 7'b0011001:
				 (in == 5) ? 7'b0010010:
				 (in == 6) ? 7'b0000010:
				 (in == 7) ? 7'b1111000:
				 (in == 8) ? 7'b0000000:
				 (in == 9) ? 7'b0011000: 7'b1111111;
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
					if(cnt == 10000000)
						begin
							clk1 = ~clk1;
							cnt = 0;
						end
				end
		end
endmodule

