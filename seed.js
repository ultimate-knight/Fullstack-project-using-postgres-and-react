require("dotenv").config()
const {Pool}=require("pg")
const fs=require("fs")


const pool=new Pool({
    user:process.env.DB_USER,
    database:process.env.DB_NAME,
    password:process.env.DB_PASSWORD,
    host:process.env.DB_HOST,
    port:process.env.DB_PORT
})

let client

const rawdata=fs.readFileSync("seed-data.json","utf-8")
const parser=JSON.parse(rawdata)


async function dbSeed(){
  try {
    client=await pool.connect()

    await client.query("DELETE FROM fitness_tracker")
    console.log("data deleted from database which is existing ones")

    const Insertquery=`insert into fitness_tracker(exercise_name,sets,date_added,created_at,rep,weight,notes) values($1,$2,$3,$4,$5,$6,$7)`

    for(let i=0;i<parser.length;i++){
      let parsers=parser[i]
      
      await client.query(Insertquery,[
        parsers.exercise_name,
        parsers.sets,
        parsers.date_added,
        parsers.created_at,
        parsers.rep,
        parsers.weight,
        parsers.notes || null
      ])
      console.log(`Data added ${i+1}/${parser.length}`)

      
    }
    console.log("Data is seeded successfully")
  } catch (error) {
    console.error("error",error.message)
  }finally{
    await client.release()
  }


}

dbSeed()