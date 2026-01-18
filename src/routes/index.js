const express=require("express")
const {client}=require("../db/fitness_tracker")
const userController=require("../controllers/index.js")

const router=express.Router()

const repo=new userController;
router.post("/workouts",repo.addingData)



router.get("/workouts",repo.gettingData)


router.get("/workouts/:id",repo.gettingDatabyId)



router.put("/workouts/:id",repo.gettingDatabyUpdate)



router.delete("/workouts/:id",repo.deletingData)




module.exports=router