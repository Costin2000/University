//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
//Date        : Thu Apr  8 10:09:17 2021
//Host        : DESKTOP-UQS0J8L running 64-bit major release  (build 9200)
//Command     : generate_target schema.bd
//Design      : schema
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "schema,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=schema,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=6,numReposBlks=6,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=6,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "schema.hwdef" *) 
module schema
   (BCD0_0,
    BCD0_1,
    BCD1_0,
    BCD1_1,
    clk_out_led_0,
    data_0,
    load_0,
    pauza_0,
    reset_0,
    sens_0);
  output [3:0]BCD0_0;
  output [3:0]BCD0_1;
  output [3:0]BCD1_0;
  output [3:0]BCD1_1;
  input clk_out_led_0;
  input [5:0]data_0;
  input load_0;
  input pauza_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RESET_0 RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RESET_0, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input reset_0;
  input sens_0;

  wire PoartaAnd_0_C;
  wire PoartaOr_0_C;
  wire [3:0]bin2bcd_0_BCD0;
  wire [3:0]bin2bcd_0_BCD1;
  wire [3:0]bin2bcd_1_BCD0;
  wire [3:0]bin2bcd_1_BCD1;
  wire clk_out_led_0_1;
  wire [5:0]data_0_1;
  wire load_0_1;
  wire numarator_59_0_carry_out;
  wire [5:0]numarator_59_0_valoare_bin;
  wire [5:0]numarator_59_1_valoare_bin;
  wire pauza_0_1;
  wire reset_0_1;
  wire sens_0_1;

  assign BCD0_0[3:0] = bin2bcd_1_BCD0;
  assign BCD0_1[3:0] = bin2bcd_0_BCD0;
  assign BCD1_0[3:0] = bin2bcd_1_BCD1;
  assign BCD1_1[3:0] = bin2bcd_0_BCD1;
  assign clk_out_led_0_1 = clk_out_led_0;
  assign data_0_1 = data_0[5:0];
  assign load_0_1 = load_0;
  assign pauza_0_1 = pauza_0;
  assign reset_0_1 = reset_0;
  assign sens_0_1 = sens_0;
  schema_PoartaAnd_0_2 PoartaAnd_0
       (.A(PoartaOr_0_C),
        .B(clk_out_led_0_1),
        .C(PoartaAnd_0_C));
  schema_PoartaOr_0_2 PoartaOr_0
       (.A(numarator_59_0_carry_out),
        .B(load_0_1),
        .C(PoartaOr_0_C));
  schema_bin2bcd_0_1 bin2bcd_0
       (.BCD0(bin2bcd_0_BCD0),
        .BCD1(bin2bcd_0_BCD1),
        .valoare_bin(numarator_59_1_valoare_bin));
  schema_bin2bcd_1_1 bin2bcd_1
       (.BCD0(bin2bcd_1_BCD0),
        .BCD1(bin2bcd_1_BCD1),
        .valoare_bin(numarator_59_0_valoare_bin));
  schema_numarator_59_0_2 numarator_59_0
       (.carry_out(numarator_59_0_carry_out),
        .clk_out_led(clk_out_led_0_1),
        .data(data_0_1),
        .load(load_0_1),
        .pauza(pauza_0_1),
        .reset(reset_0_1),
        .sens(sens_0_1),
        .valoare_bin(numarator_59_0_valoare_bin));
  schema_numarator_59_1_1 numarator_59_1
       (.clk_out_led(PoartaAnd_0_C),
        .data(data_0_1),
        .load(load_0_1),
        .pauza(pauza_0_1),
        .reset(reset_0_1),
        .sens(sens_0_1),
        .valoare_bin(numarator_59_1_valoare_bin));
endmodule
