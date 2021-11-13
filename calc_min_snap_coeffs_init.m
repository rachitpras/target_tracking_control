function min_snap_coeffs = calc_min_snap_coeffs_init(traj_wp)
%calc_min_snap_coeffs
%   Calculates the min snap trajectory coefficients for a given set of
%   way-points
    n_poly = size(traj_wp,1) - 1;
    A = zeros(8*n_poly);
    RHS = zeros(8*n_poly,1);
    
    for i=1:n_poly
        A(i,8*(i-1) + 1) = 1.0;
        RHS(i) = traj_wp(i);
    end
    
    for i=1:n_poly
        A(n_poly+i, 8*(i-1)+1:8*(i-1)+8) = 1.0;
        RHS(n_poly + i) = traj_wp(i+1);
    end
    
    for i=1:n_poly-1
        A(2*n_poly+i, 8*(i-1) + 2) = 1.0;
        A(2*n_poly+i, 8*(i-1) + 3) = 2.0;
        A(2*n_poly+i, 8*(i-1) + 4) = 3.0;
        A(2*n_poly+i, 8*(i-1) + 5) = 4.0;
        A(2*n_poly+i, 8*(i-1) + 6) = 5.0;
        A(2*n_poly+i, 8*(i-1) + 7) = 6.0;
        A(2*n_poly+i, 8*(i-1) + 8) = 7.0;
        A(2*n_poly+i, 8*(i) + 2) = -1.0;
    end
    
    for i=1:n_poly-1
        A(3*n_poly-1+i, 8*(i-1) + 3) = 1.0;
        A(3*n_poly-1+i, 8*(i-1) + 4) = 3.0;
        A(3*n_poly-1+i, 8*(i-1) + 5) = 6.0;
        A(3*n_poly-1+i, 8*(i-1) + 6) = 10.0;
        A(3*n_poly-1+i, 8*(i-1) + 7) = 15.0;
        A(3*n_poly-1+i, 8*(i-1) + 8) = 21.0;
        A(3*n_poly-1+i, 8*(i) + 3) = -1.0;
    end
       
    for i=1:n_poly-1
        A(4*n_poly-2+i, 8*(i-1) + 4) = 1.0;
        A(4*n_poly-2+i, 8*(i-1) + 5) = 4.0;
        A(4*n_poly-2+i, 8*(i-1) + 6) = 10.0;
        A(4*n_poly-2+i, 8*(i-1) + 7) = 20.0;
        A(4*n_poly-2+i, 8*(i-1) + 8) = 35.0;
        A(4*n_poly-2+i, 8*(i) + 4) = -1.0;
    end
    
    for i=1:n_poly-1
        A(5*n_poly-3+i, 8*(i-1) + 5) = 1.0;
        A(5*n_poly-3+i, 8*(i-1) + 6) = 5.0;
        A(5*n_poly-3+i, 8*(i-1) + 7) = 15.0;
        A(5*n_poly-3+i, 8*(i-1) + 8) = 35.0;
        A(5*n_poly-3+i, 8*(i) + 5) = -1.0;
    end
    
    for i=1:n_poly-1
        A(6*n_poly-4+i, 8*(i-1) + 6) = 1.0;
        A(6*n_poly-4+i, 8*(i-1) + 7) = 6.0;
        A(6*n_poly-4+i, 8*(i-1) + 8) = 21.0;
        A(6*n_poly-4+i, 8*(i) + 6) = -1.0;
    end
    
    for i=1:n_poly-1
        A(7*n_poly-5+i, 8*(i-1) + 7) = 1.0;
        A(7*n_poly-5+i, 8*(i-1) + 8) = 7.0;
        A(7*n_poly-5+i, 8*(i) + 7) = -1.0;
    end
    
    A(8*n_poly-5,2) = 1.0;
    A(8*n_poly-4,3) = 1.0;
    A(8*n_poly-3,4) = 1.0;
    
    A(8*n_poly-2,8*(n_poly-1) + 5) = 1.0;
    A(8*n_poly-2,8*(n_poly-1) + 6) = 5.0;
    A(8*n_poly-2,8*(n_poly-1) + 7) = 15.0;
    A(8*n_poly-2,8*(n_poly-1) + 8) = 35.0;
    %RHS(8*n_poly-2) = 4.0;
    
%     A(8*n_poly-1,8*(n_poly-1) + 6) = 1.0;
%     A(8*n_poly-1,8*(n_poly-1) + 7) = 6.0;
%     A(8*n_poly-1,8*(n_poly-1) + 8) = 21.0;
% 
%     A(8*n_poly-0,8*(n_poly-1) + 7) = 1.0;
%     A(8*n_poly-0,8*(n_poly-1) + 8) = 7.0;

%     A(8*n_poly-2,8*(n_poly-1) + 2) = 1.0;
%     A(8*n_poly-2,8*(n_poly-1) + 3) = 2.0;
%     A(8*n_poly-2,8*(n_poly-1) + 4) = 3.0;
%     A(8*n_poly-2,8*(n_poly-1) + 5) = 4.0;
%     A(8*n_poly-2,8*(n_poly-1) + 6) = 5.0;
%     A(8*n_poly-2,8*(n_poly-1) + 7) = 6.0;
%     A(8*n_poly-2,8*(n_poly-1) + 8) = 7.0;
%     %RHS(8*n_poly-2) = 4.0;
    
    A(8*n_poly-1,8*(n_poly-1) + 3) = 1.0;
    A(8*n_poly-1,8*(n_poly-1) + 4) = 3.0;
    A(8*n_poly-1,8*(n_poly-1) + 5) = 6.0;
    A(8*n_poly-1,8*(n_poly-1) + 6) = 10.0;
    A(8*n_poly-1,8*(n_poly-1) + 7) = 15.0;
    A(8*n_poly-1,8*(n_poly-1) + 8) = 21.0;

    A(8*n_poly-0,8*(n_poly-1) + 4) = 1.0;
    A(8*n_poly-0,8*(n_poly-1) + 5) = 4.0;
    A(8*n_poly-0,8*(n_poly-1) + 6) = 10.0;
    A(8*n_poly-0,8*(n_poly-1) + 7) = 20.0;
    A(8*n_poly-0,8*(n_poly-1) + 8) = 35.0;
    
    min_snap_coeffs = A\RHS;

end

