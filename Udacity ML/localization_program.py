colors = [['red', 'green', 'green', 'red' , 'red'],
          ['red', 'red', 'green', 'red', 'red'],
          ['red', 'red', 'green', 'green', 'red'],
          ['red', 'red', 'red', 'red', 'red']]

measurements = ['green', 'green', 'green' ,'green', 'green']

motions = [[0,0],[0,1],[1,0],[1,0],[0,1]]

sensor_right = 0.7

p_move = 0.8

def show(p):
    for i in range(len(p)):
        print p[i]

#DO NOT USE IMPORT
#ENTER CODE BELOW HERE
#ANY CODE ABOVE WILL CAUSE
#HOMEWORK TO BE GRADED
#INCORRECT

p = []

# calculate initial prob
h = len(colors)
w = len(colors[0])
p = [[1./(h*w) for i in range(w)] for i in range(h)]


# return p matrix modified based on observation
def sense(p,Z):
    q = [[0 for i in range(w)] for i in range(h)]
    for i in range(h):
        for j in range(w):
            if colors[i][j] == Z:
                q[i][j] = p[i][j] * sensor_right
            else:
                q[i][j] = p[i][j] * (1-sensor_right)
    total_sum = sum([sum(i) for i in q])
    for i in range(h):
        for j in range(w):
            q[i][j] /= total_sum
    return q

def move(p,motion):
    #print motion
    q = [[0 for i in range(w)] for i in range(h)]
    for i in range(h):
        for j in range(w):
            q[i][j] += p[i][j]*(1-p_move)
            q[i][j] += p[(i-motion[0]) % h][(j-motion[1]) % w]*(p_move)
    return q

for i in range(len(measurements)):
    p = move(p,motions[i])
    p = sense(p,measurements[i])

    
#Your probability array must be printed 
#with the following code.

show(p)

