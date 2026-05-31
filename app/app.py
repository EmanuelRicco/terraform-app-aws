from fastapi import FastAPI

app = FastAPI()

@app.get("/")
async def read_root():
    return {"message": "FastAPI rodando na AWS com sucesso em uma instância EC2 com Docker!"}
