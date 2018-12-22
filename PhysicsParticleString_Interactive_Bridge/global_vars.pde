  
        ////////////////////////////////////////////
        //                                        //
        //                GLOBAL                  //
        //  Component of Physics Chain Simulation //
        //                                        //
        ////////////////////////////////////////////
        
// images
PImage img;

// global measurements
float pixelspermeter = 300;
float scrWidth = 8; // meters
float scrHeight = 5; // meters
float dt = 0.001;
float t = 0;

// chain
particle[] chain = new particle[20];

// grab
float threshold = 1;

// constants
float stringLen = scrHeight /8;            // dist between particles
float relaxDist = stringLen / chain.length; // lenght of chain
float KString = 50;
float KAir = .04;
float KAir2 = .004;


// particle assets
particle[] neighborlist1 = new particle[1];
particle[] neighborlist2 = new particle[2];