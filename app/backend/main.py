from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def read_root():
    return {"ACA-Poker": "Hello World!"}
