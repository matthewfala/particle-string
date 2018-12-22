  
        ////////////////////////////////////////////
        //                                        //
        //                GLOBAL                  //
        //  Component of Physics Chain Simulation //
        //                                        //
        ////////////////////////////////////////////
        
// global measurements
float pixelspermeter = 300;
float scrWidth = 8; // meters
float scrHeight = 5; // meters
float dt = 0.01;
float t = 0;

// chain
particle[] chain = new particle[30];

// constants
float stringLen = scrWidth /4;            // dist between particles
float relaxDist = stringLen / chain.length; // lenght of chain
float KString = 5;
float KAir = .04;
float KAir2 = .004;


// particle assets
particle[] neighborlist1 = new particle[1];
particle[] neighborlist2 = new particle[2];