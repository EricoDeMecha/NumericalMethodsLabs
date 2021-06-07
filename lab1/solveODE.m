function solveODE(ode_str,cond1_str,cond2_str)
% function : solveODE(param1, param2, param3)
%           solveODE() function solves constant coefficient Homogeneous equations
% params: param1, param2, param3
%        param1: ODE string e.g  ay``+by``+c=0 Note: use acute punctuation marks instead of apostrophes
%        param2: First condition
%        param3: Second derivative condition
%     Note: Parameters should follow there respective orders as shown above
% return: Output
%       Displays the output in a lex format 
    if nargin < 3
        fprintf("Usage: solveODE ay``+by`+cy=0 y(d)=e y'(f)=g ");
        return;
    end
    % verify the arguments
    verifyArguments(ode_str, cond1_str, cond2_str);
    ode_val_patt = "([+-]?(?=\.\d|\d)(?:\d+)?(?:\.?\d*))(?:[eE]([+-]?\d+))?";
    ode_vals= regexp(ode_str, ode_val_patt, "split");
    disp(ode_vals);
    
    % TODO Get a,b,and c 
    %      Compute the derivative
    %      Display using LaTEX
    
end

function verifyArguments(ode_str, cond1_str, cond2_str)
%function: verifyArguments(ode_str, cond1_str, cond2_str)
%           Checks whether the arguments follow the required format
% params: param1, param2, param3
%        param1: ODE string 
%        param2: First condition string
%        param3: Second derivative condition string
%     Note: Parameters should follow there respective orders as shown above
% return: Output
%       Displays an error message incase of  an error
    ode_patt = "^.*[a-zA-Z]``.*[a-zA-Z]`.*[a-zA-Z]=0$";
    ode_ver = regexp(ode_str, ode_patt, "match");
    cond1_patt = "^[a-zA-Z]\(\d\)=[0-9]+$";
    cond1_ver = regexp(cond1_str, cond1_patt, "match");
    cond2_patt = "^[a-zA-Z]`\(\d\)=[0-9]+$";
    cond2_ver = regexp(cond2_str, cond2_patt, "match");

    if isempty(ode_ver)
        fprintf("Your ODE expression do not  match the required format\n");
        return;
    end
    if isempty(cond1_ver)
        fprintf("Your 1st condition do not  match the required format\n");
        return;
    end
    if isempty(cond2_ver)
        fprintf("Your 2nd  condition do not  match the required format\n");
        return;
    end
end