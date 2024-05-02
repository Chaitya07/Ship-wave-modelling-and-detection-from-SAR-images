function Ax = radonT(x, theta)
Ax = iradon(x,theta);
Ax = max(0,Ax(2:end-1,2:end-1));
