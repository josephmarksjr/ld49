-- jam: ludum dare 49
-- title: unstable
-- author: joseph marks
-- date: october 2021
---------------------------
-- collect the star

--global variables
offset=0
xoffset=0
scr_spd=0.2
px=0
py=0
ps=7
dy=0
dx=0
fx=0
fy=0
ground=false
pc=1
dc=0//drill cell for animation
txt="hello"//debug text
bs={}
xs={}
intro=true
gameover=false
lvl=3
lives=3
timer=5
itimer=4
friction=0.90

function init_block(t,x,y)
 b={}
 b.x=x
 b.y=y
 b.t=t
 b.falling=false
 b.fcount=0
 b.dy=0
 b.dx=0
 return b
end

function init_spike(t,x,y)
 s={}
 s.x=x
 s.y=y
 s.t=t
 return s
end

function init_game()
 gameover=false
 intro=true
 lives=3
 init_level_1()
end

function init_level_1()
 bs={}
 --blocks
 add(bs,init_block(48,5*8,49*8))
 add(bs,init_block(48,6*8,49*8))
 add(bs,init_block(48,7*8,49*8))
 add(bs,init_block(48,8*8,49*8))
 add(bs,init_block(48,6*8,41*8))
 add(bs,init_block(48,9*8,41*8))
 add(bs,init_block(48,7*8,40*8))
 add(bs,init_block(48,8*8,40*8))
 add(bs,init_block(48,7*8,45*8))
 add(bs,init_block(48,8*8,45*8))
 add(bs,init_block(48,6*8,29*8))
 add(bs,init_block(48,7*8,29*8))
 add(bs,init_block(48,8*8,29*8))
 add(bs,init_block(48,9*8,29*8))
 add(bs,init_block(48,10*8,29*8))
 add(bs,init_block(48,8*8,22*8))
 add(bs,init_block(48,9*8,22*8))
 add(bs,init_block(48,10*8,22*8))
 add(bs,init_block(48,11*8,22*8))
 add(bs,init_block(48,12*8,22*8))

 --spikes
 add(xs,init_spike(33,9*8,52*8))
 add(xs,init_spike(33,10*8,52*8))

 add(xs,init_spike(59,2*8,33*8))
 add(xs,init_spike(59,2*8,34*8))
 add(xs,init_spike(59,2*8,35*8))
 add(xs,init_spike(59,2*8,36*8))
 add(xs,init_spike(59,2*8,37*8))
 add(xs,init_spike(59,2*8,38*8))
 add(xs,init_spike(58,13*8,33*8))
 add(xs,init_spike(58,13*8,34*8))
 add(xs,init_spike(58,13*8,35*8))
 add(xs,init_spike(58,13*8,36*8))
 add(xs,init_spike(58,13*8,37*8))
 add(xs,init_spike(58,13*8,38*8))

 add(xs,init_spike(33,2*8,30*8))

 add(xs,init_spike(33,8*8,24*8))
 add(xs,init_spike(33,9*8,24*8))
 add(xs,init_spike(33,10*8,24*8))
 add(xs,init_spike(33,11*8,23*8))
 add(xs,init_spike(33,12*8,23*8))

 add(xs,init_spike(59,2*8,18*8))
 add(xs,init_spike(33,2*8,14*8))
 add(xs,init_spike(33,8*8,14*8))
 add(xs,init_spike(33,9*8,14*8))
 add(xs,init_spike(33,12*8,14*8))
 add(xs,init_spike(33,13*8,14*8))
 add(xs,init_spike(33,4*8,10*8))
 add(xs,init_spike(33,5*8,10*8))
 
 add(xs,init_spike(33,7*8,60*8))
 
 offset=100
 xoffset=0
 px=4*8
 py=59*8
 dx=0
 dy=0
 fx=10*8
 fy=3*8
 ground=false
 lvl=1
 itimer=4
 timer=6
 friction=0.90
end

function init_level_2()
 bs={}
 xs={}
 xoffset=16
 offset=100
 px=4*8
 py=59*8
 dx=0
 dy=0
 fx=10*8
 fy=3*8
 ground=false
 lvl=2
 itimer=4
 timer=6
 friction=0.999
end

function _init()
 init_game()
end

function _update60()
 if(timer>0 and intro==false)then
  timer-=1/60
 end
 
 if(itimer>0)then
  itimer-=1/60
 elseif(gameover==true or lvl==3)then
  if(btnp(0) or btnp(1) or
   btnp(2) or btnp(3) or
   btnp(4) or btnp(5))
  then
   init_game()
  end
 elseif(intro==true)then
  if(btnp(0) or btnp(1) or
   btnp(2) or btnp(3) or
   btnp(4) or btnp(5))
  then
   intro=false
  end
 else
 
 if(timer<0 and offset<488)then
  offset+=scr_spd
  if(offset<-127)then
   offset=0
  end
 end
 
 --gravity
 dy=dy+0.05
 
 --left
 if(btn(0))then
  dx=dx-0.05
  
  if(pc>10)then
   pc=1
  else
  	pc+=0.5
  end
 end
 
 --right
 if(btn(1))then
  dx=dx+0.05
  
  if(pc>10)then
   pc=1
  else
  	pc+=0.5
  end
 end
 
 --jump
 if(btnp(2) or btnp(4))then
  if(ground)then
   ground=false
   dy=dy-1.9
  end
 end
 
 --fall faster
 if(btn(3))then
  dy=dy+0.05
 end
 
 --l/r collisions
 if(hit(px+dx,py,7,7))then
  dx=0
 end
 
 --u/d collisions
 if(hit(px,py+dy,7,7))then
  if(dy>0)then
   ground=true
  end
  dy=0
 end
 
 --b collisions
 for o in all(bs) do
  if(
   hit_o(px,py+dy,7,7,o.x,o.y)
  )then
    if(dy>0)then
     ground=true
     o.falling=true
    end
    dy=0
  end
  if(
  	hit_o(px+dx,py,7,7,o.x,o.y)
  )then
   dx=0
  end
 end
 
 --x collisions
 for x in all(xs) do
  if(hit_flag(px,py,x.x,x.y,false))then
   die()
 	end
 end
 
 if(ground)then
  dx=dx*friction
  jump=0
 end
 
 --prevent going too fast
 if(dx>1)then
  dx=1
 end
 if(dx<-1)then
  dx=-1
 end
 if(dy>2)then
  dy=2 
 end
 if(dy<-2)then
  dy=-2
 end
 
 if(dc>=2)then
  dc=0
 else
  dc+=0.1
 end
 
 for b in all(bs) do 
  if(b.y>594)then
   del(bs,b)
  elseif(b.falling==true)then
   b.fcount+=1
   if(b.fcount>3)then
    b.dy=b.dy+0.01
   end
  end
  b.y=b.y+b.dy
 end
 
 if((py+offset)>594)then
  die()
 end
 
 if(hit_flag(px,py,fx,fy,true))then
  win()
 end
 
 newpy=py+dy
 --hacky solution to shake free
 if(btnp(5) or btnp(3))
 then
  if(fget(mget(px/8,(py+8)/8))<1)then
   newpy=py+4
  end
 end
 
 py=newpy
 px=px+dx
 end
end

function hit_flag(ax,ay,bx,by,f)
 h=8
 if(f==true)then
  h=16
 end
 if(ax>bx+8)then
  return false
 end
 if(ax<bx-8)then
  return false
 end
 if(ay>=by+h)then
  return false
 end
 if(ay<=by-7)then
  return false
 end
 return true
end

function _draw()
  if(gameover==true)then
   cls()
   camera(0,0)
   draw_gameover()
  elseif(intro==true)then
   cls()
   camera(0,0)
   draw_lvl_intro(lvl)
  else
		 cls()
		 map(xoffset,0,0,0,16,64)
		 camera(0,488-offset)
		 draw_p()
		 spr(dc+55,fx,fy)
		 spr(57,fx,fy+8)
		 foreach(bs,draw_b)
		 foreach(xs,draw_s)
		 
		 for i=0,16 do
		  spr(17,i*8,608-offset)
		  spr(dc+2,i*8,600-offset)
		 end 
		end
end

function draw_p()
 if(dx>0)then
  ps=23
 end
 if(dx<0)then
  ps=7
 end
 pss=ps
 
 if(dx!=0)then
  if(ground==false)then
   pss=ps+3
  elseif(pc>5)then
   pss=ps+2
  else
   pss=ps+1
  end
 end
 spr(pss,px,py)
end

function draw_b(b)
 spr(b.t,b.x,b.y)
end

function draw_s(s)
 spr(s.t,s.x,s.y)
end

function die()
 lives-=1
 if(lives<=0)then
  gameover=true
  itimer=6
 else
  intro=true
  if(lvl==1)then
   init_level_1()
  elseif(lvl==2)then
   init_level_2()
  end
 end
end

function win()
 intro=true
 itimer=5
 if(lvl==1)then
  init_level_2()
 elseif(lvl==2)then
  lvl=3
 end
end

function hit_o(x,y,w,h,ox,oy)
 if(x>ox+8)then
  return false
 end
 if(x<ox-8)then
  return false
 end
 if(y>oy+8)then
  return false
 end
 if(y<oy-8)then
  return false
 end
 
 return true
end

function hit(x,y,w,h,t)
 x+=(xoffset*8)
 collide=false
 for i=x,x+w,w do
 	if
 	 (fget(mget(i/8,y/8))>0) or
   (fget(mget(i/8,(y+h)/8))>0)
  then
   collide=true
  end
 end
 
 for i=y,y+h,h do
  if
   (fget(mget(x/8,i/8))>0) or
   (fget(mget((x+w)/8,i/8))>0)
  then
   collide=true
  end
 end
 
 return collide
end

function draw_lvl_intro(l)
 print("demolition mouse",0,20)
 print("reach the flag at the top",0,28)
 print("before building is demolished",0,36)
 print("(press ⬇️ or ❎/x if stuck!)",0,44)
 
 sp=4*8+10

 if(lvl==3)then
  print("you won!",0,sp+20)
  print("you beat both levels!",0,sp+28)
  print("thanks for playing!",0,sp+36)
 else
  print("level "..l.."/2",0,sp+20)
  print("lives: "..lives,0,sp+28)
 end
 
 sp+=10
 
 if(itimer>0)then
  print(flr(itimer),64,sp+50)
 else
  print("press ⬆️⬇️⬅️➡️ to play",16,sp+50)
 end
end

function draw_gameover(l)
 print("game over",46,20)
 if(itimer>0)then
  print(flr(itimer),64,36)
 else
  print("press any button to play",16,28)
 end
end
