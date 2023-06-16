import json
import uuid
from dapr.clients import DaprClient
from fastapi import FastAPI, Query
from pydantic import BaseModel

DAPR_STORE_NAME="acapoker-state"

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
    with DaprClient() as dapr:
        dapr.save_state(DAPR_STORE_NAME, str(game_id), game.json())
    return {"game_id": str(game_id), "game": game}

@app.get("/game")
async def get_game(game_id: uuid.UUID = Query(...)):
    with DaprClient() as dapr:
        game = dapr.get_state(DAPR_STORE_NAME, str(game_id)).data
    if game is None:
        raise HTTPException(status_code=404, detail="Game not found")
    else:
        game = json.loads(game)
        return game

@app.delete("/game")
async def get_game(game_id: uuid.UUID = Query(...)):
    with DaprClient() as dapr:
        game = dapr.get_state(DAPR_STORE_NAME, str(game_id)).data
        if game is None:
            raise HTTPException(status_code=404, detail="Game not found")
        else:
            dapr.delete_state(DAPR_STORE_NAME, str(game_id))
            return "game_id: " + str(game_id) + " has been deleted."