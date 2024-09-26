def setup():
    size(1440,1080)
    background(150,210,150)
    

def bifurcation_x(r):
    iteration = 100
    x = 0.5
    scale = 50
    for i in range(iteration):
        x = r*x*(1-x)
        if i > iteration //2:
            fill(230,25,25)
            ellipse(r*scale, x*scale+500, 10,10)

r = 0.0
lim = 4.0
def draw():
    global r, lim
    if r < lim:
        bifurcation_x(r)
    r += 0.01
