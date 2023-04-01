
module seven_seg(U,T,H, en, clk, rst, out);
input [3:0]U,T,H;
output reg [2:0]en;
input clk,rst;
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

  always @(posedge clk) 
  begin
      if(rst)
          in = U;
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