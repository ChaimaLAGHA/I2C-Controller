--
-- VHDL Architecture Projet_I2CIP_lib.Z_Environnement2.arch
--
-- Created:
--          by - CHAIMA.LAGHA (LAPTOP-I71U7FVH)
--          at - 16:00:05 26/11/2022
--
-- using Mentor Graphics HDL Designer(TM) 2018.2 (Build 19)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;
LIBRARY Projet_I2CIP_lib;
USE Projet_I2CIP_lib.I2C_Package.ALL;

ENTITY Z_Environnement2 IS
   PORT( 
      Dbus  : INOUT  DefDbus;
      Addr  : OUT    DefAddr;
      Clk   : OUT    DefBit;
      RnW   : OUT    DefBit;
      nAS   : OUT    DefBit;
      nBE0  : OUT    DefBit;
      nBE1  : OUT    DefBit;
      nRst  : OUT    DefBit;
      nWait : OUT    DefBit;
      SDA   : INOUT  DefBit
   );
END Z_Environnement2 ;
ARCHITECTURE arch OF Z_Environnement2 IS

   SIGNAL ClkInt, RstInt : std_logic; 
   SIGNAL CptDATA : std_logic_vector(7 downto 0);
BEGIN
Clk <= ClkInt;
nRst <= RstInt;

-- Definition des processus

ResetGenerator : process
    begin
      RstInt <= '0';
      wait for 5000 ns;
      RstInt <= '1';
      wait;
end process ResetGenerator;
  
  
ClockGenerator : process
    begin
      ClkInt <= '0';
      wait for 5 ns;
      ClkInt <= '1';
      wait for 5 ns;
end process ClockGenerator;

CPUonlyBehavior : process (ClkInt,RstInt) 
  variable DbusValue : DefDbus;
  variable count :  integer :=0;
  variable ReadNWrite : integer range 0 to 1;
  variable NBData : integer range 0 to 7 :=7;
  variable c_Standard :integer :=Nb_CycleStandadard;
  type DefState is (idle, Writing_config, Writing_SendAddress, I2C_DeviceACK_Add,I2C_DeviceACK_1,I2C_DeviceACK_2,I2C_DeviceACK_3, Write_Data_1
  ,Write_Data_2,Write_Data_3, Read_Status, Reading_Config, Writing_DeviceAdd, Receive_Data_1,Receive_Data_2 ,Device_Ack_1,Device_Ack_2); 
    variable State_Proc : DefState;
    begin
      --  -- Reset I2C controller
    if (RstInt = '0') then   
      Addr <= (others=>'0');
      Dbus <= (others=>'Z');
      nWait <='0';
      RnW <= '0';
      nAS <= '1';
      SDA<= '0';
      nBE0 <='0';
      nBE1 <='1';
      State_Proc:= Idle;
   elsif rising_edge (ClkInt) then
      Case State_Proc is
        when idle => 
          --  -- Preparing the I2C controller for data transfer
          nWait <='1';
          nAS <= '0';
          ReadNWrite:=0;
          SDA<='Z';
          Dbus <= (others=>'Z');
          if (count=Nb_CycleStandadard) then 
          State_Proc:= Writing_config;
          count:=0;
          else 
          State_Proc:= idle;
          count:=count+1;
          end if;
        when Writing_config =>
          --  -- Configuration of a 3 bytes send data in standard mode and Little Endian format without interruption 
          DbusValue:="0000001000000011"; --0203
          RnW <= '0';
          Addr <= I2C_Config ;--01
          Dbus <= DbusValue(DataBusSize-1 downto 0);
          CptDATA<=DbusValue(DataBusSize-9 downto 0); 
          SDA<= 'Z' ;
          if (count=Nb_CycleStandadard) then
          State_Proc :=Writing_SendAddress; 
          else
          State_Proc:= Writing_config; 
          count:=count+1; 
          end if;
        When Writing_SendAddress =>
          DbusValue:="0000000011011001"; --D9
          RnW <= '0';
          Addr <= I2C_Addr ; --00
          Dbus <=DbusValue(DataBusSize-1 downto 0);
          SDA<= 'Z';
          if(count=((10*Nb_CycleStandadard)+383) )then
          count:=0; 
          ReadNWrite:=0;
          State_Proc:= I2C_DeviceACK_Add;
          else
          State_Proc:= Writing_SendAddress; 
          count:= count+1;
          end if;
      When I2C_DeviceACK_Add =>
          SDA <='1'; 
          if (count=c_Standard) then --999
            if (ReadNWrite=0) then
             State_Proc:= Write_Data_1;
          else 
            State_Proc:= Receive_Data_1;
        end if;
          count:=0;
          else
          count:=count+1;
          end if ;
      When Write_Data_1=>
        --  -- Sending data once we have received the acknowledgement bit 
        DbusValue:="0000000001011101"; --5D
        Addr <= I2C_DataToSend; --02
        Dbus <=DbusValue(DataBusSize-1 downto 0);
        SDA <='Z';
        if(count=(8*Nb_CycleStandadard ))then
          count:=0; 
          cptData<= cptData-1;
          State_Proc:= I2C_DeviceACK_1;
          else
          State_Proc:= Write_Data_1; 
          count:= count+1;
          end if;
        When I2C_DeviceACK_1 =>
          SDA <='1'; 
          if (count=Nb_CycleStandadard) then 
          State_Proc:= Write_Data_2;
          count:=0;
        else
          count:=count+1;
        end if ;
        When Write_Data_2=>
        --  -- Sending data once we have received the acknowledgement bit 
        DbusValue:="0000000000011110"; --1E
        Addr <= I2C_DataToSend; --02
        Dbus <=DbusValue(DataBusSize-1 downto 0);
        SDA <='Z';
        if(count=(8*Nb_CycleStandadard ))then
          count:=0; 
          cptData<= cptData-1;
          State_Proc:= I2C_DeviceACK_2;
          else
          State_Proc:= Write_Data_2; 
          count:= count+1;
          end if;
        When I2C_DeviceACK_2 =>
          SDA <='1'; 
          if (count=Nb_CycleStandadard) then 
          State_Proc:= Write_Data_3;
          count:=0;
          elsif( count=Nb_CycleStandadard ) then --and cptData=0
          State_Proc:= idle;
          count:=0;
          else
          count:=count+1;
          end if ;
        When Write_Data_3=>
        --  -- Sending data once we have received the acknowledgement bit 
        DbusValue:="0000000000111101"; --3D
        Addr <= I2C_DataToSend; --02
        Dbus <=DbusValue(DataBusSize-1 downto 0);
        SDA <='Z';
        if(count=(8*Nb_CycleStandadard ))then
          count:=0; 
          cptData<= cptData-1;
          State_Proc:= I2C_DeviceACK_3;
          else
          State_Proc:= Write_Data_3; 
          count:= count+1;
          end if;
        When I2C_DeviceACK_3 =>
          SDA <='1'; 
          if (count=Nb_CycleStandadard)then 
          State_Proc:= Read_Status;
          count:=0;
        else
          count:=count+1;
        end if ;
        
      When Read_Status =>
        RnW<= '1';
        Addr <= I2C_Status; --02
        Dbus <= (others=>'Z');
        SDA<= 'Z';
        if (count=Nb_CycleStandadard) then 
          if(ReadNWrite=0)then
          State_Proc:= Reading_Config;
          else 
          State_Proc:=idle;
          end if;
          count:=0;
        else 
          State_Proc:= Read_Status;
          count:=count+1;
        end if;
     When Reading_Config =>
      --  -- Configuration of a 2 bytes read data in standard mode and Big Edian format without interruption 
          nBE0<= '1';
          nBE1 <= '0'; 
          DbusValue:="0000001000000100"; --0204
          Addr <= I2C_Config ;--01
          Dbus <= DbusValue(DataBusSize-1 downto 0);
          RnW <= '0'; 
          SDA<= 'Z' ;
          if (count=Nb_CycleRapide) then 
          State_Proc :=Writing_DeviceAdd; 
          else
          State_Proc:= Reading_Config; 
          count:=count+1; 
          end if;
    When Writing_DeviceAdd=>
      DbusValue:="1001101100000110"; --9B06
          RnW <= '0';
          Addr <= I2C_Addr ;
          Dbus <=DbusValue(DataBusSize-1 downto 0);
          SDA<= 'Z';
          if(count=10*Nb_CycleRapide)then --24 
          count:=0; 
          ReadNWrite :=1;
          c_Standard:=33;
          State_Proc:= I2C_DeviceACK_Add;
          else
          State_Proc:= Writing_DeviceAdd; 
          count:= count+1;
          end if;
    When Receive_Data_1=>
      DBusValue:="0000000011000011";
      SDA<=DBusValue(NBData);
      if(NBData=0) then 
        if (count=Nb_CycleRapide) then 
         State_Proc :=Device_Ack_1; 
         NBData:=7; 
         count:=0;
        else
         count:=count+1;
       end if;
      else 
        if (count=Nb_CycleRapide)then 
          NBData:=NBData-1; 
          count:=0;
        else 
        count:=count+1;
        end if ;
      end if;
      
    When Device_Ack_1=>
      RnW<= '1';
      Addr<= I2C_DataReceived;
      Dbus<=(others=>'Z');
      if (count=Nb_CycleRapide) then 
          State_Proc:= Receive_Data_2;
          count:=0;
          else 
          State_Proc:= Device_Ack_1;
          count:=count+1;
      end if; 
    When Receive_Data_2=>
      DBusValue:="0000000000000011";
      SDA<=DBusValue(NBData);
      
      if(NBData=0) then 
        if (count=Nb_CycleRapide) then 
         State_Proc :=Device_Ack_2; 
         NBData:=7; 
         count:=0;
        else
         count:=count+1;
       end if;
      else 
        if (count=Nb_CycleRapide)then 
          NBData:=NBData-1; 
          count:=0;
        else 
        count:=count+1;
        end if ;
      end if;
    When Device_Ack_2=>
      SDA<= 'Z';
      if (count=Nb_CycleRapide) then 
          State_Proc:= Read_Status;
          count:=0;
          else 
          State_Proc:= Device_Ack_2;
          count:=count+1;
      end if;        
    end case; 
  end if;         
end process CPUonlyBehavior;
  
END ARCHITECTURE arch;

