# APB-protocol

 About the APB protocol:
 The APB protocol is a low-cost interface, optimized for minimal power consumption and reduced interface complexity. The APB interface is not pipelined and is a simple, 
 synchronous protocol. Every transfer takes at least two cycles to complete.
 The APB interface is designed for accessing the programmable control registers of peripheral devices. APB peripherals are typically connected to the main memory system using 
 an APB bridge. For example, a bridge from AXI to APB could be used to connect a number of APB peripherals to an AXI memory system.
 APB transfers are initiated by an APB bridge. APB bridges can also be referred to as a Requester. A peripheral interface responds to requests. APB peripherals can also be 
 referred to as a Completer. This specification will use Requester and Completer.
 
 AMBA APB signals:
 PCLK -  Clock. PCLK is a clock signal. All APB signals are timed against the rising edge of PCLK. 
 PRESETn -  Reset. PRESETn is the reset signal and is active-LOW. PRESETn is normally connected directly to the system bus reset signal.
 PADDR -  Address. PADDR is the APB address bus. PADDR can be up to 32 bits wide.
 PSELx - Select. The Requester generates a PSELx signal for each Completer. PSELx indicates that the Completer is selected and that a data transfer is required.
 PENABLE - Enable. PENABLE indicates the second and subsequent cycles of an APB transfer.
 PWRITE -  Direction. PWRITE indicates an APB write access when HIGH and an APB read access when LOW.
 PWDATA - Write data. The PWDATA write data bus is driven by the APB bridge Requester during write cycles when PWRITE is HIGH. PWDATA can be 8 bits, 16 bits, or 32 bits wide.
 PREADY -  Ready. PREADY is used to extend an APB transfer by the Completer.
 PRDATA -  Read data. The PRDATA read data bus is driven by the selected Completer during read cycles when PWRITE is LOW. PRDATA can be 8 bits, 16 bits, or 32 bits wide.

 Write transfers:
 All signals shown in this section are sampled at the rising edge of PCLK.
 <img width="242" alt="image" src="https://github.com/user-attachments/assets/b848b08d-a592-44b9-81c8-b0d45aaf02b6">

 Read transfers:
 <img width="235" alt="image" src="https://github.com/user-attachments/assets/5bba9456-8296-465e-98af-d7d78a7e5f3a">

 Operating states:
 <img width="248" alt="image" src="https://github.com/user-attachments/assets/c332b2f8-d82e-400f-acb8-7b7a21b756cd">
 
 Simulation results of APB agent:
 <img width="935" alt="APB_lab (1)" src="https://github.com/user-attachments/assets/43eb97fa-b1f4-4f59-bb59-b9ee01db12ad">







