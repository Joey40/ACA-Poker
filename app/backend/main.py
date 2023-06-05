import uuid
from fastapi import FastAPI

app = FastAPI()

class PokerGame(BaseModel):
    id: uuid.UUID
    name: str
    players: list
    status: str

@app.get("/")
def read_root():
    return {"ACA-Poker": "Hello World!"}

@app.post("/game")
async def create_game(game: PokerGame):
    gameID = uuid.uuid4()
    game.id = game_id
    return {"game_id": str(game_id), "game": game}