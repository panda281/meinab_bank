const express = require("express");
const router = express.Router();
const p = require("../index");
const pool = p.createconn;
const jwt = require('jsonwebtoken');


router.get("/", async (req, res) => {
  
    res.send("test");
});
router.get("/login", async (req, res) => {
    const connection = await pool.getConnection((err, conn) => {
      if (err) {
        res.status(500)
        res.json(err);
      }
    });
    try {
      const username = req.query.username;
      const password = req.query.password;
  
     
      const result = await connection.query(
        "call authentication(?,?);",
        [username, password]
      );
    //   res.json(result[0][0][0]);
       const GeneratedToken = jwt.sign(result[0][0][0], 'e1e2cd540a72f8ffdd5590ce70e52710ac0f79db0d1b6cd742c33db20507d17ff57bfaeffd7421ec260f2852a0d39e8dc13b0c39f53a5894209fa96929389a3a',{ expiresIn: '15m' });
       let final = {Authorization: 'Bearer '+ GeneratedToken}
       res.json(final)
    } catch (err) {
        res.status(401)
        res.json(err);
    } finally {
      connection.release();
    }
  });


  module.exports = router;