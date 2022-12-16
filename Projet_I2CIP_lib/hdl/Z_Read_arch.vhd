--
-- VHDL Architecture Projet_I2CIP_lib.Z_Read.arch
--
-- Created:
--          by - CHAIMA.LAGHA (LAPTOP-I71U7FVH)
--          at - 22:56:16 18/11/2022
--
-- using Mentor Graphics HDL Designer(TM) 2018.2 (Build 19)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
LIBRARY Projet_I2CIP_lib;
USE Projet_I2CIP_lib.I2C_Package.ALL;

ENTITY Z_Read IS
   PORT( 
      Addr         : IN     DefAddr;
      DataReceived : IN     DefData;
      RnW          : IN     DefBit;
      Status       : IN     DefStatus;
      nAS          : IN     DefBit;
      nBE0         : IN     DefBit;
      nBE1         : IN     DefBit;
      nRst         : IN     DefBit;
      nWait        : IN     DefBit;
      Dbus         : INOUT  DefDbus
   );

-- Declarations

END Z_Read ;

--
ARCHITECTURE arch OF Z_Read IS
  signal nBE: std_logic_vector (EndiannessSize-1 downto 0);
BEGIN
  ReadBehavior:process(nRst,RnW,Addr,DataReceived,Status)
  begin
    Dbus<=TriState;
    nBE(0)<= nBE0;
    nBE(1)<= nBE1;
      if (nRst='0') then 
        Dbus<= (others=>'Z');
      elsif nAS='0'and RnW='1'then
      case Addr is
      when I2C_Addr=>
      when I2C_Config=>
      when I2C_DataToSend=>
      when I2C_DataReceived=>
        case nBE is
          when BIG_ENDIAN => 
                            Dbus(DataBusSize-1 downto 8)<= DataReceived;
                            Dbus(DataBusSize-9 downto 0)<= "00000000";
          when LITTLE_ENDIAN => 
                            Dbus(DataBusSize-9 downto 0)<= DataReceived;
                            Dbus(DataBusSize-1 downto 8)<= "00000000";
          when others => --nothing to do 
        end case; 
      when I2C_Status => 
         case nBE is 
          when BIG_ENDIAN=>
                         Dbus(15)<= Status.Write_Error;
                         Dbus(14)<= Status.Read_Error;
                         Dbus(13)<= Status.Waiting_ACK;
                         Dbus(12)<= Status.Busy;
                         Dbus(11)<= Status.Write_Done;
                         Dbus(10)<= Status.Read_Done;
                         Dbus(DataBusSize-7 downto 0)<= "0000000000";
         when others =>  Dbus(0)<= Status.Write_Error;
                         Dbus(1)<= Status.Read_Error;
                         Dbus(2)<= Status.Waiting_ACK;
                         Dbus(3)<= Status.Busy;
                         Dbus(4)<= Status.Write_Done;
                         Dbus(5)<= Status.Read_Done;
                         Dbus(DataBusSize-1 downto 6)<= "0000000000";
       end case;        
      when others=>
      end case;
    end if;
  end process ReadBehavior;
END ARCHITECTURE arch;

