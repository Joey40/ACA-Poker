import uuid
from dapr.clients import DaprClient
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class PokerGame(BaseModel):
    # set a default value of none so that the API doesn't
    # expect it when creating a new game
    id: uuid.UUID = None
    name: str
    players: list
    status: str

@app.get("/")
def read_root():
    return {"ACA-Poker": "Hello World!"}

@app.post("/game")
async def create_game(game: PokerGame):
    game_id = uuid.uuid4()
    game.id = game_id
    return {"game_id": str(game_id), "game": game}
