function [TR_Matrix] = transfVP(fromVP,toVP,VP)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if fromVP == "Z"; Cols = [1,2]; end
if fromVP == "Y"; Cols = [3,4]; end
if fromVP == "A"; Cols = [5,6]; end
if fromVP == "H"; Cols = [7,8]; end

if toVP == "Z"; Rows = [1,2]; end
if toVP == "Y"; Rows = [3,4]; end
if toVP == "A"; Rows = [5,6]; end
if toVP == "H",; Rows = [7,8]; end


ZtoZ = VP;

if det(VP) == 0; YtoZ = [0,0;0,0];
else YtoZ = [VP(2,2)/det(VP), -(VP(1,2))/det(VP); ...
        -(VP(2,1))/det(VP), VP(1,1)/det(VP)];
end

if VP(2,1) == 0; AtoZ = [0,0;0,0];
else AtoZ = [VP(1,1)/VP(2,1), -(det(VP))/VP(2,1); ...
        1/VP(2,1), -(VP(2,2))/VP(2,1)];
end

if VP(2,2) == 0; HtoZ = [0,0;0,0];
else HtoZ = [det(VP)/VP(2,2), VP(1,2)/VP(2,2); ...
        -(VP(2,1))/VP(2,2), 1/VP(2,2)];
end

Any2Z = [ZtoZ, YtoZ, AtoZ, HtoZ];

if det(VP) == 0; ZtoY = [0,0;0,0];
else ZtoY = [VP(2,2)/det(VP),-(VP(1,2)/det(VP)); ...
        -(VP(2,1)/det(VP)),VP(1,1)/det(VP)];
end

YtoY = VP;

if VP(1,2) == 0; AtoY = [0,0;0,0];
else AtoY = [VP(2,2)/VP(1,2),-(det(VP)/VP(1,2)); ...
        1/VP(1,2),-(VP(1,1)/VP(1,2))];
end

if VP(1,1) == 0; HtoY = [0,0;0,0];
else HtoY = [1/VP(1,1),-(VP(1,2)/VP(1,1)); ...
        VP(2,1)/VP(1,1),det(VP)/VP(1,1)];
end

Any2Y = [ZtoY,YtoY,AtoY,HtoY];

if VP(2,1) == 0; ZtoA = [0,0;0,0];
else ZtoA = [VP(1,1)/VP(2,1),-(det(VP)/VP(2,1)); ...
        1/VP(2,1),-(VP(2,2)/VP(2,1))];
end

if VP(2,1) == 0; YtoA = [0,0;0,0];
else YtoA = [-(VP(2,2)/VP(2,1)),1/VP(2,1); ...
        -(det(VP)/VP(2,1)),VP(1,1)/VP(2,1)];
end

AtoA = VP;

if VP(2,1) == 0; HtoA = [0,0;0,0];
else HtoA = [-(det(VP)/VP(2,1)),VP(1,1)/VP(2,1); ...
        -(VP(2,2)/VP(2,1)),1/VP(2,1)];
end

Any2A = [ZtoA,YtoA,AtoA,HtoA];

if VP(2,2) == 0; ZtoH = [0,0;0,0];
else ZtoH = [det(VP)/VP(2,2),VP(1,2)/VP(2,2); ...
        -(VP(2,1)/VP(2,2)),1/VP(2,2)];
end

if VP(1,1) == 0; YtoH = [0,0;0,0];
else YtoH = [1/VP(1,1),-(VP(1,2)/VP(1,1)); ...
        VP(2,1)/VP(1,1),-(det(VP)/VP(1,1))];
end

if VP(2,2) == 0; AtoH = [0,0;0,0];
else AtoH = [VP(1,2)/VP(2,2),det(VP)/VP(2,2); ...
        1/VP(2,2),-(VP(2,1)/VP(2,2))];
end

HtoH = VP;

Any2H = [ZtoH,YtoH,AtoH,HtoH];

TR_tbl = [Any2Z;Any2Y;Any2A;Any2H];

TR_Matrix = [TR_tbl(Rows(1),Cols(1)), TR_tbl(Rows(1),Cols(2)); ...
    TR_tbl(Rows(2),Cols(1)), TR_tbl(Rows(2),Cols(2))];
if [TR_Matrix] == 0;
    TR_Matrix = ['existiert nicht'];
end
end

