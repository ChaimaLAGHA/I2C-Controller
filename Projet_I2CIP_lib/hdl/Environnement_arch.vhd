--
-- VHDL Architecture Projet_I2CIP_lib.Environnement.arch
--
-- Created:
--          by - E21C396C.UNKNOWN (irc107-04)
--          at - 14:05:48 17/11/2022
--
-- using Mentor Graphics HDL Designer(TM) 2022.1 Built on 21 Jan 2022 at 13:00:30
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
LIBRARY Projet_I2CIP_lib;
USE Projet_I2CIP_lib.I2C_Package.ALL;

ENTITY Environnement IS
   PORT( 
      Addr  : OUT    DefAddr;
      Clk   : OUT    DefBit;
      Dbus  : OUT    DefDbus;
      RnW   : OUT    DefBit;
      nAS   : OUT    DefBit;
      nBE0  : OUT    DefBit;
      nBE1  : OUT    DefBit;
      nRst  : OUT    DefBit;
      nWait : OUT    DefBit
   );

-- Declarations

END Environnement ;

--
ARCHITECTURE arch OF Environnement IS
  
 SIGNAL ClkInt, RstInt : std_logic; 
  
BEGIN
-- Affectations permanentes
Clk <= ClkInt;
nRst <= RstInt;
-- En permanence en little Endianne 
nBE0<='0';
nBE1 <='0';

-- Definition des processus
ResetGenerator : process
    begin
      RstInt <= '0';
      wait for 20ns;
      RstInt <= '1';
      wait;
end process ResetGenerator;
  
ClockGenerator : process
    begin
      ClkInt <= '0';
      wait for 10 ns;
      ClkInt <= '1';
      wait for 10 ns;
end process ClockGenerator;

CPUonlyBehavior : process (RstInt,ClkInt)
    variable DbusValue : DefDbus;
    type DefState is (idle, WritingConfig_Write,WritingConfig_Write1, EndWritingConfig_Write);-- Writing2, EndWriting2, Reading1, EndReading1, Reading2, EndReading2);
    variable State : DefState;
    begin
    if RstInt = '0' then
      Addr <= (others=>'0');
      Dbus <= (others=>'Z');
      RnW <= '0';
      State := Idle;
    elsif rising_edge (ClkInt) then
      Case State is
        when idle =>
          nAS <= '0';
          nWait <='1';
          DbusValue := initialDbus_Value;
          State := WritingConfig_Write;
        when WritingConfig_Write =>
          RnW <= '0';
          Addr <= I2C_Config ;
          Dbus <= DbusValue(DataBusSize-1 downto 0);
          State := WritingConfig_Write1;
        when WritingConfig_Write1 =>
          DbusValue:="0000001000000110";
          RnW <= '0';
          Addr <= I2C_Config ;
          Dbus <= DbusValue(DataBusSize-1 downto 0);
          State := EndWritingConfig_Write;
        when EndWritingConfig_Write =>
          DBus <= TriState;
          State := idle;
          --State := Writing2;
          --State:= Reading1;
        --when Writing2 =>
--          Addr <= I2C_DataToSend;
--          DataToSend(TimerValueSize-1-DataBusSize downto 0) <= TimerValue(TimerValueSize-1 downto DataBusSize);
--          RnW <= '0';
--          Cs <= '1';
--          State := EndWriting2;
--        when EndWriting2 =>
--          Data <= TriState;
--          Cs <= '0';
--          State := Reading1;
--        when Reading1 =>
--          Addr <= I2C_Status;
--          RnW <= '1';
--          State := EndReading1;
--        when EndReading1 =>
--          TimerValue(DataBusSize-1 downto 0) := Data;
--          Cs <= '0';
--          State := Reading2;
--        when Reading2 =>
--          Addr <= AddrTimerValueMSB;
--          RnW <= '1';
--          Cs <= '1';
--          State := EndReading2;
--        when EndReading2 =>
--          TimerValue(TimerValueSize-1 downto DataBusSize) := Data(TimerValueSize-1-DataBusSize downto 0);
--          Cs <= '0';
--          State := Reading1;
      end case;
     end if;
end process CPUonlyBehavior;
END ARCHITECTURE arch;

