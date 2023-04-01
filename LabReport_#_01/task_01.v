module notGate(
    input a,
    output b
);
    not myNotGate(b, a);
endmodule

module buffer (
    input X,
    output Y
);
    //buf myBuffer(Y, X);
    // This can be achive by two not gat in series 
    wire mywire;
    notGate first(mywire, X);
    notGate second(Y, mywire);
endmodule

module buffer_stim;
    reg x;
    wire y;

    buffer DUT(x, y);
    initial begin
        $display("X        Y");
        x = 0;
        #1 $display("%b      %b", x, y);
        x = 1;
        #1 $display("%b      %b", x, y);
    end

endmodule