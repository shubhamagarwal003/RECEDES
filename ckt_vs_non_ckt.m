function [PROB] = ckt_vs_non_ckt(addr)
    dire=addr;   %directory containing symbols of one image.
    a1=dir(dire);
    j=0;
    PROB=zeros(1,3);
    for i=3:size(a1,1)
        addr = strcat(dire,a1(i).name);   %address of each symbol.
        prob_r=detect_symbol(addr);
        PROB=PROB+prob_r;
    end
    PROB=PROB/(size(a1,1)-2);
end