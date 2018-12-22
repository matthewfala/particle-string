  
        ////////////////////////////////////////////
        //                                        //
        //                GLOBAL                  //
        //  Component of Physics Chain Simulation //
        //                                        //
        ////////////////////////////////////////////
        
// global measurements
float pixelspermeter = 100;
float scrWidth = 20; // meters
float scrHeight = 12; // meters
float dt = 0.01;

// chain
particle[] chain = new particle[20];

// constants
float stringLen = scrHeight /2;            // dist between particles
float relaxDist = stringLen / chain.length; // lenght of chain
float KString = 6;
float KAir = .04;
float KAir2 = .001;


// particle assets
particle[] neighborlist1 = new particle[1];
particle[] neighborlist2 = new particle[2];