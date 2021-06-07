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
    % verify the arguments
    %verifyArguments(ode_str, cond1_str, cond2_str);
    % get the coefficients of the string equation
    [Coefs, matches] = strsplit(ode_str, {'*D2y', '*Dy', '*y'});
    Coefs(end)=[];% remove the last element(=0)
    disp(Coefs);
    % TODO Get a,b,and c 
    %      Compute the derivative
    %      Display using LaTEX
    
    % - extract the coefficients

end