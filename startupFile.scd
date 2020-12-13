
(
s.reboot {
	// code to play the sound on an extern device
/*
Server.local.options.numOutputBusChannels = 4;    // change number of input and output channels
Server.local.options.numInputBusChannels = 4;
Server.internal.options.numOutputBusChannels = 4;
Server.internal.options.numInputBusChannels = 4;

Server.local.options.device = "Built-in Audio";    // use a specific soundcard
Server.local.options.device = "MOTU Traveler";
Server.local.options.device = "TASCAM US-122";
Server.local.options.device = "Jack Router";
Server.local.options.device = nil;                // use the system default soundcard

Server.local.options.blockSize = 128; // increase block size (default is 64)
Server.internal.options.blockSize = 128;

Server.local.options.sampleRate = 96000; // increase sampling rate (if your hardware supports it)
Server.internal.options.sampleRate = 96000;
Server.internal.options.sampleRate = nil;    // use the currently selected samplerate of the soundcard

// change the standard archive path to a custom one:
Archive.archiveDir = "~/scwork".standardizePath;

// hook up jack ports to audio channels
"SC_JACK_DEFAULT_INPUTS".setenv("system");
"SC_JACK_DEFAULT_OUTPUTS".setenv("system");

*/


	// server options
	s.options.numBuffers = 1024 * 256; // increase this if you need to load more samples
	s.options.memSize = 20192 * 32; // increase this if you get "alloc failed" messages
	s.options.numWireBufs = 64; // increase this if you get "exceeded number of interconnect buffers" messages
	s.options.maxNodes = 1024 * 32; // increase this if you are getting drop outs and the message "too many nodes"
	s.options.numOutputBusChannels = 2; // set this to your hardware output channel size, if necessary
	s.options.numInputBusChannels = 2; // set this to your hardware output channel size, if necessary
	// boot the server and start SuperDirt
s.waitForBoot {
		~dirt = SuperDirt(2, s); // two output channels, increase if you want to pan across more channels
		~dirt.loadSoundFiles;   // load samples (path containing a wildcard can be passed in)
		~dirt.loadSoundFiles("/Users/milanvanalderwerelt/Documents/2019-2020/2019/DEVELOPMENT/samples-extra/*"); //to load in more sounds
		// s.sync; // optionally: wait for samples to be read
		~dirt.start(57120, 0 ! 12);   // start listening on port 57120, create two busses each sending audio to channel 0

		// optional, needed for convenient access from sclang:
		(
			~d1 = ~dirt.orbits[0]; ~d2 = ~dirt.orbits[1]; ~d3 = ~dirt.orbits[2];
			~d4 = ~dirt.orbits[3]; ~d5 = ~dirt.orbits[4]; ~d6 = ~dirt.orbits[5];
			~d7 = ~dirt.orbits[6]; ~d8 = ~dirt.orbits[7]; ~d9 = ~dirt.orbits[8];
			~d10 = ~dirt.orbits[9]; ~d11 = ~dirt.orbits[10]; ~d12 = ~dirt.orbits[11];
		);
	};

	s.latency = 0.3; // increase this if you get "late" messages
};
);

Server.killAll() //to stop all servers

//qjackctl
