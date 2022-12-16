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

![architecture classique du SOC](https://user-images.githubusercontent.com/92653832/208107451-6ca79e30-92b5-499b-a500-357648efbc4e.png)

The detailed wiring diagram of the circuit to be designed is given in the figure below:
![Schéma de cablage du I2C](https://user-images.githubusercontent.com/92653832/208107913-fbcba95e-f21f-4d8f-bfd1-c4d9e4850ce1.png)
# I2C Controler exchange cycle with an external device
Exchanges between the I2C controller and an external device are done via the SDA and SCK signals.
An I2C frame is composed of :
● A START bit (SDA goes to '0' and SCK remains at 1).
● 8 address bits (to select the external device with which the circuit exchanges data).
exchange data with).
● One data direction bit (R / W) ("0" write, '1' read).
● 8 data bits.
● An acknowledgement bit.
● A stop bit (SDA goes to '1' and SCK remains at '1').
The number of bytes that can be exchanged is defined during the configuration of the circuit by the processor. The data are transmitted from the most significant bit (MSB).
![trame i2C](https://user-images.githubusercontent.com/92653832/208107921-ce810d54-f1ca-45c0-ad89-35a68e710961.png)
Each byte must be followed by an acknowledgement bit (ACK).

The figure below represents a two-byte read cycle.
![read cycle](https://user-images.githubusercontent.com/92653832/208108854-13b57cdd-79cd-496b-b717-4148846ce528.png)
# I2C controller state-transition diagram
The objective of the functional specifications is to describe the functions that the system must provide for its environment.The state-transition diagram of the I2C controller towards its environment is given below:
![comportement](https://user-images.githubusercontent.com/92653832/208109475-40ce3920-586d-408e-8b34-cabd45ce3ac4.png)

This state-transition diagram describes the behavior of the I2C controller in case of writing and reading without
presenting the creation of the SCK clock signal and its link with the generation of the SDA signal. 

# Simulation 
The following figure shows the sending of an I2C frame composed of three bytes in standard transmission mode in Little Endian format. 

![write I2C](https://user-images.githubusercontent.com/92653832/208110260-98b8e811-7ab1-4c7a-a699-a672e373d843.png)

 The following figure shows the reception of an I2C frame composed of two bytes in fast transmission mode in Big Endian format. 
 
![read I2C](https://user-images.githubusercontent.com/92653832/208110250-8ffae556-7834-466b-bdc8-3720b6a5ae21.png)

#Synthesis
The RTL schematic shows the 3 blocks: ClockGenerator, Emission_Reception and Interface. It also shows the tri-state buffers for the I2C controller signals (DataReceived , DataToSend, SDA) and the Dbus processor bus.

![Capture](https://user-images.githubusercontent.com/92653832/208111235-97470fc1-bc87-4a44-a565-ded0aea33b42.PNG)
