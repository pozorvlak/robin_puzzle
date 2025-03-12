set of int: COORD = 1..6;
set of int: VALUE = 1..36;

array[COORD,COORD] of var VALUE: v;

include "alldifferent.mzn";

constraint alldifferent(v);

% replace divisions with multiplications by variables
% divisions involving only two terms
array[1..2] of var VALUE: k;
constraint v[1,5] = k[1] * v[1,6];
constraint v[2,1] = k[2] * v[3,1];

% divisions involving three terms
array[1..2] of var 1..(36 * 35): j;
constraint v[3,3] * v[3,5] = j[1] * v[3,4];
constraint v[2,4] * v[4,4] = j[2] * v[3,4];

constraint v[1,4] = 9;
constraint v[3,3] = 10;
constraint v[4,2] = 20;
constraint v[4,3] = 29;

% constraint v[1,1] - v[1,2] - v[1,3] * v[1,4] - v[1,5] / v[1,6] = -70;
constraint v[1,1] - v[1,2] - v[1,3] * v[1,4] - k[1] = -70;
constraint v[2,1] + v[2,2] * v[2,3] + v[2,4] - v[2,5] - v[2,6] = 333;
% constraint v[3,1] - v[3,2] - v[3,3] / v[3,4] * v[3,5] - v[3,6] = -187;
constraint v[3,1] - v[3,2] - j[1] - v[3,6] = -187;
constraint v[4,1] - v[4,2] + v[4,3] - v[4,4] - v[4,5] * v[4,6] = -134;
constraint v[5,1] - v[5,2] - v[5,3] + v[5,4] + v[5,5] - v[5,6] = 3;
constraint v[6,1] * v[6,2] + v[6,3] + v[6,4] - v[6,5] - v[6,6] = 790;

% constraint v[1,1] - v[2,1] / v[3,1] - v[4,1] + v[5,1] * v[6,1] = 1170;
constraint v[1,1] - k[2] - v[4,1] + v[5,1] * v[6,1] = 1170;
constraint v[1,2] + v[2,2] + v[3,2] + v[4,2] + v[5,2] - v[6,2] = 84;
constraint v[1,3] - v[2,3] + v[3,3] + v[4,3] - v[5,3] + v[6,3] = 21;
% constraint v[1,4] - v[2,4] / v[3,4] * v[4,4] - v[5,4] - v[6,4] = -180;
constraint v[1,4] - j[2] - v[5,4] - v[6,4] = -180;
constraint v[1,5] + v[2,5] + v[3,5] + v[4,5] - v[5,5] - v[6,5] = 71;
constraint v[1,6] * v[2,6] + v[3,6] + v[4,6] - v[5,6] - v[6,6] = 389;

solve :: int_search(v, dom_w_deg, indomain_split) satisfy;