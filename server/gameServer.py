import socket
import threading
import json
import time


availablecolours = ["red", "blue", "green", "yellow"]
clients = {}
receivedcolours = False
transitiontest = '{"transition":true, "playerspositions": {"player1": {"pawn1": 22 , "pawn2": 56, "pawn3": 65 , "pawn4": 55}, "player2": {"pawn1": 20 , "pawn2": 30, "pawn3": 40 , "pawn4": 50}}}\n'

playerstring = "player"
playernumber = 1
maxplayers = False
startgame = False

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


class Receive(threading.Thread):
    def __init__(self, client,addr):
            super(Receive,self).__init__()
            self.client = client
            self.addr = addr
    def run(self):
        while True:
           incoming = self.client.recv(1024)
           data = json.loads(incoming)
           if "colour" in data:
               availablecolours.remove(data["colour"])
           else:
               position = data
               print position
               print type(position)
               position = json.loads(position)
               print position['pawn1']

servsocket = socket.socket()

servsocket.bind(("127.0.0.1", 8000))
servsocket.listen(4)
colour = ""
print "Parques Server Running..."
while True:
    if not maxplayers and not startgame:
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

        playerid = '{"playerid" : "' + playerstring + str(playernumber) + '"}\n'
        
        c.send(playerid)
        for key, client in clients.iteritems():
            newplayerstring ='{"newplayer":true, "playerid" : "' + str(playernumber) + '", "colour" : "' + colour + '"}\n'
            client.send(newplayerstring)

        test(c)
        playernumber += 1
        clients[playerstring+str(playernumber)]= c

        t = Receive(c,addr)
        t.start()



servsocket.close()
