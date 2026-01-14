const express=require("express")
const {connectdB}=require("./src/db/fitness_tracker")

const app=express()

PORT=8901

app.get("/",(req,res)=>{
    res.send("hello world")
})


connectdB()

app.listen(PORT,()=>{
    console.log(`Server is running on port ${PORT}`)
})



