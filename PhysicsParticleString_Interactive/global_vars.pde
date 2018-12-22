  
        ////////////////////////////////////////////
        //                                        //
        //                GLOBAL                  //
        //  Component of Physics Chain Simulation //
        //                                        //
        ////////////////////////////////////////////
        
// global measurements
float pixelspermeter = 10;
float scrWidth = 200; // meters
float scrHeight = 120; // meters
float dt = 0.01;

// constants
float relaxDist; // dist between particles
float stringLen; // lenght of chain
float KString = 5;
float KAir = .1;

// chain
particle[] chain = new particle[10];

// particle assets
particle[] neighborlist1 = new particle[1];
particle[] neighborlist2 = new particle[2];