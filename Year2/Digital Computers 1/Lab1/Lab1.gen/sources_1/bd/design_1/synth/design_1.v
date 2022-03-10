//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
//Date        : Wed Mar 17 09:57:10 2021
//Host        : DESKTOP-UQS0J8L running 64-bit major release  (build 9200)
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=4,numReposBlks=4,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   (A,
    B,
    C,
    D);
  input [0:0]A;
  input [0:0]B;
  input [0:0]C;
  output [0:0]D;

  wire [0:0]And1_Res;
  wire [0:0]And2_Res;
  wire [0:0]Op1_0_1;
  wire [0:0]Op2_0_1;
  wire [0:0]Op2_0_2;
  wire [0:0]Or1_Res;
  wire [0:0]util_vector_logic_0_Res;

  assign D[0] = util_vector_logic_0_Res;
  assign Op1_0_1 = A[0];
  assign Op2_0_1 = B[0];
  assign Op2_0_2 = C[0];
  design_1_util_vector_logic_1_0 And1
       (.Op1(Op1_0_1),
        .Op2(Op2_0_1),
        .Res(And1_Res));
  design_1_util_vector_logic_0_2 And2
       (.Op1(And1_Res),
        .Op2(Or1_Res),
        .Res(And2_Res));
  design_1_util_vector_logic_0_0 Or1
       (.Op1(Op1_0_1),
        .Op2(Op2_0_2),
        .Res(Or1_Res));
  design_1_util_vector_logic_0_4 util_vector_logic_0
       (.Op1(And2_Res),
        .Res(util_vector_logic_0_Res));
endmodule
