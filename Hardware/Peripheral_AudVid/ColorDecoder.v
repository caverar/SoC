module ColorDecoder(
    input  wire [3:0]  Input,
    output wire [15:0] Output
    );

    reg [15:0] Data [15:0];

    initial begin

        Data[0]  = 16'h0000;  //BLACK	0000	0
        Data[1]  = 16'hFFFF;  //WHITE	FFFF	1
        Data[2]  = 16'h03EF;  //D_CYAN	03EF	2
        Data[3]  = 16'h07E0;  //GREEN	07E0	3
        Data[4]  = 16'h9E66;  //Y_GREEN	9E66	4
        Data[5]  = 16'h867D;  //SKYBLUE	867D	5
        Data[6]  = 16'h000F;  //NAVY	000F	6
        Data[7]  = 16'hF800;  //RED	    F800	7
        Data[8]  = 16'h8000;  //D_RED	8000	8
        Data[9]  = 16'hFEA0;  //GOLD	FEA0	9
        Data[10] = 16'hFD20;  //ORANGE	FD20	A
        Data[11] = 16'h895C;  //B_VIO	895C	B
        Data[12] = 16'h901A;  //D_VIO	901A	C
        Data[13] = 16'hFFE0;  //YELLOW	FFE0	D
        Data[14] = 16'hAFE5;  //G_YELL	AFE5	E
        Data[15] = 16'h7BEF;  //GRAY	7BEF	F
    end
    assign Output=Data[Input];


endmodule