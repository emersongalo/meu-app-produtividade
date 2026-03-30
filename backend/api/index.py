from fastapi import FastAPI
from pydantic import BaseModel
from typing import List

app = FastAPI()

class Item(BaseModel):
    titulo: str
    tipo: str # "habito", "tarefa" ou "nota"
    concluido: bool = False

db_temporario = []

@app.get("/")
def raiz():
    return {"status": "Sistema Online", "projeto": "App do Emerson"}

@app.get("/api/itens")
def listar():
    return db_temporario

@app.post("/api/itens")
def adicionar(item: Item):
    db_temporario.append(item.dict())
    return {"msg": "Salvo com sucesso!"}