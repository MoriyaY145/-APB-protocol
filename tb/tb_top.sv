/*-----------------------------------------------------------------
File name     : top.sv
Description   : lab01_data top module template file
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/

module tb_top;

  // import the UVM library
  import uvm_pkg::*;

  // include the UVM macros
  `include "uvm_macros.svh"

  // import the apb package
  import apb_pkg::*;

  // include the router testbench file
  `include "apb_tb.sv"
  `include "apb_test_lib.sv"

  initial begin

    uvm_config_db#(virtual apb_if)::set(null,"*.tb.apb.tx_agent.*","vif", hw_top.apb_if);

    run_test();
    //#10000000ns;  // Adjust this as needed
   //$finish;
  end

endmodule : tb_top

