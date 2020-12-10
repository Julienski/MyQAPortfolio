#1. Брой на потребители.
Select * from users;

#2. Най-стария потребител.
Select birthDate, username
from users
order by birthDate asc limit 1;

#3. Най-младия потребител.
Select birthDate, username
from users
order by birthDate desc limit 1;

#4. Колко потребители са регистрирани с мейли от abv и gmail. И колко с различни от двата.
Select count(*) from users
where email like '%gmail.com'
union all
Select count(*) from users
where email like '%abv.bg'
union all
Select count(*) from users
where email not like 'gmail.com' and email not like '%abv.bg';

#5. Кои потребители за баннати.
Select username from users
where isBanned=1;

#6. Изкарайте всички потребители от базата като ги наредите по име в азбучен ред и дата на раждане(от най-младия към най-възрастния).
Select * from users
order by username, birthDate desc;

#7. Изкарайте всички потребители от базата, на които потребителското име започва с буквата А.
Select * from users
where username like 'A%';

#8. Изкарайте всички потребители от базата, които съдържат а username името си.
Select * from users
where username like '%A%';

#9. Изкарайте всички потребители от базата, чието име се състои от 2 имена.
Select * from users
where username REGEXP '[[a-z][[:blank:]][a-z]';

#10. Регистрирайте 1 юзър през UI-а и го забранете след това от базата.
Update users
set isBanned=0
where username='username';

#11. Брой на всички постове.
Select count(*) from posts;

#12. Брой на всички постове групирани по статуса на post-a.
Select postStatus, count(*) from posts
group by postStatus;

#13. Намерете поста/овете с най-къс caption.
Select min(caption) from posts;

#14. Покажете поста с най-дълъг caption
Select max(caption) from posts;

#15. Кой потребител има най-много постове. Използвайте join заявка.
Select u.username, count(*) as posts
from users u
left join posts p
on u.id=p.userid
group by u.username
order by posts desc limit 1;

#16. Кои потребители имат най-малко постове. Използвайте join заявка.
Select u.username, count(*) as posts
from users u
left join posts p
on u.id=p.userid
group by u.username
order by posts asc limit 1;

#17. Колко потребителя с по 1 пост имаме. Използвайте join заявка, having clause и вложени заявки.
Select count(username)
from
(
select u.username, count(*) as posts
from users u
left join posts p
on u.id=p.userid
group by u.username
having (posts=1)
)a;

#18. Колко потребителя с по малко от 5 поста имаме. Използвайте join  заявка, having clause и вложени заявки.
Select count(username)
from
(
select u.username, count(*) as posts
from users u
left join posts p
on u.id=p.userid
group by u.username
having (posts<5)
)a;

#19. Кои са постовете с най-много коментари. Използвайте вложена заявка и where clause.
Select *
from posts
where commentsCount =(select max(commentsCount) from posts);

#20. Покажете най-стария пост. Може да използвате order или с aggregate function.
Select * from posts
order by createdAt limit 1;

#21. Покажете най-новия пост. Може с order или с aggregate function.
Select * from posts
order by createdAt desc limit 1;

#22. Покажете всички постове с празен caption.
Select * from posts
where caption='';

#23. Създайте потребител през UI-а, добавете му public пост през базата и проверете дали се е създал през UI-а.
Insert into posts (caption, coverUrl, postStatus, createdAt, isDeleted, commentsCount, userId)
values ('test', 'https://i.imgur.com/gMPUKj7.jpg', 'public', curdate(), 0, 0, 2 );

#24. Покажете всички постове и коментарите им ако имат такива.
Select p.id, caption, content
from posts p
inner join comments c
on p.id = c.postId
order by p.id;

#25. Покажете само постове с коментари и самите коментари.
Select p.id, caption, content
from posts p
inner join comments c
on p.id = c.postId
order by p.id;

#26. Покажете името на потребителя с най-много коментари. Използвайте join клауза.
Select u.username, count(*) as c
from comments c
inner join users u
on c.userId = u.id
group by u.username
order by c desc;

#27. Покажете всички коментари, към кой пост принадлежат и кой ги е направил. Използвайте join клауза.
Select u.username, c.content, p.id, p.caption
from comments c
inner join users u
on c.userId = u.id
inner join posts p
on c.postId = p.id;

#28. Кои потребители са like-нали най-много постове.
Select u.username, count(*) c
from users_liked_posts ul
inner join
users u
on u.id=ul.usersId
group by u.username
order by c desc;


#29. Кои потребители не са like-вали постове.
Select u.username
from users u
left join
users_liked_posts ul
on u.id=ul.usersId
where ul.usersId is null
order by u.username;

#30. Кои постове имат like-ове. Покажете id на поста и caption.
Select p.id, p.caption
from posts p
inner join users_liked_posts ul
on p.id=ul.postsId;

#31. Кои постове имат най-много like-ове. Покажете id на поста и caption.
Select p.id, p.caption, count(*) c
from posts p
inner join users_liked_posts ul
on p.id=ul.postsId
group by p.id, p.caption
order by c desc;

#32. Покажете всички потребители, които не follow-ват никого.
Select u.username from users u
left join
users_followers_users uf
on u.id = usersId_1
where usersId_1 is null;

#33. Покажете всички потребители, които не са follow-нати от никого.
Select u.username from users u
left join
users_followers_users uf
on u.id = usersId_2
where usersId_2 is null;

#34. Регистрирайте потребител през UI. Follow-нете някой съществуващ потребител и проверете дали записа го има в базата.
select * from users_followers_users
where usersId_1='firstuserID' and usersId_2='seconduserID';


















