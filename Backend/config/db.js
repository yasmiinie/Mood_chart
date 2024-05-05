const mongoose = require('mongoose');

const connection = mongoose.createConnection('mongodb://127.0.0.1:27017/chartMood').on('open', ()=>{
    console.log("Mongo Db success");}
).on("error", ()=>{
    console.log("Mongo Db error");
});

module.exports = connection;