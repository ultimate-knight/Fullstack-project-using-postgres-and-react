const { client } = require("../db/fitness_tracker");

class userRepository {
  async Insertdata(data) {
    try {
        const {
        exercise_name,
        sets,
        date_added,
        created_at,
        rep,
        weight,
        notes,
        }=data
      const insertquery =
        "insert into fitness_tracker(exercise_name,sets,date_added,rep,weight,notes,created_at) values($1,$2,$3,$4,$5,$6,$7) returning *";

      const result = await client.query(insertquery, [
        exercise_name,
        sets,
        date_added,
        rep,
        weight,
        notes || null,
        created_at
      ]);

    return result.rows[0]
    } catch (error) {
      throw error
    }
  }

  async getAlldata(exercise_name){
     try {

        if(!exercise_name){
            const result=await client.query("SELECT * FROM fitness_tracker")
            return result.rows
        }

        const result=await client.query("SELECT * FROM fitness_tracker WHERE exercise_name ILIKE $1",[exercise_name])

        return result.rows

        

    } catch (error) {
        throw error
    }
  }

  async databyId(id){
   try {
       const insertquery=`select * from fitness_tracker where id=$1`

     const result=await client.query(insertquery,[id])

     return result.rows[0]

    } catch (error) {
        throw error
    }
  }

  async databyUpdate(exercise_name,sets,id){
     try {

       const insertquery=`update fitness_tracker set exercise_name=$1,sets=$2 where id=$3 RETURNING *`

     const result=await client.query(insertquery,[exercise_name,sets,id])
     
     console.log("Update result:", result.rows)

     return result.rows[0]

    } catch (error) {
        throw error
    }
  }

  async databyDelete(id){
     try {

       const insertquery="delete from fitness_tracker where id=$1"

     const result=await client.query(insertquery,[id])

     return result.rowCount

    } catch (error) {
        res.status(500).json({Message:error.message})
    }
  }


}


module.exports=userRepository
