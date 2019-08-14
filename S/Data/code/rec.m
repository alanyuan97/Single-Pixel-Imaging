function Cnorm = rec(Bnew)
C=ifwht2d(Bnew); %inverse transform
vmax=max(max(C));
vmin=min(min(C));
Cnorm=(C-vmin)/(vmax-vmin);
end