module Buttons(
    input  CLK,
    input  [3:0] buttons,  
    output [3:0] data,
    output Button1Interrupt,
    output Button2Interrupt,
    output Button3Interrupt,
    output Button4Interrupt
);

    assign Button1Interrupt=data[0];
    assign Button2Interrupt=data[1];
    assign Button3Interrupt=data[2];
    assign Button4Interrupt=data[3];

    ButtonDebouncer button1(
        .clk(CLK),
        .Input(buttons[0]),
        .Output(data[0])
    );
    ButtonDebouncer button2(
        .clk(CLK),
        .Input(buttons[1]),
        .Output(data[1])
    );
    ButtonDebouncer button3(
        .clk(CLK),
        .Input(buttons[2]),
        .Output(data[2])
    );
    ButtonDebouncer button4(
        .clk(CLK),
        .Input(buttons[3]),
        .Output(data[3])
    );

endmodule