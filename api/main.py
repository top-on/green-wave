""" FastAPI """

from fastapi import FastAPI
from pydantic import BaseModel

from starlette.testclient import TestClient


app = FastAPI()
client = TestClient(app)


class Item(BaseModel):
    name: str


@app.get("/test/")
async def root(item: Item):
    item_dict = item.dict()
    return item_dict
