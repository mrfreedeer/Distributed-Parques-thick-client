import socket
import threading
import json
import time
from itertools import cycle 

availablecolours = ["red", "blue", "green", "yellow"]
clients = {}
clientsid = []
chosencolours = {}
receivedcolours = False
transitiontest = '{"transition":true, "playerspositions": {"player1": {"pawn1": 22 , "pawn2": 56, "pawn3": 65 , "pawn4": 55}, "player2": {"pawn1": 20 , "pawn2": 30, "pawn3": 40 , "pawn4": 50}}}\n'

playerstring = "player"
playernumber = 1
maxplayers = False
startgame = False
clientpool = cycle(clientsid)


def getColours(availablecolours):
    colourstr = '{"colours": "'
    for x in availablecolours:
        print x
        colourstr = colourstr + x + ","
    colourstr = colourstr[:-1]
    return colourstr + '"}\n'

def test(client):
    print "TESTING"
    newplayerstring ='{"newplayer":true, "playerid" : "player2", "colour" : "blue"}\n'
    client.send(newplayerstring)
    time.sleep(1)
    client.send('{"startgame":true}\n')
    time.sleep(1)
    client.send(transitiontest)


def grantTurn():
    clientid = next(clientpool)
    print("Next: ", clientid)
    client = clients[clientid]
    client.send('{"turngranted":true}\n')

class Receive(threading.Thread):
    def __init__(self, client, addr, id):
            super(Receive,self).__init__()
            self.client = client
            self.addr = addr
            self.clientid = id
    def run(self):
        while True:
           incoming = self.client.recv(1024)
           print "----->", incoming
           data = json.loads(incoming)
           if data:
            if "start" in data: 
                if playernumber >= 3:
                    client.send('{"start": true}')
                    grantTurn()
                else:
                    client.send('{"waiting":true}')

            else:
                    transitionstring = '{"transition" : true, "playerpositions": {"' + self.clientid +'": '+ incoming
                    print transitionstring
                    for key, client in clients.iteritems():
                        if key != self.clientid: 
                            client.send(transitionstring)
                    grantTurn()
                   

servsocket = socket.socket()

servsocket.bind(("", 8000))
servsocket.listen(4)
colour = ""
print "Parques Server Running..."
while True:
    if not maxplayers and not startgame:
        receivedcolours = False
        c, addr = servsocket.accept()
        colours = getColours(availablecolours)
        print ("Connection from: ", addr)
        while not receivedcolours:
            c.send(colours)
            ack = c.recv(1024)
            if ack == "true":
                colour = c.recv(1024)
                availablecolours.remove(colour)
                print("Current colours: ", availablecolours)
                receivedcolours = True

        playeridstring = '{"playerid" : "' + playerstring + str(playernumber) + '"}\n'
        playerid = playerstring + str(playernumber)
        chosencolours[playerid] = colour
        c.send(playeridstring)
        for key, client in clients.iteritems():
            newplayerstring ='{"newplayer":true, "playerid" : "'+ playerid + '", "colour" : "' + colour + '"}\n'
            allplayersforclient = '{"newplayer":true, "playerid" : "'+ key + '", "colour" : "' + chosencolours[key] + '"}\n'
            client.send(newplayerstring)
            c.send(allplayersforclient)

        #test(c)
        playernumber += 1
        clients[playerid]= c
        clientsid.append(playerid)

        t = Receive(c,addr, playerid)
        t.start()



servsocket.close()
