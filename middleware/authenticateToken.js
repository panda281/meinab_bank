
const jwt = require('jsonwebtoken')
function authenticateToken(req, res, next) {
    const authHeader = req.headers['authorization']
    const token = authHeader && authHeader.split(' ')[1]
    if (token == null) return res.sendStatus(401)
  
    jwt.verify(token, 'e1e2cd540a72f8ffdd5590ce70e52710ac0f79db0d1b6cd742c33db20507d17ff57bfaeffd7421ec260f2852a0d39e8dc13b0c39f53a5894209fa96929389a3a', (err, user) => {
     
      if (err)
      {
       
        res.sendStatus(403);
        
      } 
      else{
        req.customer_phone_no = user.customer_phone_no;
        req.account_no = user.account_no
        next()
      }
     
      
      
      
      
    })
  }


  exports.authenticateToken = authenticateToken;