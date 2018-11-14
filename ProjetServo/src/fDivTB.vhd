library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity fDivTB is
 port(Done: out boolean:=FALSE);
end entity fDivTB;


Architecture bench of fDivTB is
  
  signal TClk, TReset, TTick: std_logic;
  signal Start : boolean := false;
  
  component fDiv IS 
	Generic (  Fclock  : positive := 50E6); -- System Clock Freq in Hertz
  Port (
    Clk     : In    std_logic;
    Rst     : In    std_logic;
    Tick : Out   std_logic
    );
  END component;
  
  begin
    UUT: COMPONENT fDiv PORT MAP(
	    Clk => TClk,
      Rst => TReset,
      Tick => TTick
    );
    

  -- Generation d'une horloge
  TClk <= '0' when not Start else not TClk after 20 ns;
  -- Generation d'un reset au debut
  TReset <= '1', '0' after 40 ns;

  test_bench : process
  begin
   
   Start <= true;
        
        wait for 10 ms;
        
   Start <= false;

        
  REPORT "Bench test is successfully finished." SEVERITY note;
  Done <= TRUE;
  Wait;
  end process;
  
End BENCH;