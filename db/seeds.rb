# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'stream-chat'

User.destroy_all
UserFriend.destroy_all
Project.destroy_all
Picture.destroy_all
Comment.destroy_all

client = StreamChat::Client.new(api_key='5cx2ee96rmr9', api_secret='6r7xzu64u8pjapbxms47bt9qyr8wq8nmesma4sg33jmjfgfqxbj6hy49gv9y6jup')

u1 = User.create(name:"Geoffrey", 
    username:"StupendousOne", 
    bio:"A bio", 
    img:"https://scontent.faus1-1.fna.fbcdn.net/v/t31.0-8/18922546_10211466020541206_2128325124362336323_o.jpg?_nc_cat=111&_nc_sid=cdbe9c&_nc_ohc=st81JiuXpe4AX-3Eacn&_nc_ht=scontent.faus1-1.fna&oh=3f916555b98be15bbb4eb34b245df51c&oe=5F0ABBC3", 
    banner_img:"https://beinglol.com/media/facebook-cover/Funny-Science-Facebook-Cover-315.jpg",
    password: "123",
    chat_token: client.create_token('Geoffrey'))
u2 = User.create(name:"Cory", 
username:"Big Dawg", 
bio:"A better bio",
img:"https://www.dailymoss.com/wp-content/uploads/2019/08/funny-profile-pic26.jpg", 
banner_img:"https://lh3.googleusercontent.com/proxy/vSD_Jh3IvAz8aEWjOflUJESQpo8nht_bxwjWIIT6a8cFA90A3zM80FBsChkiv6SbOa-T9Xz7yWZv26FR82OtzBpJWp7w0ppTrHN9XWoCbsyN86GcKYSANHXlIENgnLzYQ0LTg_HFgfos6ctH",
password:"456",
chat_token: client.create_token('Cory')
)

u2 = User.create(name:"Jimbo", 
username:"JimboJambo", 
bio:"A better bio",
img:"https://www.dailymoss.com/wp-content/uploads/2019/08/funny-profile-pic26.jpg", 
banner_img:"https://lh3.googleusercontent.com/proxy/vSD_Jh3IvAz8aEWjOflUJESQpo8nht_bxwjWIIT6a8cFA90A3zM80FBsChkiv6SbOa-T9Xz7yWZv26FR82OtzBpJWp7w0ppTrHN9XWoCbsyN86GcKYSANHXlIENgnLzYQ0LTg_HFgfos6ctH",
password:"456"
)

p1 = Project.create(name:"Mod1", desc:"A desc", user_id:u1.id, img:"https://www.eschoolnews.com/files/2020/01/coding-science.jpg")
p2 = Project.create(name:"Mod2", desc:"Another desc", user_id:u2.id, img:"https://www.eschoolnews.com/files/2020/01/coding-science.jpg")
p3 = Project.create(name:"Mod3", desc:"yet Another desc", user_id:u1.id, img:"https://www.eschoolnews.com/files/2020/01/coding-science.jpg")
p4 = Project.create(name:"Mod4", desc:"last desc", user_id:u2.id, img:"https://www.eschoolnews.com/files/2020/01/coding-science.jpg")

Comment.create(comment:"A comment", user_id:u1.id, project_id:p1.id)
Comment.create(comment:"A comment", user_id:u2.id, project_id:p1.id) 
Comment.create(comment:"A comment", user_id:u1.id, project_id:p2.id) 
Comment.create(comment:"A comment", user_id:u2.id, project_id:p2.id) 
Comment.create(comment:"A comment", user_id:u1.id, project_id:p3.id) 
Comment.create(comment:"A comment", user_id:u2.id, project_id:p3.id) 
Comment.create(comment:"A comment", user_id:u1.id, project_id:p4.id) 
Comment.create(comment:"A comment", user_id:u2.id, project_id:p4.id) 

Picture.create(img:"img.html", project_id:p1.id)
Picture.create(img:"img2.html", project_id:p2.id)
Picture.create(img:"img3.html", project_id:p3.id)
Picture.create(img:"img4.html", project_id:p4.id)
Picture.create(img:"img5.html", project_id:p1.id)
Picture.create(img:"img6.html", project_id:p2.id)
Picture.create(img:"img7.html", project_id:p3.id)
Picture.create(img:"img8.html", project_id:p4.id)

UserFriend.create(user_id:u1.id, friend_id:u2.id, accepted: true)
UserFriend.create(user_id:u2.id, friend_id:u1.id, accepted: true)