function solveODE(ode_str,cond1_str,cond2_str,indept)
% function : solveODE(param1, param2, param3)
%           solveODE() function solves constant coefficient Homogeneous equations
% params: param1, param2, param3
%        param1: ODE string e.g  a*D2y+b*Dy+c*y=0 Note: use acute punctuation marks instead of apostrophes
%        param2: First condition e.g y(0)=0
%        param3: second condition e.g Dy(0)=1
%        param4: Independent  variable e.g x 
%     Note: Parameters should follow there respective orders as shown above
% return: Output
%       Displays the output in a lex format 
    if nargin < 4
        fprintf("Usage: solveODE a*D2y+b*Dy+c*y=0  y(d)=e y'(f)=g x\n");
        return;
    end
    % extract coefficients in ode
    [Coefs, matches] = strsplit(ode_str, {'*D2y', '*Dy', '*y'});
    if ~isempty(Coefs)
        Coefs(end) = []; % remove the last element(=0)
        disp(Coefs);
    else
        fprintf("Error: resolve format of the equation");
        return;
    end
    % coefficients
    a = str2double(Coefs(1));
    b = str2double(Coefs(2));
    c = str2double(Coefs(3));
    % extract values from the boundary condition
    patt = digitsPattern;
    vals1 = extract(cond1_str, patt);
    y0 = vals1(2);
    x0 = vals1(1);

    vals2 = extract(cond2_str, patt);
    dx0 = vals2(1);
    dy0 = vals2(2);
    % applying the rules
    if (b^2 - 4*a*c) > 0
        % real distinct roots
        r1 = (-b + sqrt((b^2 - 4 * a * c))) / (2 * a);
        r2 = (-b - sqrt((b^2 - 4 * a * c))) / (2 * a);
        % general solution
        y = "c1*"+num2str(exp(r1))+"c2"+num2str(exp(r2));
        disp(y);
    end
    if (b^2 - 4*a*c) == 0
        % real repeated roots
        r = -b/(2*a);
        % general solution
        y = "c1*" + num2str(exp(r))+"c2*"+indept+num2str(exp(r));
    end
    if (b^2 - 4*a*c) < 0
        % complex roots
        r1 = (-b + sqrt((b^2 - 4 * a * c))) / (2 * a);
        r2 = (-b - sqrt((b^2 - 4 * a * c))) / (2 * a);
        % general solution
        y = "c1*" + num2str(exp(r1)) + "c2" + num2str(exp(r2));
    end
end