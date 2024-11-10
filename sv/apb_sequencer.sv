class apb_sequencer extends uvm_sequencer #(apb_seq_item);

    // component macro
    `uvm_component_utils(apb_sequencer)

    // Constructor
    function new(string name, uvm_component phase);
        super.new(name, phase);
    endfunction : new

endclass : apb_sequencer