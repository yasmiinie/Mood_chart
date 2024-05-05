
const mongoose = require('mongoose');
const db = require('../config/db');
const bycrypt = require('bcrypt');

const { Schema } = mongoose;

const userSchema = new Schema({
    email: { type : String , required: true , unique:  true, lowercase: true},
    password:  {type : String, required:true}
})

userSchema.pre("save" , async function () {
    try {
        var user = this ;
        const salt = await(bycrypt.genSalt(5));
        hashpass = await bycrypt.hash(user.password ,salt);
        user.password = hashpass;
    } catch (error) {
        throw error ;
    }
    
})

const UserModel = db.model('user' , userSchema);

module.exports = UserModel ;
