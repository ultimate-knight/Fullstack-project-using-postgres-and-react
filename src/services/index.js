const userRepository = require("../repositories/index.js");

class userServices {
  async addData(arg) {
    try {
      const repo = new userRepository();
      const data = await repo.Insertdata(arg);
      console.log("data", data);

      return data;
    } catch (error) {
      console.error("Error fetching users:", error);
      throw error;
    }
  }

  async getData(arg) {
    try {
      const repo = new userRepository();
      const data = await repo.getAlldata(arg.exercise_name);
      console.log("data", data);
      return data;
    } catch (error) {
      console.error("Error fetching users:", error);
      throw error;
    }
  }

  async getDatabyId(args) {
    try {
      const repo = new userRepository();
      const data = await repo.databyId(args);
      console.log("data", data);
      return data;
    } catch (error) {
      console.error("Error fetching users:", error);
      throw error;
    }
  }

  async getDatabyUpdate(arg1,arg2,arg3){
    try {
        const repo = new userRepository();
        const data= await repo.databyUpdate(arg1,arg2,arg3);
        console.log("data",data);
        return data;
    } catch (error) {
         console.error("Error fetching users:", error);
      throw error;
    }
  }

   async getDatabyDelete(arg){
    try {
        const repo = new userRepository();
        const data=await repo.databyDelete(arg)
        console.log("data",data);
        return data;
    } catch (error) {
         console.error("Error fetching users:", error);
      throw error;
    }
  }
}

module.exports=userServices