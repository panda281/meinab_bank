const middleware = require('../middleware/authenticateToken').authenticateToken
const express = require("express");
const router = express.Router();
const p = require("../index");
const pool = p.createconn;
const axios = require('axios')
const jsonc = require ('jsonc');
let savedOTPS = {

};

router.post("/order",middleware, async (req, res) => {
    const connection = await pool.getConnection((err, conn) => {
      if (err) {
        res.status(500)
        res.json(err);
      }
    });
    try {
      const amount = req.body.amount;
      const receiver = req.body.receiver;
      const sender = req.account_no;
  
     
      const result = await connection.query(
        "call transaction(?,?,?);",
        [amount, sender, receiver]
      );
    //   res.json(result[0][0][0]);
      let phonenumber = req.customer_phone_no;
      let digits = '0123456789';
      let limit = 5;
      let otp = ''
      for (let i = 0; i < limit; i++) {
          otp += digits[Math.floor(Math.random() * 10)];
      }

      axios.post("https://sms.yegara.com/api/send",{
        token: "d29d4d2-725c921-8-36d11f-9f27250-40-e06e",
        to: phonenumber,
        message: otp,
        template_id : "otp"
    }).then((response)=>{
        if(jsonc.parse(jsonc.stringify(response)).data.status=="success")
        {
            savedOTPS[phonenumber] = otp;
            
        }
        setTimeout(
            () => {
                delete savedOTPS[phonenumber];
            }, 60000
        )
      
            res.json({
                phonenumber: phonenumber,
                order_id: result[0][0][0].order_id
            })
        
    })

    } catch (err) {
        res.status(400)
        res.json(err);
    } finally {
      connection.release();
    }
    // const x  = req.body.account_no;
    // const y = req.body.customer_phone_no
   
  

  });

  router.post("/resend_OTP",middleware, async (req, res) => {
    const connection = await pool.getConnection((err, conn) => {
      if (err) {
        res.status(500)
        res.json(err);
      }
    });
    try {
      // const amount = req.body.amount;
      // const receiver = req.body.receiver;
      // const sender = req.account_no;
  
     
      // const result = await connection.query(
      //   "call transaction(?,?,?);",
      //   [amount, sender, receiver]
      // );
    //   res.json(result[0][0][0]);
      let phonenumber = req.customer_phone_no;
      let digits = '0123456789';
      let limit = 5;
      let otp = ''
      for (let i = 0; i < limit; i++) {
          otp += digits[Math.floor(Math.random() * 10)];
      }

      axios.post("https://sms.yegara.com/api/send",{
        token: "d29d4d2-725c921-8-36d11f-9f27250-40-e06e",
        to: phonenumber,
        message: otp,
        template_id : "otp"
    }).then((response)=>{
        if(jsonc.parse(jsonc.stringify(response)).data.status=="success")
        {
            savedOTPS[phonenumber] = otp;
            
        }
        setTimeout(
            () => {
                delete savedOTPS[phonenumber];
            }, 60000
        )
      
            res.json(response.data.status)
        
    })

    } catch (err) {
        res.status(400)
        res.json(err);
    } finally {
      connection.release();
    }
    // const x  = req.body.account_no;
    // const y = req.body.customer_phone_no
   
  

  });


  router.post('/verify', middleware, async (req, res) => {
    let otprecived = req.body.otp;
    let phonenumber = req.customer_phone_no;
    if (savedOTPS[phonenumber] == otprecived) {
       
        delete savedOTPS[phonenumber];
        // res.send("Verfied");
        const order_id = req.body.order_id;
        const connection = await pool.getConnection((err, conn) => {
            if (err) {
              res.status(500)
              res.json(err);
            }
          });
        try{
            const result = await connection.query(
                "call transfer_order(?);",
                [order_id]
              );
              res.json(result[0][0][0])
        }
        catch (err) {
            res.status(401)
            res.json(err);
        } finally {
          connection.release();
        }



    }
    else {
        res.status(500).send("Invalid OTP")
    }
})


  module.exports = router;