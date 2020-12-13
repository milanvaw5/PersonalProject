// Function I used in the final result
// This code forwards messages from tidal to an additional port via OSC.
// From https://github.com/tado/ofxTidalCycles

var addr = NetAddr.new("127.0.0.1", 6666); //choose port to listen on
OSCFunc({ |msg, time, tidalAddr| // send message time and tidalAddr
	var latency = time - Main.elapsedTime; //time of creating sound
	msg = msg ++ ["time", time, "latency", latency];
	msg.postln;
	addr.sendBundle(latency, msg)
}, '/play2').fix;


//functions I used but not in the final result
(
n  = NetAddr("127.0.0.1",3333);

~dirt.receiveAction = { |e|
  if ( (e.at(\s)==\bd), //listen for specific sound/event
     { n.sendMsg("/bd", e.at(\cycle)); }, {}
  );
};
)

(
n = NetAddr("127.0.0.1", 6666); // or 9999 to run 2 at the same time
~dirt.startSendRMS;
OSCFunc({ |msg| //listen for message
    defer {
        n.sendMsg("/rms", msg);
    }
}, "/rms");
)
