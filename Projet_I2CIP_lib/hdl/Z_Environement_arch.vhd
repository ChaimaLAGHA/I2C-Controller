--
-- VHDL Architecture Projet_I2CIP_lib.Z_Environement.arch
--
-- Created:
--          by - CHAIMA.LAGHA (LAPTOP-I71U7FVH)
--          at - 22:14:14 18/11/2022
--
-- using Mentor Graphics HDL Designer(TM) 2018.2 (Build 19)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
LIBRARY Projet_I2CIP_lib;
USE Projet_I2CIP_lib.I2C_Package.ALL;

ENTITY Z_Environement IS
   PORT( 
      Addr  : OUT    DefAddr;
      Clk   : OUT    DefBit;
      RnW   : OUT    DefBit;
      nAS   : OUT    DefBit;
      nBE0  : OUT    DefBit;
      nBE1  : OUT    DefBit;
      nRst  : OUT    DefBit;
      nWait : OUT    DefBit;
      Dbus  : INOUT  DefDbus;
      SDA   : INOUT  DefBit
   );

-- Declarations

END Z_Environement ;

--
ARCHITECTURE arch OF Z_Environement IS
 SIGNAL ClkInt, RstInt : std_logic; 
 SIGNAL SDA_LOCAL : std_logic ;
BEGIN
-- Affectations permanentes

Clk <= ClkInt;
nRst <= RstInt;

-- Definition des processus

ResetGenerator : process
    begin
      RstInt <= '0';
      wait for 100 ns;
      RstInt <= '1';
      wait;
end process ResetGenerator;
  
  
ClockGenerator : process
    begin
      ClkInt <= '0';
      wait for 15 ns;
      ClkInt <= '1';
      wait for 15 ns;
end process ClockGenerator;

CPUonlyBehavior : process 
     variable DbusValue : DefDbus;
     begin  
  -- Reset I2C controller
        Addr <= (others=>'0');
        Dbus <= (others=>'Z');
        nWait <='0';
        nAS <= '1';
        RnW <= '0'; 
        SDA_LOCAL <= SDA;
      wait for 100 ns ;
  -- Preparing the I2C controller for data transfer
        nWait <='1';
        nAS <= '0';
        -- En permanence en little Endianne 
        nBE0<='0';
        nBE1 <='0';
        SDA_LOCAL <= SDA;
      wait until rising_edge(Clkint);
  -- Configuration of a 3 bytes send data in standard mode without interruption
        DbusValue:="0000001000000011"; --0203
        RnW <= '0';
        Addr <= I2C_Config ;--01
        Dbus <= DbusValue(DataBusSize-1 downto 0);
        SDA_LOCAL <= SDA;
      wait for 9000 ns  ;
  -- Sending Address where the I2C controller will send data 
        DbusValue:="1101100100000000"; --D9
        RnW <= '0';
        Addr <= I2C_Addr ; --00
        Dbus <=DbusValue(DataBusSize-1 downto 0);
        SDA_LOCAL <= SDA;
        wait for 80900 ns;
  -- Sending data once we have received the acknowledgement bit 
        DbusValue:="0101110100000000"; --5D
        Addr <= I2C_DataToSend; --02
        Dbus <=DbusValue(DataBusSize-1 downto 0);
        SDA_LOCAL <= SDA;
        wait for 183300 ns;
        DbusValue:="0011110100000000"; --3D
        Addr <= I2C_DataToSend; --02
        Dbus <=DbusValue(DataBusSize-1 downto 0);
        SDA_LOCAL <= SDA;
        wait for 183300 ns;
        DbusValue:="0001111010000000"; --1E
        Addr <= I2C_DataToSend; --02
        Dbus <=DbusValue(DataBusSize-1 downto 0);
        SDA<= '1'; 
        wait ;
        
  

end process CPUonlyBehavior;
END ARCHITECTURE arch;

