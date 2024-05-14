function [VP_Matrix] = getVP(Circuit,vp_type,Imp)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if Circuit == "lng_vp"; Rows = [1,2]; end
if Circuit == "crsw_vp"; Rows = [3,4]; end
if Circuit == "cross_vp"; Rows = [5,6]; end
if Circuit == "ltg_ideal"; Rows = [7,8]; end
if Circuit == "trfo_ideal"; Rows = [9,10]; end
if Circuit == "OP_ideal"; Rows = [11,12]; end

if vp_type == "Z"; Cols = [1,2]; end
if vp_type == "Y"; Cols = [3,4]; end
if vp_type == "A"; Cols = [5,6]; end
if vp_type == "H"; Cols = [7,8]; end

Z = Imp;

lng_vp_Z = [0,0;0,0];
lng_vp_Y = [(1/Z),-(1/Z);(1/Z),-(1/Z)];
lng_vp_A = [1,Z;0,1];
lng_vp_H = [Z,1;1,0];
lng_vp = [lng_vp_Z, lng_vp_Y, lng_vp_A, lng_vp_H];

crsw_vp_Z = [Z,-Z;Z,-Z];
crsw_vp_Y = [0,0;0,0];
crsw_vp_A = [1,0;1/Z,1];
crsw_vp_H = [0,1;1,-(1/Z)];
crsw_vp = [crsw_vp_Z, crsw_vp_Y, crsw_vp_A, crsw_vp_H];

cross_vp_Z = [0,0;0,0];
cross_vp_Y = [0,0;0,0];
cross_vp_A = [-1,0;0,-1];
cross_vp_H = [0,-1;-1,0];
cross_vp = [cross_vp_Z, cross_vp_Y, cross_vp_A, cross_vp_H];

VP_tbl = [lng_vp;crsw_vp;cross_vp];

VP_Matrix = [VP_tbl(Rows(1),Cols(1)), VP_tbl(Rows(1),Cols(2)); ...
    VP_tbl(Rows(2),Cols(1)), VP_tbl(Rows(2),Cols(2))];
if [VP_Matrix] == 0;
    VP_Matrix = ['existiert nicht'];
end
end

