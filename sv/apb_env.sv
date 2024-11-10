class apb_env extends uvm_env;

   apb_agent tx_agent;

    // component macro
   `uvm_component_utils(apb_env)

   // Constructor
   function new(string name, uvm_component parent);
    super.new(name, parent);
   endfunction

    // UVM build_phase() method 
   function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tx_agent = apb_agent::type_id::create("tx_agent", this);
   endfunction
   
endclass : apb_env