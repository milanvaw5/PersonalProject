// Intro


// Forwarding tidal messages from supercollider to hydra
// Run the play2 function in SuperCollider. This file forwards all messages.
// Received from tidal in SuperCollider to an additional port (3333),(6666) or (9999)

// Port listens to the messages
msg.setPort(6666)

// Function to convert tidal messages from an array to an object
parseTidal = (args) => {
  obj = {}
  for(var i = 0; i < args.length; i+=2){
    obj[args[i]] = args[i+1]
  }
  return obj
}

// Receive messages from supercollider in hydra. '/play2' corresponds to the
// address of the OSC message
msg.on('/play2', (args) => {
 tidal = parseTidal(args)
 console.log(tidal)
})



// Result part 1
blend = 1
value = 0
speed = 0.3
red =0
green =0
blue =0
// Receive args from SuperCollider in hydra.
// Tidal sends the OSC message before the sound plays so it waits to change the visuals
msg.on('/play2', (args) => {

 var tidal = parseTidal(args)

  setTimeout(() => {

     if(tidal.s === "techno"){
         blend = 1
         red = 0.3
         green = 14
         blue = 0.4
         value = 4
         speed=0.3
     } else if (tidal.s === "feelfx"){
         blend = 2
         value = 2
         red= 0.1
         green = 0.1
         blue = 1.4
         speed=5
     }

  }, tidal.delta * 1000)
})

//Noise effect's speed is determend by the playing sound
//Color switches by instrument
//Scale is determend by the playing sound
//Blend determend by the playing sound
noise(7,()=>speed,4).rotate(1.9).color(()=>red,()=>green,()=>blue).scale(()=>value).repeat(()=>blend,()=>blend).out()





// Result part 2

freq = 1
numSides = 1
r = -1
g = 1
b = -5

msg.on('/play2', (args) => {

 var tidal = parseTidal(args)

  setTimeout(() => {

     if(tidal.s === "ownsynths"){
         freq = 5
     } else if (tidal.s === "linnhats"){
       numSides = numSides +1
       if(numSides == 20) {
         numSides = 2
       }
     } else if (tidal.s === "house"){
       r = -1
       g = 1
       b = -5
     } else {
       r = -0.1
       g = -0.6
       b = -1.8
       freq = 10
     }
  }, (tidal.delta - tidal.latency) * 1000)
})

//number of corners = freq, color changes on sound
//horizontal number of repeat is one by one selected from the array
//verticle repeat is counted up by linnhats sound and reset every 20 cycles
shape(()=> freq)
  .color(()=>r,()=>g,()=>b)
  .repeat([10, 50, 2, 3, 5], ()=>numSides)
  .out()


// the global speed can be changed with bpm()
//bpm(128) doesn't always work
