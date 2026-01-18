const express=require("express")
const {connectdB}=require("./src/db/fitness_tracker")
const workoutRoutes=require("./src/routes")

const app=express()

PORT=3000

app.use(express.json())
app.use(express.urlencoded({extended:true}))

app.get("/",(req,res)=>{
    res.send("hello world")
})

app.use("/api",workoutRoutes)


connectdB()

app.listen(PORT,()=>{
    console.log(`Server is running on port ${PORT}`)
})



