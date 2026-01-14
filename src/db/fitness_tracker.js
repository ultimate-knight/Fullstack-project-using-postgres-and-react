require("dotenv").config();
const {Client}=require("pg")

const client=new Client({
    user:process.env.DB_USER,
    database:process.env.DB_NAME,
    password:process.env.DB_PASSWORD,
    host:process.env.DB_HOST,
    port:process.env.DB_PORT
})

async function connectdB(){
    try {
        await client.connect()
        console.log("Database connected successfully")
    } catch (error) {
        console.error("Database connection failed",error)
    }
}

module.exports={connectdB,client}

