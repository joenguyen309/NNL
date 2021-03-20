module Multiple_Block (
    Red_Out,Green_Out,Blue_Out,Flag_Reg,Flag_Green,Flag_Blue,Red_In,Green_In,Blue_In,ENABLE_IN,ENABLE_OUT,CLK
);
    parameter RED_Factor = 32'h3e991687;
    parameter GREEN_Factor = 32'h3f1645a2;
    parameter BLUE_Factor = 32'h3de978d5;

    input   wire [31:0] Red_In,Green_In,Blue_In;
    input   wire CLK,ENABLE_IN,ENABLE_OUT;
    output  wire [31:0] Red_Out,Green_Out,Blue_Out;
    output wire Flag_Reg,Flag_Green,Flag_Blue;

    wire [31:0] Red_to_Reg,Green_to_Reg,Blue_to_Reg;

    

    FPM RED_Mul(
        .clk(CLK),
        .start(ENABLE_IN),
        .a(Red_In),
        .b(RED_Factor),
        .bias(8'd127),
        .out(Red_to_Reg),
        .result(Flag_Red),
        .overflow()
    );

    FPM GREEN_Mul(
        .clk(CLK),
        .start(ENABLE_IN),
        .a(Green_In),
        .b(GREEN_Factor),
        .bias(8'd127),
        .out(Green_to_Reg),
        .result(Flag_Green),
        .overflow()
    );
    
    FPM BLUE_Mul(
        .clk(CLK),
        .start(1'b1),
        .a(Blue_In),
        .b(BLUE_Factor),
        .bias(8'd127),
        .out(Blue_to_Reg),
        .result(Flag_Blue),
        .overflow()
    );


     Reg_Pipeline Reg_Red(
        .Data_out(Red_Out),
        .Data_in(Red_to_Reg),
        .Enable(ENABLE_OUT),
        .CLK(CLK)
    );

    Reg_Pipeline Reg_Green(
        .Data_out(Green_Out),
        .Data_in(Green_to_Reg),
        .Enable(ENABLE_OUT),
        .CLK(CLK)
    );

    Reg_Pipeline Reg_Red(
        .Data_out(Blue_Out),
        .Data_in(Blue_to_Reg),
        .Enable(ENABLE_OUT),
        .CLK(CLK)
    );
    
endmodule