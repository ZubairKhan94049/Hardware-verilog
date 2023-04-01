module counter(
	input clk, rst,
	output [2:0]en, 
	output [6:0] counter7seg
    );
	
    reg [3:0] U,T,H;

	seven_seg seg_7(U,T,H, en, clk, rst, counter7seg);

	clk_divider Div_Clock(clk, clk1, rst);
	
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