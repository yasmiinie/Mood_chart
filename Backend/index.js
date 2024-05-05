const app = require('./app');
const db = require('./config/db');
const UserModel = require('./models/user.model');
const port  = 3000 ;

app.listen(port, () => {
    console.log(`Server is running at http://localhost:${port}/`);
});

app.get('/', (req , res) =>{
    res.send('its working');} );