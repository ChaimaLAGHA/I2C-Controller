--
-- VHDL Architecture Projet_I2CIP_lib.Z_Write.arch
--
-- Created:
--          by - CHAIMA.UNKNOWN (LAPTOP-I71U7FVH)
--          at - 22:57:43 18/11/2022
--
-- using Mentor Graphics HDL Designer(TM) 2018.2 (Build 19)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
LIBRARY Projet_I2CIP_lib;
USE Projet_I2CIP_lib.I2C_Package.ALL;

ENTITY Z_Write IS
   PORT( 
      Addr              : IN     DefAddr;
      Clk               : IN     DefBit;
      Dbus              : IN     DefDbus;
      RnW               : IN     DefBit;
      nAS               : IN     DefBit;
      nBE0              : IN     DefBit;
      nBE1              : IN     DefBit;
      nRst              : IN     DefBit;
      Config            : OUT    DefConfig;
      DataToSend        : OUT    DefData;
      Transfert_Request : OUT    DefBit
   );

-- Declarations

END Z_Write ;

--
ARCHITECTURE arch OF Z_Write IS
  signal nBE: std_logic_vector (EndiannessSize-1 downto 0);
BEGIN
  WriteBehavior: process (nRst,Clk)
  begin
    nBE(0)<= nBE0;
    nBE(1)<= nBE1;
    if nRst='0' then
      DataToSend<=(others=>'Z');
      Transfert_Request<='0';
      Config.NB_Donnees <= (others=>'0');
      Config.IT_Enable <= '0';
      Config.Mode_Vitess <= '0';
      Config.Sens_Echange <= '0';
      elsif rising_edge(Clk)then
      if nAS='0'and RnW='0'then
        case Addr is
          when I2C_Addr=>
            case nBE is
              when BIG_ENDIAN => DataToSend <= Dbus(DataBusSize-1 downto 8); 
              when others => DataToSend <= Dbus(DataBusSize-9 downto 0);
            end case;
          when I2C_Config=>
            case nBE is 
            when BIG_ENDIAN => 
                            Config.NB_Donnees <= Dbus(DataBusSize-1 downto 8);
                            Config.IT_Enable <= Dbus(0);
                            Config.Mode_Vitess <= Dbus(1);
                            Config.Sens_Echange <= Dbus(2);
            when LITTLE_ENDIAN => 
                            Config.NB_Donnees <= Dbus(7 downto 0);
                            Config.IT_Enable <= Dbus(8);
                            Config.Mode_Vitess <= Dbus(9);
                            Config.Sens_Echange <= Dbus(10);
            when others => 
          end case;
            Transfert_Request<= '1';
          when I2C_DataToSend =>
            case nBE is 
              when BIG_ENDIAN => DataToSend <= Dbus(DataBusSize-1 downto 8);
              when others => DataToSend <= Dbus(DataBusSize-9 downto 0);
            end case; 
          when others =>
        end case;
      end if;
    end if;
  end process WriteBehavior;
END ARCHITECTURE arch;

