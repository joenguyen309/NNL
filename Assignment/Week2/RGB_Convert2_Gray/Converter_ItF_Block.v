module Converter_ItF_Block (
    Red_Out,Green_Out,Blue_Out,Red_In,Green_In,Blue_In,CLK,CLEAR, ENABLE_IN,ENABLE_OUT
);
    input   wire [31:0] Red_In,Green_In,Blue_In;
    input   wire CLK,CLEAR,ENABLE;
    output  wire [31:0] Red_Out,Green_Out,Blue_Out;

    wire [31:0] Red_to_Reg,Green_to_Reg,Blue_to_Reg;

    ItF RED (
        .Int_In(Red_In),
        .Float_Out(Red_to_Reg),
        .clk(CLK),
        .clr(CLEAR),
        .Out_Enable(ENABLE_IN)
    );
    ItF GREEN (
        .Int_In(Green_In),
        .Float_Out(Green_Out),
        .clk(CLK),
        .clr(Clear),
        .Out_Enable(ENABLE_IN)
    );
    ItF BLUE (
        .Int_In(Blue_In),
        .Float_Out(Blue_to_Reg),
        .clk(CLK),
        .clr(Clear),
        .Out_Enable(ENABLE_IN)
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