library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Wavelet2D is
  Port ( clk: in std_logic;
    in_data1 : in  STD_LOGIC_VECTOR (63 downto 0);  
			in_data2: in STD_LOGIC_VECTOR (63 downto 0);  
      out_data1: out STD_LOGIC_VECTOR (63 downto 0);
     out_data2: out STD_LOGIC_VECTOR (63 downto 0);
	 dwt_valid: out std_logic 
  );
end Wavelet2D;

architecture Behaviora of Wavelet2D is
component Wavelet1D is
  Port (
    in_data : in  STD_LOGIC_VECTOR (63 downto 0);  
     out_data   : out STD_LOGIC_VECTOR (63 downto 0); 
    clk   : in  STD_LOGIC                       
  );
end component Wavelet1D;
signal wv3,wv4,wv5,wv6,wv7,wv8 : STD_LOGIC_VECTOR (63 downto 0);
signal wv1,wv2: std_logic_vector(63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
signal present1,present2,Q,y : std_logic_vector(63 downto 0);
begin
wv1<= in_data1;
wv2<= in_data2;
wave1: Wavelet1D port map(in_data=> Q, out_data=> wv3, clk=> clk);
wave2: Wavelet1D port map(in_data=> y, out_data=> wv4, clk=> clk);
wv5<= wv3(63 downto 56) & wv4(63 downto 56) & wv3(55 downto 48) & wv4(55 downto 48) & wv3(47 downto 40) & wv4(47 downto 40) & wv3(39 downto 32) & wv4(39 downto 32);
wv6<= wv3(31 downto 24) & wv4(31 downto 24) & wv3(23 downto 16) & wv4(23 downto 16) & wv3(15 downto 8) & wv4(15 downto 8) & wv3(7 downto 0) & wv4(7 downto 0);
wave3: Wavelet1D port map(in_data=> wv5, out_data=> present1, clk=> clk);
wave4: Wavelet1D port map(in_data=> wv6, out_data=> present2, clk=> clk);
out_data1<= present1;
out_data2<= present2;


valid: process(wv1,wv2,clk)
begin
if (clk='1' and clk' event) then
Q<= wv1;
y<= wv2;
end if;
end process;
dwt_valid<= '0','1' after 90 ns; 
end Behaviora;
