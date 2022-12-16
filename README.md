# I2C-Controller-design-using-the-MCSE-method
This project presents the design of a digital circuit based on the MCSE approach.
The circuit to be designed is an I2C controller whose role is to ensure the coupling of the microprocessor with external modules via an I2C(Inter-Integrated Circuit) communication protocol . 

The MSCE design approach was applied to come up with a solution that can be implemented in a Xilinx Zynq 7000 FPGA.

The simulation phase of the circuit timings allowed to validate the functional behavior of the circuit defined in the specifications.

The synthesis phase showed the logical resources necessary for the realization of the IP, which made it possible to check the coherence of the resources compared to the specification of the system.
# I2C Controller expected functionalities
● The circuit is configured by the microprocessor, the parameters to be configured are:

    ○ The generation of interrupts at transmission or/and reception.
    
    ○ The transmission speed (Standard mode 100 kbit/s, Fast mode 4000 kbit/s).
    
    ○ The communication mode: Read or write.
    
    ○ The number of data to be transmitted.
    
● The circuit ensures the data exchanges in transmission and reception.

● An acknowledgement bit must be sent after each byte to indicate that the byte has been
successfully received and that another byte can be sent (status register).

● The circuit can generate interrupts at the end of a transmission or reception, this
depending on the configuration made by the microprocessor.

The internal organization of the final system-on-chip is as below . This project is dedicated only to the design of the I2C controller.
