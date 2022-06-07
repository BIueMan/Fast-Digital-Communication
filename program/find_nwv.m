function nwv=find_nwv(Data,Pattern)

V=[];
for nwv=3:50
    [RefPattern]=generate_refcode_signal(Pattern,nwv);
    
    C=conv(real(Data),flip(RefPattern),'same');
    [val,idx]=max(C);
    %remove half of center of pattern to get starting point
    idx=idx-floor(length(Pattern)/2);
    V=[V;val/nwv,nwv];
end
global to_plt
if to_plt
figure(111)
plot(V(:,2),V(:,1))
xlabel("nwv")
ylabel("normalized corelattion");
end
[nwv,idx]=max(V(:,1));
nwv=V(idx,2);
end