
// 64 bit option for AWS labs
-64

 -uvmhome $UVMHOME

 // default timescale
-timescale 1ns/100ps 
//-timescale 1ns/1ns

// include directories
//*** add incdir include directories here

-incdir ../sv // include directory for sv files

// options
+UVM_VERBOSITY=UVM_LOW
+UVM_TESTNAME=simple_test
+SVSEED=random


//-gui 
//-access +rwc

// compile files
//*** add compile files here

../sv/apb_pkg.sv // compile YAPP package
../sv/apb_if.sv

../apb_dut.sv 


clkgen.sv
resetgen.sv 
// top level module
tb_top.sv 
// hw_top.sv
hw_top.sv 





