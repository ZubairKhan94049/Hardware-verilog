
module orGateUsingNAND (
    input X, Y,
    output Z
);
    wire w1 , w2;

    nand NAND_1(w1, X, X);
    nand NAND_2(w2, Y, Y);
    nand NAND_3(Z, w1, w2);
endmodule

module orGateUsingNAND_stim;
    reg X, Y;
    wire Z;

    orGateUsingNAND DUT(X, Y, Z);
    initial begin
        $display("X     Y       Z");

        X = 0; Y = 0;
        #10
        $display("%b     %b       %b", X, Y, Z);

        X = 1; Y = 0;
        #10
        $display("%b     %b       %b", X, Y, Z);

        X = 0; Y = 1;
        #10
        $display("%b     %b       %b", X, Y, Z);

        X = 1; Y = 1;
        #10
        $display("%b     %b       %b", X, Y, Z);
    end
endmodule