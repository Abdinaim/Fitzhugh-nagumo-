% this program is used to plot the bifurcation diagram. Here we find the
% fixed points of the system and calculate the max and min voltage values
% at each time instant starting from a given point. The plot of the voltage
% values represents the bifurcation diagram.

function bifurcation_diagram()
    global a b tau I;
    % Værdierne af parametrene a, b, tau kan ændres her
    a = 0.7; b = 0.8; tau = 13;
    % indlæser variable 
    i = 1;  
    V = zeros; Vmin = zeros; Vmax = zeros;
    
    % Gå igennem forskellige værdier af i for at se på dens indflydelse som
    % forskydningsparameter
    for I=[-1:0.01:1.8]
        % definerer ligningssystemet
        f = @(t,y) [ y(1) - y(1).^3/3 - y(2) + I; (1/tau)*(y(1) + a - b*y(2)) ];
        g = @(y) f(0,y);
        % Find fikspunktet
        fp = fsolve(g,[0 0]);       
        %Find værdierne af w og V for fikspunktet
        v_fp = fp(1); w_fp = fp(2);   
        tspan = [0 80];
        % Løser ligningssustemet
        [tspan u] = ode45(f, tspan , [v_fp+0.2, w_fp]);
        V(i) = v_fp;
        % Finder minimum og maksimumværdierne for hvert ''step''
        Vmin(i) = min(u(:,1));
        Vmax(i) = max(u(:,1));
        i = i + 1;
    end
       I = [-1:0.01:1.8];
       plot(I,Vmin,I,Vmax);
       title('Forskydningsdiagram');
       xlabel('I');
       ylabel('Membrane Potential v(t)');
end