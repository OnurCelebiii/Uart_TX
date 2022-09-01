----------------------------------------------------------------------------------
-- Engineer: 
-- Create Date: 16.08.2022 09:21:04
-- Design Name: Uart Tx TB
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity uart_tx_tb is
end uart_tx_tb;

architecture Behavioral of uart_tx_tb is

component uart_tx is    
                                                
    Port (i_clk         :        in std_logic                       ;
          i_tx_data     :        in std_logic_vector (7 downto 0)   ;
          i_rst         :        in std_logic                       ;
          i_start_byte  :        in std_logic                       ;
          o_tx          :        out std_logic)  ;
          
end component;                                                         

signal    tb_i_clk            :       std_logic :='0'                            ;
signal    tb_i_tx_data        :       std_logic_vector (7 downto 0):="00101010"  ;
signal    tb_i_rst            :       std_logic := '0'                           ;
signal    tb_i_start_byte     :       std_logic := '1'                           ;
signal    tb_o_tx             :       std_logic             ;

begin

DUT  :  uart_tx PORT MAP (

 i_clk               =>         tb_i_clk         ,
 i_tx_data           =>         tb_i_tx_data     ,
 i_rst               =>         tb_i_rst         ,
 i_start_byte        =>         tb_i_start_byte  ,
 o_tx                =>         tb_o_tx         );

process begin 

--for a in 0 to 1 loop
    
--    tb_i_clk <= not tb_i_clk;
--    wait for 20 ns ;
--        for b in 0 to 8 loop
           
--           tb_i_tx_data <= std_logic_vector(unsigned(tb_i_tx_data)+1);
--           wait for 20 ns;
--                for c in 0 to 1 loop
                    
--                    tb_i_rst <= not tb_i_rst;
--                    tb_i_start_byte <= not tb_i_start_byte;
--                    wait for 20 ms; 
                    
--        end loop;
--    end loop;
--end loop;
--end process;

for a in 0 to 1 loop 

tb_i_clk <= not tb_i_clk;
wait for 20 ns;

end loop;
end process;
end Behavioral;
