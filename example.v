// DSCH 3.5
// 11-11-2024 16:55:49
// C:\Users\divyo\OneDrive - Indian Institute of Information Technology, Nagpur\Desktop\cmos\layout\example.sch

module example( clk3,clk1,clk2);
 input clk3,clk1,clk2;
 wire w2,w4,w6,w7,w9,w10;
 and #(2) and2_1(w4,w2,clk2);
 and #(2) and2_2(w6,clk3,w2);
 or #(2) or2_3(w7,w4,w6);
 and #(2) and2_4(w9,clk1,w7);
 not #(1) inv_5(w10,w9);
endmodule

// Simulation parameters in Verilog Format
always
#8000 clk3=~clk3;
#2000 clk1=~clk1;
#4000 clk2=~clk2;

// Simulation parameters
// clk3 CLK 40 40
// clk1 CLK 10 10
// clk2 CLK 20 20
