const express = require('express')
const User = require('../models/user.model')
const router = express.Router()
const clients = require('../models/client.model')
const { response } = require('express')
let channels = []


router.post('/signup',(req,res)=>{
    User.findOne({mail:req.body.mail},(err,user)=>{
        if(err){
            console.log(err)
            res.json(err)
        }else{
            if(user==null){
                const user = User({
                    email:req.body.mail,
                    password:req.body.password
                })
                user.save()
                .then((err)=>{
                    if(err){
                        console.log(err)
                        res.json(err)
                    }else{
                        console.log(user)
                        res.json(user)
                    }
                    
                })
            }else{

            res.json({
                message:'email is not avilable'
            })   
            }
        }
    })
    
})

router.post('/signin',(req,res)=>{
    User.findOne({mail:req.body.mail,password:req.body.password},(err,user)=>{
        if(err){
            console.log(err)
            res.json(err)
        }else{
            res.json(user)   
        }
    })
})
router.post('/insertdata',async(req,res)=>{
    const client = await new clients ({
    username : req.body.username,
    email : req.body.email,
    phoneNo : req.body.phoneNo,
    adresse : req.body.adresse,
}).save()
res.json({"message": "inserted sucessfully"})
})
router.get('/getdata', async(req,res,next)=>{
    await clients.find()
    .then(result=>{
        res.status(200).json({
            clientData : result
        })
    })
})
router.delete('/deletedata/:id', async (req,res)=>{
    const id  = req.params.id
    const del =  await clients.findByIdAndRemove(id)
    res.json({"delete" : del})
})
module.exports = router