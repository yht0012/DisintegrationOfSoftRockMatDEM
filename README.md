**Storage directory of code used in simulation is "MatDEM3.20(2021a runtime)".**

## About software: **MatDEM**

MatDEM, a general discrete element software for rock-soil body developed by Nanjing University with fully independent intellectual property rights, uses the original matrix computing of discrete element method to realize the fast discrete element simulation of millions of particles and complete the large-scale three-dimensional numerical simulation of discrete element in a few hours. Based on the original theory, the software has realized the automatic modeling of discrete element materials, as well as the energy conservation calculation of discrete element system, etc, which has made a major breakthrough. The software combines pre-processing, computing, post-processing, and powerful secondary development to provide a complete functional interface and an efficient computing engine that can complete complex multi-field coupling simulations through secondary development.

MatDEM is written by Matlab language,so in theory,as long as your operating system which can run Matlab can run MatDEM,including Windows,Linux,Unix and Mac OS,etc.Currently, the vast majority of MatDEM users use Windows systems, so only the Windows version of MatDEM is compiled and maintained, and if required, additional versions for other systems will be added in the future.

Secondary development of MatDEM based on Matlab language,which need to install Matlab runtime environment,MatDEM_v3.20 and above versions are required to install the R2021A version.MATLAB runtime environment is free which can be downloaded in Matlab official website and installation. If you want to download the latest version of MatDEM, please to the website: http://matdem.com.

## **Running of MatDEM software**

1. Please download folder named "MatDEM3.20(2021a runtime)", and double-click the application named "MatDEM.exe"
1. After MatDEM software starts running, go to the "main program", you can double-click to open the "code" in the working folder on its right
1. Double-click the code (named step 1~3) and click the "Run commands" below the code bar
    * These three codes need to be run in order
1. The code "step 1" is accumulation modeling, that is, to establish a geological accumulation body through gravity deposition and compaction
1. The code "step 2" is model cutting and material setting
1. The code "step 3" is load and calculation
1. After the calculation, the post-processing module can be used to output the results

**Notes:The program cannot be terminated after starting the iteration. If you need to force the termination, you can end the task with Matdem in the task manager.**
