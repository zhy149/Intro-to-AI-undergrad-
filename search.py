import math
import pygame
import sys
import time


pygame.init()
pygame.font.init()
font = pygame.font.SysFont("Calibri MS", 16)
screen = pygame.display.set_mode((1280, 720))
screen.fill("white")
pygame.display.update()


def read_file(fname):
    my_file = open(fname, 'r')
    line = my_file.readline().rstrip(' \n').split(' ')  # get first line to resolve row and col
    row, col = int(line[0]), int(line[1])
    matrix = []  # initialize an empty list to build adjacent matrix
    for i in range(row):
        line = my_file.readline().rstrip('\n').split(' ')
        line.pop()
        tmp_list = []
        for j in range(col):
            node_para = line[j].split('-')
            node_para[2], node_para[3] = int(node_para[2]), int(node_para[3])
            tmp_node = Node(node_para[0], node_para[1], node_para[2], node_para[3])  # build new node
            tmp_list.append(tmp_node)  # insert the node into the matrix
        matrix.append(tmp_list)
    my_file.close()
    return matrix


def dis_est(matrix, option):
    row, col = len(matrix), len(matrix[0])
    for i in range(row):
        for j in range(col):
            if option == "lnode":
                matrix[i][j].est = 1  # initial underestimate step from a node to target
            else:
                matrix[i][j].est = matrix[i][j].get_dis(matrix[row - 1][col - 1])  # calculate estimate distance
    matrix[row - 1][col - 1].est = 0


def mov_and_find(matrix, node1, opt):
    x, y = find_index(matrix, node1)
    x1, y1 = x, y
    row, col = len(matrix), len(matrix[0])
    cur_color = matrix[x][y].color
    cur_direc = matrix[x][y].direc
    ans_lis = []
    flag = (0 <= x < row and 0 <= y < col)
    while flag:
        if 'N' in cur_direc:
            if x == 0:
                break
            x -= 1
            if 'W' in cur_direc:
                if y == 0:
                    break
                else:
                    y -= 1
            if 'E' in cur_direc:
                if y == col - 1:
                    break
                else:
                    y += 1
        if 'S' in cur_direc:
            if x == row - 1:
                break
            x += 1
            if 'W' in cur_direc:
                if y == 0:
                    break
                else:
                    y -= 1
            if 'E' in cur_direc:
                if y == col - 1:
                    break
                else:
                    y += 1
        if cur_direc == 'W':
            if y == 0:
                break
            y -= 1
        if cur_direc == 'E':
            if y == col - 1:
                break
            y += 1
        if matrix[x][y].color != cur_color:
            if opt == "lnode":
                t_dis = 1
            else:
                t_dis = matrix[x][y].get_dis(matrix[x1][y1])
            test_dis = t_dis + matrix[x1][y1].traveled + matrix[x][y].est
            if matrix[x][y].prev is None or test_dis < matrix[x][y].total:
                matrix[x][y].prev = matrix[x1][y1]
                matrix[x][y].update_dis(t_dis + matrix[x1][y1].traveled)
                matrix[x][y].visited = True
                ans_lis.append(matrix[x][y])
                pygame.event.get()
                pygame.draw.lines(screen, "orange", False,
                                  [((matrix[x1][y1].xcor * 16) - 500, matrix[x1][y1].ycor * 9/3),
                                   ((matrix[x][y].xcor * 16) - 500, matrix[x][y].ycor * 9/3)], 2)
                textsurface = font.render(matrix[x][y].name, False, (0, 0, 0))
                screen.blit(textsurface, (matrix[x][y].xcor * 16 - 490, matrix[x][y].ycor * 9/3))
                if opt != "lnode":
                    textsurface = font.render("{:.2f}".format(test_dis), False, (0, 0, 0))
                    screen.blit(textsurface, (matrix[x][y].xcor * 16 - 460, matrix[x][y].ycor * 9 / 3))
                pygame.display.update()
                time.sleep(1)
                pygame.draw.lines(screen, "black", False,
                                  [((matrix[x1][y1].xcor * 16) - 500, matrix[x1][y1].ycor * 9 / 3),
                                   ((matrix[x][y].xcor * 16) - 500, matrix[x][y].ycor * 9 / 3)], 2)

        flag = (0 <= x < row and 0 <= y < col)
    return ans_lis


def build_initial(sbs, option, start_node):  # answer string
    ret_str = "A* algorithm heuristics: "
    if option == "lnode":
        ret_str += "fewest-nodes\nStep-by-Step: "
    else:
        ret_str += "straight-line\nStep-by-Step: "
    if sbs is True:
        ret_str += "Yes\nStarting node: " + start_node
    else:
        ret_str += "No\nStarting node: " + start_node
    ret_str += "\n\n"
    if sbs is True:
        ret_str += "STEP BY STEP: "
    return ret_str


def shortest_path(matrix, sbs, start_node, option):  # if sbs is 1 then output step by step info
    x, y = find_index(matrix, start_node)  # here x is the row and y is the col index of the matrix
    if x < 0:
        print("Error start_node")
        return ""
    row, col = len(matrix), len(matrix[0])
    if x == row-1 and y == col-1:
        return "You are at the target!\n"
    content = build_initial(sbs, option, start_node)
    stack = [matrix[x][y]]
    while matrix[row - 1][col - 1].visited is False or matrix[row - 1][col - 1].total < stack[0].total:
        cur_n = stack.pop(0)  # get the shortest total node and continue
        cur_n.visited = True  # visited
        nodes_lis = mov_and_find(matrix, cur_n.name, option)
        stack.extend(nodes_lis)
        stack.sort(key=lambda o: o.total)
        if sbs is True:
            content += "\n*****************************************************************************************\n"
            content += "node selected: " + cur_n.name + "\n"
            content += "Possible node to travel: "
            for itm in nodes_lis:
                content += itm.name + ' '
            content += "\nnode at the end of possible path: "
            if option == "lnode":
                for itm in stack:
                    content += itm.name + "({})".format(itm.total) + ' '
            else:
                for itm in stack:
                    content += itm.name + "({0:.3f})".format(itm.total) + ' '
        if len(stack) == 0:  # if o is unvisited then there is no path
            break
    if len(stack) != 0 and sbs is True:
        cur_n = stack.pop(0)  # get the shortest total node and continue
        content += "\n*****************************************************************************************\n"
        content += "node selected: " + cur_n.name + "\n"
        content += "Possible node to travel: "
        content += "\nnode at the end of possible path: "
        if option == "lnode":
            for itm in stack:
                content += itm.name + "({})".format(itm.total) + ' '
        else:
            for itm in stack:
                content += itm.name + "({0:.3f})".format(itm.total) + ' '
        content += "\n*****************************************************************************************\n"
    if matrix[row - 1][col - 1].visited is False:
        content += "\nNo path Found to the target node\n"
        return content
    matrix[x][y].prev = None  # prevent loop after printing
    tmp_node = matrix[row - 1][col - 1]
    content += "The final solution is:\n"
    str_lis = []
    while tmp_node.prev is not None:
        pygame.draw.lines(screen, "green", False,
                          [((tmp_node.prev.xcor * 16) - 500, tmp_node.prev.ycor * 9 / 3),
                            ((tmp_node.xcor * 16) - 500, tmp_node.ycor * 9 / 3)], 2)
        if option == "lnode":
            str_lis.append(tmp_node.prev.name + " to " + tmp_node.name + " distance: 1,")
        else:
            str_lis.append(
                tmp_node.prev.name + " to " + tmp_node.name +
                " distance: " + "{0:.3f},".format(tmp_node.get_dis(tmp_node.prev)))
        tmp_node = tmp_node.prev
    str_lis.reverse()
    content += '\n'.join(str_lis)
    content += "\n*****************************************************************************************\n"
    if option == "lnode":
        content += "Total path distance: " + str(matrix[row - 1][col - 1].total)
        total_nodes = (str(matrix[row - 1][col - 1].total) + " nodes")
        textsurface = font.render((total_nodes), False, (0, 0, 0))
        screen.blit(textsurface, (matrix[row - 1][col - 1].xcor * 16 - 470, matrix[row - 1][col - 1].ycor * 9 / 3))
        pygame.display.update()
    else:
        if option == "lnode":
            content += "Total path distance: " + str(matrix[row - 1][col - 1].total)
        else:
            content += "Total path distance: " + "{0:.3f}".format(matrix[row - 1][col - 1].total)
    return content


def write_solution(fname, content):
    f = open(fname, 'w')
    f.write(content)
    f.close()


def find_index(matrix, target_node):
    row, col = len(matrix), len(matrix[0])
    for i in range(row):
        for j in range(col):
            if matrix[i][j].name == target_node:  # found the start node
                return i, j
    return -1, -1


class Node:
    def __init__(self, name, direc, y, x):  # node initialization
        self.name = name
        self.direc = direc
        self.ycor = y
        self.xcor = x
        self.color = name[0]  # color can be either 'R' or 'B'
        self.est = 0  # est is estimated distance from current node to the target node
        self.traveled = 0  # traveled is the distance from initial node to current node
        self.total = 0  # total is current distance plus traveled distance
        self.visited = False  # default not visited (when get to a new node, if and only if not visited)
        self.prev = None  # to mark the previous node

    def visit(self):
        self.visited = True

    def update_dis(self, traveled):
        self.traveled = traveled
        self.total = self.est + traveled

    def get_dis(self, node1):
        return math.sqrt((node1.xcor - self.xcor) ** 2 + (node1.ycor - self.ycor) ** 2)  # calculate distance

    def print_node(self):
        print(self.name, self.ycor, self.xcor, self.traveled, self.total, self.prev.name, self.visited)


def main():
    while True:
        mat = read_file('maze.txt')
        stop = input("Press 1 to continue input, 2 to exit\n")
        if stop == '2':
            break
        option1 = input("Please input 1 for fewest nodes or 2 for straight line strategy, press Enter to end input\n")
        option2 = input("Please input 1 for Step by Step procedure or 2 for no, press Enter to end input\n")
        option3 = input("Please input the starting node's name, press Enter to end input\n")

        if option1 == '1':
            option1 = 'lnode'
        if option2 == '1':
            option2 = True
        else:
            option2 = False
        dis_est(mat, option1)
        solution = shortest_path(mat, option2, option3, option1)
        write_solution("maze-sol.txt", solution)

        pygame.display.update()


if __name__ == '__main__':
    main()
