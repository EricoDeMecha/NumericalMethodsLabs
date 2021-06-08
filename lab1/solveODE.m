function solveODE(ode_str,cond1_str,cond2_str,indept)
% function : solveODE(param1, param2, param3, param4)
%           solveODE() function solves constant coefficient Homogeneous equations
% params: param1, param2, param3, param4
%        param1: ODE string e.g  a*D2y+b*Dy+c*y=0 Note: use acute punctuation marks instead of apostrophes
%        param2: First condition e.g y(0)=0
%        param3: second condition e.g Dy(0)=1
%        param4: Independent  variable e.g x 
%     Note: Parameters should follow their respective orders as shown above
% return: Output
%       Displays the output in a lex format 
    if nargin < 4
        fprintf("Usage: solveODE a*D2y+b*Dy+c*y=0  y(d)=e Dy(f)=g x\n");
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
    patt =  "(\-*+\.*+\d)++";
    
    vals1 = regexp(cond1_str, patt,'tokens');
    x0 = str2double(vals1{1,1});
    y0 = str2double(vals1{1,2}); 
    
    vals2 = regexp(cond2_str, patt,'tokens');  
    dx0 = str2double(vals2{1,1});
    dy0 = str2double(vals2{1,2});
    
    disp([x0,y0,dx0,dy0]);
    
    % applying the rules
    if (b^2 - 4*a*c) > 0
        % real distinct roots
        r1 = (-b + sqrt((b^2 - 4 * a * c))) / (2 * a);
        r2 = (-b - sqrt((b^2 - 4 * a * c))) / (2 * a);
        % general solution
        y1 = "exp("+ num2str(r1) + "*" + indept + ")";
        y2 = "exp(" + num2str(r2) + "*" + indept + ")";
        par = "@("+indept+")";
        f1 = sym(str2func([convertStringsToChars(par), convertStringsToChars(y1)]));
        f2 = sym(str2func([convertStringsToChars(par), convertStringsToChars(y2)]));

        g1 = diff(f1); g2 = diff(f2);
        disp(g1); disp(g2);
        % containing the other two functionalities

        syms(convertStringsToChars(indept))
        init_var = "= "+ num2str(x0);
        eval([indept convertStringsToChars(init_var)]); % a shot in the knee but it is worth taking it
        A1 = [subs(f1) subs(f2)];
        init_var = "= "+ num2str(dx0);
        eval([indept convertStringsToChars(init_var)]);
        A2 = [subs(g1) subs(g2)];
        A = [A1 ; A2];
        B = [y0; dy0];
        C = A\B; % solve for c1 and c2
        fprintf("Solution using the re-invented dsolve\n");
        sol = num2str(double(C(2))) + "*"+ y2 +"+"+num2str(double(C(1))) +"*"+y1;
        disp(sol); 
        fprintf("Solution using actual dsolve \n");
        conds = cond1_str + "," + cond2_str;
        d_sol = dsolve(convertStringsToChars(ode_str), convertStringsToChars(conds),convertStringsToChars(indept));
        disp(d_sol);
    end
    if (b^2 - 4*a*c) == 0
        % real repeated roots
        r = -b/(2*a);
        % general solution
        y1 = "exp(" + num2str(r) + "*" + indept + ")";
        y2 = indept + "*exp(" + num2str(r) + "*" + indept + ")";
        par = "@(" + indept + ")";
        f1 = sym(str2func([convertStringsToChars(par), convertStringsToChars(y1)]));
        f2 = sym(str2func([convertStringsToChars(par), convertStringsToChars(y2)]));

        g1 = diff(f1); g2 = diff(f2);
        % disp(g1); disp(g2);
        % containing the other two functionalities

        syms(convertStringsToChars(indept))
        init_var = "= " + num2str(x0);
        eval([indept convertStringsToChars(init_var)]); % a shot in the knee but it is worth taking it
        A1 = [subs(f1) subs(f2)];
        init_var = "= " + num2str(dx0);
        eval([indept convertStringsToChars(init_var)]);
        A2 = [subs(g1) subs(g2)];
        A = [A1; A2];
        B = [y0; dy0];
        C = A \ B; % solve for c1 and c2
        fprintf("Solution using the re-invented dsolve\n");
        sol = num2str(double(C(2))) + "*" + y2 + "+" + num2str(double(C(1))) + "*" + y1;
        disp(sol);
        fprintf("Solution using actual dsolve \n");
        conds = cond1_str + "," + cond2_str;
        d_sol = dsolve(convertStringsToChars(ode_str), convertStringsToChars(conds), convertStringsToChars(indept));
        disp(d_sol);
    end
    if (b^2 - 4*a*c) < 0
        % complex roots
        r1 = (-b + sqrt((b^2 - 4 * a * c))) / (2 * a);
        r2 = (-b - sqrt((b^2 - 4 * a * c))) / (2 * a);
        % general solution
        y = "c1*" + num2str(exp(r1)) + "+c2*" + num2str(exp(r2));
        disp(y);
    end
end