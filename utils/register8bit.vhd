---------------------------------------------
-- Register: 8-bit Register with load enable.
--
-- Required signals:
---------------------------------------------
-- CLK, LD: in std_logic;
-- D_IN   : in std_logic_vector(7 downto 0);
-- D_OUT  : in std_logic_vector(7 downto 0);
---------------------------------------------
process (CLK)
begin
    if(rising_edge(CLK)) then
        if(LD = '1') then
            D_OUT <= D_IN;
        end if;
    end if;
end process;
--
