""" 
The idea is to model objects to be consisting of some boundary points
that together manifest the properties of the object under consideration.
"""

"""
Taking 1 px = 1 cm
"""

"""
Consider breaking down the dynamics into internal and external components. This will
allow to apply damping to the internal movements.
"""

CurrentTime = millis()
import random
class PhysicsPoint:
    def __init__(
                self, 
                posX=100, 
                posY=100, 
                velX=0, 
                velY=0, 
                acclX=0, 
                acclY=0,
                mass = 1,
                gravity = False
            ):
        
        self.pos = PVector(posX, posY)
        self.vel = PVector(velX, velY)
        self.internal_vel = PVector(0,0)
        self.accl = PVector(acclX, acclY)
        self.internal_accl = PVector(0,0)
        self.mass = mass
        self.gravity = gravity
        
    def update(self, t):
        self.checkBoundary()
        if self.gravity:
            self.applyGravity()
        self.addDamping()
        
        self.vel += self.accl.copy().mult(t)
        
        self.internal_vel += self.internal_accl.copy().mult(t)
        
        self.pos += self.vel.copy().mult(t)
        self.pos += self.internal_vel.copy().mult(t)

        self.accl.mult(0)
        self.internal_accl.mult(0)
        
        
    def checkBoundary(self):
        absorption = -0.8
        if self.pos.y >= height:
            self.pos.y = height
            self.vel.y *= absorption
        
        if self.pos.y <= 0:
            self.pos.y = 0
            self.vel.y *= absorption
            
        if self.pos.x >= width:
            self.pos.x = width
            self.vel.x *= absorption
            
        if self.pos.x <= 0:
            self.pos.x = 0
            self.vel.x *= absorption    
    
    def applyForce(self, force):
        accl = force.div(self.mass)
        self.accl.add(accl)
        
    def applyInternalForce(self, force):
        accl = force.div(self.mass)
        self.internal_accl.add(accl)
    
    def applyGravity(self):
        
        self.accl.add(PVector(0, 981))
        
    def drawPoint(self):
        
        strokeWeight(10)
        point(self.pos.x, self.pos.y)
        
    def addDamping(self):
        dir = self.internal_vel.copy().normalize().mult(-1)
        m = self.internal_vel.mag()**2
        force = dir.mult(50)
        self.applyForce(force)
        
        
def setup():
    size(800,800)
    background(10,150,200)
    
p1 = PhysicsPoint(posX=500, posY= 700, mass = 0.01)
p2 = PhysicsPoint(posX=250, mass = 0.01)
d = 100
k = 1

def draw():
    global CurrentTime
    background(10,150,200)
    stroke(100,100,250)
    p1.drawPoint()
    stroke(250,100,100)
    p2.drawPoint()
    strokeWeight(1)
    line(p1.pos.x, p1.pos.y, p2.pos.x, p2.pos.y)
    if keyPressed:
        if key == 'w':
            p1.applyForce(PVector(0,-10))
        if key == 's':
            p1.applyForce(PVector(0,10))
        if key == 'a':
            p1.applyForce(PVector(-10,0))
        if key == 'd':
            p1.applyForce(PVector(10,0))
            
    diff = p2.pos.copy()-p1.pos
    print(diff.mag())
    if diff.mag() > d+50:
        p1.applyInternalForce(diff.copy().mult(k))
        p2.applyInternalForce(diff.copy().mult(-k))
  
    if diff.mag() < d:
        p1.applyInternalForce(diff.copy().mult(-k))  
        p2.applyInternalForce(diff.copy().mult(k)) 
        
    elapsedTime = millis()-CurrentTime
    p1.update(elapsedTime/1000.)
    p2.update(elapsedTime/1000.)
    CurrentTime += elapsedTime
    
        
