class apb_seq_item #(int ADDR_WIDTH = 32, int DATA_WIDTH = 32) extends uvm_sequence_item;
   rand bit [ADDR_WIDTH-1:0] PADDR;
   rand bit [DATA_WIDTH-1:0] PWDATA;
   bit [DATA_WIDTH-1:0] PRDATA;
   rand bit PWRITE;

   `uvm_object_utils_begin(apb_seq_item)
       `uvm_field_int(PADDR, UVM_ALL_ON)
       `uvm_field_int(PWDATA, UVM_ALL_ON)
       `uvm_field_int(PRDATA, UVM_ALL_ON)
       `uvm_field_int(PWRITE, UVM_ALL_ON)
   `uvm_object_utils_end

   // Constructor
   function new(string name="apb_seq_item");
      super.new(name);
   endfunction : new

   constraint PWDATA_randomize{
      if(!PWRITE)
         PWDATA=='0;
   }
   //constraint delay_limit {packet_delay >=0 ;packet_delay <5;}
   constraint limit_addr {
        PADDR inside {[1:2]};
     }

endclass : apb_seq_item