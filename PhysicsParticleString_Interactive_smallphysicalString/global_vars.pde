  
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

// chain
particle[] chain = new particle[20];

// constants
float stringLen = scrHeight /2;            // dist between particles
float relaxDist = stringLen / chain.length; // lenght of chain
float KString = 6;
float KAir = .07;
float KAir2 = .004;


// particle assets
particle[] neighborlist1 = new particle[1];
particle[] neighborlist2 = new particle[2];