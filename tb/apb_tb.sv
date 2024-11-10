class apb_tb extends uvm_env;

   // component macro
   `uvm_component_utils(apb_tb)

   apb_env apb;

   // Constructor
   function new(string name, uvm_component parent=null);
    super.new(name, parent);
   endfunction

   // UVM build() phase
   function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    apb = apb_env::type_id::create("apb", this);
    `uvm_info("MSG", "The build phase of the testbench is being executed", UVM_HIGH)
   endfunction

   function void start_of_simulation_phase(uvm_phase phase);
     `uvm_info(get_type_name(), $sformatf("Start of simulation for %s", get_full_name()), UVM_HIGH)
   endfunction

endclass