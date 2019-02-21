module BUFGCE(
    output O,
	input CE,
    input I
    );

    assign O= (I)? I:0;
endmodule