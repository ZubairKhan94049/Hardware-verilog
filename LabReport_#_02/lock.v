
module fsm_lock_mealys (seq_in, rst, clk,lock_sys,alarm);
	
	input seq_in, rst, clk;
	output lock_sys,alarm;
	reg lock_sys,alarm;
	
	parameter s0 = 0, s1= 1, s2 = 2,s3=3;
	reg [1:0] state, next_state;

	always @(posedge clk)
		if (rst)
			state <= s0;
		else
			state <= next_state;
			
	always @(state or seq_in)
		case (state)
			s0: 
			begin
                lock_sys=seq_in? 0:0;
                alarm=seq_in? 1:0;
                next_state = seq_in?s0:s1;
			end
			
			s1: 
			begin
                lock_sys=seq_in? 0:0;
                alarm=seq_in? 0:1;
                next_state = seq_in?s2:s0;
			end
			
			s2: 
			begin
                lock_sys=seq_in? 0:1;
                alarm= seq_in? 1:0;
                next_state = seq_in?s0:s3;
			end
			
			s3: 
			begin
                lock_sys=seq_in? 0:0;
                alarm=seq_in? 0:0;
                next_state = seq_in? s0:s0;
			end
			
		endcase

endmodule

module lock_sys_tb;

	reg seq_in,rst,clk;
	wire lock_sys,alarm;
	
	fsm_lock_mealys lock_sys01  (seq_in, rst, clk,lock_sys,alarm);
	
	initial	
    begin
        clk = 0;
        seq_in = 0;
        #10 seq_in  = 1;	
        #20 seq_in  = 0;	
        #20 seq_in  = 0; 
        #20 seq_in  = 1;
        #20 seq_in  = 0;
        #20 seq_in  = 0;
	end
	
	initial	begin		
		rst = 1;
		#10 rst = 0;	
		#40 rst=1;
		#10 rst=0	;	
	end			
	
	always 
		#10 clk = ~clk;	
		
	initial
	$monitor($time, "  ->  seq_in=%b,  lock_sys=%b , alarm=%b , Reset=%b", seq_in,lock_sys, alarm, rst);
		
endmodule