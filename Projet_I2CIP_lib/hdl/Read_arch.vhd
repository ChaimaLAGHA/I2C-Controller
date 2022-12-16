--
-- VHDL Architecture Projet_I2CIP_lib.Read.arch
--
-- Created:
--          by - E21C396C.UNKNOWN (irc107-04)
--          at - 14:32:10 17/11/2022
--
-- using Mentor Graphics HDL Designer(TM) 2022.1 Built on 21 Jan 2022 at 13:00:30
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
LIBRARY Projet_I2CIP_lib;
USE Projet_I2CIP_lib.I2C_Package.ALL;

ENTITY Read IS
   PORT( 
      Addr         : IN     DefAddr;
      DataReceived : IN     DefData;
      RnW          : IN     DefBit;
      Status       : IN     DefStatus;
      nAS          : IN     DefBit;
      nBE0         : IN     DefBit;
      nBE1         : IN     DefBit;
      nRst         : IN     DefBit;
      Dbus         : OUT    DefDbus
   );

-- Declarations

END Read ;

--
ARCHITECTURE arch OF Read IS
BEGIN
  ReadBehavior:process(nRst,RnW,Addr)
  begin
    Dbus<=TriState;
      if nAS='0'and RnW='1'then
      case Addr is
      when I2C_Addr=>
      when I2C_Config=>
      when I2C_DataToSend=>
      when I2C_DataReceived=> Dbus(DataBusSize-1 downto 8)<= DataReceived;
      when I2C_Status => Dbus(0)<= Status.Write_Error;
                         Dbus(1)<= Status.Read_Error;
                         Dbus(2)<= Status.Waiting_ACK;
                         Dbus(3)<= Status.Busy;
                         Dbus(4)<= Status.Write_Done;
                         Dbus(5)<= Status.Read_Done;
                         
                        -- Dbus(DataBusSize-1 downto  10)<= Status;
      when others=>
      end case;
    end if;
  end process ReadBehavior;
  
END ARCHITECTURE arch;

