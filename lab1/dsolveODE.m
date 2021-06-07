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
