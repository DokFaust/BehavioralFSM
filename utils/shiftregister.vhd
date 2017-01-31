-------------------------------------------------------------------
-- Shift Register: unidirectional shift register with synchronous
-- parallel load.
--
-- Required signals:
-------------------------------------------------------------------
-- CLK, D_IN:   in std_logic;
-- P_LOAD:      in std_logic;
-- P_LOAD_DATA: in std_logic_vector(7 downto 0);
-- D_OUT:       out std_logic;
--
--Required intermediate signals:
signal REG_TMP: std_logic_vector(7 downto 0);
-------------------------------------------------------------------
process (CLK)
begin
    if (rising_edge(CLK)) then
        if(P_LOAD = '1') then
            REG_TMP <= P_LOAD_DATA;
        else
            REG_TMP <= REG_TMP(6 downto 0) & D_IN;
        end if;
    end if;
    D_OUT <= REG_TMP(7);
end process;
--
