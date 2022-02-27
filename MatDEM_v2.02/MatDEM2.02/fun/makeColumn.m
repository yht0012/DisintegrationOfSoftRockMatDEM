function column=makeColumn(columnR,columnHeight,ballR,Rrate)
columnR2=columnR-ballR;
columnHeight2=columnHeight-ballR;
ballR2=ballR*Rrate;
disc=f.run('fun/makeDisc.m',columnR2,ballR2);
column=mfs.make3Dfrom2D(disc,columnHeight2,ballR2);

column.R(:)=ballR;
column.columnR=columnR;
column.columnHeight=columnHeight;
column.ballR=ballR;
end