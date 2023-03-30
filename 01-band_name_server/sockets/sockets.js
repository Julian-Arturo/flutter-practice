const {io} = require("../index");
const Bands = require("../models/bands");
const Band = require("../models/band");

const bands = new Bands();

bands.addBand(new Band("Queeen"));
bands.addBand(new Band("Morat"));
bands.addBand(new Band("Bon Jovi"));
bands.addBand(new Band("Metalica"));

console.log(bands);

//Mensajes de Sockes
io.on('connection', client => {
  console.log("Cliente conectado")
     
  client.emit("active-bands", bands.getBands()); 

  client.on('disconnect', () => {
     console.log("Cliente desconectado")
   });

   client.on("mensaje", (payload)=> {
    console.log("Mensaje ", payload)
     io.emit("mensaje", {admin: "Nuevo mensaje"});


   });
   client.on("vote-band", (payload)=> {
    bands.voteBand(payload.id);
    io.emit("active-bands", bands.getBands()); 

   }) 

   client.on("add-band", (payload)=>{
     const newBand =  new Band(payload.name);
     bands.addBand(newBand);
     io.emit("active-bands", bands.getBands()); 

   })

   client.on("delete-band", (payload)=>{
     bands.deleteBands(payload.id);
     io.emit("active-bands", bands.getBands()); 

   })
  //  client.on("emitir-mensaje", (data)=>{
  //   console.log(data)
  //   client.broadcast.emit("nuevo-mensaje", data);
  //  })
});