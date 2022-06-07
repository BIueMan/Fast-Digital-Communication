function [T, Filter] = RaisedCosine(n_span,np_wnd ,beta)
    T = -n_span*np_wnd:n_span*np_wnd;
    if beta== -1
        T=0:np_wnd-1;
        Filter=ones(1,np_wnd);
        return
    end
    aaa = T./np_wnd;
    Filter = sinc(aaa).* cos(pi.*beta.*aaa)./(1 - (4*beta^2 .* T.^2)/(np_wnd^2));
end