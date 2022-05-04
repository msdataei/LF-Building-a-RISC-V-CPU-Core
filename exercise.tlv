\m4_TLV_version 1d: tl-x.org
\SV

   // =================================================
   // Welcome!  New to Makerchip? Try the "Learn" menu.
   // =================================================

   // Default Makerchip TL-Verilog Code Template
   
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
   //m4_include_lib(['https://raw.githubusercontent.com/stevehoover/LF-Building-a-RISC-V-CPU-Core/main/lib/calc_viz.tlv']).
   /* verilator lint_on WIDTH */
\TLV
   $reset = *reset;
   
   /*
   //Full Adder
   $xor = $in1 ^ $in2;
   $out = $carry_in ^ $xor;
   $carry_out = ($xor & $carry_in) | ($in1 & $in2);
   */
   /*
   //Vector Operations
   $out_add[7:0] = $in1[6:0] + $in2[6:0];
   $out_mul[11:0] = $in1[6:0] * $in2[6:0];
   */
   /*
   // Combinational calculator circuit
   $val1_zero[25:0] = 0;
   $val2_zero[27:0] = 0;
   $val1[31:0] = {$val1_zero , $val1_rand[5:0]};
   $val2[31:0] = {$val2_zero , $val2_rand[3:0]};
   $sum[31:0] = $val1[31:0] + $val2[31:0];
   $diff[31:0] = $val1[31:0] - $val2[31:0];
   // Or just this with no range for val1 and val2
   // $diff[31:0] = $val1 - $val2;
   $prod[31:0] = $val1[31:0] * $val2[31:0];
   $quot[31:0] = $val1[31:0] / $val2[31:0];
   $out[31:0] = $op[1:0] == 2'b00 ? $sum[31:0] :
                $op[1:0] == 1 ? $diff[31:0] :
                $op[1:0] == 2 ? $prod[31:0] :
                                $quot[31:0]; // $op[1:0] == 3
   */
   //
   //$cnt[15:0] = $reset ? 16'b0 : >>1$cnt + 1;
   
   //
   // Combinational calculator circuit
   $val1[31:0] = >>1$out[31:0];
   $sum[31:0] = $val1[31:0] + $val2[31:0];
   $diff[31:0] = $val1[31:0] - $val2[31:0];
   $prod[31:0] = $val1[31:0] * $val2[31:0];
   $quot[31:0] = $val1[31:0] / $val2[31:0];
   $out[31:0] = $reset ? 32'b0 :
                $op[1:0] == 2'b00 ? $sum[31:0] :
                $op[1:0] == 1 ? $diff[31:0] :
                $op[1:0] == 2 ? $prod[31:0] :
                                $quot[31:0];
   
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
   //m4+calc_viz()
\SV
   endmodule
