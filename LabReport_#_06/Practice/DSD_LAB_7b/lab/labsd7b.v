
`timescale 1ns / 1ps

module counter(
	input clk, rst,
	output [2:0]en, 
	output [6:0] counter7seg
    );
	
    reg [3:0] U,T,H;


	clk_divider Div_Clock(clk, clk1, rst);
	seven_seg seg_7(U,T,H, en, clk1, rst, counter7seg);
	
	always @ (posedge clk1)
	if(rst)
	begin
            U = 0;
            T = 0;
            H = 0;
   end
	else 
	begin
		U = U + 1'b1;
		if(U == 10)
		begin
			U = 0;
			T = T + 1'b1;
			if(T == 10)
			begin
				T = 0;
				H = H + 1'b1;
				if(H==10)
					H = 0;
			end
		end
  end

endmodule



module seven_seg(U,T,H, en, clk1, rst, out);
input [3:0]U,T,H;
output reg [2:0]en;
input clk1,rst;
output [6:0]out;
reg[3:0]in;
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

  always @(posedge clk1) 
  begin
      if(rst)
		begin
          in = U;
		end
      else begin
          if(en == 3'b110) begin
              en = 3'b101;
              in = T;
          end 
          else begin
              if(en == 3'b101)begin
                  en = 3'b 011;
                  in = H;
              end
          end
      end
  end
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





