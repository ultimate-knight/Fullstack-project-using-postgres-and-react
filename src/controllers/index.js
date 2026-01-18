const userServices = require("../services/index.js");

class userController {
  async addingData(req, res) {
    try {
      const repo = new userServices();
      const data1 = await repo.addData(req.body);

      if (!data1) {
        return res.status(401).json({ Message: "Invalid fields" });
      }
      res
        .status(201)
        .json({ Message: "data created successfully", data: data1 });
    } catch (error) {
      console.error("error", error.message);
      res.status(500).json({ error: error.message });
    }
  }

  async gettingData(req, res) {
    try {
      const repo = new userServices();
      const data2 = await repo.getData(req.query);

      if (!data2) {
        return res.status(401).json({ Message: "Message has error" });
      }

      res
        .status(200)
        .json({ Message: "data fetched successfully", data: data2 });
    } catch (error) {
      console.error("error", error.message);
      res.status(500).json({ error: error.message });
    }
  }

  async gettingDatabyId(req, res) {
    try {
      const repo = new userServices();
      const data3 = await repo.getDatabyId(req.params.id);

      if (!data3) {
        return res.status(401).json({ Message: "Message has error" });
      }

      res
        .status(200)
        .json({ Message: "data fetched successfully by id", data: data3 });
    } catch (error) {
      console.error("error", error.message);
      res.status(500).json({ error: error.message });
    }
  }

  async gettingDatabyUpdate(req, res) {
    try {
      const repo = new userServices();
      const data4 = await repo.getDatabyUpdate(
        req.body.exercise_name,
        req.body.sets,
        req.params.id,
      );

      if (data4.length === 0) {
        return res
          .status(404)
          .json({ Message: "No record found with this ID" });
      }

      res
        .status(200)
        .json({ Message: "data updated successfully", data: data4 });
    } catch (error) {
      console.error("error", error.message);
      res.status(500).json({ error: error.message });
    }
  }

  async deletingData(req, res) {
    try {
      const repo = new userServices();
      const data4 = await repo.getDatabyDelete(req.params.id);

      if (!data4) {
        return res.status(401).json({ Message: "Message has error" });
      }

      res
        .status(200)
        .json({ Message: "data deleted successfully", data: data4 });
    } catch (error) {
      console.error("error", error.message);
      res.status(500).json({ error: error.message });
    }
  }
}

module.exports = userController;
