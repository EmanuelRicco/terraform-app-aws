from fastapi import FastAPI

app = FastAPI()

@app.get("/")
async def read_root():
    return {"message": "App em docker rodando com sucesso em na magalu cloud!"}
