# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
UserFriend.destroy_all
Project.destroy_all
Picture.destroy_all
Comment.destroy_all

u1 = User.create(name:"Geoffrey", username:"StupendousOne", bio:"A bio", img:"")
u2 = User.create(name:"Corey", username:"Bid Dawg", bio:"A better bio", img:"")

p1 = Project.create(name:"Mod1", desc:"A desc", user_id:u1.id)
p2 = Project.create(name:"Mod2", desc:"Another desc", user_id:u2.id)
p3 = Project.create(name:"Mod3", desc:"yet Another desc", user_id:u1.id)
p4 = Project.create(name:"Mod4", desc:"last desc", user_id:u2.id)

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

UserFriend.create(user_id:u1.id, friend_id:u2.id)
UserFriend.create(user_id:u2.id, friend_id:u1.id)