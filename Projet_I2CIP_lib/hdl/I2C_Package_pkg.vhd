--
-- VHDL Package Header Projet_I2CIP_lib.I2C_Package
--
-- Created:
--          by - E21C396C.LAGHA (irc107-04)
--          at - 13:49:57 17/11/2022
--
-- using Mentor Graphics HDL Designer(TM) 2022.1 Built on 21 Jan 2022 at 13:00:30
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;
PACKAGE I2C_Package IS
  
   --Constants for the project  
   constant AddrBusSize : integer := 23;
   constant DataBusSize : integer := 16;
   constant DataSize : integer := 8;
   constant Nb_BitDonnees :integer := 8;
   constant EndiannessSize : integer :=2;
   constant Nb_CycleStandadard :integer:=999;
   constant Nb_CycleRapide :integer :=23;
  
  -- Constants for endianism of processeur 
  constant BIG_ENDIAN : std_logic_vector ( EndiannessSize -1 downto 0) := "01";
  constant LITTLE_ENDIAN : std_logic_vector ( EndiannessSize -1 downto 0) := "10";
  constant EIGHT_BITS : std_logic_vector ( EndiannessSize -1 downto 0) := "00";
  
  
  
  --Data type for the project
  subtype DefAddr is std_logic_vector(AddrBusSize-1 downto 0);
  subtype DefDbus is std_logic_vector(DataBusSize-1 downto 0);
  subtype DefData is std_logic_vector(DataSize-1 downto 0);
  subtype DefNb_Donnees is std_logic_vector(Nb_BitDonnees-1 downto 0);
  subtype DefBit is std_logic;  
 
 
  type DefConfig is record 
    IT_Enable : DefBit;
    Mode_Vitess: DefBit; --1 : Standard 100Kbit/s 0: Rapide 4000Kbit/s
    Sens_Echange: DefBit;
    NB_Donnees: DefNb_Donnees;
  end record;
  type DefStatus is record
    Busy : DefBit;
    Write_Error :DefBit;
    Read_Error: DefBit;
    Waiting_ACK: DefBit;
    Write_Done : DefBit;
    Read_Done: DefBit;
  end record;  
  -- constant for the I2C controller
   constant TriState : DefDbus := (others => 'Z');
   constant I2C_Addr : DefAddr := "00000000000000000000000";
   constant I2C_Config : DefAddr := "00000000000000000000001";
   constant I2C_DataToSend : DefAddr := "00000000000000000000010";
   constant I2C_DataReceived : DefAddr := "00000000000000000000011";
   constant I2C_Status : DefAddr := "00000000000000000000100"; 
   constant initialDbus_Value: DefDbus:="0000000000000000";
  
  --state of the I2C controlet
   type DefState is (idle , sending_StartBit, sending_Address,sending_RnWBit,waiting_AckBit,
                     Send_Data, Receive_Data,sending_AckBit, sending_StopBit );  
 
END I2C_Package;
