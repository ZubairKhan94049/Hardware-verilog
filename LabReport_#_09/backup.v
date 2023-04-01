`timescale 1ns / 1ps

`timescale 1ns / 1ps

module D_FF (q, d, clock, reset);

	output reg q;
	input d, clock, reset;

	always @(negedge clock or posedge reset)
	begin
		if (reset)
			q = 1'b0;
		else
			q = d;
	end
endmodule


module syncronizer(
    input clk, rst, in,
    output out
);
    wire w1;
    D_FF DF01   (w1, in, clk, rst);
    D_FF DF02   (out, w1, clk, rst);
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
					if(cnt == 100000000)
						begin
							clk1 = ~clk1;
							cnt = 0;
						end
				end
		end
endmodule


module L2P(
    input clk1, rst, in,
    output reg out
);

    syncronizer sync (clk1, rst, in, synin);

    parameter s0 = 0;
    parameter s1 = 1;

    reg  state;
    reg next_state;

    always @(posedge clk1)
	   if(rst)
		  begin
			state = s0;
		  end
		 else
        state = next_state;

  always @(*) begin

      case (state)
      s0:
        begin
            if(synin == 0)
            begin
                out = 0;
                next_state = s0;
            end
            else if(synin== 1)
            begin
                out = 1;
                next_state = s1;
            end
        end
      s1:
      begin
          if(synin== 0)
          begin
              out = 0;
              next_state = s0;
          end
          else if(synin == 1)
          begin
              out = 0;
              next_state = s1;
          end
              
      end

      endcase
  end
endmodule 

//module lock (on, off, reset,clk,onpulse,offpulse, out);


module traffic_controller(reset, clk, VEHICAL_IN, HighWayLight, FarmLight,state7seg,enable);

    input reset, VEHICAL_IN, clk;
    output reg [2:0] HighWayLight, FarmLight;
	 output [6:0] state7seg;
	 output enable;
	 
    reg [1:0] state, next_state;
	 assign enable =0;
    clk_divider clk_Div (clk, clk1, reset);
    L2P l1(clk1, reset, VEHICAL_IN, VEHICAL);
	 seven_seg seg1(state, state7seg);

    parameter RED = 3'b100;
    parameter GREEN = 3'b001;
    parameter YELLOW = 3'b010;

    parameter FR_HG=0;
    parameter FY_HR=1;
    parameter FG_HR=2;
    parameter FR_HY=3;

    always @(posedge clk1)
	   if(reset)
		  begin
			state = FR_HG;
		  end
		 else
            state = next_state;
        
    always @(*) begin
        case(state)
            FR_HG:
                begin
                    if(VEHICAL == 1)
                    begin
                        next_state = FY_HR;
                        FarmLight = YELLOW;
                        HighWayLight = RED;
                    end
                    else
                    begin
                        next_state = FR_HG;
                        HighWayLight = GREEN;
                        FarmLight = RED;
                    end
                end

            FY_HR:
                begin
                    FarmLight = YELLOW;
                    HighWayLight = RED;
                    next_state = FG_HR;
                end
            
            FG_HR:
                begin
                    FarmLight = GREEN;
                    HighWayLight = RED;
                    next_state = FR_HY;
                end

            FR_HY:
                begin
                    FarmLight = RED;
                    HighWayLight = YELLOW;
                    next_state = FR_HG;
                end
        endcase
    end
endmodule



module seven_seg(in, out);
    input [1:0] in;
    output [6:0] out;
	assign out = (in == 0) ? 7'b1000000:
				 (in == 1) ? 7'b1111001:
				 (in == 2) ? 7'b0100100:
				 (in == 3) ? 7'b0110000:  7'b1111111;
endmodule



// module seven_seg(in, out);
//     input [1:0] in;
//     output [6:0] out;
// 	assign out = (in == 0) ? 7'd0:
// 				 (in == 1) ? 7'b1111001:
// 				 (in == 2) ? 7'b0100100:
// 				 (in == 3) ? 7'b0110000:
// 				 (in == 4) ? 7'b0011001:
// 				 (in == 5) ? 7'b0010010:
// 				 (in == 6) ? 7'b0000010:
// 				 (in == 7) ? 7'b1111000:
// 				 (in == 8) ? 7'b0000000:
// 				 (in == 9) ? 7'b0011000: 7'b1111111;
// endmodule



//reset, clk, VEHICAL_IN, HighWayLight, FarmLight,state7seg

// NET "reset" LOC = C17 | PULLUP;
// NET "clk" LOC = V10 | PULLUP;
// NET "VEHICAL_IN" LOC = F17 | PULLUP;

// NET "HighWayLight[0]" LOC = P15;
// NET "HighWayLight[1]" LOC =  P16;
// NET "HighWayLight[2]" LOC =  N15;

// NET "FarmLight[0]" LOC =  N16;
// NET "FarmLight[1]" LOC =  U17;
// NET "FarmLight[2]" LOC =  U18;

// NET "state7seg[0]" LOC = A3;
// NET "state7seg[1]" LOC = B4;
// NET "state7seg[2]" LOC = A4;
// NET "state7seg[3]" LOC = C4;
// NET "state7seg[4]" LOC = C5;
// NET "state7seg[5]" LOC = D6;
// NET "state7seg[6]" LOC = C6;

// NET "enable" LOC = B3;




