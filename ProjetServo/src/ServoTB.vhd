library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ServoTB is
 port(Done: out boolean:=FALSE);
end entity ServoTB;


Architecture bench of ServoTB is
  
  signal TClk, TReset, Tcommande: std_logic;
  signal Tposition : std_logic_vector (7 downto 0);
  signal Start : boolean := false;
  
  component Servo IS 
	port (
    clk : in std_logic; --horloge 50Mhz, T = 20 ns
    reset : in std_logic; --actif etat haut
    position : in std_logic_vector (7 downto 0); --position sur 8 bits
    commande : out std_logic
    );
  end component;
  
  begin
    UUT: COMPONENT Servo PORT MAP(
	    Clk => TClk,
      reset => TReset,
      position => Tposition,
      commande => Tcommande
    );
    

  -- Generation d'une horloge
  TClk <= '0' when not Start else not TClk after 20 ns;
  -- Generation d'un reset au debut
  TReset <= '1', '0' after 40 ns;

  test_bench : process
  begin
   
   Start <= true;
   
        Tposition <= "00000000";
        wait for 10499 us;
        ASSERT Tcommande = '1' REPORT "ERROR: Servo TEST 1 FAILED)" -- Servo Test 1
        SEVERITY FAILURE; 
        REPORT "Servo Test 1 passed." SEVERITY note;
        
        
        Tposition <= "10110100"; -- 180
        wait for 12 ms;
        ASSERT Tcommande = '1' REPORT "ERROR: Servo TEST 2 FAILED)" -- Servo Test 2
        SEVERITY FAILURE; 
        REPORT "Servo Test 2 passed." SEVERITY note;
        
   Done <= true;

        
  REPORT "Bench test is successfully finished." SEVERITY note;
  Done <= TRUE;
  Wait;
  end process;
  
End BENCH;