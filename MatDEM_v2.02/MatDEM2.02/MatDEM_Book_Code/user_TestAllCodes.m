%run the code to test all the examples
clear
steps=[0,1];
%step0: test function
k1=f.run('funtest.m',1,2,3);%run one function
d1=f.run('testFun.m',1,2,3);%run function with internal functions
[d2,k2]=f.run('testFun.m',1,2,3);%run function with two output parameters
%step1: test 2D simple examples
MatDEMfile('user_3AxialNew1.m');
MatDEMfile('user_3AxialNew2.m');
MatDEMfile('user_3AxialNew3.m');
MatDEMfile('user_BoxCrash1.m');
MatDEMfile('user_BoxCrash2.m');
MatDEMfile('user_BoxCrash3.m');
MatDEMfile('user_BoxCuTestNew1and2.m');
MatDEMfile('user_BoxCuTestNew3.m');
MatDEMfile('user_BoxLayer1.m');
MatDEMfile('user_BoxLayer2.m');
MatDEMfile('user_BoxMatTraining.m');
MatDEMfile('user_BoxMixMat1.m');
MatDEMfile('user_BoxMixMat2.m');
MatDEMfile('user_BoxMixMat3.m');
MatDEMfile('user_BoxModel1.m');
MatDEMfile('user_BoxModel2.m');
MatDEMfile('user_BoxModel3.m');
MatDEMfile('user_BoxPile1.m');
MatDEMfile('user_BoxPile2.m');
MatDEMfile('user_BoxPile3.m');
MatDEMfile('user_BoxTunnel1.m');
MatDEMfile('user_BoxTunnel2.m');
MatDEMfile('user_BoxTunnel3.m');
MatDEMfile('user_BoxTunnelNew1.m');
MatDEMfile('user_BoxTunnelNew2.m');
MatDEMfile('user_BoxTunnelNew3.m');
MatDEMfile('user_BoxUniaxialTest.m');
MatDEMfile('user_BoxWord1.m');
MatDEMfile('user_BoxWord2.m');
MatDEMfile('user_BoxWord3.m');

%step2: test 3D complex examples
MatDEMfile('user_Box3DJointStress1.m');
MatDEMfile('user_Box3DJointStress2.m');
MatDEMfile('user_Box3DJointStress3.m');
MatDEMfile('user_BoxShear0.m');
MatDEMfile('user_BoxShear1.m');
MatDEMfile('user_BoxShear2.m');
MatDEMfile('user_BoxShear3.m');
MatDEMfile('user_BoxShearTorsional3.m');
MatDEMfile('user_BoxSlope1.m');
MatDEMfile('user_BoxSlope2.m');
MatDEMfile('user_BoxSlope3.m');
MatDEMfile('user_BoxSlopeNet1.m');
MatDEMfile('user_BoxSlopeNet2.m');
MatDEMfile('user_BoxSlopeNet3.m');
MatDEMfile('user_BoxStruct0.m');
MatDEMfile('user_BoxStruct1.m');
MatDEMfile('user_BoxStruct2.m');
MatDEMfile('user_BoxStruct3.m');

%step3: test 3D complex examples
MatDEMfile('user_L2Earthquake1.m');
MatDEMfile('user_L2Earthquake2.m');
MatDEMfile('user_L2Earthquake3.m');
MatDEMfile('user_L2LandSubsidence1.m');
MatDEMfile('user_L2LandSubsidence2.m');
MatDEMfile('user_L2LandSubsidence3.m');
MatDEMfile('user_BoxModel1.m');
MatDEMfile('user_BoxModel2.m');
MatDEMfile('user_L2Model3Exploision.m');
MatDEMfile('user_L2SoilCrackNew1.m');
MatDEMfile('user_L2SoilCrackNew2.m');
MatDEMfile('user_L2TunnelHeat1.m');
MatDEMfile('user_L2TunnelHeat2.m');
MatDEMfile('user_Box3DSlope0.m');
MatDEMfile('user_Box3DSlope1.m');
MatDEMfile('user_Box3DSlope2.m');
MatDEMfile('user_Box3DSlope3.m');
MatDEMfile('user_makeGIF.m');
MatDEMfile('user_modelExample.m');
MatDEMfile('user_TwoBalls.m');
MatDEMfile('XYZ2Surf.m');