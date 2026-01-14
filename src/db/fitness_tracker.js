const {Client}=require("pg")

const client=new Client({
    user:"baqtiyaar",
    database:"fitness_tracker",
    password:"Canton@312",
    host:"localhost",
    port:5432
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